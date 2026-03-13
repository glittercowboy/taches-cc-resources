---
name: create-meta-prompts
description: Creates optimized prompts for Claude-to-Claude pipelines by designing stage handoffs, structuring intermediate outputs with XML metadata, and optimizing prompt chaining across research, planning, and execution stages. Handles multi-stage workflows where each prompt produces structured artifacts for subsequent prompts to consume. Use when building prompt chains, agentic workflows, multi-step Claude pipelines, designing prompts that feed into other prompts, or orchestrating Claude-to-Claude communication.
---

<objective>
Create prompts optimized for Claude-to-Claude communication in multi-stage workflows. Outputs are structured with XML and metadata for efficient parsing by subsequent prompts.

Every execution produces a `SUMMARY.md` for quick human scanning without reading full outputs.

Each prompt gets its own folder in `.prompts/` with its output artifacts, enabling clear provenance and chain detection.
</objective>

<quick_start>
<workflow>
1. **Intake**: Determine purpose (Do/Plan/Research/Refine), gather requirements
2. **Chain detection**: Check for existing research/plan files to reference
3. **Generate**: Create prompt using purpose-specific patterns
4. **Save**: Create folder in `.prompts/{number}-{topic}-{purpose}/`
5. **Present**: Show decision tree for running
6. **Execute**: Run prompt(s) with dependency-aware execution engine
7. **Summarize**: Create SUMMARY.md for human scanning
</workflow>

<folder_structure>
```
.prompts/
├── 001-auth-research/
│   ├── completed/
│   │   └── 001-auth-research.md    # Prompt (archived after run)
│   ├── auth-research.md            # Full output (XML for Claude)
│   └── SUMMARY.md                  # Executive summary (markdown for human)
├── 002-auth-plan/
│   ├── completed/
│   │   └── 002-auth-plan.md
│   ├── auth-plan.md
│   └── SUMMARY.md
├── 003-auth-implement/
│   ├── completed/
│   │   └── 003-auth-implement.md
│   └── SUMMARY.md                  # Do prompts create code elsewhere
├── 004-auth-research-refine/
│   ├── completed/
│   │   └── 004-auth-research-refine.md
│   ├── archive/
│   │   └── auth-research-v1.md     # Previous version
│   └── SUMMARY.md
```
</folder_structure>
</quick_start>

<context>
Prompts directory: !`[ -d ./.prompts ] && echo "exists" || echo "missing"`
Existing research/plans: !`find ./.prompts -name "*-research.md" -o -name "*-plan.md" 2>/dev/null | head -10`
Next prompt number: !`ls -d ./.prompts/*/ 2>/dev/null | wc -l | xargs -I {} expr {} + 1`
</context>

<automated_workflow>

<step_0_intake_gate>
<title>Adaptive Requirements Gathering</title>

<critical_first_action>
**BEFORE analyzing anything**, check if context was provided.

IF no context provided (skill invoked without description):
→ **IMMEDIATELY use AskUserQuestion** with:

- header: "Purpose"
- question: "What is the purpose of this prompt?"
- options:
  - "Do" - Execute a task, produce an artifact
  - "Plan" - Create an approach, roadmap, or strategy
  - "Research" - Gather information or understand something
  - "Refine" - Improve an existing research or plan output

After selection, ask: "Describe what you want to accomplish" (they select "Other" to provide free text).

IF context was provided:
→ Check if purpose is inferable from keywords:
  - `implement`, `build`, `create`, `fix`, `add`, `refactor` → Do
  - `plan`, `roadmap`, `approach`, `strategy`, `decide`, `phases` → Plan
  - `research`, `understand`, `learn`, `gather`, `analyze`, `explore` → Research
  - `refine`, `improve`, `deepen`, `expand`, `iterate`, `update` → Refine

→ If unclear, ask the Purpose question above as first contextual question
→ If clear, proceed to adaptive_analysis with inferred purpose
</critical_first_action>

<adaptive_analysis>
Extract and infer:

- **Purpose**: Do, Plan, Research, or Refine
- **Topic identifier**: Kebab-case identifier for file naming (e.g., `auth`, `stripe-payments`)
- **Complexity**: Simple vs complex (affects prompt depth)
- **Prompt structure**: Single vs multiple prompts
- **Target** (Refine only): Which existing output to improve

If topic identifier not obvious, ask:
- header: "Topic"
- question: "What topic/feature is this for? (used for file naming)"
- Let user provide via "Other" option
- Enforce kebab-case (convert spaces/underscores to hyphens)

