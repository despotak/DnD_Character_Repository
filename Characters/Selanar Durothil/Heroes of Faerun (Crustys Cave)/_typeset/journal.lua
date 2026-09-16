-- Typesets journal.md from the conventions its entries already follow, so the
-- Markdown itself never needs Quarto markup:
--   # Title — Subtitle                  → document title block
--   ## Entry N — Name                   → entry heading; its dateline's place and date feed the contents
--   *dateline*  then  ---               → dateline, ornament, raised-cap opening
--   ---  inside an entry                → ornament; the next paragraph opens with a small-caps lead-in
--   "speech"  *thought*  `writing`      → quotation marks, italics, spaced small capitals
--   ``` fenced lines ```                → an inscription standing on its own, one line each
--   *a paragraph that is only italic*   → a thought, set apart
--   *(a parenthetical, only italic)*    → marginal note beside the paragraph before it
--   **a paragraph that is only bold**   → display line
--   > quote                             → a voice heard, one paragraph per source line
--   *Signed …*  **Name**  lines  *(…)*  → valediction, signatory, titles/notes, postscript
-- The epigraph and colophon come from _quarto.yml metadata.

local stringify = pandoc.utils.stringify

local NARROW_NBSP = "\u{202F}"
local THIN_SPACE = "\u{2009}"

local function is_blank(inline)
  return inline.t == "Space" or inline.t == "SoftBreak" or inline.t == "LineBreak"
end

local function sub(list, from, to, make)
  local out = {}
  for i = from, to or #list do table.insert(out, list[i]) end
  return make(out)
end

local function trim(inlines)
  while #inlines > 0 and is_blank(inlines[1]) do inlines:remove(1) end
  while #inlines > 0 and is_blank(inlines[#inlines]) do inlines:remove(#inlines) end
  return inlines
end

-- Spaced em dashes: a narrow no-break space before (a line never opens on a dash)
-- and a thin space after, instead of two full word spaces.
local function tighten_dashes(inlines)
  for i = 1, #inlines do
    local here = inlines[i]
    if here.t == "Str" and here.text:match("^—") then
      if i > 1 and inlines[i - 1].t == "Space" then inlines[i - 1] = pandoc.Str(NARROW_NBSP) end
      if here.text == "—" and i < #inlines and inlines[i + 1].t == "Space" then
        inlines[i + 1] = pandoc.Str(THIN_SPACE)
      end
    end
  end
  return inlines
end

local function split_at_dash(inlines)
  for i, inline in ipairs(inlines) do
    if inline.t == "Str" and inline.text == "—" then
      return trim(sub(inlines, 1, i - 1, pandoc.Inlines)), trim(sub(inlines, i + 1, nil, pandoc.Inlines))
    end
  end
end

local function sole_inline(block, tag)
  if block.t ~= "Para" and block.t ~= "Plain" then return nil end
  local found
  for _, inline in ipairs(block.content) do
    if not is_blank(inline) then
      if found then return nil end
      found = inline
    end
  end
  if found and found.t == tag then return found end
end

local function div(blocks, classes)
  return pandoc.Div(blocks, pandoc.Attr("", classes))
end

local function span(inlines, class)
  return pandoc.Span(inlines, pandoc.Attr("", {class}))
end

-- "Entry IV" → label "Entry " + numeral "IV", so the contents can show numerals alone.
local function entry_number(inlines)
  local last = #inlines
  if last < 3 or inlines[last].t ~= "Str" or inlines[last - 1].t ~= "Space" then
    return span(inlines, "entry-number")
  end
  return span(pandoc.Inlines{
    span(sub(inlines, 1, last - 1, pandoc.Inlines), "entry-label"),
    span(pandoc.Inlines{inlines[last]}, "entry-numeral"),
  }, "entry-number")
end

-- The dateline up to its year: "Moontassel, in Sembia. The 9th of Eleasis, 1501 DR".
local function place_and_date(dateline)
  local when = pandoc.Inlines{}
  for _, inline in ipairs(dateline.content) do
    if inline.t == "Str" and inline.text:match("^DR") then
      when:insert(pandoc.Str("DR"))
      return when
    end
    when:insert(inline)
  end
