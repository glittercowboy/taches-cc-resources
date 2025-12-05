---
name: spec-story
description: Create technical specifications from user stories. Use when converting story files into detailed technical specs that can be executed. Produces structured spec files ready for implementation.
---

<essential_principles>

<principle name="spec_is_executable">
Technical specs are implementation-ready documents.
They contain enough detail for Claude to execute without ambiguity.
Specs answer: What files change? What logic is added? How is it tested?
</principle>

<principle name="spec_bridges_story_and_code">
Specs translate user needs into technical decisions.
Story says WHAT user wants. Spec says HOW we'll build it.
</principle>

<principle name="traceability">
Every spec links to parent story and epic.
Every spec becomes a PLAN.md for execution.
Chain: Epic → Story → Spec → Code
</principle>

<principle name="output_structure">
Specs are markdown files in .workflow/specs/:
- spec-001-user-signup.md
- spec-002-user-login.md
- spec-003-password-reset.md

Each spec includes:
- Technical approach
- Files to modify/create
- API contracts
- Database changes
- Testing requirements
- Success verification
</principle>

</essential_principles>

<intake>
**Technical spec creation from story**

Provide the path to your story file.

Example:
- `.workflow/stories/story-001-user-signup.md`
- `.workflow/stories/story-002-task-creation.md`

**Wait for file path before proceeding.**
</intake>

<routing>
After receiving story file path:

1. **Read the story**: Load the story document
2. **Read parent epic**: For additional context
3. **Read template**: Load templates/spec.md
4. **Read patterns**: Load references/spec-patterns.md
5. **Execute workflow**: workflows/create-spec-from-story.md

**Single workflow path - no branching needed.**
</routing>

<validation>
Before completing, verify:
- [ ] Spec saved to .workflow/specs/
- [ ] All files to change identified
- [ ] API contracts defined
- [ ] Testing requirements specified
- [ ] Links to parent story and epic
- [ ] Acceptance criteria mapped to verification steps
</validation>

<success_criteria>
Spec creation successful when:
1. Spec file written to .workflow/specs/
2. Technical approach is clear and executable
3. All file changes documented
4. Testing requirements defined
5. User can proceed to implementation with /dev-story
</success_criteria>

<reference_index>
## Domain Knowledge

All in `references/`:

**spec-patterns.md** - Technical spec patterns and examples
**testing-requirements.md** - How to specify testing needs
</reference_index>

<workflows_index>
## Workflows

All in `workflows/`:

| Workflow | Purpose |
|----------|---------|
| create-spec-from-story.md | Generate technical spec from story |
| validate-spec.md | Check spec completeness and executability |
</workflows_index>
