# OpenClaw Agent — Hermes Workspace

A workspace configuration framework that gives AI agents personality, memory, and behavioral rules — ported from [Nous Research's Hermes Agent](https://github.com/NousResearch/hermes-agent).

## What This Is

This is **not** a chatbot. It's not an LLM wrapper. It's not even code.

It's a **workspace** — a collection of markdown files that, when loaded by any capable AI agent, give it:

- An identity (name, creature, vibe)
- Persistent memory across sessions
- Behavioral rules and safety boundaries
- A skills system for accumulating procedural knowledge
- Model-specific adaptations (GPT, Gemini, Claude, etc.)
- A soul

Think of it as the difference between a blank sheet of paper and a character sheet in a TTRPG. The agent fills in the rest.

## Why Port?

The original [Hermes Agent](https://github.com/NousResearch/hermes-agent) is a full Python application — CLI, gateway, tool orchestration, session management, the works. It's powerful, but tightly coupled to its own runtime.

This port asks a different question: **what if the workspace could work with any agent framework?**

The answer is a self-contained workspace directory that any agent can pick up — Hermes, OpenClaw, a custom framework, or even a raw API call with the right system prompt. No Python code. No dependencies. Just markdown files that any LLM can read and follow.

## Features

### Identity System
First-run bootstrap (`BOOTSTRAP.md`) walks the agent through discovering who it is. Once done, `IDENTITY.md` holds name, creature, vibe, emoji. The agent isn't a faceless service — it's someone.

### Persistent Memory
Two-tier memory system:
- **Daily notes** (`memory/YYYY-MM-DD.md`) — raw session logs
- **Long-term memory** (`MEMORY.md`) — curated, distilled knowledge

The agent wakes up fresh each session. These files are its continuity.

### Soul & Boundaries
`SOUL.md` defines behavioral principles: be genuinely helpful (not performatively), have opinions, be resourceful before asking, earn trust through competence. `AGENTS.md` adds safety rules: don't exfiltrate data, `trash` > `rm`, ask before external actions.

### Skills System
Procedural knowledge that compounds across sessions. When the agent solves something non-trivial (5+ tool calls, trial and error, unexpected failures), it saves the approach as a skill. Skills are self-contained directories with `SKILL.md` + optional references/templates/scripts.

### Model Protocol Adaptation
Different model families have different failure modes. The `model-protocol` skill routes to targeted behavioral guidance based on model identity:
- **GPT/Codex** → execution discipline, mandatory tool use, anti-hallucination
- **Gemini/Gemma** → absolute paths, verify-first, dependency checks
- **Claude** → no special guidance needed
- **Others** → generic tool-use enforcement as safe default

### Background Review
Post-session background agent that reviews conversations and extracts durable knowledge — either as memory saves or skill saves. Routes between memory-review, skill-review, or combined-review based on configurable turn-count triggers.

### Group Chat Awareness
Built-in rules for group chat behavior: know when to speak, know when to stay silent. The agent participates — it doesn't dominate.

### Context Compression
`COMPACTION.md` defines the summarizer preamble and template for context window overflow. Middle turns get summarized by an auxiliary model, injected back as a structured handoff.

## Workspace Structure

```
openclaw-agent-hermes/
├── AGENTS.md              # Main workspace config — the instruction manual
├── SOUL.md                # Who the agent is — personality and values
├── IDENTITY.md            # Name, creature, vibe, emoji
├── USER.md                # About the human
├── TOOLS.md               # Local environment notes
├── BOOTSTRAP.md           # First-run setup script (deleted after use)
├── COMPACTION.md          # Context compression protocol
├── HEARTBEAT.md           # Periodic check tasks
├── memory/                # Session memory (created at runtime)
├── skills/
│   ├── model-protocol/    # Model family routing
│   │   ├── SKILL.md
│   │   └── references/
│   ├── background-review/ # Post-session knowledge extraction
│   │   ├── SKILL.md
│   │   └── references/
│   └── skill-manage/      # CRUD for skills
│       └── SKILL.md
└── README.md              # This file
```

## How to Use

### With OpenClaw

This workspace is designed for OpenClaw's workspace architecture. Drop it into your OpenClaw workspace directory and the agent picks it up automatically.

### With Hermes Agent

Copy the workspace files into `~/.hermes/workspace/`. Hermes Agent loads `AGENTS.md`, `SOUL.md`, `USER.md`, and memory files on every session.

### With Any Agent Framework

Any framework that reads workspace files can use this. The core loop:

1. Load `AGENTS.md` as system context
2. On first run, follow `BOOTSTRAP.md`
3. Every session: read `SOUL.md`, `USER.md`, today's memory file
4. Follow the behavioral rules, use skills, maintain memory

### With Raw API Calls

Inject the contents of `AGENTS.md` + `SOUL.md` into your system prompt. Point the agent at the `skills/` directory for tool definitions. It works.

## What's Preserved from Hermes Agent

- **Workspace file structure** — AGENTS.md, SOUL.md, BOOTSTRAP.md, IDENTITY.md, USER.md, TOOLS.md, COMPACTION.md, HEARTBEAT.md
- **Skills system** — SKILL.md format, CRUD protocol, frontmatter conventions
- **Memory architecture** — daily notes + long-term curation pattern
- **Model protocol** — GPT/Codex execution discipline, Google operational directives, tool-use enforcement
- **Background review** — memory/skill/combined routing, trigger logic, sub-doc prompts
- **Group chat rules** — when to speak, when to stay silent
- **Safety principles** — data protection, trash > rm, external action boundaries

## What's Different from Hermes Agent

- **No Python code** — this is pure workspace configuration
- **Framework-agnostic** — works with any agent, not just Hermes
- **Simplified** — the workspace layer only, no CLI, gateway, or tool orchestration
- **Self-contained** — no dependency on any agent's source code
- **OpenClaw-native** — designed for OpenClaw's workspace directory conventions

## Feature Gaps

Compared to the full Hermes Agent:

- **No tool implementations** — tools must be provided by the host framework
- **No platform adapters** — Telegram, Discord, Slack etc. are handled by the host
- **No session management** — persistence is the host's responsibility
- **No cron/scheduler** — background tasks need the host's scheduling system
- **No CLI** — this is configuration, not an application
- **No prompt caching** — Anthropic-style caching is runtime behavior
- **No context compression execution** — COMPACTION.md defines the protocol, the host implements it

## Credits

This workspace is a port of [Nous Research's Hermes Agent](https://github.com/NousResearch/hermes-agent). All behavioral design, workspace architecture, and agent philosophy credit goes to the Hermes Agent team.

Hermes Agent proved that a workspace can be more than a config directory — it can be a personality, a memory system, and a set of behavioral principles that make an AI agent genuinely useful. This port carries that philosophy forward into the OpenClaw ecosystem.

## License

The original Hermes Agent is MIT licensed. This port maintains the same spirit of openness.

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for how this port was made, the porting philosophy, and how to contribute. See [contributing/](contributing/) for additional technical docs.
