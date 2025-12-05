---
name: dev-story
description: Execute technical specs using autonomous planning. Use when ready to implement a technical spec file. Converts specs into executable plans and invokes create-plans for implementation.
---

<essential_principles>

<principle name="spec_to_plan_conversion">
Technical specs are detailed design documents.
PLAN.md files are executable prompts for Claude.
This skill bridges the gap: Spec → PLAN.md → Execution
</principle>

<principle name="leverage_create_plans">
Don't reinvent planning/execution.
Use the battle-tested create-plans skill from taches-cc-resources.
This skill focuses on spec → plan conversion only.
</principle>

<principle name="atomic_execution">
Follow create-plans principles:
- 2-3 tasks per plan maximum
- Aggressive atomicity prevents quality degradation
- Each plan is independently verifiable
</principle>

<principle name="full_traceability">
Link implementation back to spec, story, and epic.
SUMMARY.md should reference the original story.
Chain: Epic → Story → Spec → Plan → Code → Summary
</principle>

</essential_principles>

<intake>
**Execute technical spec**

Provide the path to your technical spec file.

Example:
- `.workflow/specs/spec-001-user-signup.md`
- `.workflow/specs/spec-002-task-creation.md`

**Wait for file path before proceeding.**
</intake>

<routing>
After receiving spec file path:

1. **Read the spec**: Load the technical spec
2. **Read parent story**: For acceptance criteria
3. **Read references**: Load references/spec-to-plan-conversion.md
4. **Execute workflow**: workflows/execute-spec.md

**Single workflow path.**
</routing>

<process_overview>
1. Read spec and extract implementation requirements
2. Convert spec into PLAN.md format (create-plans structure)
3. Write PLAN.md to .workflow/.planning/
4. Invoke create-plans skill to execute the plan
5. Verify SUMMARY.md links back to story
</process_overview>

<success_criteria>
Spec execution successful when:
1. PLAN.md created from spec
2. create-plans executed successfully
3. SUMMARY.md generated
4. All acceptance criteria from story verified
5. Implementation committed to git
</success_criteria>

<reference_index>
## Domain Knowledge

All in `references/`:

**spec-to-plan-conversion.md** - How to convert specs into executable plans
</reference_index>

<workflows_index>
## Workflows

All in `workflows/`:

| Workflow | Purpose |
|----------|---------|
| execute-spec.md | Convert spec to plan and execute |
</workflows_index>
