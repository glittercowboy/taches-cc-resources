# Interactive Forms for Claude Code

A system for creating structured, visually-guided questionnaires that help Claude gather precise requirements before implementation.

## The Problem

When starting complex tasks, you often need to:

- Answer multiple related questions about configuration, preferences, or requirements
- Choose between different approaches or strategies
- Provide structured information in a specific format
- Navigate through multi-step decision trees

Typing all this information in a single message is overwhelming and error-prone.

## The Solution

Interactive Forms generates ASCII-based questionnaires with:

- **Visual structure** using box-drawing characters (┌─┐│└┘)
- **Tab-based navigation** between different sections
- **Numbered options** with clear descriptions
- **Guided workflows** that lead you through complex decisions step-by-step

## Installation

Copy the slash command to your Claude Code commands directory:

```bash
cp interactive-form.md ~/.claude/commands/
```

Restart Claude Code or reload your commands.

## Usage

### Basic Workflow

```bash
# Generate an interactive form for your task
/interactive-form налаштувати Samba для командного доступу

# Claude generates a structured questionnaire like:
┌─ 🎯 Meta ─── 📋 Доступ ─── 🔒 Права ─── 🛡️ Безпека ─── ✅ Submit ┐
│                                                                    │
│ ## Основна мета використання папки /srv/samba/documents/?        │
│                                                                    │
│ 1. **Спільна папка для командної роботи** ✓                      │
│    Користувачі повинні читати і редагувати файли разом           │
│                                                                    │
│ 2. **Архів документів (читання переважно)**                      │
│    Користувачі переважно читають, рідко пишуть                   │
│                                                                    │
└────────────────────────────────────────────────────────────────────┘

# Fill in your choices and submit
# The collected information is ready for next steps
```

### Integration with Meta-Prompting

Interactive Forms works seamlessly with the meta-prompting system:

**Workflow:**

1. **Gather requirements** with `/interactive-form [task description]`
2. **Review and confirm** your selections
3. **Generate prompt** automatically or manually with `/create-prompt`
4. **Execute** with `/run-prompt`

**Example:**

```bash
# Step 1: Gather structured requirements
/interactive-form створити систему автентифікації для веб-додатку

# Claude presents interactive form with questions about:
# - Authentication method (JWT, OAuth, sessions)
# - User roles and permissions
# - Security requirements
# - Database preferences

# Step 2: After you fill the form, Claude asks:
# "Generate meta-prompt based on these requirements?"
#
# If yes → automatically runs /create-prompt with structured info
# If no → saves requirements for manual review

# Step 3: Execute the generated prompt
/run-prompt 001
```

## When to Use This

**Use Interactive Forms for:**

- Complex configurations with multiple options
- Tasks requiring structured decision-making
- Setup wizards and initialization processes
- Situations where you need to gather multiple related pieces of information
- When you want to ensure you've considered all relevant factors

**Skip Interactive Forms for:**

- Simple, straightforward requests
- Tasks with obvious requirements
- When you already know exactly what you want
- Quick experiments or prototypes

## How It Works

1. **Analyze Task**: Claude analyzes your task description to determine what information is needed

2. **Generate Questionnaire**: Creates a structured form with:
   - Logical grouping of related questions
   - Tab-based sections for different aspects
   - Clear options with helpful descriptions
   - Navigation hints

3. **Collect Information**: You navigate through the form and select/provide your answers

4. **Structure Output**: Claude organizes your responses into a clear format ready for:
   - Direct implementation
   - Meta-prompt generation
   - Documentation
   - Configuration files

## Form Structure

Interactive Forms follow this pattern:

```
┌─ 📍 Section1 ─── 📍 Section2 ─── 📍 Section3 ─── ✅ Submit ┐
│                                                              │
│ ## [Main Question]                                           │
│                                                              │
│ 1. **[Option Title]** [status indicator]                    │
│    [Description of what this option means]                   │
│                                                              │
│ 2. **[Option Title]**                                        │
│    [Description]                                             │
│                                                              │
│ [Navigation hints: Enter/Tab/Arrow/Esc]                     │
└──────────────────────────────────────────────────────────────┘
```

**Elements:**

- **Header tabs**: Show different sections/stages
- **Status indicators**: ✓ for selected, empty for available
- **Emojis**: Visual cues for different types of sections
- **Box drawing**: Clean, terminal-friendly UI
- **Navigation hints**: Help users understand how to interact

## Tips for Best Results

1. **Be specific in your task description** - The more context you provide, the better the form Claude generates

2. **Use for multi-step decisions** - Single yes/no questions don't need a full form

3. **Combine with meta-prompting** - Let the form gather requirements, then generate a detailed prompt

4. **Review generated forms** - Claude adapts the structure to your task; check that it makes sense

5. **Iterate on the form** - If a section is unclear, ask Claude to regenerate that part

## Examples

### System Configuration

```bash
/interactive-form налаштувати PostgreSQL для production
```

Generates form with sections:
- Installation method (Docker, native, cloud)
- Performance requirements
- Backup strategy
- Security settings
- Monitoring preferences

### Project Initialization

```bash
/interactive-form ініціалізувати React проект з TypeScript
```

Generates form covering:
- Build tool (Vite, CRA, Next.js)
- State management
- Styling solution
- Testing framework
- CI/CD preferences

### Feature Planning

```bash
/interactive-form додати систему коментарів до блогу
```

Generates form exploring:
- Comment storage (database, third-party)
- Moderation requirements
- Authentication integration
- Real-time updates needed
- Spam protection

## Why This Works

Interactive Forms reduce cognitive load by:

1. **Breaking down complexity** - One section at a time instead of everything at once
2. **Providing structure** - Clear options instead of blank slate
3. **Ensuring completeness** - Guided questions prevent missing important details
4. **Creating documentation** - Your selections become a clear specification
5. **Enabling better prompts** - Structured input leads to better meta-prompts

## Credits

Part of TÂCHES Prompts collection for systematic Claude Code workflows.

---

**Questions or improvements?** Open an issue or submit a PR.

—TÂCHES
