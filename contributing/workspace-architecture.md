# Workspace Architecture

How the workspace files connect and depend on each other.

## File Relationship Map

```
AGENTS.md (entry point)
├── loads → SOUL.md (personality)
├── loads → USER.md (human context)
├── loads → memory/YYYY-MM-DD.md (recent context)
├── loads → MEMORY.md (long-term memory, main session only)
├── loads → TOOLS.md (environment notes)
├── loads → skills/model-protocol/SKILL.md (model adaptation)
├── on first run → BOOTSTRAP.md (identity bootstrap)
│   ├── creates → IDENTITY.md
│   ├── creates → USER.md
│   └── deletes → BOOTSTRAP.md (itself)
└── on context overflow → COMPACTION.md (summarization protocol)
```

## File Roles

### Entry Points
- **AGENTS.md** — The main instruction file. Loaded every session. Defines memory rules, skills protocol, safety boundaries, group chat behavior, tool use policy, and platform formatting.

### Identity
- **SOUL.md** — Core behavioral principles. Who the agent is and how it should act.
- **IDENTITY.md** — Name, creature, vibe, emoji. Filled during bootstrap.
- **BOOTSTRAP.md** — First-run script. Walks through identity discovery. Deleted after use.

### Memory
- **USER.md** — What the agent knows about its human. Updated over time.
- **TOOLS.md** — Environment-specific notes (dev setup, SSH, services). The agent's cheat sheet.
- **MEMORY.md** — Curated long-term memory. Main session only (security).
- **memory/YYYY-MM-DD.md** — Raw daily session logs. Created as needed.

### Skills
- **skills/\*/SKILL.md** — Procedural knowledge. Each skill is self-contained with frontmatter, instructions, and optional sub-docs in `references/`.

### Protocols
- **COMPACTION.md** — Defines summarizer preamble and template for context overflow.
- **HEARTBEAT.md** — Periodic check tasks. Empty by default.

## Session Lifecycle

```
1. Agent starts → reads AGENTS.md
2. Reads SOUL.md, USER.md, today's memory
3. If main session → also reads MEMORY.md
4. Scans available skills, loads matching ones
5. If BOOTSTRAP.md exists → runs first-time setup
6. Processes user messages
7. On context overflow → COMPACTION.md protocol kicks in
8. Post-session → background review may extract knowledge
9. Updates memory files as needed
```

## Skill System

Skills follow a standard structure:

```
skills/<name>/
├── SKILL.md           # Required: frontmatter + instructions
├── meta.yaml          # Optional: version, tags, author
├── references/        # Optional: sub-docs for complex skills
├── templates/         # Optional: file templates
└── scripts/           # Optional: helper scripts
```

### Sub-Docs Routing Pattern

Complex skills use references/ for modular prompts:

```
skills/background-review/
├── SKILL.md                    # Main skill — routing logic
└── references/
    ├── memory-review.md        # #25: memory-only prompt
    ├── skill-review.md         # #26: skill-only prompt
    └── combined-review.md      # #27: merged prompt
```

The main SKILL.md defines when to route to which sub-doc. Sub-docs contain the actual prompts/instructions for that specific case.

### Model Protocol Routing

```
skills/model-protocol/
├── SKILL.md                           # Routing logic + model detection
└── references/
    ├── tool-use-enforcement.md        # Generic: all non-Claude models
    ├── openai-execution.md            # GPT/Codex: execution discipline
    └── google-operational.md          # Gemini/Gemma: operational directives
```

## Customization Points

### What to customize first
1. **SOUL.md** — adjust personality for your use case
2. **USER.md** — fill in your human's details
3. **TOOLS.md** — add your environment notes
4. **HEARTBEAT.md** — add periodic tasks

### What to add
- New skills in `skills/`
- Additional workspace files referenced by AGENTS.md
- Custom memory review prompts

### What to keep intact
- AGENTS.md core structure (safety rules, memory protocol)
- Skills directory conventions (frontmatter format)
- COMPACTION.md summarizer preamble (it works)

## Design Principles

1. **Markdown only** — no code, no runtime dependencies
2. **Self-contained** — no references to any framework's source
3. **Framework-agnostic** — works with any agent that reads workspace files
4. **Discoverable** — AGENTS.md tells the agent where to look
5. **Composable** — skills are independent, can be added/removed freely
6. **Evolvable** — the agent updates its own files as it learns
