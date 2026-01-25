# Operational Learnings

Guidance on using AGENTS.md to capture and evolve Ralph's knowledge.

<what_is_agents_md>
## What is AGENTS.md?

AGENTS.md is a file that contains project-specific learnings that Ralph needs to know. It's loaded every loop iteration alongside the prompt.

**Purpose:**
- Capture patterns Ralph should follow
- Document project-specific constraints
- Record discovered learnings from failures
- Provide build/test commands
- Share context that prompts don't include

**Key insight:** AGENTS.md evolves through observation. Start minimal, add only what's needed.
</what_is_agents_md>

<start_minimal>
## Start Minimal

**Initial AGENTS.md (literally this):**
```markdown
# Operational Learnings

This file contains project-specific guidance for Ralph.

## Build/Test Commands

[To be filled as needed]

## Known Patterns

[To be filled as needed]

## Constraints

[To be filled as needed]
```

**Or even simpler (just empty sections):**
```markdown
# Operational Learnings
```

**Don't:**
- Pre-populate with guessed patterns
- Copy from other projects
- Add rules you haven't observed need for
- Try to predict all failure modes

**Do:**
- Start empty or near-empty
- Add entries when Ralph fails repeatedly
- Remove entries when no longer relevant
- Keep it focused and minimal
</start_minimal>

<when_to_add_entries>
## When to Add Entries

Add to AGENTS.md when you observe:

### 1. Repeated Mistakes

**Observation:** Ralph keeps implementing authentication without using the existing auth library
**Entry:**
```markdown
## Known Patterns

### Authentication
Always use src/lib/auth.ts for authentication. Do not implement custom auth logic.
```

### 2. Project-Specific Commands

**Observation:** Tests require specific environment setup
**Entry:**
```markdown
## Build/Test Commands

### Running Tests
```bash
export NODE_ENV=test
npm test
```

Tests require NODE_ENV=test to use test database.
```

### 3. Discovered Constraints

**Observation:** Ralph keeps trying to use a library that's not available
**Entry:**
```markdown
## Constraints

### Dependencies
- Do NOT use lodash (not installed, use native JS instead)
- Do NOT use axios (use native fetch)
- DO use Zod for validation (already installed)
```

### 4. Architectural Decisions

**Observation:** Ralph implements features in inconsistent locations
**Entry:**
```markdown
## Known Patterns

### Code Organization
- UI components: src/components/
- Business logic: src/lib/
- API routes: src/pages/api/
- Database: src/db/

New features should follow this structure.
```

### 5. Gotchas and Edge Cases

**Observation:** Ralph forgets to handle specific edge case
**Entry:**
```markdown
## Known Patterns

### Date Handling
Always handle timezone conversion. User input is in local time, database stores UTC.
Use src/lib/dates.ts utilities for all date operations.
```
</when_to_add_entries>

<when_not_to_add_entries>
## When NOT to Add Entries

Don't add to AGENTS.md for:

### 1. One-Off Mistakes

Ralph made a mistake once, then corrected it. No pattern yet.

**Wait for:** Same mistake 2-3 times, then add guidance.

### 2. General Best Practices

Don't add universal programming wisdom:

**Bad:**
```markdown
## Best Practices
- Write clean code
- Use meaningful variable names
- Handle errors properly
```

**Why:** Claude already knows this. AGENTS.md is for project-specific knowledge.

### 3. Things in Specs

If it's already in the spec, don't duplicate in AGENTS.md.

**Bad:** Spec says "use JWT for auth", AGENTS.md repeats "use JWT for auth"
**Good:** Spec says "handle auth", AGENTS.md says "use src/lib/auth.ts (JWT implementation)"

### 4. Temporary Workarounds

**Bad:**
```markdown
## Workarounds
- API endpoint /v1/users is broken, use /v2/users instead
```

**Why:** This will become stale. Fix the root cause or document in code comments, not AGENTS.md.

### 5. Overly Specific Instructions

**Bad:**
```markdown
## Implementation Steps for User Profile Feature
1. Create src/components/UserProfile.tsx
2. Add props interface with name, email, avatar
3. Import Avatar component from src/components/ui/Avatar
4. Style using Tailwind classes: bg-white rounded-lg shadow-md
...
```

**Why:** This is a task description, not a learning. Put this in specs or let Ralph figure it out.
</when_not_to_add_entries>

<structure_guidance>
## Structure Guidance

Keep AGENTS.md organized and scannable:

### Use Clear Sections

```markdown
# Operational Learnings

## Build/Test Commands
[Commands Ralph needs to run]

## Known Patterns
[Project-specific patterns to follow]

## Constraints
[Things Ralph can't or shouldn't do]

## Architecture
[High-level structure and decisions]

## Gotchas
[Edge cases and non-obvious behaviors]
```

### Use Subsections for Categories

```markdown
## Known Patterns

### Authentication
[Auth-specific patterns]

### Database
[Database-specific patterns]

### API Design
[API-specific patterns]
```

### Keep Entries Concise

**Bad:**
```markdown
### Error Handling
We have a comprehensive error handling system that was implemented
in PR #123. It uses custom error classes that extend the base Error
class. When implementing new features, you should follow this pattern
by creating appropriate error classes and throwing them with descriptive
messages. The error handling middleware will catch these and return
appropriate HTTP status codes. For validation errors, use 400. For
authentication errors, use 401. For authorization errors, use 403...
```

