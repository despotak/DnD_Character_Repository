--[[
  Stoichos — `output` Pandoc filter.

  Walks fenced code blocks with class `output` and renders them with
  the .nyx-output styling (de-emphasized monospace, paper-tone background,
  subtle indent rule on the left margin).

  Distinct from `code` (source code, syntax-highlighted) and `shell`
  (interactive terminal session). `output` is *result text* — JSON
  responses, log lines, command stdout captured for citation.

  Usage:

    ```output
    {
      "user": "alice",
      "permissions": ["read", "write"]
    }
    ```

  Quarto's default code-block treatment renders this with the same chrome
  as source code. Stoichos's `.nyx-output` styling de-emphasizes the
  visual weight so output blocks read as *citations* rather than
  *content*.
]]

local function escape_html(s)
  return (s:gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(">", "&gt;"))
end

local function trim_empty_lines(s)
  return (s:gsub("^[ \t]*\n+", ""):gsub("\n+[ \t]*$", ""))
end

function CodeBlock(block)
  if not block.classes:includes("output") then
    return nil
  end
  local text = trim_empty_lines(block.text)
  return pandoc.RawBlock(
    "html",
    '<pre class="nyx-output">' .. escape_html(text) .. '</pre>'
  )
end
