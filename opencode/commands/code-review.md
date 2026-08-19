---
description: Review code for defects, duplication, and quality issues
agent: plan
---

Review the code for quality issues and propose concrete fixes.

Hunt for defects:
- Logic errors: off-by-one, wrong comparisons, inverted conditions, missed edge cases (empty inputs, null, single element, boundary values).
- Error handling: swallowed exceptions, unhandled errors, missing validation of inputs.
- Concurrency and state bugs: race conditions, shared mutable state, improper async/await.
- Resource leaks: unclosed connections, file handles, or timers.

Hunt for duplication:
- Copy-pasted blocks that could be extracted into a shared function.
- Repeated literals, conditions, or error messages that should be constants.
- Similar classes or functions differing only by parameter, that could be unified.

Also flag:
- Dead code, unused imports, and unused variables.
- Overly complex code (deep nesting, long functions) that hurts readability.
- Inconsistencies with the project's existing style.

For each finding, report the location, why it is a problem, and the concrete fix.
Prioritize by impact: correctness first, then duplication, then style.
End with a short summary of the most impactful changes to make.
