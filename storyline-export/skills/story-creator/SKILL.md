---
name: story-creator
description: Generate user stories from epics. Use when converting epic files into detailed user stories following INVEST criteria. Produces structured story files that feed into technical spec creation.
---

<essential_principles>

<principle name="invest_criteria">
All stories must follow INVEST:
- Independent: Can be developed separately
- Negotiable: Details can be refined
- Valuable: Delivers user/business value
- Estimable: Can be sized
- Small: Fits in a sprint
- Testable: Has clear acceptance criteria
</principle>

<principle name="story_is_conversation_starter">
User stories are not complete specifications.
They are conversation starters that get elaborated into technical specs.
Format: "As a [persona], I want [capability], so that [benefit]"
</principle>

<principle name="traceability">
Every story links back to parent epic.
Every story generates technical spec.
Chain: Epic → Story → Spec → Code
</principle>

<principle name="output_structure">
Stories are markdown files in .workflow/stories/:
- story-001-user-signup.md
- story-002-user-login.md
- story-003-password-reset.md

Each story includes:
- User story statement
- Acceptance criteria
- Business value
- Technical notes
- Link to parent epic
</principle>

</essential_principles>

<intake>
**Story creation from epic**

Provide the path to your epic file.

Example:
- `.workflow/epics/epic-001-authentication.md`
- `.workflow/epics/epic-002-task-management.md`

**Wait for file path before proceeding.**
</intake>

<routing>
After receiving epic file path:

1. **Read the epic**: Load the epic document
2. **Read template**: Load templates/story.md
3. **Read patterns**: Load references/story-patterns.md
4. **Execute workflow**: workflows/create-stories-from-epic.md

**Single workflow path - no branching needed.**
</routing>

<validation>
Before completing, verify:
- [ ] All stories saved to .workflow/stories/
- [ ] Each story follows INVEST criteria
- [ ] Story numbers sequential
- [ ] Each story has acceptance criteria
- [ ] All stories link back to parent epic
- [ ] Created story index for this epic
</validation>

<success_criteria>
Story creation successful when:
1. All stories written to .workflow/stories/
2. Each story validates against INVEST criteria
3. Story index created
4. User can proceed to spec creation with /spec-story
</success_criteria>

<reference_index>
## Domain Knowledge

All in `references/`:

**story-patterns.md** - Common story patterns and INVEST examples
**acceptance-criteria.md** - How to write good acceptance criteria
</reference_index>

<workflows_index>
## Workflows

All in `workflows/`:

| Workflow | Purpose |
|----------|---------|
| create-stories-from-epic.md | Generate stories from epic file |
| validate-story.md | Check story quality and INVEST compliance |
</workflows_index>
