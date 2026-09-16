--[[
  Stoichos — `aside` Pandoc filter.

  Walks Div elements with class `aside` and adds:
    - column-margin  Quarto's layout class for marginalia (right-column flow on wide viewports,
                     inline collapse on narrow). Provides the *positioning*.
    - nyx-aside      Stoichos's typography styling (font size, font-feature-settings, color,
                     padding). Provides the *appearance*.

  Idempotent: skips divs that already have nyx-aside-processed.

  Usage in a .qmd document:

    ::: aside
    Marginalia content here. Renders alongside body on wide screens,
    collapses inline on narrow.
    :::

  Why a filter rather than asking users to write the `column-margin` class directly:
    - Single-keyword authoring (`aside`) is more memorable than `column-margin`.
    - The filter lets us evolve the underlying mechanism (column-margin today, anchor
      positioning when browser support stabilizes) without changing what authors write.
]]

function Div(div)
  if not div.classes:includes("aside") then
    return nil
  end
  -- Idempotency: skip if column-margin (Quarto's layout class we add) already
  -- present. No need for a sentinel class that leaks into the user-visible
  -- output — the columns marker is a perfect natural marker of "processed."
  if div.classes:includes("column-margin") then
    return nil
  end
  div.classes:insert("column-margin")
  div.classes:insert("nyx-aside")
  return div
end
