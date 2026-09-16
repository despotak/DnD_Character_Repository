--[[
  Stoichos — `dropcap` Pandoc filter.

  Paragraph-level dropcap via ::first-letter + initial-letter. Wrap a paragraph
  in a fenced div with class `dropcap`; the filter renames `dropcap` to
  `nyx-has-dropcap` (preserving every other class, attribute, and identifier
  the user set), and the SCSS rule `.nyx-has-dropcap > p::first-letter` does
  the typesetting.

  Usage:

    ::: dropcap
    Typography exists to honor content. The opening capital sits on the
    baseline of the first three lines, sized via `initial-letter: 3`.
    :::

  Or with extra attributes that survive:

    ::: {.dropcap #opening data-style="ornate"}
    Once upon a time...
    :::

  Renders to: <div id="opening" data-style="ornate" class="nyx-has-dropcap">…</div>

  Browser support: Chrome 110+, Safari 15+, Firefox flagged. Where unsupported,
  the SCSS fallback renders the first letter at 1.6em and lets the prose flow.

  Two dropcap mechanisms coexist:
    - `{{< large-letter "T" >}}` — span-based, float: left technique. Inline
      "oversized letter" semantics; works in every browser. Use anywhere
      in prose.
    - `::: dropcap` (this filter) — paragraph-level, ::first-letter +
      initial-letter. Modern; lays out cleanly without manual letter
      splitting. Use when you want a true newspaper-style dropcap on the
      first letter of a paragraph.
]]

function Div(div)
  if not div.classes:includes("dropcap") then
    return nil
  end
  -- Idempotency: skip if already converted.
  if div.classes:includes("nyx-has-dropcap") then
    return nil
  end
  -- Rename the trigger class to the styling class. Every other class,
  -- attribute, and identifier on the original div survives unchanged.
  for i, c in ipairs(div.classes) do
    if c == "dropcap" then
      div.classes[i] = "nyx-has-dropcap"
      break
    end
  end
  return div
end
