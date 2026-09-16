--[[
  Stoichos — `shell` Pandoc filter.

  Walks fenced code blocks with class `shell` (or `bash` aliases for
  terminal sessions) and emits per-line spans classified as command vs
  output:
    - .nyx-shell-line              every line (default styling)
    - .nyx-shell-line--cmd         lines beginning with `$ ` or `# `
                                   (user prompt detection)
    - .nyx-shell-line--out         all other lines (program output)

  Output structure:
    <pre class="nyx-shell" data-lang="bash">
      <span class="nyx-shell-line nyx-shell-line--cmd">$ git status</span>
      <span class="nyx-shell-line nyx-shell-line--out">On branch main</span>
      ...
    </pre>

  Usage:

    ```shell
    $ git log --oneline -3
    abc1234 First commit
    def5678 Second commit
    ```

  Distinct from Quarto's built-in code-block syntax highlighting: stoichos's
  `.nyx-shell` uses a Catppuccin Mocha palette (dark) with explicit
  prompt-vs-output color separation, which Quarto's default highlight-style
  doesn't provide. The reason: a shell transcript is a *conversation*
  between the user and the system, not source code, and deserves typographic
  treatment that surfaces that distinction.

  Matches `shell`, `bash`, `zsh`, `console`, `terminal` class names —
  common conventions across Markdown ecosystems.

  Reference: archived language-attempt logic at src/renderers/html/render.ts:757-774.
]]

-- ─── helpers ────────────────────────────────────────────────────────────────

local function escape_html(s)
  return (s:gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(">", "&gt;"))
end

local SHELL_CLASSES = {
  shell = true,
  bash = true,
  zsh = true,
  sh = true,
  console = true,
  terminal = true,
}

local function is_shell_block(block)
  for _, c in ipairs(block.classes) do
    if SHELL_CLASSES[c] then return true end
  end
  return false
end

local function classify_line(line)
  local trimmed = line:gsub("^%s+", "")
  if trimmed == "" then return "nyx-shell-line" end
  -- Prompt detection: leading $ or # followed by a space.
  if trimmed:sub(1, 2) == "$ " or trimmed:sub(1, 2) == "# " then
    return "nyx-shell-line nyx-shell-line--cmd"
  end
  return "nyx-shell-line nyx-shell-line--out"
end

-- ─── filter ─────────────────────────────────────────────────────────────────

function CodeBlock(block)
  if not is_shell_block(block) then
    return nil
  end

  -- Optional language hint via attributes (`{.shell lang=bash}`).
  local lang = block.attributes["lang"]
  if not lang then
    -- Pick the first non-shell class as the language hint.
    for _, c in ipairs(block.classes) do
      if not SHELL_CLASSES[c] and c ~= "" then
        lang = c
        break
      end
    end
  end

  local lines = {}
  for line in (block.text .. "\n"):gmatch("([^\n]*)\n") do
    local cls = classify_line(line)
    table.insert(
      lines,
      '<span class="' .. cls .. '">' .. escape_html(line) .. '</span>'
    )
  end

  local lang_attr = ""
  if lang and lang ~= "" then
    lang_attr = ' data-lang="' .. lang .. '"'
  end

  return pandoc.RawBlock(
    "html",
    '<pre class="nyx-shell"' .. lang_attr .. '>' .. table.concat(lines) .. '</pre>'
  )
end
