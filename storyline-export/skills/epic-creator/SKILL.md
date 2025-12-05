---
name: epic-creator
description: Parse PRDs and technical specs into manageable epics. Use when converting product requirements documents or technical specifications into epic-level work items. Produces structured epic files that feed into story creation.
---

<essential_principles>

<principle name="epic_is_theme">
An epic is a theme or large feature area, not a task list.
Epics group related user stories under a common business goal.
</principle>

<principle name="right_sized_epics">
Epics should be:
- Too large for a single sprint (requires multiple stories)
- Small enough to ship in 2-4 weeks
- Focused on a single business capability
</principle>

<principle name="traceability">
Every epic links back to the source PRD/spec.
Every epic generates multiple stories.
Full chain: PRD → Epic → Story → Spec → Code
</principle>

<principle name="output_structure">
Epics are markdown files in .workflow/epics/:
- epic-001-authentication.md
- epic-002-task-management.md
- epic-003-notifications.md

Each epic includes:
- Business goal (why this matters)
- Success criteria (what done looks like)
- User value (who benefits and how)
- Scope boundaries (what's in/out)
- Related epics (dependencies)
</principle>

</essential_principles>

<intake>
**Epic creation from PRD/spec**

Provide the path to your PRD or technical spec document.

Example:
- `docs/PRD.md`
- `.workflow/technical-spec.md`
- `requirements/product-requirements.md`

**Wait for file path before proceeding.**
</intake>

<routing>
After receiving file path:

1. **Read the PRD/spec**: Load the document using Read tool
2. **Analyze complexity**: Determine if single-epic or multi-epic
3. **Route to workflow**:
   - Small feature (1-2 main capabilities) → workflows/create-single-epic.md
   - Large project (3+ main capabilities) → workflows/create-multi-epic.md

**Automatic routing based on content analysis, no user prompt needed.**
</routing>

<validation>
Before completing, verify:
- [ ] All epics saved to .workflow/epics/
- [ ] Each epic follows template structure
- [ ] Epic numbers sequential (001, 002, 003)
- [ ] Each epic has clear business goal
- [ ] Success criteria are measurable
- [ ] Dependencies identified
- [ ] Created epic index file (.workflow/epics/INDEX.md)
</validation>

<success_criteria>
Epic creation successful when:
1. All epics written to .workflow/epics/
2. Each epic file validates against template
3. INDEX.md created with epic summary
4. User can proceed to story creation with /story-creator
</success_criteria>

<reference_index>
## Domain Knowledge

All in `references/`:

**epic-patterns.md** - Common epic patterns and anti-patterns
**prd-parsing.md** - How to extract epics from different PRD formats
**scope-sizing.md** - Guidelines for right-sizing epics
</reference_index>

<workflows_index>
## Workflows

All in `workflows/`:

| Workflow | Purpose |
|----------|---------|
| create-single-epic.md | Simple feature → one epic |
| create-multi-epic.md | Complex project → multiple epics |
| validate-epic.md | Check epic quality and completeness |
</workflows_index>
