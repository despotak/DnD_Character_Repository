# DnD_Character_Repository — session defaults

This folder's `.claude/settings.json` sets `model: sonnet` and `ultracode: true` — every session here starts on Sonnet with ultracode (xhigh effort + standing Workflow orchestration) already on, no keyword needed.

## Opus escalation

There is no harness mechanism for the assistant to swap its own main-thread model mid-session — `model` is fixed at session start. "Upgrade to Opus when needed" is implemented as delegation, not a self-switch:

- When a task within a session turns out to need Opus-tier reasoning (deep rules adjudication across conflicting sources, large multi-character build optimization, architectural planning for a big homebrew system, adversarial verification of a ruling), delegate that piece of work to an Opus-backed subagent — `Agent({..., model: "opus"})`, or in a Workflow script `agent(prompt, {model: "opus"})` — rather than trying to reason it out on Sonnet. Do this automatically; don't ask permission to spin up a subagent.
- If the *entire* remaining session clearly warrants Opus throughout (not just one delegated step), say so directly and tell the user to run `/model opus` — don't just silently underperform on Sonnet.
- Routine character-sheet edits, formatting, lookups, and small file changes stay on Sonnet with ultracode's standing orchestration — don't reach for Opus by default.

## Selanar's journal

`Characters/Selanar Durothil/Heroes of Faerun (Crustys Cave)/journal.md` is typeset to `journal.html` with the stoichos Quarto extension. After adding or editing an entry, rebuild with `bash "_typeset/render.sh"` from that folder — it builds in a temp dir, because Quarto's SQLite cache cannot lock on this CIFS share. Keep writing plain Markdown: `_typeset/journal.lua` infers the typography from the conventions the entries already follow (its header lists them: a line wholly in italics is set apart, a wholly italic parenthetical becomes a margin note, a wholly bold line a display line). The epigraph and colophon live in that folder's `_quarto.yml`.

House style for new entries — three voices, three marks:
- **Said aloud → double quotation marks**, including a verbatim word or phrase woven into a sentence (`called him "my lord"`); a spoken foreign phrase keeps its italics inside the quotes.
- **Written, carved or read → backquotes**, which the filter sets in spaced small capitals, never as code: a word or phrase inline (`` the word `Ordulin` on a bill of lading ``), or a full inscription on its own lines in a bare ```` ``` ```` fenced block, one carved line per source line.
- **Italics** are for thoughts never spoken, words mentioned as words, Elvish terms, spell names, and emphasis. A complete utterance starts with a capital and keeps its punctuation inside the closing quote; a woven fragment stays lowercase with punctuation outside.
