# Changelog

Track which Hermes Agent version this workspace is ported from.

## Upstream Source

| Item | Value |
|---|---|
| **Upstream repo** | [NousResearch/hermes-agent](https://github.com/NousResearch/hermes-agent) |
| **Pinned commit** | `1cec910b6a064d4e4821930be5cfaaf6145a2afd` |
| **Pinned date** | 2026-04-11 |
| **Pinned message** | fix: improve context compaction to prevent model answering stale questions (#8107) |
| **Port started** | 2026-04-12 |

### Workspace files extracted from upstream

These files originate from the pinned commit:

- `AGENTS.md` — workspace instructions, memory rules, skills protocol, safety, group chat
- `SOUL.md` — agent personality and behavioral principles
- `BOOTSTRAP.md` — first-run identity discovery
- `IDENTITY.md` — name/creature/vibe/emoji template
- `USER.md` — human context template
- `TOOLS.md` — local environment notes template
- `COMPACTION.md` — context compression protocol (summarizer preamble + template)
- `HEARTBEAT.md` — periodic task checklist

### Skills extracted from upstream

- `skills/model-protocol/` — model family routing (OpenAI, Google, Claude, generic)
  - `SKILL.md` + `references/openai-execution.md` + `references/google-operational.md` + `references/tool-use-enforcement.md`
- `skills/background-review/` — post-session knowledge extraction
  - `SKILL.md` + `references/memory-review.md` + `references/skill-review.md` + `references/combined-review.md`
- `skills/skill-manage/` — CRUD protocol for workspace skills

## Port Changelog

Track changes to this port (not upstream).

### 2026-04-13

- add: README.md — project overview for human readers
- add: CONTRIBUTING.md — porting philosophy and contribution guide
- add: contributing/workspace-architecture.md — file relationship map and technical reference
- add: CHANGELOG.md — upstream version tracking
- add: .gitignore — exclude runtime memory

### 2026-04-12

- init: workspace-hermes — universal agent workspace ported from hermes prompts
- add: skill-manage skill for workspace skill CRUD
- add: COMPACTION.md — context compression protocol
- add: DREAM.md — post-session memory review protocol
- refactor: replace DREAM.md with background-review skill + sub-docs routing
- add: skills/model-adaptation — model-specific routing with forced self-identification
- rename: model-adaptation → model-protocol
- add: model family routing table to AGENTS.md header
- remove: skills/reverse-engineer-agent-output (meta-analysis doesn't belong in workspace)
- remove: skills/workspace-file-trim (auto-generated, not needed)
- clean: remove prompt numbers from COMPACTION.md
- trim: COMPACTION.md keeps only compaction instructions

## How to Sync with Upstream

When the official Hermes Agent repo updates workspace-relevant files:

```bash
# 1. Fetch upstream
cd ~/repo/apps/hermes-agent/
git fetch origin

# 2. See what changed since pinned commit
git diff 1cec910b..HEAD -- \
  AGENTS.md SOUL.md BOOTSTRAP.md IDENTITY.md USER.md TOOLS.md \
  COMPACTION.md HEARTBEAT.md \
  agent/prompt_builder.py \
  agent/skill_commands.py

# 3. Check skills directory for new/changed skills
git diff 1cec910b..HEAD --name-status -- skills/

# 4. Review and port relevant changes to this workspace

# 5. Update this CHANGELOG with new pinned commit if you re-sync
```
