#!/bin/bash
# Ralph Wiggum Loop - Docker Mode
# Runs Claude Code in isolated container with your OAuth credentials

set -e

# Configuration
MODEL="${RALPH_MODEL:-opus}"
IMAGE_NAME="ralph-loop"
CONTAINER_NAME="ralph-$$"
PLAN_FILE="IMPLEMENTATION_PLAN.md"

# Check for OAuth token
if [ -z "$CLAUDE_CODE_OAUTH_TOKEN" ]; then
  if [ -f "$HOME/.claude-oauth-token" ]; then
    CLAUDE_CODE_OAUTH_TOKEN=$(cat "$HOME/.claude-oauth-token")
  else
    echo "❌ Error: No OAuth token found"
    echo ""
    echo "Set up your token:"
    echo "  1. Run: claude setup-token"
    echo "  2. Save token to ~/.claude-oauth-token"
    echo "     OR set CLAUDE_CODE_OAUTH_TOKEN env var"
    echo ""
    exit 1
  fi
fi

# Parse arguments
MODE="build"
LIMIT=""

while [[ $# -gt 0 ]]; do
  case $1 in
    plan)
      MODE="plan"
      shift
      ;;
    [0-9]*)
      LIMIT=$1
      shift
      ;;
    --build-image)
      echo "Building Docker image..."
      docker build -t "$IMAGE_NAME" .
      echo "✅ Image built"
      exit 0
      ;;
    --model)
      MODEL=$2
      shift 2
      ;;
    *)
      echo "Usage: $0 [plan] [limit] [--build-image] [--model opus|sonnet]"
      echo ""
      echo "Examples:"
      echo "  $0                  # Build mode, unlimited"
      echo "  $0 20               # Build mode, max 20 iterations"
      echo "  $0 plan             # Plan mode"
      echo "  $0 --build-image    # Build Docker image first"
      exit 1
      ;;
  esac
done

# Check if image exists, build if not
if ! docker image inspect "$IMAGE_NAME" &>/dev/null; then
  echo "Docker image not found. Building..."
  docker build -t "$IMAGE_NAME" .
fi

# ============================================================================
# ITERATION SUMMARY
# ============================================================================

print_iteration_summary() {
  local iteration_start="$1"
  local iteration_end=$(date +%s)
  local duration=$((iteration_end - iteration_start))
  local mins=$((duration / 60))
  local secs=$((duration % 60))

  # Get the last commit (if any new one was made)
  local last_commit=$(git log -1 --format="%h %s" 2>/dev/null || echo "")
  local last_commit_time=$(git log -1 --format="%ct" 2>/dev/null || echo "0")

  # Check if commit was made during this iteration
  local commit_msg=""
  if [ "$last_commit_time" -ge "$iteration_start" ]; then
    commit_msg="$last_commit"
  fi

  # Get files changed in last commit
  local files_new=0
  local files_modified=0
  local new_files=""
  local modified_files=""

  if [ -n "$commit_msg" ]; then
    new_files=$(git diff-tree --no-commit-id --name-status -r HEAD 2>/dev/null | grep "^A" | cut -f2 || echo "")
    modified_files=$(git diff-tree --no-commit-id --name-status -r HEAD 2>/dev/null | grep "^M" | cut -f2 || echo "")
    files_new=$(echo "$new_files" | grep -c . 2>/dev/null || echo "0")
    files_modified=$(echo "$modified_files" | grep -c . 2>/dev/null || echo "0")
  fi

  # Get progress
  local completed=$(grep -c '^\s*- \[x\]' "$PLAN_FILE" 2>/dev/null || echo "0")
  local total_tasks=$(grep -c '^\s*- \[' "$PLAN_FILE" 2>/dev/null || echo "0")
  local pct=0
  if [ "$total_tasks" -gt 0 ]; then
    pct=$((completed * 100 / total_tasks))
  fi

  echo ""
  echo "━━━ Iteration $ITERATION Complete (${mins}m ${secs}s) ━━━"

  if [ -n "$commit_msg" ]; then
    echo "✅ Commit: $commit_msg"
    echo "📁 Files: +$files_new new, ~$files_modified modified"

    # Show new files
    if [ -n "$new_files" ]; then
      echo "$new_files" | while read -r f; do
        [ -n "$f" ] && echo "   🆕 $f"
      done
    fi

    # Show modified files (limit to 5)
    if [ -n "$modified_files" ]; then
      echo "$modified_files" | head -5 | while read -r f; do
        [ -n "$f" ] && echo "   ✏️  $f"
      done
      local mod_count=$(echo "$modified_files" | wc -l | tr -d ' ')
      if [ "$mod_count" -gt 5 ]; then
        echo "   ... and $((mod_count - 5)) more"
      fi
    fi
  else
    echo "⚠️  No commit this iteration"
  fi

  echo "📊 Progress: $completed/$total_tasks tasks ($pct%)"
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
}

# ============================================================================
# MAIN LOOP
# ============================================================================

# Select prompt file
if [ "$MODE" = "plan" ]; then
  PROMPT_FILE="PROMPT_plan.md"
  echo "🧠 Ralph Planning Mode (Docker)"
else
  PROMPT_FILE="PROMPT_build.md"
  echo "🔨 Ralph Building Mode (Docker)"
fi

if [ ! -f "$PROMPT_FILE" ]; then
  echo "❌ Error: $PROMPT_FILE not found"
  exit 1
fi

echo "Model: $MODEL"
echo "Container: isolated"
if [ -n "$LIMIT" ]; then
  echo "Limit: $LIMIT iterations"
else
  echo "Limit: unlimited (Ctrl+C to stop)"
fi
echo ""
echo "Starting loop..."
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Run the loop
ITERATION=0
while true; do
  ITERATION=$((ITERATION + 1))
  ITERATION_START=$(date +%s)

  echo "📍 Iteration $ITERATION - $(date '+%Y-%m-%d %H:%M:%S')"

  # Check limit
  if [ -n "$LIMIT" ] && [ "$ITERATION" -gt "$LIMIT" ]; then
    echo ""
    echo "✅ Reached iteration limit ($LIMIT)"
    exit 0
  fi

  # Run Claude in Docker container
  # Mount only current directory (isolated from host filesystem)
  # Pass OAuth token via environment variable
  if docker run --rm \
    --name "$CONTAINER_NAME" \
    -e "CLAUDE_CODE_OAUTH_TOKEN=$CLAUDE_CODE_OAUTH_TOKEN" \
    -v "$(pwd):/workspace" \
    -w /workspace \
    "$IMAGE_NAME" \
    bash -c "cat $PROMPT_FILE | claude --model $MODEL -p --dangerously-skip-permissions"; then

    # Print iteration summary in build mode
    if [ "$MODE" = "build" ]; then
      print_iteration_summary "$ITERATION_START"
    else
      echo "✓ Iteration $ITERATION complete"
    fi
  else
    EXIT_CODE=$?
    echo ""
    echo "❌ Claude exited with code $EXIT_CODE"
    echo "Stopping loop"
    exit $EXIT_CODE
  fi

  echo ""

  sleep 1
done
