# #26 Skill Review Prompt

## When

Only skill nudge fired (memory nudge did not).

## Prompt

Append as final user message to the full conversation history:

> Review the conversation above and consider whether any non-trivial approach was used to complete a task that required trial and error, or changing course due to experiential findings along the way, or where the user expected or desired a different method or outcome.
>
> If a relevant skill already exists, update it to reflect the new finding. Otherwise, create a new skill if the approach could be useful again.
>
> Only save if there's something genuinely worth remembering. If nothing stands out, just say 'Nothing to save.' and stop.
>
> Skills go in the skills/ directory as SKILL.md files with frontmatter (name, description) and clear instructions.

## What Gets Saved as Skills

- Non-trivial workflows discovered through trial and error
- Solutions to tricky errors or unexpected failures
- Approaches the user corrected or refined
- Reusable procedures (5+ tool calls to figure out)

## What Does NOT Get Saved

- One-off mechanical tasks
- Information that belongs in memory instead
- Temporary session state
