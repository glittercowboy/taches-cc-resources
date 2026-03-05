# Research Pitfalls - Known Patterns to Avoid

## Purpose
This document catalogs research mistakes discovered in production use, providing specific patterns to avoid and verification strategies to prevent recurrence.

## Known Pitfalls

### Pitfall 1: Configuration Scope Assumptions
**What**: Assuming global configuration means no project-scoping exists
**Example**: Concluding "MCP servers are configured GLOBALLY only" while missing project-scoped `.mcp.json`
**Why it happens**: Not explicitly checking all known configuration patterns
**Prevention**:
```xml
<verification_checklist>
**CRITICAL**: Verify ALL configuration scopes:
□ User/global scope - System-wide configuration
□ Project scope - Project-level configuration files
□ Local scope - Project-specific user overrides
□ Workspace scope - IDE/tool workspace settings
□ Environment scope - Environment variables
</verification_checklist>
```

### Pitfall 2: "Search for X" Vagueness
**What**: Asking researchers to "search for documentation" without specifying where
**Example**: "Research MCP documentation" → finds outdated community blog instead of official docs
**Why it happens**: Vague research instructions don't specify exact sources
**Prevention**:
```xml
<sources>
Official sources (use WebFetch):
- https://exact-url-to-official-docs
- https://exact-url-to-api-reference

Search queries (use WebSearch):
- "specific search query {current_year}"
- "another specific query {current_year}"
</sources>
```

### Pitfall 3: Deprecated vs Current Features
**What**: Finding archived/old documentation and concluding feature doesn't exist
**Example**: Finding 2022 docs saying "feature not supported" when current version added it
**Why it happens**: Not checking multiple sources or recent updates
**Prevention**:
```xml
<verification_checklist>
□ Check current official documentation
□ Review changelog/release notes for recent updates
□ Verify version numbers and publication dates
□ Cross-reference multiple authoritative sources
</verification_checklist>
```

### Pitfall 4: Tool-Specific Variations
**What**: Conflating capabilities across different tools/environments
**Example**: "Claude Desktop supports X" ≠ "Claude Code supports X"
**Why it happens**: Not explicitly checking each environment separately
**Prevention**:
```xml
<verification_checklist>
□ Claude Desktop capabilities
□ Claude Code capabilities
□ VS Code extension capabilities
□ API/SDK capabilities
Document which environment supports which features
</verification_checklist>
```

### Pitfall 5: Confident Negative Claims Without Citations
**What**: Making definitive "X is not possible" statements without official source verification
**Example**: "Folder-scoped MCP configuration is not supported" (missing `.mcp.json`)
**Why it happens**: Drawing conclusions from absence of evidence rather than evidence of absence
**Prevention**:
```xml
<critical_claims_audit>
For any "X is not possible" or "Y is the only way" statement:
- [ ] Is this verified by official documentation stating it explicitly?
- [ ] Have I checked for recent updates that might change this?
- [ ] Have I verified all possible approaches/mechanisms?
- [ ] Am I confusing "I didn't find it" with "it doesn't exist"?
</critical_claims_audit>
```

### Pitfall 6: Missing Enumeration
**What**: Investigating open-ended scope without enumerating known possibilities first
**Example**: "Research configuration options" instead of listing specific options to verify
**Why it happens**: Not creating explicit checklist of items to investigate
**Prevention**:
```xml
<verification_checklist>
Enumerate ALL known options FIRST:
□ Option 1: [specific item]
□ Option 2: [specific item]
□ Option 3: [specific item]
□ Check for additional unlisted options

For each option above, document:
- Existence (confirmed/not found/unclear)
- Official source URL
- Current status (active/deprecated/beta)
</verification_checklist>
```

### Pitfall 7: Single-Source Verification
**What**: Relying on a single source for critical claims
**Example**: Using only Stack Overflow answer from 2021 for current best practices
**Why it happens**: Not cross-referencing multiple authoritative sources
**Prevention**:
```xml
<source_verification>
For critical claims, require multiple sources:
- [ ] Official documentation (primary)
- [ ] Release notes/changelog (for currency)
- [ ] Additional authoritative source (for verification)
- [ ] Contradiction check (ensure sources agree)
</source_verification>
```

