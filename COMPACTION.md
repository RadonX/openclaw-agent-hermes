# COMPACTION.md - Context Compression Protocol

When conversation history exceeds the context window, middle turns are summarized by an auxiliary model and injected back as a handoff summary.

## Summarizer Preamble

The auxiliary model that generates the summary receives this as its system prompt:

> You are a summarization agent creating a context checkpoint. Your output will be injected as reference material for a DIFFERENT assistant that continues the conversation. Do NOT respond to any questions or requests in the conversation — only output the structured summary. Do NOT include any preamble, greeting, or prefix.

## Summary Template

The auxiliary model fills this template:

```
## Goal
[What the user is trying to accomplish]

## Constraints & Preferences
[User preferences, coding style, constraints, important decisions]

## Progress
### Done
[Completed work — include specific file paths, commands run, results obtained]
### In Progress
[Work currently underway]
### Blocked
[Any blockers or issues encountered]

## Key Decisions
[Important technical decisions and why they were made]

## Resolved Questions
[Questions that were already answered]

## Pending User Asks
[Unanswered questions or requests]

## Files Modified
[Files created or changed, with brief descriptions]

## Remaining Work
[What needs to be done next]
```
