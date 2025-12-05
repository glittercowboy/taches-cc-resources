# Epic Patterns and Anti-Patterns

## Good Epic Patterns

### Pattern 1: Business Capability Epic
Groups all features for a single business capability.

**Example:** "User Authentication"
- Sign up
- Sign in
- Password reset
- Email verification
- Session management

**Why it works:** Clear boundaries, focused domain, complete capability.

### Pattern 2: User Journey Epic
Groups features for a specific user flow or persona.

**Example:** "New User Onboarding"
- Account creation
- Profile setup
- Initial preferences
- Tutorial walkthrough
- First project creation

**Why it works:** User-centric, natural story boundaries, testable end-to-end.

### Pattern 3: Technical Domain Epic
Groups features by system layer or technical area.

**Example:** "API Foundation"
- REST endpoint structure
- Authentication middleware
- Error handling
- Rate limiting
- API documentation

**Why it works:** Technical cohesion, clear ownership, reusable foundation.

### Pattern 4: Integration Epic
Groups features for integrating with external system.

**Example:** "Stripe Payment Integration"
- Payment method storage
- Charge processing
- Webhook handling
- Receipt generation
- Refund support

**Why it works:** Isolated scope, clear third-party boundary, testable integration.

## Anti-Patterns to Avoid

### Anti-Pattern 1: The Task List Epic
**Bad:** "Sprint 1 Tasks"
- Fix bug #123
- Update dependencies
- Refactor UserService
- Add dark mode toggle

**Why it fails:** No thematic connection, no business value, just random tasks.

### Anti-Pattern 2: The Kitchen Sink Epic
**Bad:** "Build the Application"
- Everything in the PRD crammed into one epic

**Why it fails:** Too large, no clear boundaries, can't be sized or estimated.

### Anti-Pattern 3: The Premature Epic
**Bad:** "Performance Optimization"
- Before any features exist
- No baseline metrics
- No user complaints

**Why it fails:** Premature, no data, should be done as needed, not upfront.

### Anti-Pattern 4: The Technical Jargon Epic
**Bad:** "Implement Microservices Architecture with Event Sourcing"
- No user value stated
- Pure technical description
- Implementation detail, not business capability

**Why it fails:** Should be framed in business terms or as enabler for user features.

### Anti-Pattern 5: The Dependency Hell Epic
**Bad:** Epic that depends on 5 other epics that don't exist yet

**Why it fails:** Can't be started, blocks everything, should be reordered or split.

## Sizing Guidelines

### Small Epic (3-5 stories)
- Single feature with variants
- Simple integration
- UI-only enhancement
- **Duration:** 1-2 weeks

### Medium Epic (5-8 stories)
- Business capability
- Full feature with backend + frontend
- Complex integration
- **Duration:** 2-3 weeks

### Large Epic (8-12 stories)
- Major feature area
- Multiple related capabilities
- Cross-system changes
- **Duration:** 3-4 weeks

### Too Large (>12 stories)
**Split it!** Break into multiple epics by:
- User persona
- Feature subset
- Technical layer
- Phases (MVP vs Enhanced)

## Epic Relationships

### Sequential Dependency
Epic B cannot start until Epic A completes.

**Example:**
- Epic 1: User Authentication
- Epic 2: User Profiles (needs auth)

### Parallel Independent
Epics can be developed simultaneously.

**Example:**
- Epic 1: Search Feature
- Epic 2: Export Feature
(Neither depends on the other)

### Enabler Pattern
Epic A unlocks Epic B, C, D.

**Example:**
- Epic 1: API Foundation
- Epic 2: Mobile App (uses API)
- Epic 3: Web App (uses API)
- Epic 4: CLI Tool (uses API)

## Validation Checklist

Good epic has:
- [ ] Clear business goal (not just technical description)
- [ ] Defined user value (who benefits and how)
- [ ] Measurable success criteria
- [ ] Scope boundaries (in/out of scope)
- [ ] Right size (3-12 stories estimated)
- [ ] No circular dependencies
- [ ] Link back to source PRD/spec
- [ ] Single thematic focus

Bad epic has:
- [ ] Vague goals ("improve the system")
- [ ] No user value stated
- [ ] Unmeasurable success ("make it better")
- [ ] Unclear boundaries
- [ ] Too large (>12 stories) or too small (1 story)
- [ ] Circular dependencies
- [ ] No traceability
- [ ] Multiple unrelated themes
