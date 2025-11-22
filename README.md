# TÂCHES Claude Code Resources

A growing collection of custom Claude Code resources built for real workflows.

## Philosophy

When you use a tool like Claude Code, it's your responsibility to assume everything is possible.

I built these tools using that mindset.

Dream big. Happy building.

— TÂCHES

## What's Inside

**[Commands](#commands)** (27 total) - Slash commands that expand into structured workflows
- **Meta-Prompting**: Separate planning from execution with staged prompts
- **Todo Management**: Capture context mid-work, resume later with full state
- **Thinking Models**: Mental frameworks (first principles, inversion, 80/20, etc.)
- **Deep Analysis**: Systematic debugging methodology with evidence and hypothesis testing

**[Skills](#skills)** (7 total) - Autonomous workflows that research, generate, and self-heal
- **Create Plans**: Hierarchical project planning for solo developer + Claude workflows
- **Create Agent Skills**: Build new skills by describing what you want
- **Create Meta-Prompts**: Generate staged workflow prompts with dependency detection
- **Create Slash Commands**: Build custom commands with proper structure
- **Create Subagents**: Build specialized Claude instances for isolated contexts
- **Create Hooks**: Build event-driven automation
- **Debug Like Expert**: Systematic debugging with evidence gathering and hypothesis testing

**[Agents](#agents)** (3 total) - Specialized subagents for validation and quality
- **skill-auditor**: Reviews skills for best practices compliance
- **slash-command-auditor**: Reviews commands for proper structure
- **subagent-auditor**: Reviews agent configurations for effectiveness

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
cp -r commands/* ~/.claude/commands/

# Install skills
cp -r skills/* ~/.claude/skills/
```

Commands install globally to `~/.claude/commands/`. Skills install to `~/.claude/skills/`. Project-specific data (prompts, todos) lives in each project's working directory.

## Commands

### Meta-Prompting

Separate analysis from execution. Describe what you want in natural language, Claude generates a rigorous prompt, then runs it in a fresh sub-agent context.

- [`/create-prompt`](./commands/create-prompt.md) - Generate optimized prompts with XML structure
- [`/run-prompt`](./commands/run-prompt.md) - Execute saved prompts in sub-agent contexts

### Todo Management

Capture ideas mid-conversation without derailing current work. Resume later with full context intact.

- [`/add-to-todos`](./commands/add-to-todos.md) - Capture tasks with full context
- [`/check-todos`](./commands/check-todos.md) - Resume work on captured tasks

### Context Handoff

Create structured handoff documents to continue work in a fresh context. Reference with `@whats-next.md` to resume seamlessly.

- [`/whats-next`](./commands/whats-next.md) - Create handoff document for fresh context

### Create Extensions

Wrapper commands that invoke the skills below.

- [`/create-agent-skill`](./commands/create-agent-skill.md) - Create a new skill
- [`/create-meta-prompt`](./commands/create-meta-prompt.md) - Create staged workflow prompts
- [`/create-slash-command`](./commands/create-slash-command.md) - Create a new slash command
- [`/create-subagent`](./commands/create-subagent.md) - Create a new subagent
- [`/create-hook`](./commands/create-hook.md) - Create a new hook

### Audit Extensions

Invoke auditor subagents.

- [`/audit-skill`](./commands/audit-skill.md) - Audit skill for best practices
- [`/audit-slash-command`](./commands/audit-slash-command.md) - Audit command for best practices
- [`/audit-subagent`](./commands/audit-subagent.md) - Audit subagent for best practices

### Self-Improvement

- [`/heal-skill`](./commands/heal-skill.md) - Fix skills based on execution issues

### Thinking Models

Apply mental frameworks to decisions and problems.

- [`/consider:pareto`](./commands/consider/pareto.md) - Apply 80/20 rule to focus on what matters
- [`/consider:first-principles`](./commands/consider/first-principles.md) - Break down to fundamentals and rebuild
- [`/consider:inversion`](./commands/consider/inversion.md) - Solve backwards (what guarantees failure?)
- [`/consider:second-order`](./commands/consider/second-order.md) - Think through consequences of consequences
- [`/consider:5-whys`](./commands/consider/5-whys.md) - Drill to root cause
- [`/consider:occams-razor`](./commands/consider/occams-razor.md) - Find simplest explanation
- [`/consider:one-thing`](./commands/consider/one-thing.md) - Identify highest-leverage action
- [`/consider:swot`](./commands/consider/swot.md) - Map strengths, weaknesses, opportunities, threats
- [`/consider:eisenhower-matrix`](./commands/consider/eisenhower-matrix.md) - Prioritize by urgent/important
- [`/consider:10-10-10`](./commands/consider/10-10-10.md) - Evaluate across time horizons
- [`/consider:opportunity-cost`](./commands/consider/opportunity-cost.md) - Analyze what you give up
- [`/consider:via-negativa`](./commands/consider/via-negativa.md) - Improve by removing

### Deep Analysis

Systematic debugging with methodical investigation.

- [`/debug`](./commands/debug.md) - Apply expert debugging methodology to investigate issues

## Agents

Specialized subagents used by the audit commands.

- [`skill-auditor`](./agents/skill-auditor.md) - Expert skill auditor for best practices compliance
- [`slash-command-auditor`](./agents/slash-command-auditor.md) - Expert slash command auditor
- [`subagent-auditor`](./agents/subagent-auditor.md) - Expert subagent configuration auditor

## Skills

### [Create Plans](./skills/create-plans/)

Hierarchical project planning optimized for solo developer + Claude. Create executable plans that Claude runs, not enterprise documentation that sits unused.

**PLAN.md IS the prompt** - not documentation that gets transformed later. Brief → Roadmap → Research (if needed) → PLAN.md → Execute → SUMMARY.md.

**Domain-aware:** Optionally loads framework-specific expertise from `~/.claude/skills/build/` (e.g., macos-apps, iphone-apps) to make plans concrete instead of generic.

**Quality controls:** Research includes verification checklists, blind spots review, critical claims audits, and streaming writes to prevent gaps and token limit failures.

**Context management:** Auto-handoff at 10% tokens remaining. Git versioning commits outcomes, not process.

See [create-plans README](./skills/create-plans/README.md) for full documentation.

### [Create Agent Skills](./skills/create-agent-skills/)

Build skills by describing what you want. Asks clarifying questions, researches APIs if needed, and generates properly structured skill files. When things don't work perfectly, `/heal-skill` analyzes what went wrong and updates the skill based on what actually worked.

Commands: `/create-agent-skill`, `/heal-skill`, `/audit-skill`

### [Create Meta-Prompts](./skills/create-meta-prompts/)

The skill-based evolution of the meta-prompting system. Builds prompts with structured outputs (research.md, plan.md) that subsequent prompts can parse. Adds automatic dependency detection to chain research → plan → implement workflows.

Commands: `/create-meta-prompt`

### [Create Slash Commands](./skills/create-slash-commands/)

Build commands that expand into full prompts when invoked. Describe the command you want, get proper YAML configuration with arguments, tool restrictions, and dynamic context loading.

Commands: `/create-slash-command`, `/audit-slash-command`

### [Create Subagents](./skills/create-subagents/)

Build specialized Claude instances that run in isolated contexts. Describe the agent's purpose, get optimized system prompts with the right tool access and orchestration patterns.

Commands: `/create-subagent`, `/audit-subagent`

### [Create Hooks](./skills/create-hooks/)

Build event-driven automation that triggers on tool calls, session events, or prompt submissions. Describe what you want to automate, get working hook configurations.

Commands: `/create-hook`

### [Debug Like Expert](./skills/debug-like-expert/)

Deep analysis debugging mode for complex issues. Activates methodical investigation protocol with evidence gathering, hypothesis testing, and rigorous verification. Use when standard troubleshooting fails or when issues require systematic root cause analysis.

Commands: `/debug`

---

More resources coming soon.

---

**Community Ports:** [OpenCode](https://github.com/stephenschoettler/taches-oc-prompts)

—TÂCHES
