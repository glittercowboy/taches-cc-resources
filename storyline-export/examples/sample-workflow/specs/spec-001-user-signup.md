---
spec_id: 001
story_id: 001
epic_id: 001
title: User Signup Implementation
status: ready_for_implementation
created: 2025-12-05
---

# Technical Spec 001: User Signup Implementation

## Overview

**User story:** examples/sample-workflow/stories/story-001-user-signup.md

**Goal:** Implement user account creation with email/password, including validation, password hashing, and automatic login upon successful signup.

**Approach:** Create a RESTful signup endpoint on the backend that validates input, hashes passwords with bcrypt, stores user records in PostgreSQL, generates JWT tokens, and returns auth data. Build a React signup form that handles validation, submission, error display, and redirection.

## Technical Design

### Architecture Decision

**Chosen approach:** Traditional REST API with JWT authentication

**Alternatives considered:**
- Session-based auth with cookies - More complex state management
- OAuth-only - Too complex for v1, deferred to v2

**Rationale:** JWT is stateless, works well with React SPA, simple to implement, industry standard.

### System Components

**Frontend:**
- SignupForm component (form UI, validation, submission)
- Auth context (stores user + token state)
- API client (signup request helper)

**Backend:**
- POST /api/auth/signup endpoint
- User service (password hashing, user creation)
- Auth middleware (JWT generation)

**Database:**
- Users table (id, email, password_hash, created_at)
- Unique index on email column

**External integrations:**
- bcrypt library for password hashing
- jsonwebtoken library for JWT generation

## Implementation Details

### Files to Create

```
backend/src/services/user.service.ts
- Purpose: Handle user creation and password hashing
- Exports: createUser(email, password)
```

```
backend/src/controllers/auth.controller.ts
- Purpose: Handle signup endpoint logic
- Exports: signupHandler(req, res)
```

```
backend/src/routes/auth.routes.ts
- Purpose: Define auth routes
- Exports: authRouter
```

```
frontend/src/components/SignupForm.tsx
- Purpose: Signup UI component
- Exports: SignupForm component
```

```
frontend/src/pages/SignupPage.tsx
- Purpose: Signup page wrapper
- Exports: SignupPage component
```

```
frontend/src/services/auth.service.ts
- Purpose: Auth API calls
- Exports: signup(email, password)
```

### Files to Modify

```
backend/src/app.ts
- Changes: Import and use authRouter
- Location: After middleware setup, before error handlers
- Reason: Register auth routes
```

```
backend/prisma/schema.prisma
- Changes: Add User model
- Location: New model definition
- Reason: Define database schema
```

```
frontend/src/App.tsx
- Changes: Add /signup route
- Location: Route definitions
- Reason: Make signup page accessible
```

```
frontend/src/context/AuthContext.tsx
- Changes: Add signup method
- Location: AuthContext provider
- Reason: Handle auth state after signup
```

### API Contracts

#### Endpoint: POST /api/auth/signup

**Request:**
```json
{
  "email": "user@example.com",
  "password": "securepassword123"
}
```

**Response (Success - 201):**
```json
{
  "user": {
    "id": "uuid-here",
    "email": "user@example.com",
    "createdAt": "2025-12-05T10:30:00Z"
  },
  "token": "jwt.token.here"
}
```

**Response (Error - 400 - Validation):**
```json
{
  "error": "Email is required"
}
```

**Response (Error - 409 - Duplicate):**
```json
{
  "error": "An account with this email already exists"
}
```

**Validation:**
- Email must be valid format (regex: `.+@.+\..+`)
- Email must be unique in database
- Password must be at least 8 characters
- Both fields required

### Database Changes

