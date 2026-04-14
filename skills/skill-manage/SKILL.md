---
name: skill-manage
description: CRUD operations on workspace skills. Create, patch, edit, delete, and manage skill files in the skills/ directory.
---

# Skill Management

Manage skills in `~/.openclaw/workspace-hermes/skills/`. Skills are your procedural memory — reusable approaches for recurring task types.

## Directory Structure

```
skills/
└── <skill-name>/
    ├── SKILL.md          # Required: frontmatter + instructions
    ├── meta.yaml          # Optional: metadata (version, tags, etc.)
    ├── references/        # Optional: supporting docs
    ├── templates/         # Optional: file templates
    └── scripts/           # Optional: helper scripts
```

## Actions

### Create a Skill

When: complex task succeeded (5+ tool calls), errors overcome, non-trivial workflow discovered, or user asks to remember a procedure.

```
skills/<skill-name>/SKILL.md
```

SKILL.md format:

```markdown
---
name: <skill-name>
description: One-line description of what this skill does.
---

# <Skill Title>

## When to use
Describe when to load this skill.

## Steps
1. First step
2. Second step
3. ...

## Pitfalls
- Known issues and how to avoid them

## Verification
- How to verify success
```

### Patch a Skill

When: instructions stale/wrong, missing steps, pitfalls found during use.

Find the broken section in SKILL.md and replace it. Use targeted edits, not full rewrites.

### Edit a Skill

When: major overhaul needed (structure change, complete rewrite).

Replace the entire SKILL.md content.

### Delete a Skill

When: skill is outdated, unused, or wrong beyond repair.

Remove the entire `skills/<skill-name>/` directory.

### Add Supporting Files

When: skill needs helper scripts, reference docs, or templates.

```
skills/<skill-name>/scripts/<script>.sh
skills/<skill-name>/references/<doc>.md
skills/<skill-name>/templates/<file>.template
```

## Rules

1. **Name**: lowercase, hyphens only (e.g. `my-skill`), max 64 chars
2. **Description**: required in frontmatter, one line, describes WHAT not HOW
3. **Patch > Edit**: prefer targeted fixes over full rewrites
4. **Maintain**: if you used a skill and found issues, patch it immediately — don't wait to be asked
5. **Remove supporting files** when deleting a skill
6. **Report changes** — after creating, patching, or deleting a skill, tell the user what changed and why
