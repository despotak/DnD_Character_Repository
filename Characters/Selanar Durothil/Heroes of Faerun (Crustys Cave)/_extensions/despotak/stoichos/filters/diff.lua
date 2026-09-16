--[[
  Stoichos — `diff` Pandoc filter.

  Walks fenced code blocks with class `diff` and emits per-line styled spans:
    - .nyx-diff-line              every line (default styling)
    - .nyx-diff-line--add         lines beginning with `+`
    - .nyx-diff-line--del         lines beginning with `-`
    - .nyx-diff-line--hunk        lines beginning with `@@` (hunk headers)

  Output structure:
    <pre class="nyx-diff" data-lang="<lang>">
      <span class="nyx-diff-line nyx-diff-line--del">- old line</span>
      <span class="nyx-diff-line nyx-diff-line--add">+ new line</span>
      <span class="nyx-diff-line">  unchanged</span>
    </pre>

  Usage:

    ```diff
    @@ -1,3 +1,3 @@
    - old
    + new
      same
    ```

  Or with a language hint for future per-line syntax highlighting:

    ```{.diff lang=ts}
    @@ -10,3 +10,3 @@
    - const x: number = 1;
    + const x: number = 2;
    ```

  Per-line hljs syntax highlighting (per the original render.ts) is deferred to v0.2 —
  Quarto's HTML output ships its own highlighter (skylighting / pandoc-highlightjs), and
  layering hljs on top inside <pre> children requires runtime JS that's brittle in
  iframe-style preview contexts. The .nyx-diff-line classes carry the semantic
  add/del/hunk distinction; the styling lives in stoichos.scss.

  Reference: archived language-attempt rendering at src/renderers/html/render.ts:731-755.
]]

-- ─── helpers ────────────────────────────────────────────────────────────────

local function escape_html(s)
  return (s:gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(">", "&gt;"))
end

local function escape_attr(s)
  return (s:gsub("&", "&amp;"):gsub('"', "&quot;"):gsub("<", "&lt;"))
end

local function classify_line(line)
  local first = line:sub(1, 1)
  local first_two = line:sub(1, 2)
  if first_two == "@@" then
    return "nyx-diff-line nyx-diff-line--hunk"
  elseif first == "+" then
    return "nyx-diff-line nyx-diff-line--add"
  elseif first == "-" then
    return "nyx-diff-line nyx-diff-line--del"
  end
  return "nyx-diff-line"
end

-- ─── filter ─────────────────────────────────────────────────────────────────

function CodeBlock(block)
  if not block.classes:includes("diff") then
    return nil
  end

  -- Optional language hint (`{.diff lang=ts}` or second class on the block).
  local lang = block.attributes["lang"]
  if not lang then
    for _, c in ipairs(block.classes) do
      if c ~= "diff" and c ~= "" then
        lang = c
        break
      end
    end
  end

  local lines = {}
  -- Append a trailing newline so the final line is captured by the gmatch.
  for line in (block.text .. "\n"):gmatch("([^\n]*)\n") do
    local cls = classify_line(line)
    table.insert(
      lines,
      '<span class="' .. cls .. '">' .. escape_html(line) .. '</span>'
    )
  end

  local lang_attr = ""
  if lang and lang ~= "" then
    -- Attribute-escape lang — even though it usually comes from a class
    -- (parser-derived), we go raw HTML and any interpolated channel needs
    -- to be escaped defensively.
    lang_attr = ' data-lang="' .. escape_attr(lang) .. '"'
  end

  return pandoc.RawBlock(
    "html",
    '<pre class="nyx-diff"' .. lang_attr .. '>' .. table.concat(lines) .. '</pre>'
  )
end