### Pitfall 8: Assumed Completeness
**What**: Assuming search results are complete and authoritative
**Example**: First Google result is outdated but assumed current
**Why it happens**: Not verifying publication dates and source authority
**Prevention**:
```xml
<source_verification>
For each source consulted:
- [ ] Publication/update date verified (prefer recent/current)
- [ ] Source authority confirmed (official docs, not blogs)
- [ ] Version relevance checked (matches current version)
- [ ] Multiple search queries tried (not just one)
</source_verification>
```

### Pitfall 9: Summary Count Pre-Commitment
**What**: Output skeleton places `<summary>` or `<count>` elements before the items they summarize, causing the model to pre-commit to counts before enumeration
**Example**: Skeleton orders `<summary>` then `<findings>`. Model writes "Found 12 issues: 3 factual errors, 5 missing..." then enumerates 14 actual findings. Summary is frozen at 12.
**Why it happens**: Autoregressive models cannot revise already-emitted tokens. Implicit counting degrades over long outputs (>10 items). Multi-dimensional breakdowns compound the error.
**Prevention**:
```xml
<output_structure_rules>
Items MUST precede their summary:
- [ ] <findings> before <summary>, never reversed
- [ ] Use [Will complete at end] placeholder if summary position is fixed
- [ ] Never place <count> fields before the items they count
- [ ] Avoid count-heavy SUMMARY.md one-liners
- [ ] For large enumerations (>30 items): use sequential IDs as implicit count
- [ ] For multi-dimensional classification: single dimension per pass
</output_structure_rules>
```
**What does NOT work**:
- "Count carefully" instructions -- errors are architectural (autoregressive token commitment), not carelessness
- "Double-check your counts" -- re-checking uses the same degraded attention that produced the error
- "Write summary first, then enumerate to match" -- produces classification errors (force-fitting/omitting items to match pre-committed counts)

## Red Flags in Research Outputs

### 🚩 Red Flag 1: Zero "Not Found" Results
**Warning**: Every investigation succeeds perfectly
**Problem**: Real research encounters dead ends, ambiguity, and unknowns
**Action**: Expect honest reporting of limitations, contradictions, and gaps

### 🚩 Red Flag 2: No Confidence Indicators
**Warning**: All findings presented as equally certain
**Problem**: Can't distinguish verified facts from educated guesses
**Action**: Require confidence levels (High/Medium/Low) for key findings

### 🚩 Red Flag 3: Missing URLs
**Warning**: "According to documentation..." without specific URL
**Problem**: Can't verify claims or check for updates
**Action**: Require actual URLs for all official documentation claims

### 🚩 Red Flag 4: Definitive Statements Without Evidence
**Warning**: "X cannot do Y" or "Z is the only way" without citation
**Problem**: Strong claims require strong evidence
**Action**: Flag for verification against official sources

### 🚩 Red Flag 5: Incomplete Enumeration
**Warning**: Verification checklist lists 4 items, output covers 2
**Problem**: Systematic gaps in coverage
**Action**: Ensure all enumerated items addressed or marked "not found"

### 🚩 Red Flag 6: Count-Heavy Summary One-Liners
**Warning**: SUMMARY.md one-liner contains multi-dimensional count breakdowns like "38 practices mapped: 8 type-A, 14 type-B, 9 type-C, 7 type-D"
**Problem**: Count-heavy one-liners prime models to pre-commit to specific multi-dimensional counts before enumeration is complete
**Action**: Replace with descriptive one-liners; derive counts from enumerated output after writing, not during summary generation

## Continuous Improvement

When research gaps occur:

1. **Document the gap**
   - What was missed or incorrect?
   - What was the actual correct information?
   - What was the impact?

2. **Root cause analysis**
   - Why wasn't it caught?
   - Which verification step would have prevented it?
   - What pattern does this reveal?

3. **Update this document**
   - Add new pitfall entry
   - Update relevant checklists
   - Share lesson learned

## Quick Reference Checklist

Before submitting research, verify:

- [ ] All enumerated items investigated (not just some)
- [ ] Negative claims verified with official docs
- [ ] Multiple sources cross-referenced for critical claims
- [ ] URLs provided for all official documentation
- [ ] Publication dates checked (prefer recent/current)
- [ ] Tool/environment-specific variations documented
- [ ] Confidence levels assigned honestly
- [ ] Assumptions distinguished from verified facts
- [ ] "What might I have missed?" review completed

---

**Living Document**: Update after each significant research gap
**Lessons From**: MCP configuration research gap (missed `.mcp.json`)
