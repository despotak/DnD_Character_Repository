# DnD_Character_Repository — session defaults

This folder's `.claude/settings.json` sets `model: sonnet` and `ultracode: true` — every session here starts on Sonnet with ultracode (xhigh effort + standing Workflow orchestration) already on, no keyword needed.

## Opus escalation

There is no harness mechanism for the assistant to swap its own main-thread model mid-session — `model` is fixed at session start. "Upgrade to Opus when needed" is implemented as delegation, not a self-switch:

- When a task within a session turns out to need Opus-tier reasoning (deep rules adjudication across conflicting sources, large multi-character build optimization, architectural planning for a big homebrew system, adversarial verification of a ruling), delegate that piece of work to an Opus-backed subagent — `Agent({..., model: "opus"})`, or in a Workflow script `agent(prompt, {model: "opus"})` — rather than trying to reason it out on Sonnet. Do this automatically; don't ask permission to spin up a subagent.
- If the *entire* remaining session clearly warrants Opus throughout (not just one delegated step), say so directly and tell the user to run `/model opus` — don't just silently underperform on Sonnet.
- Routine character-sheet edits, formatting, lookups, and small file changes stay on Sonnet with ultracode's standing orchestration — don't reach for Opus by default.
