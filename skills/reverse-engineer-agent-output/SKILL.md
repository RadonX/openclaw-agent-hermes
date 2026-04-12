---
name: reverse-engineer-agent-output
description: When an agent produces unexpected output (skill created, memory saved, profile updated), trace it back to the specific prompt, code location, and conversation trigger. Use for debugging agent behavior.
---

# Reverse-Engineer Agent Output

When the background agent produces an artifact (skill, memory entry, profile update), trace the causal chain.

## When to Use

- A skill was auto-created and you want to understand why
- A user profile was updated and you want to know what was inferred
- Any agent output seems surprising or unexplained

## Steps

1. **Identify the artifact** — what was created/updated?
2. **Find the generating prompt** — which prompt produced it?
   - Skill creation → `_SKILL_REVIEW_PROMPT` (run_agent.py:2050)
   - Memory/profile → `_MEMORY_REVIEW_PROMPT` (run_agent.py:2039)
   - Combined → `_COMBINED_REVIEW_PROMPT` (run_agent.py:2060)
3. **Map prompt criteria to conversation events** — build a matrix:

   | Prompt criterion | Matched conversation event | Confidence |
   |---|---|---|
   | [exact words from prompt] | [what was said/done] | explicit / inferred |

4. **Distinguish explicit vs inferred**:
   - **Explicit**: user directly stated it in the conversation
   - **Inferred**: agent deduced it from behavior patterns
5. **Trace to code** — provide file path + line number for the prompt definition

## Output Format

```
Artifact: [what was created/updated]
Triggering prompt: [#25 / #26 / #27] @ file:line
Trigger mechanism: [background review / manual / nudge]

Causal chain:
  conversation event → matched prompt criterion → artifact

Extraction matrix:
  | Criterion | Source | Type |
  |---|---|---|
  | ... | ... | explicit/inferred |
```

## Pitfalls

- Background review runs asynchronously — the artifact may appear several turns after the triggering conversation
- The agent may infer incorrectly — always verify inferences against what was actually said
- Combined review (#27) merges memory + skill criteria, making it harder to attribute to a single focus area
- Two targets exist: `memory` (agent's notes) and `user` (who the user is) — the same prompt focus can be written to either depending on who the main subject is

## See Also

- [background-review skill](../background-review/SKILL.md) for the review prompts themselves
- `/prompt:explain` framework for structured analysis of agent guidelines
