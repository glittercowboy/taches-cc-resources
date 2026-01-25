# Prompt Design

Guidance for writing effective planning and building mode prompts.

<prompt_principles>
## Prompt Principles

### 1. Prompts Are Signs, Not Rules

Ralph learns from:
- Existing code patterns
- AGENTS.md learnings
- Specs requirements
- Validation feedback

The prompt provides initial direction. The environment shapes actual behavior.

### 2. Start Minimal, Evolve Through Observation

Don't try to predict all failure modes. Start with simple instructions and add guidance when you observe specific failures.

**Anti-pattern:**
```markdown
IMPORTANT: Don't do X
CRITICAL: Never do Y
WARNING: Avoid Z
REMEMBER: Always check for...
```

**Better:**
```markdown
1. Study specs
2. Implement task
3. Run tests
4. Commit
```

Add specifics to `AGENTS.md` as patterns emerge.

### 3. One Clear Objective Per Mode

**Planning mode:** Gap analysis only, no implementation
**Building mode:** Implement one task, validate, commit

Mixing objectives (plan AND build) creates confusion.

### 4. Leverage Parallel Subagents

Claude Code can spawn hundreds of subagents for reading/searching. Use this:

```markdown
Study specs/* (up to 500 parallel Sonnet subagents)
```

This tells Claude it's safe and encouraged to use massive parallelism.

### 5. Context Budget Allocation

~176K usable tokens. Typical allocation:
- Prompt: ~5,000 tokens
- AGENTS.md: ~2,000 tokens
- IMPLEMENTATION_PLAN.md: ~5,000 tokens
- Specs: ~20,000 tokens
- Source code: ~100,000 tokens
- "Smart zone" (reasoning): ~40,000 tokens

Keep prompts tight to maximize smart zone.
</prompt_principles>

<planning_prompt_template>
## Planning Prompt Template

```markdown
# Planning Mode

You are Ralph, an autonomous coding agent in planning mode.

## Objective

Study specifications and existing code, then generate a prioritized implementation plan. DO NOT implement anything.

## Process

0a. Study specs/* (use up to 250 parallel Sonnet subagents)
0b. Study @IMPLEMENTATION_PLAN.md (if exists)
0c. Study src/lib/* (shared utilities to understand patterns)
0d. Reference: src/* (as needed for gap analysis)

1. Gap Analysis
   - Compare each spec against existing code
   - Identify what's missing, incomplete, or incorrect
   - IMPORTANT: Don't assume not implemented; confirm with code search first
   - Consider TODO comments, placeholders, and partial implementations

2. Generate/Update IMPLEMENTATION_PLAN.md
   - Prioritized list of tasks
   - Most important/foundational work first
   - Each task should be completable in one loop iteration
   - Include brief context for why each task matters

3. Exit
   - Do NOT implement anything
   - Do NOT commit anything
   - Just generate the plan and exit

## Success Criteria

- IMPLEMENTATION_PLAN.md exists and is prioritized
- Each task is specific and actionable
- Plan reflects actual gaps (confirmed via code search)
- No code changes made
```

