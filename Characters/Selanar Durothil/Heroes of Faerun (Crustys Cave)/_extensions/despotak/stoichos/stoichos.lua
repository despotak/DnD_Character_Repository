--[[
  Stoichos — Quarto shortcodes for typography-first authoring.

  v0.1 shortcodes:
    - smallcaps    Wraps content in true OpenType small caps (smcp + c2sc) via .nyx-smallcaps.
                   Replaces Quarto's default fake-smallcaps (text-transform: lowercase, font-size: 0.8em).
    - stat         Typed inline value with format=percent|currency|number and color=danger|warning|info|success.
                   Tabular figures + lining nums + color tier via .nyx-stat (+ .nyx-stat--<color>).
    - chem         Chemical formula with auto-subscripted trailing digits (H2SO4 → H₂SO₄).
                   Renders inside .nyx-chem with .nyx-chem__sub on each subscript.
    - large-letter Inline oversized letter via .nyx-large-letter (float-left technique;
                   works in every browser). Use anywhere in prose; not a dropcap by itself.
                   For paragraph-level dropcaps with first-letter baseline alignment, use the
                   `::: dropcap` filter (filters/dropcap.lua) instead — it's a different
                   mechanism for a different purpose.

  Block-level directives (pullquote, epigraph) are intentionally NOT shortcodes — they ship
  as direct-class fenced divs (`::: {.nyx-pullquote}`, `::: {.nyx-epigraph}`) since fenced-div
  syntax handles block content cleanly without an extra mechanism.

  Class names use the `nyx-` prefix as the NyxType umbrella's signature; the package is stoichos.
]]

-- ─── helpers ────────────────────────────────────────────────────────────────

-- Quarto shortcode arg conventions (caught the hard way 2026-05-09 evening):
--
--   args     - PLAIN STRINGS in a 1-indexed table, one per positional argument.
--              args[1] is the first positional, etc. NOT pandoc Inline lists.
--   kwargs   - Pandoc List of Inlines per key. Critically: Quarto pre-fills
--              UNSPECIFIED kwargs with EMPTY Pandoc Lists (tables, not nil).
--              `kwargs[key] ~= nil` is therefore ALWAYS true — you must check
--              the list is non-empty.
--   meta     - the document's metadata table.
--
-- pandoc.utils.stringify on a plain string returns "" in some Quarto versions
-- (uses the Pandoc walk algorithm which expects an AST node). Test type first.

local function to_str(v)
  if v == nil then return nil end
  if type(v) == "string" then return v end
  return pandoc.utils.stringify(v)
end

local function arg_or_kwarg(args, kwargs, idx, key)
  -- Positional first — args are plain strings.
  local pos = args[idx]
  if pos ~= nil and pos ~= "" then
    return tostring(pos)
  end
  -- Kwarg second — must check the Pandoc List has content; empty list is the
  -- Quarto default for unspecified kwargs, not nil.
  local kw = kwargs[key]
  if kw == nil then return nil end
  if type(kw) == "string" then
    return kw ~= "" and kw or nil
  end
  if type(kw) == "table" and #kw > 0 then
    return pandoc.utils.stringify(kw)
  end
  return nil
end

local function format_number(s, format)
  local n = tonumber(s)
  if not n then return s end
  if format == "percent" then
    -- Treat 0–1 as fractions, >1 as already-percent values.
    if n >= 0 and n <= 1 then
      return string.format("%g%%", n * 100)
    end
    return string.format("%g%%", n)
  end
  if format == "currency" then
    return "$" .. string.format("%g", n)
  end
  return s
end

-- ─── smallcaps ──────────────────────────────────────────────────────────────

-- Helper: build a Pandoc Span with a class. Native Span elements survive the
-- pipeline cleanly. Note: pandoc.Span's content arg must be a list of Inlines,
-- NOT a plain string — passing a string makes the span render empty silently.
-- That cost an hour to find on 2026-05-09.
local function span_with_class(text, cls)
  return pandoc.Span({pandoc.Str(text)}, pandoc.Attr("", {cls}, {}))
end

local function smallcaps(args, kwargs, meta)
  local text = arg_or_kwarg(args, kwargs, 1, "text") or ""
  return span_with_class(text, "nyx-smallcaps")
end

-- ─── stat ───────────────────────────────────────────────────────────────────

local function stat(args, kwargs, meta)
  local value  = arg_or_kwarg(args, kwargs, 1, "value")  or ""
  local format = arg_or_kwarg(args, kwargs, 2, "format") or "number"
  local color  = arg_or_kwarg(args, kwargs, 3, "color")
  local display = format_number(value, format)
  local classes = {"nyx-stat"}
  if color and color ~= "" then
    table.insert(classes, "nyx-stat--" .. color)
  end
  return pandoc.Span({pandoc.Str(display)}, pandoc.Attr("", classes, {}))
end

-- ─── chem ───────────────────────────────────────────────────────────────────

local function chem(args, kwargs, meta)
  local text = arg_or_kwarg(args, kwargs, 1, "text") or ""
  -- Build inline list: alternate between text segments and <sub> elements.
  -- Pattern: ([A-Za-z%)])(%d+) — letter or close-paren followed by digits.
  local inlines = {}
  local pos = 1
  while pos <= #text do
    local s, e, prefix, digits = text:find("([A-Za-z%)])(%d+)", pos)
    if not s then
      table.insert(inlines, pandoc.Str(text:sub(pos)))
      break
    end
    -- Text up to and including the prefix character.
    if s > pos then
      table.insert(inlines, pandoc.Str(text:sub(pos, s - 1)))
    end
    table.insert(inlines, pandoc.Str(prefix))
    -- The digits go inside a <sub class="nyx-chem__sub">.
    -- Inlines list, not raw string — pandoc.Span's content arg is Inlines.
    -- The string-form works in current Quarto by tolerance but is contract-wrong.
    table.insert(
      inlines,
      pandoc.Subscript({pandoc.Span({pandoc.Str(digits)}, pandoc.Attr("", {"nyx-chem__sub"}, {}))})
    )
    pos = e + 1
  end
  return pandoc.Span(inlines, pandoc.Attr("", {"nyx-chem"}, {}))
end

-- ─── large-letter ──────────────────────────────────────────────────────────

local function large_letter(args, kwargs, meta)
  local text = arg_or_kwarg(args, kwargs, 1, "text") or ""
  return span_with_class(text, "nyx-large-letter")
end

-- ─── export ─────────────────────────────────────────────────────────────────

return {
  ['smallcaps']   = smallcaps,
  ['stat']        = stat,
  ['chem']        = chem,
  ['large-letter'] = large_letter,
}
