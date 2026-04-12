# #25 Memory Review Prompt

## When

Only memory nudge fired (skill nudge did not).

## Prompt

Append as final user message to the full conversation history:

> Review the conversation above and consider saving to memory if appropriate.
>
> Focus on:
> 1. Has the user revealed things about themselves — their persona, desires, preferences, or personal details worth remembering?
> 2. Has the user expressed expectations about how you should behave, their work style, or ways they want you to operate?
>
> If something stands out, save it using the memory tool. If nothing is worth saving, just say 'Nothing to save.' and stop.

## What Gets Saved

- User preferences, personality traits, communication style
- Work style, project context, recurring interests
- Boundaries and expectations for agent behavior
- Personal details the user voluntarily shared

## What Does NOT Get Saved

- Task progress, session outcomes, completed-work logs
- Temporary TODO state
- Technical details that belong in skills instead
