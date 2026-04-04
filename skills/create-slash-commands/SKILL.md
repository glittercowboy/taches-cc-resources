---
name: create-slash-commands
description: Create, configure, and debug Claude Code slash commands — write YAML frontmatter, define argument schemas, set up command files with XML-structured prompts, and configure tool restrictions. Use when creating custom slash commands, building command files, setting up /commands, troubleshooting command configuration, or learning YAML configuration for Claude Code commands.
---

<objective>
Create effective Claude Code slash commands — reusable `.md` files that expand as prompts via `/command-name` syntax. Structure commands with XML tags, YAML frontmatter, dynamic context loading, and argument handling to standardize team workflows.
</objective>

<quick_start>

<workflow>
1. Create `.claude/commands/` directory (project) or use `~/.claude/commands/` (personal)
2. Create `command-name.md` file
3. Add YAML frontmatter (at minimum: `description`)
4. Write command prompt
5. Test with `/command-name [args]`
</workflow>

<example>
**File**: `.claude/commands/optimize.md`

```markdown
---
description: Analyze this code for performance issues and suggest optimizations
---

Analyze the performance of this code and suggest three specific optimizations:
```

**Usage**: `/optimize`
</example>
</quick_start>

<xml_structure>
All generated slash commands should use XML tags in the body (after YAML frontmatter) for clarity and consistency.

<required_tags>

**`<objective>`** - What the command does and why it matters
```markdown
<objective>
What needs to happen and why this matters.
Context about who uses this and what it accomplishes.
</objective>
```

**`<process>` or `<steps>`** - How to execute the command
```markdown
<process>
Sequential steps to accomplish the objective:
1. First step
2. Second step
3. Final step
</process>
```

**`<success_criteria>`** - How to know the command succeeded
```markdown
<success_criteria>
Clear, measurable criteria for successful completion.
</success_criteria>
```
</required_tags>

<conditional_tags>

**`<context>`** - When loading dynamic state or files
```markdown
<context>
Current state: ! `git status`
Relevant files: @ package.json
</context>
```
(Note: Remove the space after @ in actual usage)

**`<verification>`** - When producing artifacts that need checking
```markdown
<verification>
Before completing, verify:
- Specific test or check to perform
- How to confirm it works
</verification>
```

**`<testing>`** - When running tests is part of the workflow
```markdown
<testing>
Run tests: ! `npm test`
Check linting: ! `npm run lint`
</testing>
```

**`<output>`** - When creating/modifying specific files
```markdown
<output>
Files created/modified:
- `./path/to/file.ext` - Description
</output>
```
</conditional_tags>

<structure_example>

```markdown
---
name: example-command
description: Does something useful
argument-hint: [input]
---

<objective>
Process $ARGUMENTS to accomplish [goal].

This helps [who] achieve [outcome].
</objective>

<context>
Current state: ! `relevant command`
Files: @ relevant/files
</context>

<process>
1. Parse $ARGUMENTS
2. Execute operation
3. Verify results
</process>

<success_criteria>
- Operation completed without errors
- Output matches expected format
</success_criteria>
```
</structure_example>

<intelligence_rules>

**Simple commands** (single operation, no artifacts):
- Required: `<objective>`, `<process>`, `<success_criteria>`
- Example: `/check-todos`, `/first-principles`

**Complex commands** (multi-step, produces artifacts):
- Required: `<objective>`, `<process>`, `<success_criteria>`
- Add: `<context>` (if loading state), `<verification>` (if creating files), `<output>` (what gets created)
- Example: `/commit`, `/create-prompt`, `/run-prompt`

**Commands with dynamic arguments**:
- Use `$ARGUMENTS` in `<objective>` or `<process>` tags
- Include `argument-hint` in frontmatter
- Make it clear what the arguments are for

**Commands that produce files**:
- Always include `<output>` tag specifying what gets created
- Always include `<verification>` tag with checks to perform

**Commands that run tests/builds**:
- Include `<testing>` tag with specific commands
- Include pass/fail criteria in `<success_criteria>`
</intelligence_rules>
</xml_structure>

<arguments>

**`$ARGUMENTS`** — all arguments as a single string. Use when the command operates on user-specified data:
```markdown
Fix issue #$ARGUMENTS following our coding standards
```

**Positional `$1`, `$2`, `$3`** — access specific arguments individually:
```markdown
Review PR #$1 with priority $2 and assign to $3
```

**No arguments** — omit `argument-hint` and `$ARGUMENTS` when the command operates on implicit context (current conversation, known files, project state).

Include `argument-hint` in frontmatter when arguments are expected. See [references/arguments.md](references/arguments.md) for advanced patterns.
</arguments>

<file_structure>

**Project commands**: `.claude/commands/`
- Shared with team via version control
- Shows `(project)` in `/help` list

**Personal commands**: `~/.claude/commands/`
- Available across all your projects
- Shows `(user)` in `/help` list

