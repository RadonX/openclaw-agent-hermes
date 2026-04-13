---
name: model-adaptation
description: Model-specific behavioral adaptations for agent frameworks. Routes to OpenAI or Google guidance based on model identity. Generic tool-use enforcement for all non-Claude models.
---

# Model Adaptation

Different model families have different failure modes. This skill provides targeted guidance based on model identity.

## Model Self-Identification (MANDATORY)

Before routing, you MUST verify your model identity. Do this exactly:

1. Read your model name from the system prompt (usually near the timestamp line)
2. Match it against the patterns below — case-insensitive substring match
3. Apply ONLY the matching section. Do NOT apply sections that don't match

**Model name patterns:**

| Pattern in model name | Route to |
|---|---|
| `gpt` or `codex` | [openai-execution.md](references/openai-execution.md) + [tool-use-enforcement.md](references/tool-use-enforcement.md) |
| `gemini` or `gemma` | [google-operational.md](references/google-operational.md) + [tool-use-enforcement.md](references/tool-use-enforcement.md) |
| `grok` | [tool-use-enforcement.md](references/tool-use-enforcement.md) only |
| `claude` | No model-specific guidance — skip all sections below |
| anything else | No model-specific guidance — skip all sections below |

**CRITICAL: Model matching rules.**

- Your model name is a FACT given to you in the system prompt. It is not a guess, not a preference, not a best-effort.
- If your model name contains "gpt", you are a GPT model. Apply OpenAI guidance. Do NOT skip it because you "feel" you don't need it.
- If your model name contains "gemini", you are a Gemini model. Apply Google guidance. Do NOT skip it.
- If your model name contains "claude", you are a Claude model. Do NOT apply any model-specific guidance. Do NOT apply OpenAI or Google guidance.
- If you cannot find your model name in the system prompt, you are uncertain. In that case: apply tool-use-enforcement.md as a safe default, and nothing else.
- Do NOT say "I am a GPT model but I don't think I need this" — the guidance exists because humans observed that your model family NEEDS it.
- Do NOT say "I'm actually closer to Claude in behavior" — you are what your model name says you are.

## Routing Flow

```
1. Read model name from system prompt
2. Does it contain "claude"?
   YES → stop. No model-specific guidance.
   NO → continue.
3. Does it contain "gpt" or "codex"?
   YES → load openai-execution.md + tool-use-enforcement.md
   NO → continue.
4. Does it contain "gemini" or "gemma"?
   YES → load google-operational.md + tool-use-enforcement.md
   NO → continue.
5. Load tool-use-enforcement.md as default.
```

## Sub-Docs

- **[references/tool-use-enforcement.md](references/tool-use-enforcement.md)** — Generic: "Never end your turn with a promise" (all non-Claude models)
- **[references/openai-execution.md](references/openai-execution.md)** — GPT/Codex: tool persistence, mandatory tool use, act-don't-ask, prerequisite checks, verification, anti-hallucination
- **[references/google-operational.md](references/google-operational.md)** — Gemini/Gemma: absolute paths, verify-first, dependency checks, conciseness, parallel tool calls, non-interactive commands
