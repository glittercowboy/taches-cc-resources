---
name: setup-ralph
description: Sets up and configures Geoffrey Huntley's Ralph Wiggum autonomous coding loop — creates PROMPT_plan.md and PROMPT_build.md files, generates backpressure validation (tests, lints, typechecks), and initializes the iterative bash loop structure in any directory. Use when setting up Ralph Wiggum, configuring an autonomous coding loop, creating a multi-agent Claude workflow, bootstrapping parallel agentic instances, or troubleshooting an existing Ralph loop. Covers multi-agent setup, parallel Claude instances, agentic loop configuration, and backpressure-driven development.
---

<essential_principles>
## What is Ralph?

Ralph is Geoffrey Huntley's autonomous AI coding methodology that uses iterative loops with task selection, execution, and validation. In its purest form, it's a Bash loop:

```bash
while :; do cat PROMPT.md | claude ; done
```

The loop feeds a prompt file to Claude, the agent completes one task, updates the implementation plan, commits changes, then exits. The loop restarts immediately with fresh context.

### Core Insight

Ralph solves context accumulation by starting each iteration with fresh context — each loop cycle gets a clean 200K token window, avoiding the degradation that comes from long-running sessions.

### Three Phases, Two Prompts, One Loop

1. **Planning Phase**: Gap analysis (specs vs code) outputs prioritized TODO list—no implementation, no commits
2. **Building Phase**: Picks tasks from plan, implements, runs tests (backpressure), commits
3. **Observation Phase**: You sit on the loop, not in it—engineer the setup and environment that allows Ralph to succeed

### Key Principles

**Your Role**: Ralph does all the work, including deciding which planned work to implement next and how to implement it. Your job is to engineer the environment.

**Backpressure**: Create backpressure via tests, typechecks, lints, builds that reject invalid/unacceptable work.

**Observation**: Watch, especially early on. Prompts evolve through observed failure patterns.

**Context Efficiency**: With ~176K usable tokens from 200K window, allocating 40-60% to "smart zone" means tight tasks with one task per loop achieves maximum context utilization.

**File I/O as State**: The plan file persists between isolated loop executions, serving as deterministic shared state—no sophisticated orchestration needed.

**Remote Backup**: The loop automatically creates a private GitHub repo and pushes after each commit. This protects against accidental data loss from autonomous operations. Requires `gh` CLI authenticated. Disable with `RALPH_BACKUP=false`.

**Safety Rules**: PROMPT_build.md includes critical safety rules prohibiting dangerous operations like `rm -rf` on project directories. Tests must run in isolated temp directories.

### Quick Start

To bootstrap a minimal Ralph loop in an existing project:

1. Create `PROMPT_plan.md` — instructs Claude to analyze gaps between specs and code, output a prioritized TODO list, and commit only the updated plan (no implementation).
2. Create `PROMPT_build.md` — instructs Claude to pick one task from the plan, implement it, run validation (tests/lint/build), commit on success, and exit.
3. Run the loop:

```bash
# Planning pass (run once or periodically)
cat PROMPT_plan.md | claude

# Building loop (runs continuously)
while :; do cat PROMPT_build.md | claude ; done
```

Use the **setup-new-loop** workflow below for a fully scaffolded setup with backpressure, safety rules, and remote backup.
</essential_principles>

<intake>
What would you like to do?

1. **Set up a new Ralph loop** - Initialize Ralph structure in a directory
2. **Understand Ralph concepts** - Learn about the technique and how it works
3. **Customize existing loop** - Modify prompts or configuration
4. **Troubleshoot Ralph** - Debug loop issues or improve performance

Wait for response before proceeding.
</intake>

<routing>
| Response | Workflow |
|----------|----------|
| 1, "set up", "setup", "new", "initialize", "create" | `workflows/setup-new-loop.md` |
| 2, "understand", "learn", "concepts", "explain", "how" | `workflows/understand-ralph.md` |
| 3, "customize", "modify", "change", "update", "edit" | `workflows/customize-loop.md` |
| 4, "troubleshoot", "debug", "fix", "problem", "issue" | `workflows/troubleshoot-loop.md` |
| Other | Clarify intent, then select appropriate workflow |

After reading the workflow, follow it exactly.
</routing>

<reference_index>
## Domain Knowledge

All in `references/`:

**Core Concepts:** ralph-fundamentals.md - Three phases, two prompts, one loop
**Structure:** project-structure.md - Required files and directory layout
**Prompts:** prompt-design.md - Planning vs building mode instructions
**Backpressure:** validation-strategy.md - Tests, lints, builds as steering
**Best Practices:** operational-learnings.md - AGENTS.md guidance and evolution
</reference_index>

<workflows_index>
| Workflow | Purpose |
|----------|---------|
| setup-new-loop.md | Initialize Ralph structure in a directory |
| understand-ralph.md | Learn Ralph concepts and philosophy |
| customize-loop.md | Modify prompts or loop configuration |
| troubleshoot-loop.md | Debug loop issues and improve performance |
</workflows_index>

<success_criteria>
Skill is successful when:
- User understands which workflow they need
- Appropriate workflow loaded based on intent
- All required references loaded by workflow
- User can set up and run Ralph loops independently
</success_criteria>
