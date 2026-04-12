---
name: workspace-file-trim
description: After creating workspace files, review them for scope creep — files that mix protocol instructions with framework mechanics. Trim to pure protocol.
---

# Workspace File Trim

## When to use

After drafting a workspace file (AGENTS.md, COMPACTION.md, etc.), review whether it stays within its intended scope or has absorbed adjacent concerns.

## Pattern

Workspace files should contain **protocol** (what/how), not **mechanics** (when/where injected).

Example: COMPACTION.md initially contained:
- Summarizer Preamble — ✅ protocol (how to instruct the summarizer)
- Summary Template — ✅ protocol (what structure to fill)
- Summary Prefix — ❌ mechanics (agent framework injects this)
- First Compression Note — ❌ mechanics (agent framework appends this)

The mechanics belong to the agent framework's source code, not the workspace.

## Steps

1. Read the workspace file
2. For each section, ask: "Is this telling the agent WHAT/HOW to do, or is it describing WHEN/WHERE the framework injects something?"
3. Remove framework-mechanic sections
4. Keep only protocol-level instructions

## Verification

- A different agent framework loading this workspace should be able to follow every section without knowing the original framework's code
- If a section references injection timing, message roles, or system prompt mechanics — it's framework detail, remove it
