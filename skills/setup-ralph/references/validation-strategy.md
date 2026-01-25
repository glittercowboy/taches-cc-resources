# Validation Strategy

Using tests, lints, and builds as backpressure to steer Ralph.

<what_is_backpressure>
## What is Backpressure?

Backpressure is automated validation that rejects invalid work. It creates a self-correcting feedback loop:

1. Ralph implements task
2. Validation runs (tests, type checks, lints)
3. If validation fails, Ralph investigates and fixes
4. Loop continues until validation passes
5. Only then can Ralph commit and move to next task

**Without backpressure:** Ralph generates code that may not work, accumulates errors, goes off track.

**With backpressure:** Ralph must produce working code to progress. Quality is enforced, not hoped for.
</what_is_backpressure>

<types_of_backpressure>
## Types of Backpressure

### 1. Tests (Most Important)

**Unit tests:** Verify individual functions/components
**Integration tests:** Verify components work together
**End-to-end tests:** Verify full user workflows

**Why tests are critical:**
- Binary pass/fail (no ambiguity)
- Fast feedback (run every iteration)
- Specific to requirements (aligned with specs)
- Self-documenting (show expected behavior)

**If no tests exist:**
Ralph should create them as part of implementation. Update building prompt:

```markdown
3. Implement
   - Write the functionality
   - Add tests for new functionality
   - Ensure tests pass
```

### 2. Type Checking

**TypeScript:** `tsc --noEmit` or `npm run type-check`
**Python:** `mypy .`
**Go:** Built into `go build`
**Rust:** Built into `cargo build`

**Benefits:**
- Catches type errors before runtime
- Enforces interface contracts
- Prevents common bugs

**Limitation:**
- Types can be correct but logic wrong
- Needs tests for behavior validation

### 3. Linting

**JavaScript/TypeScript:** ESLint, Biome
**Python:** Ruff, flake8, pylint
**Go:** golangci-lint
**Rust:** clippy

**Benefits:**
- Enforces code style
- Catches common mistakes
- Maintains consistency

**Limitation:**
- Style != correctness
- Can be overly strict
- May slow down loop if too many rules

**Recommendation:** Start with minimal linting, add rules as patterns emerge.

### 4. Builds

**Compiled languages:** Ensure code compiles
**Bundlers:** Ensure assets bundle correctly
**Docker:** Ensure containers build

**Benefits:**
- Catches syntax errors
- Verifies dependencies
- Confirms deployment readiness

**Limitation:**
- Build success != working software
- Slower than tests (use sparingly in loop)

### 5. Custom Validation

**Example: Visual regression tests**
- Screenshot comparison
- LLM-as-judge for subjective criteria

**Example: Performance benchmarks**
- Response time thresholds
- Memory usage limits

**Example: Security scans**
- Dependency vulnerability checks
- Static analysis for common issues

**When to use:**
- Project-specific quality criteria
- Subjective acceptance criteria
- Non-functional requirements
</types_of_backpressure>

<validation_levels>
## Validation Levels

Choose based on project maturity and speed needs:

### Level 1: Tests Only (Fastest)
```markdown
Run: npm test
```

**When to use:**
- Early development
- Fast iteration needed
- No type system or linting configured

**Pros:** Fast loop, minimal friction
**Cons:** May accumulate style inconsistencies

### Level 2: Tests + Type Checking (Recommended)
```markdown
Run:
- npm test
- npm run type-check
```

**When to use:**
- TypeScript/typed projects
- After initial implementation phase
- When interfaces are stabilizing

**Pros:** Good balance of speed and quality
**Cons:** Type errors can slow down loop

### Level 3: Full Validation (Slowest)
```markdown
Run:
- npm test
- npm run type-check
- npm run lint
- npm run build
```

**When to use:**
- Mature projects
- Pre-release quality gates
- When consistency is critical

**Pros:** Highest quality output
**Cons:** Slowest loop, most friction

### Level 4: Custom Validation
```markdown
Run:
- npm test
- npm run type-check
- npm run visual-test
- npm run security-scan
```

**When to use:**
- Specific quality requirements
- Regulated industries
- User-facing products

**Pros:** Tailored to actual needs
**Cons:** Complex to set up and maintain
</validation_levels>

<validation_in_prompts>
## Validation in Prompts

### Planning Mode

No validation needed. Planning mode doesn't change code.

### Building Mode

Include validation as a required step:

