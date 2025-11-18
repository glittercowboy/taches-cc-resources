# TÂCHES Claude Code Resources

A growing collection of my favourite custom Claude Code resources in one place.

## Installation

### Option 1: Plugin Install (Recommended)

```bash
# Add the marketplace
claude plugin marketplace add glittercowboy/taches-cc-resources

# Install the plugin
claude plugin install taches-cc-resources
```

Start a new Claude Code session to use the commands and skills.

### Option 2: Manual Install

```bash
# Clone the repo
git clone https://github.com/glittercowboy/taches-cc-resources.git
cd taches-cc-resources

# Install commands
cp commands/*.md ~/.claude/commands/

# Install skills
cp -r skills/* ~/.claude/skills/
```

Commands install globally to `~/.claude/commands/`. Skills install to `~/.claude/skills/`. Project-specific data (prompts, todos) lives in each project's working directory.

## Commands

### Meta-Prompting

A systematic approach to building complex software by delegating prompt engineering to Claude itself. Instead of telling Claude what to do, you tell Claude what you want, and it figures out how to ask itself to do it.

- `/create-prompt` - Generate optimized prompts with XML structure
- `/run-prompt` - Execute saved prompts in sub-agent contexts

Perfect for complex refactoring, new features, and multi-step tasks where you want rigorous specifications without manually crafting detailed prompts.

### Todo Management

Capture ideas mid-conversation without losing focus. When you spot a bug, think of a feature, or notice something to refactor - but don't want to derail your current work - `/add-to-todos` captures it with full context. Later, `/check-todos` resumes exactly where you left off.

- `/add-to-todos` - Capture tasks with full context
- `/check-todos` - Resume work on captured tasks

Perfect for staying focused while building a backlog of improvements, features, and research tasks that won't be forgotten.

### Context Handoff

Continue work in a fresh context without losing progress. `/whats-next` analyzes the current conversation and creates a structured handoff document with what was completed, what remains, and critical context. Reference it in your next chat to resume seamlessly.

- `/whats-next` - Create handoff document for fresh context

Perfect for when your context is getting full, you need a clean slate, or you're switching between tasks and want to preserve exactly where you left off.

## Skills

### [Create Agent Skills](./skills/create-agent-skills/)

Build skills by describing what you want. `/create-agent-skill` asks clarifying questions, researches APIs if needed, and generates properly structured skill files. When things don't work perfectly, `/heal-skill` analyzes what went wrong and updates the skill based on what actually worked.

Perfect for packaging repeatable workflows—PDF processing, API integrations, chart generation—into skills that Claude can execute consistently. Let your mind go wild!

### [Create Meta-Prompts](./skills/create-meta-prompts/)

The skill-based evolution of the meta-prompting system above. `/create-meta-prompt` builds prompts with structured outputs (research.md, plan.md) that subsequent prompts can parse. Adds automatic dependency detection to chain research → plan → implement workflows.

Perfect for complex tasks that benefit from staged workflows where each stage produces artifacts for the next.

### [Create Slash Commands](./skills/create-slash-commands/)

Expert guidance for creating Claude Code slash commands. Covers YAML frontmatter, XML structure, dynamic context loading, and argument handling. Use when you want to create reusable `/command-name` prompts for your team or personal workflows.

Perfect for standardizing operations like deployments, code reviews, or project-specific workflows.

### [Create Subagents](./skills/create-subagents/)

Expert guidance for creating specialized Claude instances that run in isolated contexts. Covers system prompt design, tool access configuration, and multi-agent orchestration with the Task tool. Use when you need focused agents for specific tasks like code review, testing, or research.

Perfect for delegating complex tasks to autonomous agents that return results without user interaction.

### [Create Hooks](./skills/create-hooks/)

Expert guidance for creating event-driven automation in Claude Code. Covers PreToolUse, PostToolUse, Stop, SessionStart, and other hook types. Use when you want to validate commands, automate workflows, inject context, or add notifications.

Perfect for project-specific automation, safety checks, and workflow customization without modifying Claude's core behavior.

---

More resources coming soon.

---

**Community Ports:** [OpenCode](https://github.com/stephenschoettler/taches-oc-prompts)

—TÂCHES
