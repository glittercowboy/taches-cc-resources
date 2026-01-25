# Ralph Fundamentals

Core concepts and philosophy of Geoffrey Huntley's Ralph Wiggum autonomous coding technique.

<what_is_ralph>
## What is Ralph?

Ralph is an autonomous AI coding methodology created by Geoffrey Huntley that went viral in late 2025. In its purest form, it's a Bash loop:

```bash
while :; do cat PROMPT.md | claude ; done
```

The loop continuously feeds a prompt file to Claude Code CLI. The agent completes one task, updates the implementation plan on disk, commits changes, then exits. The loop restarts immediately with fresh context.

**The core insight:** Ralph solves context accumulation by starting each iteration with fresh context. This is "deterministically bad in an undeterministic world"—embracing the chaos rather than fighting it.
</what_is_ralph>

<three_phases_two_prompts_one_loop>
## Three Phases, Two Prompts, One Loop

Ralph isn't just "a loop that codes." It's a funnel with specific structure:

### Phase 1: Planning Mode

**Objective:** Gap analysis only
**Input:** Specs and existing code
**Output:** `IMPLEMENTATION_PLAN.md` (prioritized TODO list)
**Rule:** No implementation, no commits

The planning prompt instructs Claude to:
1. Study all specification files
2. Study existing source code
3. Compare specs against implementation
4. Generate or update `IMPLEMENTATION_PLAN.md`
5. Exit

**Critical instruction:** "Don't assume not implemented; confirm with code search first."

### Phase 2: Building Mode

**Objective:** Implement from the plan
**Input:** Plan, specs, existing code
**Output:** Code changes + commits
**Rule:** One task per loop iteration

The building prompt instructs Claude to:
1. Study the implementation plan
2. Select most important task
3. Search existing code (don't assume anything is missing)
4. Implement the functionality
5. Run validation (tests, type checks, lints)
6. Update the plan with findings
7. Commit with descriptive message
8. Exit

### Phase 3: Observation (Your Role)

**Objective:** Sit on the loop, not in it
**Action:** Engineer the environment that allows Ralph to succeed

You:
- Watch for failure patterns
- Update `AGENTS.md` with learnings
- Tune prompts based on observed behavior
- Regenerate plan when trajectory fails
- Add backpressure mechanisms
- Improve specs when Ralph misunderstands

You DON'T:
- Jump into the loop to fix things
- Manually implement features
- Edit code directly
- Interfere with the autonomous process
</three_phases_two_prompts_one_loop>

<core_principles>
## Core Principles

### 1. Fresh Context Every Iteration

Each loop starts with a clean 200K context window. No accumulated conversation history, no stale assumptions. This prevents context poisoning and forces Ralph to ground decisions in files on disk.

### 2. File I/O as State

The `IMPLEMENTATION_PLAN.md` file is the only state that persists across iterations. This serves as deterministic shared state—no sophisticated orchestration needed. Claude reads it, updates it, commits it.

### 3. Backpressure as Steering

Tests, type checks, lints, and builds provide downstream steering. If Ralph's code doesn't pass validation, the loop continues until it does. This creates self-correcting behavior without manual intervention.

**Validation must be:**
- Automated (no human approval)
- Binary (pass/fail)
- Fast enough to run every iteration
- Relevant to code quality

### 4. Context Efficiency

200K advertised tokens ≈ 176K usable tokens. The "smart zone" (where Claude reasons best) is 40-60% of the window.

**Optimization:**
- Tight tasks + one task per loop = 100% smart zone utilization
- Use main agent as scheduler; spawn subagents for expensive work
- Prefer Markdown over JSON (more token-efficient)
- Keep prompts focused on current task

### 5. Parallel Subagents for Reads

The main agent orchestrates. Subagents do expensive work:
- Up to 250-500 Sonnet subagents for reading/searching code
- Only 1 subagent for builds/tests (to create backpressure)
- Subagents are cheap and fast for I/O-bound work

### 6. Prompts as Signs

Prompts aren't just instructions—they're discoverable patterns. Ralph learns from:
- Existing code patterns (how utilities are structured)
- AGENTS.md (project-specific learnings)
- Specs (requirements and constraints)
- Validation failures (what not to do)

### 7. Let Ralph Ralph

Trust the LLM's self-identification and self-correction ability:
- Don't micromanage
- Don't pre-optimize
- Observe and course-correct reactively
- "Tune it like a guitar" through iteration

Signs of over-steering:
- Prompts with too many rules
- Trying to predict all failure modes
- Not letting Ralph fail and learn
- Jumping in to fix instead of updating prompts
</core_principles>

<philosophy>
## Philosophy

### Deterministically Bad in an Undeterministic World

Traditional AI coding tries to maintain context across a long conversation. This fights against the probabilistic nature of LLMs and leads to:
- Context poisoning (earlier mistakes color later decisions)
- Assumption drift (LLM forgets what it "knew" earlier)
- Hallucination accumulation (errors compound)

Ralph embraces chaos:
- Fresh context = fresh start
- Plan on disk = deterministic state
- Validation = reality check
- Loop = inevitable progress

### The Loop is the Product

You're not building software. You're building an environment that builds software. The loop is the unit of work, not the feature.

Good loop design:
- Clear specs that Ralph can understand
- Effective backpressure that rejects bad work
- Minimal prompts that evolve through observation
- AGENTS.md that captures learnings

### Move Outside the Loop

Your role shifts from implementer to environment engineer:
- **Inside the loop:** Writing code, fixing bugs, implementing features (Ralph's job)
- **Outside the loop:** Writing specs, tuning prompts, adding tests, observing patterns (your job)

When Ralph fails repeatedly on the same thing, don't jump in and fix it. Update the environment:
1. Add guidance to AGENTS.md
2. Improve the spec
3. Add a test that would have caught it
4. Update the prompt pattern
</philosophy>

<when_to_regenerate_plan>
## When to Regenerate Plan

Discard `IMPLEMENTATION_PLAN.md` and restart planning when:
- Ralph implements wrong things or duplicates work
- Plan feels stale or mismatched to current state
- Too much completed-item clutter
- Significant spec changes made
- Confusion about actual completion status

**Cost-benefit:** One planning loop iteration is cheaper than Ralph circling on bad assumptions.

To regenerate:
```bash
rm IMPLEMENTATION_PLAN.md
./loop.sh plan
```
</when_to_regenerate_plan>

<escape_hatches>
## Escape Hatches

**Stop the loop:**
```bash
Ctrl+C  # Stops current iteration
```

**Revert uncommitted changes:**
```bash
git reset --hard
```

**Regenerate plan:**
```bash
rm IMPLEMENTATION_PLAN.md
./loop.sh plan
```

**Limit iterations:**
```bash
./loop.sh 20        # Build mode, max 20 tasks
./loop.sh plan 5    # Plan mode, max 5 iterations
```

**Review what Ralph did:**
```bash
git log --oneline
git show [commit-hash]
```
</escape_hatches>
