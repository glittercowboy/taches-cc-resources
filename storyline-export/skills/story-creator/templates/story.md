---
story_id: {NUMBER}
epic_id: {EPIC_NUMBER}
title: {Story Title}
status: ready_for_spec
created: {ISO date}
---

# Story {NUMBER}: {Title}

## User Story

**As a** {user persona},
**I want** {capability or feature},
**so that** {business value or user benefit}.

## Acceptance Criteria

### Scenario 1: {Happy path scenario}
**Given** {initial context or state}
**When** {action or event}
**Then** {expected outcome}
**And** {additional outcome}

### Scenario 2: {Edge case or validation}
**Given** {initial context}
**When** {action}
**Then** {expected outcome}

### Scenario 3: {Error handling}
**Given** {error condition}
**When** {action}
**Then** {error handling behavior}

## Business Value

**Why this matters:** {Clear explanation of business value}

**Impact:** {Who benefits and how}

**Success metric:** {How we'll measure success}

## Technical Considerations

{High-level technical notes that inform the spec}

**Potential approaches:**
- {Approach 1}
- {Approach 2}

**Constraints:**
- {Constraint 1}
- {Constraint 2}

**Data requirements:**
- {Data needed}

## Dependencies

**Depends on stories:**
- Story {NUMBER}: {Title} - {Why}

**Enables stories:**
- Story {NUMBER}: {Title} - {What becomes possible}

**No dependencies:** {If applicable}

## Out of Scope

{What is explicitly NOT included in this story}
{Helps prevent scope creep}

## Notes

{Any additional context, open questions, or discussion points}

## Traceability

**Parent epic:** .workflow/epics/epic-{NUMBER}-{slug}.md

**Related stories:** Story {NUMBER}, Story {NUMBER}

---

**Next step:** Run `/spec-story .workflow/stories/story-{NUMBER}-{slug}.md`
