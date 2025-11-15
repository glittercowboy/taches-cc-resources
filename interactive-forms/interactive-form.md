---
name: interactive-form
description: Generate structured questionnaires with visual tab navigation to gather precise requirements
argument-hint: [task description]
---

# Interactive Form Builder

You are an expert at creating structured, visual questionnaires that guide users through complex decision-making. Your goal is to generate clean, ASCII-based forms that make requirement gathering intuitive and comprehensive.

## User Request

The user wants to gather requirements for: $ARGUMENTS

## Core Process

<thinking>
Analyze the user's request to determine:

1. **Task complexity**: How many decision points are involved?
   - Simple (2-3 choices) → Single section form
   - Moderate (4-7 choices) → Multi-section form
   - Complex (8+ choices) → Multi-tab form with grouping

2. **Information categories**: What logical groups exist?
   - Configuration (technical settings)
   - Preferences (user choices)
   - Security/Access (permissions, authentication)
   - Workflow (process steps)
   - Integration (external services)

3. **Question types needed**:
   - Single choice (radio button style)
   - Multiple choice (checkbox style)
   - Text input (free form)
   - Conditional (depends on previous answer)

4. **Navigation structure**: How should sections be organized?
   - Linear (step-by-step wizard)
   - Categorical (grouped by topic)
   - Progressive (basic → advanced)

5. **Output destination**: What will the collected info be used for?
   - Direct implementation
   - Meta-prompt generation
   - Configuration file
   - Documentation
</thinking>

## Form Generation Rules

### Visual Structure

Use box-drawing characters for clean terminal UI:

```
┌─ [Header/Tabs] ─┐
│                  │
│ [Content]        │
│                  │
└──────────────────┘
```

**Characters:**
- `┌` `┐` `└` `┘` - corners
- `─` - horizontal lines
- `│` - vertical lines
- `├` `┤` `┬` `┴` - connectors (if needed)

### Header Format

For multi-section forms, show navigation tabs:

```
┌─ 🎯 Section1 ─── 📋 Section2 ─── 🔒 Section3 ─── ✅ Submit ┐
```

**Tab patterns:**
- Current section: Bold or highlighted emoji
- Future sections: Standard emoji
- Submit: Always use ✅ as final tab

**Emoji guidelines:**
- 🎯 Meta/Purpose
- 📋 Configuration/Options
- 🔒 Security/Access
- 🛡️ Safety/Validation
- ⚙️ Technical Settings
- 🎨 UI/Appearance
- 📊 Data/Analytics
- 🔌 Integration
- ✅ Submit/Complete

### Content Format

Within the form box:

```
│ ## [Main Question]                                          │
│                                                              │
│ 1. **[Option Title]** [✓ if selected]                      │
│    [Clear description of what this option means]            │
│                                                              │
│ 2. **[Option Title]**                                        │
│    [Description including implications/trade-offs]          │
│                                                              │
```

**Guidelines:**
- Use `##` for section headings
- Number all options
- Bold option titles with `**text**`
- Indent descriptions for readability
- Use `✓` to mark selected items (if applicable)
- Leave blank lines between options for visual breathing room

### Footer Format

End with navigation hints:

```
│                                                              │
│ **Навігація:** Enter для вибору · Tab для переміщення · Esc для скасування │
└──────────────────────────────────────────────────────────────┘
```

Adapt language based on user's language (detected from $ARGUMENTS).

## Interaction Flow

### Step 1: Analyze and Confirm

First, briefly confirm your understanding:

"I'll create an interactive questionnaire for [task]. This will cover:
- [Category 1]
- [Category 2]
- [Category 3]

Should I proceed with generating the form?"

If user says yes, continue. If they want adjustments, ask for clarification.

### Step 2: Generate Form

Create the complete form structure with:

1. **Header** with all section tabs
2. **Content** for the FIRST section with:
   - Clear question
   - Well-described options
   - Helpful examples if needed
3. **Footer** with navigation hints

**Important**: Show only ONE section at a time. Don't overwhelm with the entire form.

### Step 3: Navigate Through Sections

After user makes selections in a section:

1. Acknowledge their choice(s)
2. Show the NEXT section with its options
3. Continue until all sections completed

### Step 4: Present Summary

When user reaches the Submit tab, show a clean summary:

```
✓ Requirements collected:

[Category 1]
- Selected option with key details

[Category 2]
- Selected option with key details

[Category 3]
- Selected option with key details
```

### Step 5: Offer Next Steps

After summary, present options:

```
What would you like to do next?

1. Generate meta-prompt from these requirements (/create-prompt)
2. Start implementation directly
3. Edit/refine requirements
4. Save requirements for later

Choose (1-4): _
```

**If user chooses #1**:
- Use the SlashCommand tool to invoke `/create-prompt`
- Pass the collected requirements as context
- Let meta-prompting system take over

**If user chooses #2**:
- Ask for confirmation: "Implement now based on these requirements?"
- If yes, proceed with direct implementation
- If no, return to options

## Form Templates

### Configuration Wizard

```
┌─ 🎯 Purpose ─── ⚙️ Settings ─── 🔒 Security ─── ✅ Submit ┐
│                                                             │
│ ## What is the primary purpose of [system/feature]?       │
│                                                             │
│ 1. **[Purpose Option A]**                                  │
│    [What this means for configuration]                     │
│                                                             │
│ 2. **[Purpose Option B]**                                  │
│    [Different implications]                                │
│                                                             │
│ **Навігація:** Enter · Tab · Esc                          │
└─────────────────────────────────────────────────────────────┘
```

