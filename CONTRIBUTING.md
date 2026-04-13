# Contributing to OpenClaw Agent — Hermes Workspace

## How This Port Was Made

The original [Hermes Agent](https://github.com/NousResearch/hermes-agent) is a ~40K LOC Python application. This port distills its **workspace configuration layer** into pure markdown files that any agent framework can use.

### The Extraction Process

1. **Identify the workspace boundary** — which files does the agent actually read each session? Which define behavior, identity, memory, and skills?
2. **Extract workspace files** — AGENTS.md, SOUL.md, BOOTSTRAP.md, IDENTITY.md, USER.md, TOOLS.md, COMPACTION.md, HEARTBEAT.md
3. **Extract skill definitions** — SKILL.md files and their reference sub-docs, preserving the frontmatter format and sub-docs routing pattern
4. **Remove runtime coupling** — strip all Python imports, tool implementations, platform adapters, and framework-specific references
5. **Generalize instructions** — rephrase where the original assumed Hermes-specific tooling (e.g., "the memory tool" instead of "hermes memory")
6. **Verify self-containment** — confirm the workspace works when loaded by any agent, not just the original Hermes runtime

## Porting Philosophy

### What We Keep

- **Behavioral design** — how the agent should think, decide, and act
- **Memory architecture** — the two-tier system (daily notes + long-term curation)
- **Skills system** — the CRUD protocol, frontmatter conventions, sub-docs routing
- **Safety principles** — data protection, external action boundaries, trash > rm
- **Personality system** — soul, identity, bootstrap ritual

### What We Drop

- **All Python code** — no runtime, no tool implementations, no CLI
- **Platform adapters** — Telegram, Discord, Slack are the host's job
- **Tool orchestration** — the host framework provides tools
- **Session management** — persistence is runtime behavior
- **Prompt construction** — system prompt assembly is the host's responsibility

### The Core Principle

**The workspace must be self-contained and framework-agnostic.**

A workspace file should never reference the source code of any agent framework. If the agent needs to know how to use a tool, that knowledge belongs in a skill — not in a code comment pointing to `tools/registry.py`.

## Porting Challenges

### 1. Untangling Runtime from Configuration

The original Hermes Agent has workspace instructions deeply interwoven with runtime behavior. For example, AGENTS.md references the memory tool, skill tools, and session search — all implemented in Python. The port had to keep the behavioral intent while removing the implementation assumptions.

**Solution:** Describe *what* the agent should do ("save durable facts to memory"), not *how* the runtime implements it ("call hermes_tools.memory()").

### 2. Model Protocol Without Runtime Detection

The model-protocol skill in Hermes Agent detects model identity at runtime via `self.model`. In a pure workspace, the agent reads its model name from the system prompt — which varies by framework.

**Solution:** The skill instructs the agent to read its model name from the system prompt text and match against string patterns. No code needed — just clear instructions an LLM can follow.

### 3. Background Review Without Subagent Infrastructure

Hermes Agent's background review forks a subagent process with tool access. In a pure workspace, there's no process forking.

**Solution:** The skill defines the prompts and routing logic. The host framework decides *how* to execute them (subagent, background task, manual trigger). The workspace says *what* to do; the host says *how*.

### 4. Context Compression Without an Auxiliary Model

Hermes Agent calls an auxiliary LLM for summarization. The workspace just needs to define the preamble and template.

**Solution:** COMPACTION.md contains the summarizer prompt and summary template. The host framework implements the actual compression pipeline.

### 5. Heartbeats Without a Scheduler

Hermes Agent has a built-in heartbeat poller. The workspace just needs HEARTBEAT.md as a task list.

**Solution:** HEARTBEAT.md is a simple checklist. The host's cron/scheduler reads it and decides when to trigger.

## How to Contribute

### Adding a New Skill

1. Create `skills/<skill-name>/SKILL.md` with YAML frontmatter:
   ```yaml
   ---
   name: <skill-name>
   description: One-line description.
   ---
   ```
2. Add clear trigger conditions, steps, pitfalls, and verification
3. Use sub-docs routing for complex skills (reference docs in `references/`)
4. Keep it self-contained — no references to any framework's source code

### Updating Existing Skills

- **Patch** (preferred): targeted edits to specific sections
- **Edit**: full rewrite only for major structural changes
- If you used a skill and found issues, update it immediately

### Adding Workspace Files

New workspace files should follow the existing conventions:
- Markdown with clear headings
- Self-contained instructions
- Framework-agnostic
- Reference the skills system for complex behavior

### Testing Your Changes

The best test: **load the workspace in a different agent framework** and see if it works. If the agent can read AGENTS.md, follow BOOTSTRAP.md, maintain memory, and use skills — the port is good.

## Directory Conventions

```
openclaw-agent-hermes/
├── *.md                          # Workspace root files (AGENTS, SOUL, etc.)
├── memory/                       # Runtime memory (gitignored in forks)
├── skills/
│   └── <skill-name>/
│       ├── SKILL.md              # Required
│       ├── meta.yaml             # Optional metadata
│       ├── references/           # Optional sub-docs
│       ├── templates/            # Optional file templates
│       └── scripts/              # Optional helper scripts
└── docs/                         # Project documentation
```

## What We're Looking For

- **Skills** — new behavioral patterns, tool integrations, workflow automations
- **Model adaptations** — guidance for model families beyond GPT/Gemini/Claude
- **Platform notes** — quirks discovered when running on different agent frameworks
- **Documentation** — clearer explanations, examples, use cases
- **Bug fixes** — instructions that don't work as written, broken references

## What We're NOT Looking For

- **Python code** — this is a pure workspace, no runtime
- **Framework-specific features** — keep it agnostic
- **Tool implementations** — those belong in the host framework

## License

MIT, matching the original Hermes Agent.
