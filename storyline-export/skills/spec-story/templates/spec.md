---
spec_id: {NUMBER}
story_id: {STORY_NUMBER}
epic_id: {EPIC_NUMBER}
title: {Spec Title}
status: ready_for_implementation
created: {ISO date}
---

# Technical Spec {NUMBER}: {Title}

## Overview

**User story:** {Link to parent story}

**Goal:** {What we're building in technical terms}

**Approach:** {High-level technical approach - 2-3 sentences}

## Technical Design

### Architecture Decision

{Which architectural pattern/approach we're using and why}

**Chosen approach:** {Selected option}

**Alternatives considered:**
- {Alternative 1} - {Why not chosen}
- {Alternative 2} - {Why not chosen}

**Rationale:** {Why the chosen approach is best}

### System Components

**Frontend:**
- {Component/file changes}

**Backend:**
- {API/service changes}

**Database:**
- {Schema changes}

**External integrations:**
- {Third-party services}

## Implementation Details

### Files to Create

```
{file-path}
- Purpose: {what this file does}
- Exports: {what it exposes}
```

### Files to Modify

```
{file-path}
- Changes: {what needs to change}
- Location: {which function/section}
- Reason: {why}
```

### API Contracts

#### Endpoint: {METHOD /path}
**Request:**
```json
{
  "field": "type"
}
```

**Response (Success - 200):**
```json
{
  "field": "type"
}
```

**Response (Error - 4xx):**
```json
{
  "error": "message"
}
```

**Validation:**
- {Validation rule 1}
- {Validation rule 2}

### Database Changes

#### New Tables
```sql
CREATE TABLE {table_name} (
  {column} {type} {constraints},
  ...
);
```

#### Schema Migrations
```sql
ALTER TABLE {table} ADD COLUMN {column} {type};
```

#### Indexes
```sql
CREATE INDEX {index_name} ON {table}({column});
```

### State Management

**State shape:**
```javascript
{
  field: type,
  nested: {
    field: type
  }
}
```

**Actions:**
- {Action name}: {What it does}

**Selectors:**
- {Selector name}: {What it returns}

## Acceptance Criteria Mapping

### From Story → Verification

**Story criterion 1:** {Acceptance criterion from story}
**Verification:**
- Unit test: {Test description}
- Integration test: {Test description}
- Manual check: {UI verification}

**Story criterion 2:** {Next criterion}
**Verification:**
...

## Testing Requirements

### Unit Tests

**File:** `{test-file-path}`

```javascript
describe('{Feature}', () => {
  it('should {behavior}', () => {
    // Test implementation
  });

  it('should {edge case}', () => {
    // Test implementation
  });
});
```

**Coverage target:** {percentage or critical paths}

### Integration Tests

**Scenario 1:** {End-to-end flow}
- Setup: {Preconditions}
- Action: {User action}
- Assert: {Expected outcome}

### Manual Testing

- [ ] {Visual check 1}
- [ ] {Interaction check 2}
- [ ] {Browser compatibility check}

## Dependencies

**Must complete first:**
- Spec {NUMBER}: {Title}
- {External dependency}

**Enables:**
- Spec {NUMBER}: {Title}

## Risks & Mitigations

**Risk 1:** {Potential issue}
**Mitigation:** {How we'll handle it}
**Fallback:** {Plan B if mitigation fails}

## Performance Considerations

**Expected load:** {Usage patterns}
**Optimization strategy:** {How we'll keep it fast}
**Benchmarks:** {Target metrics}

## Security Considerations

**Authentication:** {How we verify identity}
**Authorization:** {Who can do what}
**Data validation:** {Input sanitization}
**Sensitive data:** {How we protect it}

## Success Verification

After implementation, verify:
- [ ] All unit tests pass
- [ ] Integration tests pass
- [ ] Manual testing checklist complete
- [ ] Acceptance criteria from story satisfied
- [ ] No console errors
- [ ] Performance benchmarks met
- [ ] Security review complete

## Traceability

**Parent story:** .workflow/stories/story-{NUMBER}-{slug}.md
**Parent epic:** .workflow/epics/epic-{NUMBER}-{slug}.md

## Implementation Notes

{Any additional context for the developer/Claude}

**Open questions:**
- {Question 1}
- {Question 2}

**Assumptions:**
- {Assumption 1}
- {Assumption 2}

---

**Next step:** Run `/dev-story .workflow/specs/spec-{NUMBER}-{slug}.md`