```markdown
4. Validate
   - Run: [specific commands]
   - Use only 1 Sonnet subagent for build/tests
   - If validation fails, investigate and fix
   - Do not commit until all validation passes
   - If repeatedly failing (3+ attempts), note blocker and move on
```

**Key points:**
- Specific commands (not vague "make sure it works")
- Single subagent for validation (creates backpressure bottleneck)
- Failure requires investigation and fix
- Escape hatch for stuck tasks (note blocker, move on)
</validation_in_prompts>

<handling_validation_failures>
## Handling Validation Failures

### Expected Behavior

Ralph should:
1. See validation failure
2. Read error messages
3. Investigate cause
4. Fix the issue
5. Re-run validation
6. Repeat until passing

### Failure Patterns

**Pattern 1: Test failure due to incorrect implementation**
- Ralph implemented wrong behavior
- Fix: Update implementation to match spec

**Pattern 2: Test failure due to incorrect test**
- Spec changed but test didn't
- Fix: Update test to match current spec

**Pattern 3: Type error due to API mismatch**
- Ralph used wrong types
- Fix: Correct types based on definitions

**Pattern 4: Lint error due to style**
- Code works but style is off
- Fix: Adjust formatting

**Pattern 5: Build failure due to missing dependency**
- Imported something not installed
- Fix: Add dependency or use different approach

### Stuck in Loop

If Ralph repeatedly fails validation (3+ iterations on same task):

**Option 1: Note blocker and skip**
```markdown
If repeatedly failing (3+ attempts), note blocker in plan and move to next task
```

**Option 2: Regenerate plan**
```bash
rm IMPLEMENTATION_PLAN.md
./loop.sh plan
```

**Option 3: Manual intervention**
```bash
# Stop loop
Ctrl+C

# Fix the issue manually
# Commit fix

# Restart loop
./loop.sh
```

**Option 4: Update AGENTS.md**
Add guidance about the failure pattern so Ralph doesn't repeat it.
</handling_validation_failures>

<backpressure_as_learning>
## Backpressure as Learning

Validation failures teach Ralph:
- What "working" means for this project
- Edge cases to handle
- Patterns to follow
- Mistakes to avoid

Over time, validation failures should decrease as Ralph learns project patterns.

**Early loops:**
- Many validation failures
- Ralph learning patterns
- Prompts and AGENTS.md evolving

**Later loops:**
- Fewer validation failures
- Ralph aligned with patterns
- Stable prompts and learnings

**If failures increase:**
- Specs may have changed
- New complexity introduced
- Prompts may need update
- Consider plan regeneration
</backpressure_as_learning>

<no_tests_strategy>
## No Tests? Start Here

If project has no tests:

### Option 1: Ralph Creates Tests

Update building prompt:
```markdown
3. Implement
   - Write the functionality
   - Add unit tests for new functionality
   - Ensure tests pass before proceeding
```

Ralph will create tests as it implements features.

### Option 2: Add Minimal Test Framework

Before starting loop:
```bash
# JavaScript/TypeScript
npm install --save-dev vitest
# or jest, or your preferred framework

# Python
pip install pytest

# Go
# Built-in, just use: go test ./...

# Rust
# Built-in, just use: cargo test
```

Create one example test to establish pattern.

### Option 3: Use Type Checking Only

If tests are too much overhead initially:
```markdown
4. Validate
   - Run: tsc --noEmit  # or equivalent
   - Type errors must be fixed
```

Better than nothing. Add tests later when patterns stabilize.

### Option 4: Manual Smoke Tests

Define manual checks in AGENTS.md:
```markdown
## Validation

After each change:
- Run the application
- Test the changed feature manually
- Verify no errors in console
```

Not ideal (not automated) but establishes quality baseline.
</no_tests_strategy>

<tuning_backpressure>
## Tuning Backpressure

Start strict, loosen if too slow:

**Week 1:** Full validation (tests + types + lint + build)
- See where Ralph struggles
- Identify slow validation steps
- Note which checks catch real issues

**Week 2:** Remove low-value checks
- If linting catches nothing, remove it
- If build is slow and redundant with tests, remove it
- Keep only checks that catch real problems

**Week 3:** Add custom checks
- Based on observed failure patterns
- Aligned with actual quality needs
- Fast enough to not slow loop significantly

**Ongoing:** Evolve with project
- Add checks when new failure patterns emerge
- Remove checks when no longer catching issues
- Balance speed vs quality based on project phase
</tuning_backpressure>
