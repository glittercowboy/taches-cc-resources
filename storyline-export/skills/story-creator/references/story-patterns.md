# User Story Patterns

## Good Story Examples

### Example 1: CRUD Story
**As a** task manager user,
**I want** to create a new task with title and description,
**so that** I can track work I need to complete.

**Why this works:**
- ✅ Independent (doesn't need other features)
- ✅ Valuable (basic functionality users need)
- ✅ Small (single create operation)
- ✅ Testable (clear success criteria)

### Example 2: Authentication Story
**As a** new user,
**I want** to sign up with email and password,
**so that** I can access my personal task list.

**Why this works:**
- ✅ Focused on one action (signup)
- ✅ Clear persona (new user)
- ✅ Measurable outcome (account created)

### Example 3: Integration Story
**As a** user,
**I want** to receive email notifications when tasks are due,
**so that** I don't miss important deadlines.

**Why this works:**
- ✅ Clear integration point (email)
- ✅ Specific trigger (task due date)
- ✅ User benefit stated

## INVEST Criteria Explained

### Independent
Stories can be developed in any order.

**Good:** "As a user, I want to mark tasks complete"
**Bad:** "As a user, I want to mark tasks complete and archive them and export them"
(Split into 3 independent stories)

### Negotiable
Implementation details can be discussed.

**Good:** "As a user, I want to filter tasks by category"
(How filtering works is negotiable)

**Bad:** "As a user, I want a dropdown menu with checkboxes using React Select component"
(Too specific - implementation detail, not user need)

### Valuable
Delivers user or business value on its own.

**Good:** "As a user, I want to see my task count on the dashboard"
**Bad:** "As a developer, I want to refactor the TaskService class"
(Developer story - no user value. Should be technical task, not user story)

### Estimable
Team can estimate effort.

**Good:** "As a user, I want to upload a profile picture"
**Bad:** "As a user, I want AI to automatically organize my tasks"
(Too vague - what does "organize" mean? How does AI work?)

### Small
Fits in a sprint (1-5 days).

**Good:** "As a user, I want to sort tasks by due date"
**Bad:** "As a user, I want a complete project management system"
(Epic-sized - needs to be broken down)

### Testable
Has clear acceptance criteria.

**Good:** "As a user, I want to search tasks by keyword"
- Test: Search for "meeting" returns tasks with "meeting" in title
- Test: Search for "xyz" returns no results if none exist

**Bad:** "As a user, I want a better experience"
(Not measurable)

## Acceptance Criteria Patterns

### Pattern 1: Given/When/Then (Gherkin)
```
Given I am logged in
When I click "New Task"
Then I see a task creation form
And the form has title and description fields
```

### Pattern 2: Checklist Format
```
- [ ] User can click "New Task" button
- [ ] Form displays with title and description
- [ ] Saving creates task in database
- [ ] User redirected to task list after save
- [ ] Error shown if required fields empty
```

### Pattern 3: Scenario-Based
```
Scenario: Happy path
- User fills title and description
- Clicks Save
- Task appears in task list

Scenario: Validation
- User leaves title empty
- Clicks Save
- Error message: "Title required"
```

## Story Splitting Techniques

### Technique 1: Split by CRUD
**Original:** "As a user, I want to manage tasks"

**Split:**
- Story 1: Create task
- Story 2: Read/view task
- Story 3: Update task
- Story 4: Delete task

### Technique 2: Split by Persona
**Original:** "As a user, I want dashboard analytics"

**Split:**
- Story 1: As a team member, I want to see my task completion rate
- Story 2: As a manager, I want to see team task completion
- Story 3: As an admin, I want to see org-wide analytics

### Technique 3: Split by Happy Path / Variations
**Original:** "As a user, I want to login"

**Split:**
- Story 1: Login with valid credentials (happy path)
- Story 2: Login with invalid credentials (error handling)
- Story 3: Login with "remember me" (enhancement)
- Story 4: Login with social auth (alternative)

### Technique 4: Split by Simple / Complex
**Original:** "As a user, I want to search tasks"

**Split:**
- Story 1: Simple keyword search
- Story 2: Advanced filters (date, category, status)
- Story 3: Saved searches

## Anti-Patterns

### Anti-Pattern 1: Technical Task Disguised as Story
**Bad:** "As a developer, I want to set up CI/CD pipeline"
**Fix:** This is a technical task, not a user story. Put it in backlog as task.

### Anti-Pattern 2: Too Many "And" Clauses
**Bad:** "As a user, I want to create tasks and assign them and set due dates and add tags and..."
**Fix:** Split into separate stories.

### Anti-Pattern 3: Solution-Focused Story
**Bad:** "As a user, I want a Redux store for state management"
**Fix:** Focus on user need, not implementation.
**Better:** "As a user, I want my task list to stay synchronized across tabs"

### Anti-Pattern 4: Epic Disguised as Story
**Bad:** "As a user, I want a complete notification system"
**Fix:** Break into stories (email notifications, in-app notifications, preferences, etc.)

## Validation Checklist

Good story has:
- [ ] "As a [persona], I want [capability], so that [benefit]" format
- [ ] Clear acceptance criteria (3-5 scenarios)
- [ ] Passes all INVEST criteria
- [ ] Small enough for 1-5 days work
- [ ] Links to parent epic
- [ ] Business value stated
- [ ] Testable outcomes

Bad story has:
- [ ] Vague "as a user" with no specific persona
- [ ] No "so that" benefit stated
- [ ] No acceptance criteria
- [ ] Fails INVEST (too large, not valuable, etc.)
- [ ] Implementation details in story statement
- [ ] No traceability
