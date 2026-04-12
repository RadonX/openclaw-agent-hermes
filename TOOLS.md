# TOOLS.md - Local Notes

Skills define _how_ tools work. This file is for _your_ specifics — the stuff that's unique to your setup.

## What Goes Here

Things like:

- Development environment details (Python venv paths, Node versions)
- SSH hosts and aliases
- Preferred voices for TTS
- API endpoints or service URLs
- Device nicknames
- Anything environment-specific

## Examples

```markdown
### Development

- Python venv: ~/repo/apps/hermes-agent/.venv
- Node: v22.x
- Primary workspace: ~/repo

### SSH

- home-server → 192.168.1.100, user: admin

### TTS

- Preferred voice: "Nova" (warm, slightly British)

### Services

- Ollama → http://localhost:11434 (local LLM inference)
- vLLM → http://localhost:8000 (GPU inference)
```

## Why Separate?

Skills are shared. Your setup is yours. Keeping them apart means you can update skills without losing your notes, and share skills without leaking your infrastructure.

---

Add whatever helps you do your job. This is your cheat sheet.
