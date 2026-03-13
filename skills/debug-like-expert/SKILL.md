---
name: debug-like-expert
description: >
  Activates deep analysis debugging mode that analyzes stack traces, inspects logs, traces execution flow,
  identifies race conditions, and performs methodical root cause analysis with evidence gathering and
  hypothesis testing. Use when the user reports a bug, error, crash, unexpected behavior, or says something
  is 'not working' or 'broken' and standard troubleshooting has failed.
---

<objective>
Deep analysis debugging mode for complex issues. This skill activates methodical investigation protocols with evidence gathering, hypothesis testing, and rigorous verification when standard troubleshooting has failed.

The skill emphasizes treating code you wrote with MORE skepticism than unfamiliar code, as cognitive biases about "how it should work" can blind you to actual implementation errors. Use scientific method to systematically identify root causes rather than applying quick fixes.
</objective>

<context_scan>
```bash
# Detect project type and available expertise
for f in package.json Cargo.toml pyproject.toml setup.py go.mod Package.swift; do [ -f "$f" ] && echo "DETECTED: $f"; done
ls ~/.claude/skills/expertise/ 2>/dev/null | head -5
```
</context_scan>

<domain_expertise>
Domain-specific expertise lives in `~/.claude/skills/expertise/`. If the context scan finds matching expertise, load it before investigating:

```bash
cat ~/.claude/skills/expertise/[domain]/references/*.md 2>/dev/null
```

Infer the domain from project files and the user's description (e.g., `.swift` + SwiftUI → `expertise/macos-apps`, `Cargo.toml` → `expertise/rust-systems`). If no domain expertise is found or the bug is domain-agnostic (pure logic, generic algorithms), proceed with general debugging methodology.
</domain_expertise>

<context>
This skill activates when standard troubleshooting has failed. The issue requires methodical investigation, not quick fixes. You are entering the mindset of a senior engineer who debugs with scientific rigor.

**Important**: If you wrote or modified any of the code being debugged, you have cognitive biases about how it works. Your mental model of "how it should work" may be wrong. Treat code you wrote with MORE skepticism than unfamiliar code - you're blind to your own assumptions.
</context>

<core_principle>
**VERIFY, DON'T ASSUME.** Every hypothesis must be tested. Every "fix" must be validated. No solutions without evidence.

**ESPECIALLY**: Code you designed or implemented is guilty until proven innocent. Your intent doesn't matter - only the code's actual behavior matters. Question your own design decisions as rigorously as you'd question anyone else's.
</core_principle>

<quick_start>

<evidence_gathering>

Before proposing any solution:

**A. Document Current State**
- What is the EXACT error message or unexpected behavior?
- What are the EXACT steps to reproduce?
- What is the ACTUAL output vs EXPECTED output?
- When did this start working incorrectly (if known)?

**B. Map the System**
- Trace the execution path from entry point to failure point
- Identify all components involved
- Read relevant source files completely, not just scanning
- Note dependencies, imports, configurations affecting this area

**Example — adding targeted logging to trace a bug:**
```python
# Before the suspected function, add logging to capture actual state
import logging
logging.basicConfig(level=logging.DEBUG)
logger = logging.getLogger(__name__)

def process_order(order):
    logger.debug(f"process_order called with: {order!r}")
    logger.debug(f"order.status={order.status}, order.items={len(order.items)}")
    # ... rest of function
```

```javascript
// For Node.js — trace an unexpected undefined value
console.log('[DEBUG] req.body:', JSON.stringify(req.body, null, 2));
console.log('[DEBUG] user:', req.user?.id, 'role:', req.user?.role);
```

**C. Gather External Knowledge (when needed)**
- Use MCP servers for API documentation, library details, or domain knowledge
- Use web search for error messages, framework-specific behaviors, or recent changes
- Check official docs for intended behavior vs what you observe
- Look for known issues, breaking changes, or version-specific quirks

See [references/when-to-research.md](references/when-to-research.md) for detailed guidance on research strategy.

</evidence_gathering>

<root_cause_analysis>

**A. Form Hypotheses**

Based on evidence, list possible causes:
1. [Hypothesis 1] - because [specific evidence]
2. [Hypothesis 2] - because [specific evidence]
3. [Hypothesis 3] - because [specific evidence]

**B. Test Each Hypothesis**

For each hypothesis:
- What would prove this true?
- What would prove this false?
- Design a minimal test
- Execute and document results