**Good:**
```markdown
### Error Handling
Use custom error classes from src/lib/errors.ts
- ValidationError → 400
- AuthenticationError → 401
- AuthorizationError → 403
```

### Use Code Examples

When patterns are easier to show than describe:

```markdown
### API Response Format
Always return this structure:
```typescript
{
  success: boolean
  data?: any
  error?: { message: string, code: string }
}
```
```
</structure_guidance>

<evolution_over_time>
## Evolution Over Time

AGENTS.md grows and changes with the project:

### Phase 1: Initial Loops (Days 1-3)
- File is mostly empty
- Watching for patterns
- Taking notes but not committing to AGENTS.md yet

### Phase 2: Pattern Recognition (Week 1)
- First entries added based on observed failures
- Mostly build/test commands and constraints
- 20-50 lines total

### Phase 3: Stabilization (Weeks 2-4)
- Known patterns documented
- Architecture decisions captured
- Ralph following patterns more consistently
- 50-150 lines total

### Phase 4: Maturity (Month 2+)
- Well-documented project knowledge
- New entries added rarely
- Occasional cleanup of stale entries
- 100-300 lines total

### Phase 5: Maintenance
- AGENTS.md changes infrequently
- Entries removed when architecture changes
- Project patterns are stable
- Size stays constant or shrinks
</evolution_over_time>

<example_agents_md>
## Example AGENTS.md

Real-world example from a TypeScript web app:

```markdown
# Operational Learnings

## Build/Test Commands

### Running Tests
```bash
npm test                  # All tests
npm test -- --watch      # Watch mode
npm test -- path/to/test # Specific test
```

### Type Checking
```bash
npm run type-check       # TypeScript validation
```

### Building
```bash
npm run build           # Production build
npm run dev             # Development server
```

## Known Patterns

### Authentication
- Use src/lib/auth.ts for all auth operations
- JWT tokens stored in httpOnly cookies
- Refresh tokens in separate cookie
- Don't implement custom auth logic

### Database Queries
- Use Prisma client from src/db/client.ts
- Always use transactions for multi-step operations
- Include error handling for unique constraint violations

### API Design
Response format:
```typescript
{
  success: boolean
  data?: T
  error?: { message: string, code: string }
}
```

### Component Structure
- UI components: src/components/ui/ (no business logic)
- Feature components: src/components/features/ (can have logic)
- Shared hooks: src/hooks/
- Use TypeScript interfaces for all props

## Constraints

### Dependencies
- Use native fetch (not axios)
- Use Zod for validation (already installed)
- Use date-fns for dates (not moment.js)
- Use Tailwind for styling (no CSS modules)

### Database
- Do NOT use raw SQL (use Prisma)
- Do NOT expose internal IDs in API (use UUIDs or slugs)

### Testing
- Do NOT use shallow rendering (use Testing Library)
- Do NOT test implementation details (test behavior)

## Gotcas

### Dates
- User input is local time, database stores UTC
- Always convert using src/lib/dates.ts utilities

### File Uploads
- Max file size: 10MB (enforced by middleware)
- Store in S3, not local filesystem
- Generate signed URLs for access

### Rate Limiting
- API endpoints are rate-limited (100 req/min)
- Auth endpoints stricter (10 req/min)
- Handle 429 responses with exponential backoff
```
</example_agents_md>

<common_categories>
## Common Categories

Categories you might need in AGENTS.md:

### Technical
- Build/Test Commands
- Dependencies and Versions
- Environment Variables
- API Endpoints
- Database Schema Notes

### Patterns
- Code Organization
- Naming Conventions
- Error Handling
- Logging Strategy
- Authentication/Authorization

### Constraints
- What NOT to use
- Performance Requirements
- Security Requirements
- Deployment Constraints

### Business Logic
- Domain Rules
- Calculation Formulas
- State Machines
- Workflow Steps

### Integration
- External APIs
- Third-party Services
- Webhook Handling
- Event Processing

### Testing
- Test Strategy
- Mock Patterns
- Test Data Setup
- CI/CD Notes
</common_categories>

<keeping_it_current>
## Keeping It Current

AGENTS.md can become stale. Regular maintenance:

### Weekly Review
- Read through AGENTS.md
- Remove entries that are now in code patterns
- Remove entries that are outdated
- Add entries from the week's observations

### After Major Changes
- Architecture refactor → update patterns
- Dependency updates → verify commands still work
- New features → add new patterns if emerging

### Signs of Staleness
- Entries contradict current code
- Commands don't work anymore
- Patterns no longer followed
- Ralph ignoring entries (they're wrong)

### Cleanup Triggers
- File over 500 lines → too much, condense
- Same information repeated → consolidate
- Entries no one references → remove
- Contradictory entries → reconcile
</keeping_it_current>

<antipatterns>
## Anti-Patterns

Things to avoid:

### 1. The Novel
AGENTS.md shouldn't be 1000+ lines of comprehensive project documentation. That belongs in real docs.

### 2. The Rule Book
Don't make it a list of "thou shalt not" commands. Keep it practical and pattern-focused.

### 3. The Tutorial
Don't teach programming concepts. Assume Claude is a competent developer, just new to your project.

### 4. The Archive
Don't keep historical notes about decisions. Document current state only.

### 5. The Spec Duplicate
Don't repeat what's in your specs. Reference specs, don't duplicate them.

### 6. The Wishlist
Don't add patterns you wish existed. Document what actually is, not what should be.
</antipatterns>
