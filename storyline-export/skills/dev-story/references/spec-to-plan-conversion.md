# Converting Technical Specs to Executable Plans

## Core Principles

### 1. Specs Are Design, Plans Are Execution

**Technical Spec:**
- WHY we're building it (business context)
- WHAT we're building (features, API contracts)
- HOW we'll build it (architecture, approach)
- Tests and verification

**PLAN.md:**
- Objective (one clear goal)
- Context (files to read)
- Tasks (atomic, executable steps)
- Verification (how to check it worked)
- Success criteria (definition of done)

### 2. Maintain Aggressive Atomicity

From create-plans principle:
- **2-3 tasks maximum per plan**
- Better 10 small plans than 3 large plans
- Each plan should complete in <50% context usage

### 3. Preserve Traceability

Every PLAN.md should:
- Reference source spec in execution_context
- Reference parent story
- Generate SUMMARY that links back to story

## Conversion Process

### Step 1: Identify Plan Boundaries

Look for natural splits in the spec:

**Database layer:**
- Schema changes = 1 plan
- Migrations = can combine with schema if simple

**Backend layer:**
- Each API endpoint = 1 plan
- Related endpoints can combine if very simple

**Frontend layer:**
- Each major component = 1 plan
- Component + integration = split if complex

**Testing layer:**
- Test creation often separate plan
- Simple tests can bundle with feature

### Step 2: Map Spec Sections to Plan Sections

| Spec Section | → | Plan Section |
|--------------|---|--------------|
| Overview | → | Objective |
| Files to Modify/Create | → | Context + Tasks |
| Implementation Details | → | Tasks (action) |
| API Contracts | → | Tasks (implementation) |
| Database Changes | → | Tasks (specific changes) |
| Testing Requirements | → | Tasks (test creation) |
| Acceptance Criteria Mapping | → | Verification |
| Success Verification | → | Success Criteria |

### Step 3: Write Atomic Tasks

Each task should:
- Have ONE clear action
- Touch 1-3 files maximum
- Be independently verifiable
- Take 30 minutes - 2 hours

**Example good tasks:**
```xml
<task type="auto">
<id>1</id>
<description>Create User database schema</description>
<files>prisma/schema.prisma</files>
<action>
Add User model with fields: id, email, passwordHash, createdAt
Run prisma generate and prisma migrate dev
</action>
<verify>
- Schema file has User model
- Migration file created in prisma/migrations/
- Prisma client regenerated
</verify>
<done>
User table exists in database, schema synced
</done>
</task>
```

**Example bad task (too large):**
```xml
<task type="auto">
<id>1</id>
<description>Implement complete authentication system</description>
<!-- TOO BIG - split into multiple tasks -->
</task>
```

## Example Conversion

### Input: Technical Spec

```markdown
# Spec 001: User Signup

## Implementation Details

### Files to Create
- src/api/auth/signup.ts
- src/api/auth/signup.test.ts

### Files to Modify
- src/api/router.ts (add signup route)
- prisma/schema.prisma (add User model)

### Database Changes
CREATE TABLE users (
  id UUID PRIMARY KEY,
  email VARCHAR UNIQUE NOT NULL,
  password_hash VARCHAR NOT NULL
);

### API Contract
POST /api/auth/signup
Body: { email, password }
Response: { user: { id, email }, token }

### Testing
- Unit tests for signup logic
- Integration test for full flow
```

### Output: Multiple PLAN.md Files

**01-01-PLAN.md (Database)**
```xml
<objective>Create User database schema for authentication</objective>

<tasks>
<task type="auto">
<id>1</id>
<description>Add User model to Prisma schema</description>
<files>prisma/schema.prisma</files>
<action>...</action>
</task>

<task type="auto">
<id>2</id>
<description>Run migration to create users table</description>
<action>prisma migrate dev --name add-users-table</action>
</task>
</tasks>
```

**01-02-PLAN.md (API Endpoint)**
```xml
<objective>Implement POST /api/auth/signup endpoint</objective>

<tasks>
<task type="auto">
<id>1</id>
<description>Create signup handler</description>
<files>src/api/auth/signup.ts</files>
<action>...</action>
</task>

<task type="auto">
<id>2</id>
<description>Register route in API router</description>
<files>src/api/router.ts</files>
<action>...</action>
</task>
</tasks>
```

**01-03-PLAN.md (Tests)**
```xml
<objective>Add test coverage for signup functionality</objective>

<tasks>
<task type="auto">
<id>1</id>
<description>Write unit tests for signup logic</description>
<files>src/api/auth/signup.test.ts</files>
<action>...</action>
</task>
</tasks>
```

## Handling Checkpoints

If spec requires human verification:

```xml
<task type="checkpoint:human-verify">
<id>3</id>
<description>Verify signup form UI</description>
<action>
- Open http://localhost:3000/signup
- Fill out form with test data
- Submit and verify success message
</action>
<verify>
User can successfully sign up via UI
</verify>
</task>
```

## Best Practices

### ✅ Do:
- Keep plans atomic (2-3 tasks)
- Link back to spec and story
- Include clear verification
- Split database/backend/frontend into separate plans
- Make tasks independently executable

### ❌ Don't:
- Put entire spec in one plan
- Skip verification steps
- Lose traceability to story
- Create tasks with vague actions
- Bundle unrelated changes

## Template for Conversion

```markdown
For each major section in spec:

1. Assess size (how many tasks?)
2. If > 3 tasks, split into multiple plans
3. Create plan directory: .workflow/.planning/story-{N}/
4. Write 01-01-PLAN.md, 01-02-PLAN.md, etc.
5. Each plan:
   - Clear objective
   - 2-3 tasks maximum
   - References spec in execution_context
   - Verification steps
   - Success criteria
6. Execute plans sequentially
7. Generate SUMMARY for each
8. Update story status when all plans complete
```
