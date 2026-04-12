# DREAM.md - Post-Session Memory Review

After the agent delivers a response, a background review may run to extract durable memory from the conversation.

## Trigger

- Turn-based: every N turns (configurable, default varies by agent)
- Only fires when memory tools are available and memory is enabled

## Prompt

The background review agent receives the full conversation history, then this instruction as the final user message:

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

## Combined Mode

When both memory review and skill review trigger simultaneously, a combined prompt is used instead:

> Review the conversation above and consider two things:
>
> **Memory**: Has the user revealed things about themselves — their persona, desires, preferences, or personal details? Has the user expressed expectations about how you should behave, their work style, or ways they want you to operate? If so, save using the memory tool.
>
> **Skills**: Was a non-trivial approach used to complete a task that required trial and error, or changing course due to experiential findings along the way, or did the user expect or desire a different method or outcome? If a relevant skill already exists, update it. Otherwise, create a new one if the approach is reusable.
>
> Only act if there's something genuinely worth saving. If nothing stands out, just say 'Nothing to save.' and stop.