**Customization points:**
- Subagent counts (250-500 depending on project size)
- Source directory structure (src/lib/*, src/features/*, etc.)
- Project-specific analysis needs
</planning_prompt_template>

<building_prompt_template>
## Building Prompt Template

```markdown
# Building Mode

You are Ralph, an autonomous coding agent in building mode.

## Objective

Select the most important task from the implementation plan, implement it correctly, validate it works, and commit.

## Process

0a. Study specs/* (use up to 500 parallel Sonnet subagents)
0b. Study @IMPLEMENTATION_PLAN.md
0c. Reference: src/* (use parallel Sonnet subagents for code reading)

1. Select Task
   - Pick the most important task from IMPLEMENTATION_PLAN.md
   - Most important = most foundational or highest priority
   - If unclear, pick the first uncompleted task

2. Investigate Before Implementing
   - Search codebase first (don't assume missing)
   - Understand existing patterns and conventions
   - Use up to 500 Sonnet subagents for reading/searching
   - Identify exactly what needs to change

3. Implement
   - Follow patterns from existing code
   - Reference specs for requirements
   - Write clean, maintainable code
   - Add tests if they don't exist

4. Validate
   - Run: [VALIDATION_COMMANDS]
   - Use only 1 Sonnet subagent for build/tests (creates backpressure)
   - If validation fails, fix and retry
   - Do not commit until validation passes

5. Update Plan
   - Mark completed task in IMPLEMENTATION_PLAN.md
   - Add any new tasks discovered during implementation
   - Note any blockers or issues found

6. Commit
   - Descriptive commit message
   - Format: "[component] brief description"
   - Push changes (if remote configured)

7. Exit
   - End loop iteration
   - Fresh context starts next iteration

## Success Criteria

- One task completed per iteration
- All validation passes
- Changes committed
- Plan updated with progress
```

**Customization points:**
- `[VALIDATION_COMMANDS]` - Project-specific tests/checks
- Subagent counts
- Source directory references
- Commit message format
- Push behavior (if using remote git)
</building_prompt_template>

<validation_commands>
## Validation Commands

Replace `[VALIDATION_COMMANDS]` with project-specific commands:

### JavaScript/TypeScript
```markdown
Run:
- npm test (or yarn test, pnpm test)
- npm run type-check (if using TypeScript)
- npm run lint (if configured)
- npm run build (if applicable)
```

### Python
```markdown
Run:
- pytest
- mypy . (if using type hints)
- ruff check . (or flake8, pylint)
- python -m build (if package)
```

### Go
```markdown
Run:
- go test ./...
- go vet ./...
- golangci-lint run (if configured)
- go build ./...
```

### Rust
```markdown
Run:
- cargo test
- cargo clippy -- -D warnings
- cargo build --release
```

### Minimal (no tooling yet)
```markdown
Run:
- [language] [test_runner] (create if missing)
- Basic smoke test (does it run?)
```

**Principle:** Validation must be automated and binary (pass/fail). If tests don't exist, Ralph should create them.
</validation_commands>

<subagent_guidance>
## Subagent Guidance

### Why Specify Counts?

Claude Code is conservative about spawning subagents unless explicitly permitted. Specifying counts signals:
- It's safe to parallelize
- High counts are acceptable
- Performance is valued

### Recommended Counts

**Reading/searching (Sonnet):**
- Small project (<100 files): 50-100 subagents
- Medium project (100-500 files): 250-500 subagents
- Large project (500+ files): 500+ subagents

**Building/testing (Sonnet):**
- Always 1 subagent
- Creates backpressure
- Sequential validation is intentional

**Why Sonnet?**
- Faster than Opus
- Cheaper than Opus
- Good enough for reading/searching and validation
- Opus is overkill for most Ralph tasks

**Specifying in prompt:**
```markdown
Study specs/* (use up to 500 parallel Sonnet subagents)
Run tests (use only 1 Sonnet subagent)
```

### Main Agent Role

The main agent (Opus or Sonnet for loop) orchestrates:
- Task selection
- Strategy decisions
- Code generation (sometimes delegates to subagents)
- Plan updates

Keep main agent focused on reasoning, delegate I/O to subagents.
</subagent_guidance>

<prompts_evolve>
## Prompts Evolve

### Initial Prompt (Minimal)

Start with basic structure:
```markdown
1. Study specs
2. Pick task from plan
3. Implement
4. Run tests
5. Commit
```

### After Observing Failures

Ralph keeps reimplementing the same thing? Add:
```markdown
2a. Search existing code first (don't assume missing)
```

Ralph writes inconsistent code? Add:
```markdown
3a. Study existing patterns in src/lib/*
3b. Match existing code style and conventions
```

Ralph doesn't update plan? Add:
```markdown
5a. Mark task complete in IMPLEMENTATION_PLAN.md
5b. Note any new tasks discovered
```

### After Many Iterations

Prompts accumulate learnings. But watch for:
- Too many rules (sign of over-steering)
- Contradictory guidance
- Outdated assumptions

Periodically review and simplify. Move stable patterns to `AGENTS.md`.
</prompts_evolve>

<common_prompt_mistakes>
## Common Prompt Mistakes

### Mistake 1: Mixing Modes

**Bad:**
```markdown
Generate a plan, then start implementing the first task...
```

**Good:**
```markdown
Planning mode: Generate plan only, do not implement
Building mode: Implement from plan, one task per iteration
```

### Mistake 2: Over-Specifying

**Bad:**
```markdown
CRITICAL: Before implementing, you must:
1. Read all files in src/
2. Check for existing implementations of similar features
3. Review the git history for context
4. Consider performance implications
5. Think about edge cases
6. Validate against all specs
...
```

**Good:**
```markdown
1. Search existing code
2. Implement task
3. Run tests
```

Let Ralph figure out the details. Add specifics only when failures occur.

### Mistake 3: Assuming Sequential Reading

**Bad:**
```markdown
Read spec-1.md, then spec-2.md, then spec-3.md...
```

**Good:**
```markdown
Study specs/* (use up to 500 parallel Sonnet subagents)
```

Claude can read hundreds of files simultaneously. Let it.

### Mistake 4: No Clear Exit

**Bad:**
```markdown
Implement tasks from the plan until everything is done...
```

**Good:**
```markdown
6. Exit
   - End this loop iteration
   - One task per iteration
   - Loop will restart with fresh context
```

Ralph needs to know when to exit. Otherwise it may try to do multiple tasks or wait for input.

### Mistake 5: Vague Validation

**Bad:**
```markdown
Make sure everything works before committing...
```

**Good:**
```markdown
4. Validate
   - Run: npm test
   - Run: npm run type-check
   - If any fail, fix and retry
   - Do not commit until all pass
```

Concrete commands create reliable backpressure.
</common_prompt_mistakes>

<context_references>
## Context References

Use `@filename` to ensure files are loaded into context:

```markdown
0b. Study @IMPLEMENTATION_PLAN.md
```

This tells Claude Code to inline the file content, guaranteeing it's in context.

**When to use:**
- Critical files that must be loaded (plan, specs)
- Files Ralph needs for every iteration
- Relatively small files (<10K tokens)

**When not to use:**
- Large directories (use parallel subagents instead)
- Optional reference files
- Files that may not exist yet
</context_references>
