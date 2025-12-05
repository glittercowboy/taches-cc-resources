<objective>
Parse PRD/spec into multiple epics, each representing a major feature area or business capability.
</objective>

<required_reading>
- templates/epic.md - Epic file structure
- references/epic-patterns.md - Common patterns
</required_reading>

<process>

## Step 1: Read Reference Files

Read the following to understand epic structure:
- Read templates/epic.md
- Read references/epic-patterns.md

## Step 2: Analyze PRD Content

Extract from the PRD:
1. **Core features** - Major capabilities mentioned
2. **User personas** - Who will use this
3. **Business goals** - Why we're building this
4. **Technical scope** - What systems/domains involved
5. **Dependencies** - What depends on what

## Step 3: Identify Epic Boundaries

Group features into epics based on:
- **Business capability** - Authentication, payments, notifications, etc.
- **User journey stage** - Onboarding, core workflow, admin, etc.
- **Technical domain** - Frontend, backend, infrastructure, etc.
- **Dependencies** - What must be built first

**Epic size target:** Each epic should contain 3-8 user stories.

## Step 4: Create Epic Files

For each identified epic:

1. **Create file** in .workflow/epics/
   - Naming: `epic-{number}-{slug}.md`
   - Example: `epic-001-authentication.md`

2. **Use template** from templates/epic.md

3. **Fill sections:**
   - Epic ID and title
   - Business goal (the "why")
   - User value proposition
   - Success criteria (measurable)
   - Scope (what's in/out)
   - Dependencies on other epics
   - Estimated story count
   - Link back to source PRD

4. **Write the file** using Write tool

## Step 5: Create Epic Index

Create `.workflow/epics/INDEX.md`:

```markdown
# Epic Index

Generated from: [source PRD path]
Created: [date]
Total epics: [count]

## Epics

### Epic 001: [Title]
**Goal:** [One sentence]
**Stories:** ~[count]
**Status:** Ready for story creation

### Epic 002: [Title]
...

## Execution Order

Recommended sequence based on dependencies:
1. Epic 001 (no dependencies)
2. Epic 002 (depends on: 001)
3. Epic 003 (depends on: 001, 002)

## Next Steps

Run `/story-creator .workflow/epics/epic-001-[slug].md` to begin.
```

## Step 6: Validate Output

Run validation checks:
- All epic files created successfully
- Epic numbers are sequential
- Each epic has all required sections
- Dependencies are valid (no circular deps)
- Success criteria are measurable
- INDEX.md created

</process>

<output_specification>
Creates:
- .workflow/epics/epic-001-{slug}.md
- .workflow/epics/epic-002-{slug}.md
- .workflow/epics/epic-00N-{slug}.md
- .workflow/epics/INDEX.md

Each epic file contains:
- YAML frontmatter (epic_id, title, status)
- Business goal section
- User value section
- Success criteria
- Scope definition
- Dependencies
- Metadata (source, created date)
</output_specification>

<success_criteria>
Complete when:
1. All epic files written to .workflow/epics/
2. INDEX.md created
3. Validation checks pass
4. User informed of next step (/story-creator)
</success_criteria>