end

local function entry_heading(header, dateline)
  local number, name = split_at_dash(header.content)
  if not number or #name == 0 then return header end
  header.content = pandoc.Inlines{
    entry_number(number),
    span(pandoc.Inlines{pandoc.Str(" — ")}, "entry-sep"),
    span(name, "entry-name"),
  }
  local when = dateline and place_and_date(dateline)
  if when then header.content:extend{pandoc.Space(), span(when, "entry-when")} end
  return header
end

-- After the name come title lines (upright) and notes (wholly italic); the first
-- paragraph opening with "(" starts the postscript.
local function signature(blocks)
  local out = pandoc.Blocks{}
  local i = 1
  out:insert(div({blocks[i]}, {"journal-valediction"}))
  i = i + 1
  if blocks[i] and sole_inline(blocks[i], "Strong") then
    out:insert(div({blocks[i]}, {"journal-signatory"}))
    i = i + 1
  end
  local run, run_kind = pandoc.Blocks{}, nil
  local function flush()
    if #run > 0 then out:insert(div(run, {"journal-" .. run_kind})) end
    run, run_kind = pandoc.Blocks{}, nil
  end
  while i <= #blocks do
    local block = blocks[i]
    local kind
    if run_kind == "postscript" or stringify(block):match("^%(") then
      kind = "postscript"
    elseif sole_inline(block, "Emph") then
      kind = "notes"
    else
      kind = "titles"
    end
    if kind ~= run_kind then flush() end
    run_kind = kind
    run:insert(block)
    i = i + 1
  end
  flush()
  return div(out, {"journal-signature"})
end

-- Backquotes mark writing, not code, so their text is read as prose again:
-- curly quotes, dashes and emphasis all still apply inside.
local function written_inlines(text)
  local parsed = pandoc.read(text, "markdown")
  return tighten_dashes(pandoc.utils.blocks_to_inlines(parsed.blocks))
end

local function written(code)
  return span(written_inlines(code.text), "journal-written")
end

local function inscription(lines)
  local paras = pandoc.Blocks{}
  for _, line in ipairs(lines) do
    if line:match("%S") then paras:insert(pandoc.Para(written_inlines(line))) end
  end
  return div(paras, {"journal-inscription"})
end

local function voice(quote)
  local lines = pandoc.Blocks{}
  for _, block in ipairs(quote.content) do
    if block.t == "Para" then
      local line = pandoc.Inlines{}
      for _, inline in ipairs(block.content) do
        if inline.t == "SoftBreak" then
          lines:insert(pandoc.Para(trim(line)))
          line = pandoc.Inlines{}
        else
          line:insert(inline)
        end
      end
      lines:insert(pandoc.Para(trim(line)))
    else
      lines:insert(block)
    end
  end
  quote.content = lines
  return quote
end

local LEAD_IN_WORDS = 3

-- The first words of a section, wrapped so they can be set in small capitals.
local function lead_in(para)
  local words, in_word = 0, false
  for i, inline in ipairs(para.content) do
    if is_blank(inline) then
      in_word = false
      if words == LEAD_IN_WORDS then
        local content = pandoc.Inlines{span(sub(para.content, 1, i - 1, pandoc.Inlines), "journal-leadin")}
        content:extend(sub(para.content, i, nil, pandoc.Inlines))
        para.content = content
        return para
      end
    elseif not in_word then
      in_word = true
      if not (inline.t == "Str" and inline.text:match("^%p+$")) then words = words + 1 end
    end
  end
  para.content = pandoc.Inlines{span(para.content, "journal-leadin")}
  return para
end

-- A float starts where it is placed, so the note goes in before the paragraph it glosses.
local function insert_marginal(out, note)
  local at = #out
  if at > 0 and out[at].t == "Para" then
    out:insert(at, note)
  else
    out:insert(note)
  end
end