For Refine purpose, also identify target output from `.prompts/*/` to improve.
</adaptive_analysis>

<chain_detection>
Scan `.prompts/*/` for existing `*-research.md` and `*-plan.md` files.

If found:
1. List them: "Found existing files: auth-research.md (in 001-auth-research/), stripe-plan.md (in 005-stripe-plan/)"
2. Use AskUserQuestion:
   - header: "Reference"
   - question: "Should this prompt reference any existing research or plans?"
   - options: List found files + "None"
   - multiSelect: true

Match by topic keyword when possible (e.g., "auth plan" → suggest auth-research.md).
</chain_detection>

<contextual_questioning>
Generate 2-4 questions using AskUserQuestion based on purpose and gaps.

Load questions from: [references/question-bank.md](references/question-bank.md)

Route by purpose:
- Do → artifact type, scope, approach
- Plan → plan purpose, format, constraints
- Research → depth, sources, output format
- Refine → target selection, feedback, preservation
</contextual_questioning>

<decision_gate>
After receiving answers, present decision gate using AskUserQuestion:

- header: "Ready"
- question: "Ready to create the prompt?"
- options:
  - "Proceed" - Create the prompt with current context
  - "Ask more questions" - I have more details to clarify
  - "Let me add context" - I want to provide additional information

Loop until "Proceed" selected.
</decision_gate>

<finalization>
After "Proceed" selected, state confirmation:

"Creating a {purpose} prompt for: {topic}
Folder: .prompts/{number}-{topic}-{purpose}/
References: {list any chained files}"

Then proceed to generation.
</finalization>
</step_0_intake_gate>

<step_1_generate>
<title>Generate Prompt</title>

Load purpose-specific patterns:
- Do: [references/do-patterns.md](references/do-patterns.md)
- Plan: [references/plan-patterns.md](references/plan-patterns.md)
- Research: [references/research-patterns.md](references/research-patterns.md)
- Refine: [references/refine-patterns.md](references/refine-patterns.md)

Load intelligence rules: [references/intelligence-rules.md](references/intelligence-rules.md)

<prompt_structure>
All generated prompts include:

1. **Objective**: What to accomplish, why it matters
2. **Context**: Referenced files (@), dynamic context (!)
3. **Requirements**: Specific instructions for the task
4. **Output specification**: Where to save, what structure
5. **Metadata requirements**: For research/plan outputs, specify XML metadata structure
6. **SUMMARY.md requirement**: All prompts must create a SUMMARY.md file
7. **Success criteria**: How to know it worked

For Research and Plan prompts, output must include:
- `<confidence>` - How confident in findings
- `<dependencies>` - What's needed to proceed
- `<open_questions>` - What remains uncertain
- `<assumptions>` - What was assumed

All prompts must create `SUMMARY.md` with:
- **One-liner** - Substantive description of outcome
- **Version** - v1 or iteration info
- **Key Findings** - Actionable takeaways
- **Files Created** - (Do prompts only)
- **Decisions Needed** - What requires user input
- **Blockers** - External impediments
- **Next Step** - Concrete forward action
</prompt_structure>

<file_creation>
1. Create folder: `.prompts/{number}-{topic}-{purpose}/`
2. Create `completed/` subfolder
3. Write prompt to: `.prompts/{number}-{topic}-{purpose}/{number}-{topic}-{purpose}.md`
4. Prompt instructs output to: `.prompts/{number}-{topic}-{purpose}/{topic}-{purpose}.md`
</file_creation>
</step_1_generate>

<step_2_present>
<title>Present Decision Tree</title>

After saving prompt(s), present inline (not AskUserQuestion):

<single_prompt_presentation>
```
Prompt created: .prompts/{number}-{topic}-{purpose}/{number}-{topic}-{purpose}.md

What's next?

1. Run prompt now
2. Review/edit prompt first
3. Save for later
4. Other

Choose (1-4): _
```
</single_prompt_presentation>

<multi_prompt_presentation>
List all created prompts with detected execution order (sequential/parallel/mixed), then offer: Run all / Review first / Save for later / Other.
</multi_prompt_presentation>
</step_2_present>

<step_3_execute>
<title>Execution Engine</title>

<execution_modes>
For each prompt: read file → spawn Task agent (subagent_type="general-purpose") with prompt contents and output location → validate → archive to `completed/`.