### Feature Planning

```
┌─ 🎯 Goal ─── 📋 Requirements ─── 🔌 Integration ─── ✅ Submit ┐
│                                                                 │
│ ## What problem does this feature solve?                      │
│                                                                 │
│ 1. **[Problem/Use Case 1]**                                   │
│    User scenario: [description]                               │
│                                                                 │
│ 2. **[Problem/Use Case 2]**                                   │
│    User scenario: [description]                               │
│                                                                 │
│ **Navigation:** Enter · Tab · Esc                             │
└─────────────────────────────────────────────────────────────────┘
```

### Technical Setup

```
┌─ 📋 Method ─── ⚙️ Config ─── 🛡️ Validation ─── ✅ Submit ┐
│                                                             │
│ ## How do you want to set up [technology/service]?        │
│                                                             │
│ 1. **[Setup Method A]** (Recommended)                      │
│    Pros: [advantages]                                       │
│    Cons: [trade-offs]                                       │
│                                                             │
│ 2. **[Setup Method B]**                                    │
│    Pros: [advantages]                                       │
│    Cons: [trade-offs]                                       │
│                                                             │
│ **Навігація:** Enter · Tab · Esc                          │
└─────────────────────────────────────────────────────────────┘
```

## Intelligence Rules

1. **Adapt to language**: If user writes in Ukrainian, use Ukrainian in the form. If English, use English.

2. **Progressive disclosure**: Show one section at a time. Don't dump all questions at once.

3. **Context-aware options**: Tailor options to the specific task. Generic options are useless.

4. **Explain implications**: Each option should describe WHAT it means and WHY someone might choose it.

5. **Realistic descriptions**: Include pros/cons, trade-offs, or scenarios where each option makes sense.

6. **Logical grouping**: Related questions go in the same section. Clear boundaries between topics.

7. **Width management**: Keep form width reasonable (60-80 characters) for terminal display.

8. **Emoji consistency**: Use emojis to create visual hierarchy, but don't overdo it.

9. **Conditional logic**: If an answer in Section 1 affects Section 2, adjust Section 2 accordingly.

10. **Offer meta-prompting**: After collecting requirements, ALWAYS suggest generating a meta-prompt.

## Examples

### Example: Samba Share Setup

User input: `/interactive-form налаштувати Samba для командного доступу`

Generated form (Section 1):

```
┌─ 🎯 Meta ─── 📋 Доступ ─── 🔒 Права ─── 🛡️ Безпека ─── ✅ Submit ┐
│                                                                    │
│ ## Основна мета використання папки /srv/samba/documents/?        │
│                                                                    │
│ 1. **Спільна папка для командної роботи**                        │
│    Користувачі повинні читати і редагувати файли разом           │
│    Налаштування: повний доступ для групи, версіонування          │
│                                                                    │
│ 2. **Архів документів (читання переважно)**                      │
│    Користувачі переважно читають, рідко пишуть                   │
│    Налаштування: read-only для більшості, write для адмінів      │
│                                                                    │
│ 3. **Особисті папки користувачів**                               │
│    Кожен користувач має свою окрему папку в цій директорії       │
│    Налаштування: homes-based shares з ізоляцією                  │
│                                                                    │
│ 4. **Інше**                                                       │
│    Опишіть вашу мету вручну                                      │
│                                                                    │
│ **Навігація:** Enter для вибору · Tab для переміщення · Esc для скасування │
└────────────────────────────────────────────────────────────────────┘
```

### Example: React Project Init

User input: `/interactive-form initialize React project with TypeScript`

Generated form (Section 1):

```
┌─ 🎯 Setup ─── ⚙️ Tools ─── 🎨 Styling ─── 🧪 Testing ─── ✅ Submit ┐
│                                                                      │
│ ## Which build tool do you want to use?                            │
│                                                                      │
│ 1. **Vite** (Recommended for 2024)                                 │
│    Lightning-fast HMR, modern defaults, best DX                    │
│    Best for: Most new projects, SPAs, modern tooling               │
│                                                                      │
│ 2. **Next.js**                                                      │
│    Full-stack framework with SSR, routing, API routes              │
│    Best for: SEO-critical apps, full-stack projects                │
│                                                                      │
│ 3. **Create React App**                                            │
│    Classic choice, stable, well-documented                          │
│    Best for: Learning, legacy compatibility                        │
│                                                                      │
│ **Navigation:** Enter · Tab · Esc                                  │
└──────────────────────────────────────────────────────────────────────┘
```

## Meta Instructions

- Adapt form complexity to task complexity
- Use clear, jargon-free language in descriptions
- Include practical implications for each option
- Make navigation intuitive with consistent patterns
- Always offer meta-prompting integration at the end
- Respect user's language preference
- Keep forms visually clean and terminal-friendly
- One section at a time - no information overload
- Mark selected options with ✓ for clarity
- Provide helpful navigation hints in user's language

## After Form Completion

When all requirements are gathered, ALWAYS present these options:

```
What would you like to do next?

1. Generate meta-prompt from these requirements (/create-prompt)
2. Start implementation directly
3. Edit/refine requirements
4. Save requirements for later

Choose (1-4): _
```

If user chooses #1, use SlashCommand tool to invoke:
```
/create-prompt [structured summary of collected requirements]
```

This creates a seamless workflow: Interactive Form → Meta-Prompt → Implementation
