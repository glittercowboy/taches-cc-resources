#!/bin/bash
# Storyline installer - Story-driven development workflow for Claude Code
# https://github.com/prillcode/storyline

set -e

echo "📖 Installing Storyline..."
echo ""

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Create .claude directories if they don't exist
mkdir -p ~/.claude/skills
mkdir -p ~/.claude/commands

# Check for taches-cc-resources dependency
echo "Checking dependencies..."
if [ ! -d "$HOME/.claude/skills/create-plans" ]; then
  echo -e "${YELLOW}⚠️  Storyline requires taches-cc-resources${NC}"
  echo ""
  echo "Storyline builds on the taches-cc-resources framework."
  echo "Would you like to install it now? (y/n)"
  read -r response

  if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
    echo "Installing taches-cc-resources..."

    # Clone to temp directory
    TEMP_DIR=$(mktemp -d)
    git clone https://github.com/glittercowboy/taches-cc-resources.git "$TEMP_DIR" 2>/dev/null || {
      echo -e "${RED}Failed to clone taches-cc-resources${NC}"
      exit 1
    }

    # Install taches skills and commands
    cp -r "$TEMP_DIR/skills"/* ~/.claude/skills/ 2>/dev/null || true
    cp -r "$TEMP_DIR/commands"/* ~/.claude/commands/ 2>/dev/null || true
    cp -r "$TEMP_DIR/agents" ~/.claude/ 2>/dev/null || true

    # Cleanup
    rm -rf "$TEMP_DIR"

    echo -e "${GREEN}✅ taches-cc-resources installed${NC}"
  else
    echo -e "${RED}Installation cancelled. Install taches-cc-resources first.${NC}"
    exit 1
  fi
fi

# Install storyline skills
echo "Installing Storyline skills..."
cp -r skills/* ~/.claude/skills/

# Install storyline commands
echo "Installing Storyline commands..."
cp -r commands/* ~/.claude/commands/

echo ""
echo -e "${GREEN}✅ Storyline installed successfully!${NC}"
echo ""
echo "Available commands:"
echo "  /epic-creator <PRD.md>      - Create epics from PRD/tech spec"
echo "  /story-creator <epic-file>  - Generate user stories from epic"
echo "  /spec-story <story-file>    - Create technical spec from story"
echo "  /dev-story <spec-file>      - Execute technical spec (implement)"
echo ""
echo "Example workflow:"
echo "  1. /epic-creator docs/PRD.md"
echo "  2. /story-creator .workflow/epics/epic-001.md"
echo "  3. /spec-story .workflow/stories/story-001.md"
echo "  4. /dev-story .workflow/specs/spec-001.md"
echo ""
echo "Start a new Claude Code session to use Storyline."
echo ""
echo -e "${YELLOW}Documentation: https://github.com/prillcode/storyline${NC}"