**File naming**: `command-name.md` → invoked as `/command-name`
</file_structure>

<yaml_frontmatter>

<field name="description">
**Required** - Describes what the command does

```yaml
description: Analyze this code for performance issues and suggest optimizations
```

Shown in the `/help` command list.
</field>

<field name="allowed-tools">
**Optional** - Restricts which tools Claude can use

```yaml
allowed-tools: Bash(git add:*), Bash(git status:*), Bash(git commit:*)
```

**Formats**:
- Array: `allowed-tools: [Read, Edit, Write]`
- Single tool: `allowed-tools: SequentialThinking`
- Bash restrictions: `allowed-tools: Bash(git add:*)`

If omitted: All tools available
</field>
</yaml_frontmatter>

<dynamic_context>

Use `!` prefix before backticks (no space) to execute bash commands and inject output into the prompt. Examples below show a space after `!` to prevent execution during skill loading.

```markdown
- Current git status: ! `git status`
- Current git diff: ! `git diff HEAD`
- Recent commits: ! `git log --oneline -10`
```
</dynamic_context>

<file_references>

Use `@` prefix (no space in actual usage) to inject file contents:

```markdown
Review the implementation in @ src/utils/helpers.js
```
</file_references>

<best_practices>

1. **Always use XML structure** after frontmatter: `<objective>`, `<process>`, `<success_criteria>` (required); add `<context>`, `<verification>`, `<testing>`, `<output>` as needed.
2. **Write clear descriptions**: `description: Analyze this code for performance issues and suggest optimizations` not `description: Optimize stuff`.
3. **Load dynamic context** for state-dependent tasks: `! \`git status\``, `! \`git diff --name-only\``.
4. **Restrict tools** when appropriate: `allowed-tools: Bash(git add:*), Bash(git commit:*)` or `allowed-tools: SequentialThinking`.
5. **Use `$ARGUMENTS`** for user-specified input; omit for self-contained commands.
6. **Reference files** with `@` prefix: `@ package.json`, `@ src/database/*`.
</best_practices>

<common_patterns>

**Simple self-contained command** (no arguments, uses dynamic context):
```markdown
---
description: Create a git commit
allowed-tools: Bash(git add:*), Bash(git status:*), Bash(git commit:*)
---

<objective>
Create a git commit for current changes following repository conventions.
</objective>

<context>
- Current status: ! `git status`
- Changes: ! `git diff HEAD`
- Recent commits: ! `git log --oneline -5`
</context>

<process>
1. Review staged and unstaged changes
2. Stage relevant files
3. Write commit message following recent commit style
4. Create commit
</process>

<success_criteria>
- All relevant changes staged
- Commit message follows repository conventions
- Commit created successfully
</success_criteria>
```

**Parameterized command** (uses `$ARGUMENTS` and file references):
```markdown
---
description: Fix issue following coding standards
argument-hint: [issue-number]
---

<objective>
Fix issue #$ARGUMENTS following project coding standards.
</objective>

<process>
1. Understand the issue described in ticket #$ARGUMENTS
2. Locate the relevant code in codebase
3. Implement a solution that addresses root cause
4. Add appropriate tests
5. Verify fix resolves the issue
</process>

<success_criteria>
- Issue fully understood and addressed
- Solution follows coding standards
- Tests added and passing
- No regressions introduced
</success_criteria>
```

See [references/patterns.md](references/patterns.md) for git workflows, file operations, security reviews, and more.
</common_patterns>

<reference_guides>

- [references/arguments.md](references/arguments.md) — `$ARGUMENTS`, positional args, parsing strategies
- [references/patterns.md](references/patterns.md) — git workflows, code analysis, file operations, security reviews
- [references/tool-restrictions.md](references/tool-restrictions.md) — bash command patterns, security best practices
</reference_guides>

<generation_protocol>

1. **Analyze request**: Determine purpose, whether it needs `$ARGUMENTS`, produces artifacts, or requires verification.
2. **Create frontmatter**: `description` (required), `argument-hint` (if args needed), `allowed-tools` (if restricting).
3. **Create XML body**: Always `<objective>`, `<process>`, `<success_criteria>`. Add `<context>`, `<verification>`, `<testing>`, `<output>` when relevant.
4. **Scale complexity**: Simple commands get 3 required tags only. Complex commands add context, verification, testing as needed.
5. **Save**: Project commands to `.claude/commands/`, personal to `~/.claude/commands/`.
</generation_protocol>

<success_criteria>
A well-structured slash command:
- Has clear `description` in frontmatter; `argument-hint` and `allowed-tools` when needed
- Contains all three required XML tags (`<objective>`, `<process>`, `<success_criteria>`) properly closed, with conditional tags as appropriate
- Uses `$ARGUMENTS` only when operating on user-specified data; omits for self-contained commands
- Loads dynamic context and restricts tools appropriately
- Scales detail to complexity — concise for simple tasks, thorough for multi-step workflows
</success_criteria>
