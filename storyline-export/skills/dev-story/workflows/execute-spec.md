<objective>
Convert technical spec into executable PLAN.md and implement using create-plans skill.
</objective>

<required_reading>
- references/spec-to-plan-conversion.md - Conversion guidelines
</required_reading>

<process>

## Step 1: Read Spec and Context

1. Read the technical spec file provided by user
2. Read parent story file (linked in spec frontmatter)
3. Read references/spec-to-plan-conversion.md

## Step 2: Extract Plan Components

From the spec, extract:

**Objective:**
- What we're building (from spec Overview)

**Context files:**
- Files mentioned in "Files to Modify" section
- Related components referenced

**Tasks:**
- Each file creation = 1 task
- Each file modification = 1 task
- Database migrations = 1 task
- Test creation = 1 task

**Verification:**
- From "Success Verification" section
- From "Acceptance Criteria Mapping" section

**Success criteria:**
- From parent story acceptance criteria
- From spec success verification

## Step 3: Break Into Atomic Plans

Apply create-plans atomicity principle:
- **Maximum 2-3 tasks per plan**
- Split large specs into multiple plans

Example breakdown:
```
spec-001-user-signup.md →
  01-01-PLAN.md (Database schema + migration)
  01-02-PLAN.md (Backend API endpoint)
  01-03-PLAN.md (Frontend form component)
  01-04-PLAN.md (Tests and verification)
```

## Step 4: Create PLAN.md File(s)

For each atomic plan:

1. **Create directory**: `.workflow/.planning/story-{number}/`

2. **Write PLAN.md** following create-plans format:

```markdown
---
phase_id: story-{number}-{segment}
spec_source: .workflow/specs/spec-{number}-{slug}.md
story_source: .workflow/stories/story-{number}-{slug}.md
---

<objective>
{From spec overview - what we're building in this segment}
</objective>

<execution_context>
Essential reading before executing ANY tasks:

@.workflow/specs/spec-{number}-{slug}.md - Technical spec for this story
@.workflow/stories/story-{number}-{slug}.md - Parent story with acceptance criteria

**Execution protocol:**
- Follow deviation rules (auto-fix bugs, ask architectural, etc.)
- All deviations documented in SUMMARY.md
- Link SUMMARY back to story
</execution_context>

<context>
{@file references from spec - files being modified}
</context>

<tasks>

<task type="auto">
<id>1</id>
<description>
{Task description from spec}
</description>
<files>
{Files to create/modify}
</files>
<action>
{Specific implementation steps from spec}
</action>
<verify>
{How to verify this task completed}
</verify>
<done>
{Definition of done for this task}
</done>
</task>

<task type="auto">
<id>2</id>
...
</task>

</tasks>

<verification>
{Overall verification for this plan segment}
</verification>

<success_criteria>
{Success criteria from story - subset relevant to this segment}
</success_criteria>

<output>
Create SUMMARY.md in same directory with:
- Tasks completed
- Files modified
- Deviations (if any)
- Tests added
- Verification results
- Link to parent story: .workflow/stories/story-{number}-{slug}.md
- Commit hash
</output>
```

## Step 5: Execute Using create-plans

For each PLAN.md created:

Invoke the create-plans execution flow:
```
Read the PLAN.md at .workflow/.planning/story-{number}/01-01-PLAN.md

Execute all tasks following:
- Deviation rules from create-plans
- Checkpoint protocols (if any)
- Context management
- Quality controls

Generate SUMMARY.md with:
- Implementation results
- Link back to story and spec
- Commit information
```

**Note:** Don't invoke create-plans skill directly.
Instead, execute the plan following create-plans patterns.

## Step 6: Verify Story Completion

After all plan segments execute:

1. Check story acceptance criteria:
   - Each criterion from story verified
   - Tests written and passing
   - Manual verification completed (if needed)

2. Update story status:
   - Edit .workflow/stories/story-{number}-{slug}.md
   - Change `status: ready_for_spec` → `status: implemented`
   - Add implementation reference

3. Create story completion summary:

```markdown
## Implementation Summary

**Spec:** .workflow/specs/spec-{number}-{slug}.md
**Plans executed:**
- .workflow/.planning/story-{number}/01-01-PLAN.md
- .workflow/.planning/story-{number}/01-02-PLAN.md

**Commits:**
- {commit hash}: {message}
- {commit hash}: {message}

**Acceptance criteria:**
- [x] Criterion 1 - Verified
- [x] Criterion 2 - Verified
- [x] Criterion 3 - Verified

**Status:** ✅ Complete
```

</process>

<output_specification>
Creates:
- .workflow/.planning/story-{number}/01-01-PLAN.md
- .workflow/.planning/story-{number}/01-01-SUMMARY.md
- .workflow/.planning/story-{number}/01-0N-PLAN.md (if needed)
- .workflow/.planning/story-{number}/01-0N-SUMMARY.md

Updates:
- .workflow/stories/story-{number}-{slug}.md (status → implemented)

Produces:
- Working code implementing the spec
- Git commits
- Tests
- Summary linking back to story
</output_specification>

<success_criteria>
Complete when:
1. All plan segments executed
2. All SUMMARY.md files created
3. Story acceptance criteria verified
4. Story status updated to implemented
5. User informed of completion
</success_criteria>