**Example — testing a race condition hypothesis:**
```python
# Hypothesis: two threads modify `shared_state` concurrently
# Test: add a lock and see if the bug disappears
import threading
lock = threading.Lock()
with lock:
    shared_state.update(new_data)  # If bug vanishes, race condition confirmed
```

**Example — investigating an error message:**
```bash
# Hypothesis: "ECONNREFUSED" means the downstream service isn't running
curl -v http://localhost:3001/health   # Test: verify the service is reachable
docker ps | grep my-service            # Check if the container is up
```

See [references/hypothesis-testing.md](references/hypothesis-testing.md) for scientific method application.

**C. Eliminate or Confirm**

Don't move forward until you can answer:
- Which hypothesis is supported by evidence?
- What evidence contradicts other hypotheses?
- What additional information is needed?

</root_cause_analysis>

<solution_development>

**Only after confirming root cause:**

**A. Design Solution**
- What is the MINIMAL change that addresses the root cause?
- What are potential side effects?
- What could this break?

**B. Implement with Verification**
- Make the change
- Add logging/debugging output if needed to verify behavior
- Document why this change addresses the root cause

**C. Test Thoroughly**
- Does the original issue still occur?
- Do the reproduction steps now work?
- Run relevant tests if they exist
- Check for regressions in related functionality

See [references/verification-patterns.md](references/verification-patterns.md) for comprehensive verification approaches.

</solution_development>

</quick_start>

<critical_rules>

1. **NO DRIVE-BY FIXES**: If you can't explain WHY a change works, don't make it
2. **VERIFY EVERYTHING**: Test your assumptions. Read the actual code. Check the actual behavior
3. **USE ALL TOOLS**:
   - MCP servers for external knowledge
   - Web search for error messages, docs, known issues
   - Extended thinking ("think deeply") for complex reasoning
   - File reading for complete context
4. **THINK OUT LOUD**: Document your reasoning at each step
5. **ONE VARIABLE**: Change one thing at a time, verify, then proceed
6. **COMPLETE READS**: Don't skim code. Read entire relevant files
7. **CHASE DEPENDENCIES**: If the issue involves libraries, configs, or external systems, investigate those too
8. **QUESTION PREVIOUS WORK**: Maybe the earlier "fix" was wrong. Re-examine with fresh eyes

</critical_rules>

<success_criteria>

Before starting:
- [ ] Context scan executed to detect domain
- [ ] Domain expertise loaded if available and relevant

During investigation:
- [ ] Do you understand WHY the issue occurred?
- [ ] Have you verified the fix actually works?
- [ ] Have you tested the original reproduction steps?
- [ ] Have you checked for side effects?
- [ ] Can you explain the solution to someone else?
- [ ] Would this fix survive code review?

If you can't answer "yes" to all of these, keep investigating.

**CRITICAL**: Do NOT mark debugging tasks as complete until this checklist passes.

</success_criteria>

<output_format>

```markdown
## Issue: [Problem Description]

### Evidence
[What you observed - exact errors, behaviors, outputs]

### Investigation
[What you checked, what you found, what you ruled out]

### Root Cause
[The actual underlying problem with evidence]

### Solution
[What you changed and WHY it addresses the root cause]

### Verification
[How you confirmed this works and doesn't break anything else]
```

</output_format>

<advanced_topics>

For deeper topics, see reference files:

**Debugging mindset**: [references/debugging-mindset.md](references/debugging-mindset.md)
- First principles thinking applied to debugging
- Cognitive biases that lead to bad fixes
- The discipline of systematic investigation
- When to stop and restart with fresh assumptions

**Investigation techniques**: [references/investigation-techniques.md](references/investigation-techniques.md)
- Binary search / divide and conquer
- Rubber duck debugging
- Minimal reproduction
- Working backwards from desired state
- Adding observability before changing code

**Hypothesis testing**: [references/hypothesis-testing.md](references/hypothesis-testing.md)
- Forming falsifiable hypotheses
- Designing experiments that prove/disprove
- What makes evidence strong vs weak
- Recovering from wrong hypotheses gracefully

**Verification patterns**: [references/verification-patterns.md](references/verification-patterns.md)
- Definition of "verified" (not just "it ran")
- Testing reproduction steps
- Regression testing adjacent functionality
- When to write tests before fixing

**Research strategy**: [references/when-to-research.md](references/when-to-research.md)
- Signals that you need external knowledge
- What to search for vs what to reason about
- Balancing research time vs experimentation

</advanced_topics>