local function entry_body(blocks)
  while #blocks > 0 and blocks[#blocks].t == "HorizontalRule" do
    blocks:remove(#blocks)
  end

  local out = pandoc.Blocks{}
  local dateline
  local i = 1
  local dated = blocks[i] and sole_inline(blocks[i], "Emph")
  if dated then
    dateline = dated
    out:insert(div({blocks[i]}, {"journal-dateline"}))
    i = i + 1
    if blocks[i] and blocks[i].t == "HorizontalRule" then
      out:insert(blocks[i])
      i = i + 1
    end
  end
  if blocks[i] and blocks[i].t == "Para" then
    out:insert(div({blocks[i]}, {"journal-opening"}))
    i = i + 1
  end

  while i <= #blocks do
    local block = blocks[i]
    local italic = sole_inline(block, "Emph")
    local text = italic and stringify(block)
    if italic and text:match("^Signed") then
      local last = i
      while blocks[last + 1] and blocks[last + 1].t == "Para" do last = last + 1 end
      out:insert(signature(sub(blocks, i, last, pandoc.Blocks)))
      i = last
    elseif italic and text:match("^%(") then
      insert_marginal(out, div({block}, {"nyx-aside", "journal-marginal"}))
    elseif italic then
      out:insert(div({block}, {"journal-apart"}))
    elseif sole_inline(block, "Strong") then
      out:insert(div({block}, {"journal-display"}))
    elseif block.t == "CodeBlock" and #block.classes == 0 then
      local lines = {}
      for line in (block.text .. "\n"):gmatch("(.-)\n") do table.insert(lines, line) end
      out:insert(inscription(lines))
    elseif sole_inline(block, "Code") then
      out:insert(inscription({sole_inline(block, "Code").text}))
    elseif block.t == "BlockQuote" then
      out:insert(voice(block))
    elseif block.t == "Para" and blocks[i - 1].t == "HorizontalRule" then
      out:insert(lead_in(block))
    else
      out:insert(block)
    end
    i = i + 1
  end
  return out, dateline
end

local function epigraph(meta)
  local e = meta.epigraph
  if not e or not e.text then return nil end
  local blocks = pandoc.Blocks{pandoc.Para(e.text)}
  if e.attribution then
    blocks:insert(div({pandoc.Para(e.attribution)}, {"nyx-epigraph__attr"}))
  end
  return div(blocks, {"nyx-epigraph", "journal-epigraph"})
end

local function small_caps_era(str)
  local era, rest = str.text:match("^(DR)(%p*)$")
  if not era then return nil end
  local inlines = pandoc.Inlines{span({pandoc.Str(era)}, "nyx-smallcaps")}
  if rest ~= "" then inlines:insert(pandoc.Str(rest)) end
  return inlines
end

function Pandoc(doc)
  local blocks = doc.blocks
  local out = pandoc.Blocks{}
  local i = 1

  local first = blocks[1]
  if first and first.t == "Header" and first.level == 1 and doc.meta.title == nil then
    local title, subtitle = split_at_dash(first.content)
    doc.meta.title = pandoc.MetaInlines(title or first.content)
    if subtitle and #subtitle > 0 then doc.meta.subtitle = pandoc.MetaInlines(subtitle) end
    i = 2
  end

  local front = epigraph(doc.meta)
  if front then out:insert(front) end

  local header, section
  local function close_section()
    if not header then return end
    local body, dateline = entry_body(section)
    out:insert(entry_heading(header, dateline))
    out:extend(body)
    header, section = nil, nil
  end

  while i <= #blocks do
    local block = blocks[i]
    if block.t == "Header" and block.level == 2 then
      close_section()
      header, section = block, pandoc.Blocks{}
    elseif section then
      section:insert(block)
    else
      out:insert(block)
    end
    i = i + 1
  end
  close_section()

  if doc.meta.colophon then
    out:insert(div({pandoc.Para(doc.meta.colophon)}, {"nyx-colophon", "journal-colophon"}))
  end

  doc.blocks = out
  return doc:walk{Str = small_caps_era, Code = written, Inlines = tighten_dashes}
end