#### New Tables
```sql
CREATE TABLE users (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  email VARCHAR(255) UNIQUE NOT NULL,
  password_hash VARCHAR(255) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

#### Indexes
```sql
CREATE UNIQUE INDEX idx_users_email ON users(email);
```

### State Management

**Auth Context state shape:**
```typescript
{
  user: {
    id: string;
    email: string;
  } | null,
  token: string | null,
  loading: boolean,
  error: string | null
}
```

**Actions:**
- signup(email, password): Calls API, stores user + token
- logout(): Clears user and token
- setError(message): Sets error state

**Token storage:**
- Store in localStorage: `localStorage.setItem('token', token)`
- Include in API requests: `Authorization: Bearer ${token}`

## Acceptance Criteria Mapping

### From Story → Verification

**Story criterion 1:** Successful signup with valid email/password
**Verification:**
- Unit test: userService.createUser hashes password and creates record
- Integration test: POST /signup returns 201 with user + token
- Manual check: Fill signup form, verify redirect to tasks page

**Story criterion 2:** Email validation
**Verification:**
- Unit test: Validation rejects invalid email formats
- Integration test: POST /signup with invalid email returns 400
- Manual check: Enter "notanemail", verify error message shown

**Story criterion 3:** Duplicate email handling
**Verification:**
- Integration test: POST /signup with existing email returns 409
- Manual check: Signup twice with same email, verify error shown

**Story criterion 4:** Password requirements
**Verification:**
- Unit test: Validation rejects passwords < 8 chars
- Integration test: POST /signup with short password returns 400
- Manual check: Enter "short", verify error message

## Testing Requirements

### Unit Tests

**File:** `backend/src/services/user.service.test.ts`

```typescript
describe('UserService', () => {
  it('should hash password before storing', async () => {
    const user = await createUser('test@example.com', 'password123');
    expect(user.password_hash).not.toBe('password123');
    expect(user.password_hash).toMatch(/^\$2[ayb]\$/); // bcrypt format
  });

  it('should reject duplicate emails', async () => {
    await createUser('test@example.com', 'password123');
    await expect(createUser('test@example.com', 'other')).rejects.toThrow();
  });
});
```

**File:** `frontend/src/components/SignupForm.test.tsx`

```typescript
describe('SignupForm', () => {
  it('should display error for invalid email', () => {
    // Test implementation
  });

  it('should display error for short password', () => {
    // Test implementation
  });
});
```

**Coverage target:** 80% for user service and auth controller

### Integration Tests

**Scenario 1:** Full signup flow
- Setup: Clean database
- Action: POST /api/auth/signup with valid data
- Assert:
  - Response 201
  - User created in database
  - Token is valid JWT
  - Password is hashed in database

**Scenario 2:** Duplicate email prevention
- Setup: Create user with test@example.com
- Action: POST /api/auth/signup with same email
- Assert: Response 409, error message correct

### Manual Testing

- [ ] Signup form displays properly
- [ ] Email validation error shows for invalid emails
- [ ] Password validation error shows for short passwords
- [ ] Success: User redirected to tasks page after signup
- [ ] Token stored in localStorage
- [ ] Test in Chrome, Firefox, Safari

## Dependencies

**Must complete first:**
- Database setup (PostgreSQL connection configured)
- Prisma ORM setup
- JWT secret configured in environment

**Enables:**
- Spec 002: User Login (requires users table)
- All task specs (require auth)

## Risks & Mitigations

**Risk 1:** Password hashing performance could slow down signup
**Mitigation:** Bcrypt is async, won't block event loop
**Fallback:** Can reduce bcrypt rounds if needed (default 10 is fine)

**Risk 2:** JWT secret exposure
**Mitigation:** Store in environment variable, never commit to git
**Fallback:** Can rotate secret if compromised (invalidates existing tokens)

## Performance Considerations

**Expected load:** Low (<10 signups/hour)
**Optimization strategy:** Not needed for v1
**Benchmarks:** Signup should complete in <500ms

## Security Considerations

**Authentication:** Not applicable (this is the signup endpoint)

**Authorization:** Not applicable (public endpoint)

**Data validation:**
- Validate email format server-side
- Validate password length server-side
- Sanitize inputs to prevent SQL injection (handled by Prisma)

**Sensitive data:**
- NEVER store plaintext passwords
- Use bcrypt with salt rounds = 10
- JWT secret must be strong random string (>32 chars)
- Don't include password_hash in API responses

## Success Verification

After implementation, verify:
- [ ] All unit tests pass
- [ ] Integration tests pass
- [ ] Manual testing checklist complete
- [ ] User can signup and see tasks page
- [ ] Password is hashed in database (check with SQL query)
- [ ] Token is valid JWT (decode at jwt.io)
- [ ] No console errors
- [ ] Duplicate email properly rejected
- [ ] Invalid email properly rejected
- [ ] Short password properly rejected

## Traceability

**Parent story:** examples/sample-workflow/stories/story-001-user-signup.md
**Parent epic:** examples/sample-workflow/epics/epic-001-authentication.md

## Implementation Notes

**Open questions:**
- Should we add rate limiting to prevent signup spam? → No for v1, add in v2
- Email confirmation required? → No for v1

**Assumptions:**
- Users will use real emails (no validation required for v1)
- Token expiry of 24h is acceptable
- No need for refresh tokens in v1

---

**Next step:** Run `/dev-story examples/sample-workflow/specs/spec-001-user-signup.md`