**Mode selection by dependency analysis:**
- **Single/Sequential**: Execute in dependency order. Stop chain on validation failure, offer recovery.
- **Parallel**: Spawn ALL Task agents in a SINGLE message (required for true parallelism). Continue even if some fail; report all results.
- **Mixed (DAG)**: Group into layers by dependency depth. Parallel within layers, sequential between. Stop if dependency fails.

Show progress inline: `Executing 2/3: 002-auth-plan... ✓`
</execution_modes>

<dependency_detection>
Parse `@.prompts/{number}-{topic}/` references → build dependency graph → detect cycles → determine order.

**Inference** (when no explicit @ references): Research=no deps, Plan=depends on same-topic research, Do=depends on same-topic plan. Explicit references override.

**Missing dependencies**: Check session prompts → check `.prompts/*/` → warn user and offer to create, continue, or cancel.
</dependency_detection>

<validation>
After each prompt completes, verify:
1. Output file exists and has content (> 100 chars)
2. Research/plan outputs include required XML tags: `<confidence>`, `<dependencies>`, `<open_questions>`, `<assumptions>`
3. SUMMARY.md exists with required sections (Key Findings, Decisions Needed, Blockers, Next Step)
4. One-liner is substantive (not generic like "Research completed")

On failure: report what's missing, offer retry / continue / stop.
</validation>

**Failure handling**: Sequential stops chain on failure; parallel continues and collects all results. See [references/failure-handling.md](references/failure-handling.md) for presentation templates.

<archiving>
Archive by moving prompt to `completed/` subfolder (output stays in place). Sequential: archive immediately after each success. Parallel: archive all at end.
</archiving>

<result_presentation>
Display SUMMARY.md content inline so user sees findings without opening files.

- **Single prompt**: Show status, display full SUMMARY.md content, offer next-step options (create follow-up / view full output / done)
- **Chain**: Show condensed one-liner from each SUMMARY.md with decisions/blockers flagged, then offer review/test/new-chain options
</result_presentation>

**Special cases** (re-runs, output conflicts, commit handling, recursive prompts): See [references/special-cases.md](references/special-cases.md)
</step_3_execute>

</automated_workflow>

<reference_guides>
**Prompt patterns by purpose:**
- [references/do-patterns.md](references/do-patterns.md) - Execution prompts + output structure
- [references/plan-patterns.md](references/plan-patterns.md) - Planning prompts + plan.md structure
- [references/research-patterns.md](references/research-patterns.md) - Research prompts + research.md structure
- [references/refine-patterns.md](references/refine-patterns.md) - Iteration prompts + versioning

**Shared templates:**
- [references/summary-template.md](references/summary-template.md) - SUMMARY.md structure and field requirements
- [references/metadata-guidelines.md](references/metadata-guidelines.md) - Confidence, dependencies, open questions, assumptions

**Supporting references:**
- [references/question-bank.md](references/question-bank.md) - Intake questions by purpose
- [references/intelligence-rules.md](references/intelligence-rules.md) - Extended thinking, parallel tools, depth decisions
- [references/failure-handling.md](references/failure-handling.md) - Failure presentation templates for sequential and parallel execution
- [references/special-cases.md](references/special-cases.md) - Re-runs, output conflicts, commit handling, recursive prompts
</reference_guides>

<success_criteria>
**Prompt Creation:**
- Intake gate completed with purpose and topic identified
- Chain detection performed, relevant files referenced
- Prompt generated with correct structure for purpose
- Folder created in `.prompts/` with correct naming
- Output file location specified in prompt
- SUMMARY.md requirement included in prompt
- Metadata requirements included for Research/Plan outputs
- Quality controls included for Research outputs (verification checklist, QA, pre-submission)
- Streaming write instructions included for Research outputs
- Decision tree presented

**Execution (if user chooses to run):**
- Dependencies correctly detected and ordered
- Prompts executed in correct order (sequential/parallel/mixed)
- Output validated after each completion
- SUMMARY.md created with all required sections
- One-liner is substantive (not generic)
- Failed prompts handled gracefully with recovery options
- Successful prompts archived to `completed/` subfolder
- SUMMARY.md displayed inline in results
- Results presented with decisions/blockers flagged

**Research Quality (for Research prompts):**
- Verification checklist completed
- Quality report distinguishes verified from assumed claims
- Sources consulted listed with URLs
- Confidence levels assigned to findings
- Critical claims verified with official documentation
</success_criteria>
