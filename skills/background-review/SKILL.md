---
name: background-review
description: Post-session background agent that reviews conversations and saves durable memory or skills. Routes to memory-review, skill-review, or combined-review based on trigger.
---

# Background Review

After the agent delivers a response, a background agent may fork to review the conversation and extract durable knowledge.

## Trigger Logic

Two independent nudges fire on configurable intervals (turn-count based):

| memory nudge | skill nudge | route to |
|---|---|---|
| ✅ | ❌ | [memory-review.md](references/memory-review.md) |
| ❌ | ✅ | [skill-review.md](references/skill-review.md) |
| ✅ | ✅ | [combined-review.md](references/combined-review.md) |

When both fire simultaneously, **combined-review** is used to avoid forking two agents.

## Execution

1. Determine which nudges triggered
2. Route to the matching sub-doc
3. Fork a background agent with the full conversation history
4. The sub-doc prompt is appended as the final user message
5. Background agent uses memory/skill tools as instructed

## Configuration

- `review_memory_every`: turns between memory review (default varies)
- `review_skills_every`: turns between skill review (default varies)
- Both require the respective tools to be available

## Sub-Docs

- **[references/memory-review.md](references/memory-review.md)** — #25: Extract user persona, preferences, behavior expectations
- **[references/skill-review.md](references/skill-review.md)** — #26: Capture reusable non-trivial approaches as skills
- **[references/combined-review.md](references/combined-review.md)** — #27: Merged prompt for simultaneous triggers
