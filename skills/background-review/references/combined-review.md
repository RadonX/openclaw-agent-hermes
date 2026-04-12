# #27 Combined Review Prompt

## When

Both memory nudge AND skill nudge fired simultaneously. This replaces running #25 and #26 as separate agents — single fork, single pass.

## Prompt

Append as final user message to the full conversation history:

> Review the conversation above and consider two things:
>
> **Memory**: Has the user revealed things about themselves — their persona, desires, preferences, or personal details? Has the user expressed expectations about how you should behave, their work style, or ways they want you to operate? If so, save using the memory tool.
>
> **Skills**: Was a non-trivial approach used to complete a task that required trial and error, or changing course due to experiential findings along the way, or did the user expect or desire a different method or outcome? If a relevant skill already exists, update it. Otherwise, create a new one if the approach is reusable.
>
> Only act if there's something genuinely worth saving. If nothing stands out, just say 'Nothing to save.' and stop.

## Behavior

- Single agent handles both memory and skill review in one pass
- Memory saves go to the memory tool (user profile + personal notes)
- Skill saves go to skills/ as SKILL.md files
- Avoids duplicate work from running #25 and #26 separately

## See Also

- [memory-review.md](memory-review.md) for memory-only criteria
- [skill-review.md](skill-review.md) for skill-only criteria
