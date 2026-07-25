# Selanar Durothil — Build Progression (Level 0 → 20)

Working log for building Selanar under this table's house rules (level 0 start, narrative ability unlocks, feats-over-ASI, milestone leveling). Built one decision at a time; each locked choice is verified against the published rules text (5etools JSON mirror).

Concept target: Wizard → **Bladesinger** at level 3 (per our 2025 conversation). Duelist-mage aesthetic — no robe, no staff, fine clothes, curved blade. See `../Selanar Durothil.md` for full fluff/backstory.

## Locked decisions

### 1. Species — Elf (2024/XPHB) + High Elf Lineage
- **Source:** XPHB Elf, p.189; Elven Lineages table
- No fixed racial ability score — 2024 species don't grant ASIs; that comes from Background instead
- Medium, Speed 30 ft, Darkvision 60 ft
- Skill proficiency: **Perception** (chosen over Insight/Survival — Insight is already reachable via the Wizard class skill list at level 1, so it'd be a wasted pick; Perception adds coverage Wizard doesn't, and matches the established "traps don't make me nervous, idiots who trigger them do" personality trait)
- Fey Ancestry — advantage on saves to avoid/end Charmed
- Trance — no sleep needed, magic can't sleep you, long rest finishes in 4 hrs if spent trancing
- **Elven Lineage: High Elf** — spellcasting ability **INT**, to stay unified with the Wizard casting stat (no reason to split casting stats across two different abilities)
  - Level 1: know Prestidigitation; swap it for a different Wizard cantrip on any long rest
  - Level 3: learn Detect Magic — always prepared, castable once/long rest without a slot (or via a real slot)
  - Level 5: learn Misty Step — same free-cast structure

### 2. Ability scores — **ASSUMED, not final**

Real stats get rolled live Monday at the table (see Open Questions below for the mechanic + simulated expectations). To keep the build moving, assuming one concrete near-median result from the pool simulation as a stand-in — **this entire array is a placeholder and will be swapped for whatever actually gets rolled/picked Monday.**

Assumed array (sorted): **18, 16, 15, 13, 7, 6** (sums to 75, valid under the house rule)

| Stat | Rolled (assumed) | Background ASI | **Final** | Rationale |
|---|---|---|---|---|
| INT | 18 | +2 (Mythalkeeper) | **20** | Primary — Wizard casting stat, also drives the Elven Lineage spells. Every spell he casts scales off this; +2 is non-negotiable here |
| DEX | 16 | +1 (Mythalkeeper) | **17** | Secondary — AC, initiative every round under the dynamic-initiative house rule, and DEX saves. NOTE (later-pass correction): does *not* back weapon attacks as first assumed — 2024 Bladesong routes weapon attack/damage through INT while active. DEX is purely defensive/initiative here, but still beats WIS on breadth |
| CON | 15 | — | 15 | Squishy-caster survivability; "combats are difficult, people go down" per house rules |
| WIS | 13 | — | 13 | Backs the Perception proficiency and generic saves — real but narrower value than DEX |
| CHA | 7 | — | 7 | Lowest non-dump — mechanically unused by the build; in tension with the "confident, charismatic noble" fluff, worth revisiting once real numbers are in |
| STR | 6 | — | 6 | Dump — matches "the body of a dancer, not a fighter" |

**Background ASI allocation, revised:** Mythalkeeper's printed pool is INT/WIS/CHA, but the table's customization house rule frees the ASI target to any ability, not just that pool — so the real question is what the *build* needs, not what the background prints. DEX beats WIS on pure relevance (AC + attack rolls + initiative every round, vs. one skill), so it gets the +1 instead. This also holds up against the future feat pipeline: checked the full XPHB feat list — **Origin feats (the level-0 feat we pick next) grant no ability score at all**, but **General feats (first available at level 4) all do.** The strongest Bladesinger-flavored General feats — War Caster, Fey-Touched, Resilient — skew toward covering INT/CON/WIS later; the one standout DEX option (Defensive Duelist) isn't guaranteed to get picked. So DEX benefits more from being locked in now via the free background point than WIS does. This reasoning is stat-value-based, not tied to the placeholder numbers, so it holds regardless of what actually gets rolled Monday.

### 3. Background — Mythalkeeper (FRHoF)
- **Source:** *Forgotten Realms: Heroes of Faerûn*, full 2024-format entry
- **Why:** Myth Drannor is named for its mythal — a background about keeping/studying mythals for a Myth Drannor-born elf whose life mission is reviving Arselu'Tel'Quess (ancient elven high magic) is about as tight a name-to-concept match as the dataset has. See `background-tier-list.md` for the full comparison against Archaeologist, Sage, Noble, and everything else surveyed.
- Ability pool: INT/WIS/CHA as printed, but freely retargeted per the house rule → **+2 INT, +1 DEX** (see § Ability scores above for the full reasoning)
- Skill proficiencies: **Arcana, History** — both also sit on the Wizard class skill list, but since Wizard only needs 2 of 7 options, no pick gets wasted; class picks route to the *other* remaining options (e.g. Investigation, Insight) instead
- Tool proficiency: **Jeweler's Tools** — nice unplanned synergy with the Selu'Kiira (a gem-set diadem) being one of his two search targets
- Default origin feat: Crafter — **not locking yet**, feats are next step
- Default equipment: quarterstaff, jeweler's tools, perfume, pouch, robe, shovel, string, waterskin, 16 gp (option A) or flat 50 gp (option B). Robe/quarterstaff clash with the "no robe, no staff" mandate — option B (flat gold) is the cleaner pick, decide at the Equipment step

### 4. Origin feat — Spellfire Spark (FRHoF)
- **Source:** *Forgotten Realms: Heroes of Faerûn*; freely swapped in over Mythalkeeper's printed default (Crafter) per the customization house rule
- **Why:** the only available feat scoring ★★★★★ narrative while doing real mechanical work — spellfire is his declared signature motif (see `../Spell reskins - Approval Pending.txt`), Sacred Flame is radiant (his light theme), and the pick survived three independent evaluation passes (see `origin-feat-tier-list.md`)
- **Magic Absorption:** once per turn when taking damage from a spell/magical effect, reduce the total by 1d4 (not while Incapacitated)
- **Spellfire Flame:** learn **Sacred Flame** — casting stat **INT** (chosen, unified with everything else); at-will as an Action, plus castable as a **Bonus Action** Proficiency-times per long rest. Caveat: the bonus action competes with Bladesong activation rounds and (at 14+) Song of Victory
- **In-fiction justification — the birth-night spark** (per the Session-0 narrative-unlock rule): tied to two facts already in his backstory — he was *born the dawn after the Quess'Ar'Teranthvar was unmade* (1375 DR), and his mother's line, House Aluviirsan, descends from **Tyvollus Aluviirsan — the High Mage who created the Golden Grove and bound himself to its keeping.** Draft blurb below.
- **Synergy note:** reflavor Sacred Flame's "flame-like radiance" as prismatic spellfire — zero mechanical change, pure theme

#### The awakening beat (proposed narrative unlock — pairs with the spell-reskin doc)

> Centuries ago the High Mage Tyvollus Aluviirsan wove the stolen Nether Scrolls into a living tree of gold — the Quess'Ar'Teranthvar, the Golden Grove of Hidden Knowledge — and bound himself, and his line, to its keeping. In 1375 DR, the Year of the Risen Elfkin, agents of Shade tore the Grove from Windsong Tower; rather than let Netheril reclaim it, the heroes of Shadowdale unmade it, and fifty scrolls' worth of raw, unbound Art scattered to the winds of Anauroch.
>
> The next dawn, in Myth Drannor, Iamorasseianna of House Aluviirsan — Tyvollus's blood — gave birth to a son.
>
> Something of the Grove followed the bloodline home. A mote of liberated Weave-stuff — spellfire, the raw essence of the Art, the very thing Mystra's silver serpent guarded in the Grove's branches — settled into the newborn and slept. It is what pulled the Spell-Major's tattoo to the surface, unbidden, the first time the boy wove dweomercræft. And now, with Mystra reborn and the Weave rewoven, the ember his birth-night left in him has finally begun to kindle: azure fire shot through with every color light can hold.
>
> Selanar seeks the scattered Nether Scrolls as his House's duty and his people's inheritance. He does not yet know that the Grove, in its unmaking, already gave him a spark of itself.

Mechanical mapping for the level-0 reveal: **Magic Absorption** = the spark instinctively drinks hostile magic before it can bite him (first sign, passive, ideally manifests on-screen the first time a spell hits him); **Spellfire Flame** (Sacred Flame) = the first deliberate release, once he understands what lives in him. A two-stage unlock — exactly the structure the Session 0 doc asks for.

### 5. Class & subclass — Wizard (XPHB) → Bladesinger (FRHoF) at level 3

- **Class:** Wizard, 2024 (XPHB p.164). d6 hit die; saves INT & WIS; simple weapons; no armor. Class skills: 2 of Arcana/History/Insight/Investigation/Medicine/Nature/Religion → **Investigation + Insight** (locked). Investigation: INT-based (+7 at L1), the deduction half of a mystery-heavy game, and the one lane neither the Knowledge Cleric nor the Eloquence Bard covers. Insight: the contested check vs. every Deception roll in an intrigue campaign; the overlap with Vesper is a feature, not waste — the table's "can only Help when you have proficiency" rule makes shared proficiencies the license to Help the better roller. Religion was the runner-up (INT-based, Corellite-Faerna flavor) but it's the most-covered skill at this table (a literal Knowledge cleric of Selûne); Medicine/Nature don't make the cut.
- **Subclass:** **Bladesinger (FRHoF)** — the 2024 rewrite, *not* TCE 2014. Comes online at level 3, which per the Session-0 doc is a major narrative beat. Its own flavor text: bladesinging is "associated with the ancient elven societies that first mastered the art… most Bladesingers still hail from old elven realms, **such as Myth Drannor**." The subclass is literally native to his home city.
- **Deferred by design:** general feats (levels 4/8/12/16), Epic Boon (19), and all spell selections — separate passes.

#### Feature skeleton, levels 1–20 (RAW, verified against `class-wizard.json`)

| Lvl | Feature(s) | Notes for this build |
|---|---|---|
| 1 | **Spellcasting** · **Ritual Adept** · **Arcane Recovery** | 3 cantrips known / 4 prepared; ritual-cast anything with the Ritual tag straight from the spellbook (no prep needed); Arcane Recovery = ½ wizard level in slot-levels back on a short rest, 1/day |
| 2 | **Scholar** | Expertise in one proficient skill from Arcana/History/Investigation/Medicine/Nature/Religion → **Arcana** (his entire identity: Silver Twilight researcher, mythal-keeper, Seeker of Mysteries) |
| 3 | **Bladesinger** subclass: **Bladesong** · **Training in War and Song** | See breakdown below — the build's engine arrives |
| 4 | Feat/ASI + 4th cantrip | Planned: **Elven Accuracy** (+1 DEX→18) — see § 6 |
| 5 | **Memorize Spell** | Swap one prepared spell on every short rest — huge flexibility for an investigation game |
| 6 | **Extra Attack** (subclass) | Attack twice; may replace one attack with a Wizard action-cantrip → the gish loop matures (e.g. blade cantrip + weapon attack in one Attack action) |
| 8 | Feat/ASI | Planned: **War Caster** (+1 WIS→14) — see § 6 |
| 10 | **Song of Defense** (subclass) + 5th cantrip | Reaction while Bladesong is up: burn a slot, reduce damage by 5× slot level |
| 12 | Feat/ASI | Planned: **Spellfire Adept** (+1 WIS→15) — see § 6 |
| 14 | **Song of Victory** (subclass) | Cast an action spell → bonus-action weapon attack. Note: competes for the bonus action with Spellfire Spark's Sacred Flame and Bladesong activation — action-economy pass needed at this tier |
| 16 | Feat/ASI | Planned: flex — Resilient (CON→16) / Keen Mind / Observant / Alert — see § 6 |
| 18 | **Spell Mastery** | One L1 + one L2 spell castable at will; swappable per long rest |
| 19 | **Epic Boon** | *deferred* — and there's the table-wide house-rule boon at 19 (needs a ruling: same thing, or additional?) |
| 20 | **Signature Spells** | Two L3 spells, each free-cast 1/short rest |

Cantrips known: 3 → 4 (L4) → 5 (L10). Prepared spells: 4 → 25 across 1–20. One cantrip from the class list is also swappable every long rest (on top of the High Elf lineage swap — two floating cantrip slots in practice).

#### Bladesong (L3, FRHoF) — the engine, in full

- **Activation:** Bonus Action; requires no armor, no shield. Lasts 1 minute; ends if Incapacitated, armored/shielded, or if he makes a two-handed weapon attack. Free to dismiss.
- **Uses:** INT mod per long rest (min 1) — **and Arcane Recovery refunds one use**, an FRHoF addition worth remembering every single adventuring day.
- **Agility:** +INT mod to AC (with the assumed array: 10 + 3 DEX + 5 INT = **AC 18 unarmored**, matching half-plate with none of the wardrobe crimes) and +10 ft Speed; Advantage on Acrobatics.
- **Bladework:** weapon attack *and damage* rolls may use INT instead of STR/DEX — the whole martial side runs off the casting stat.
- **Focus:** +INT mod to Concentration saves.

**Training in War and Song (L3):** proficiency with all one-handed melee martial weapons (the curved blade is legal RAW, no reflavor needed — a scimitar or shortsword chassis works as-is); a proficient melee weapon becomes his **spellcasting focus** (no component pouch, no wand — the sword *is* the focus, which is maximally on-concept); plus one skill from Acrobatics/Athletics/Performance/Persuasion → **Acrobatics** (locked). The hard mechanical reason, beyond the dancer flavor: in 2024 rules escaping a grapple is a STR (Athletics) *or* DEX (Acrobatics) check, and his Athletics rides the STR 6 dump at −2 — Acrobatics is his *only* viable escape from a grab, and a grappled no-armor melee caster is a dead one. Proficiency + Bladesong's built-in Acrobatics advantage makes it reliable. Performance/Persuasion would ride the CHA 7 (and Performance is the bard's lane); Athletics rides the dump stat — not close.

### 6. General feats — planned sequence (provisional, each slot re-confirmed when reached)

Full 80+-feat analysis in `general-feat-tier-list.md`. These are *plans*, not locks — revisit each at its level, and re-rank if the Monday roll shifts the array or the radiant reskins aren't approved.

| Slot | Pick | ASI routing | Why |
|---|---|---|---|
| **L4** | **Elven Accuracy** (XGE, elf-only) | +1 DEX → **18** (AC 19 in Bladesong, +4 initiative every round) | Reroll one advantage die on INT/DEX/WIS/CHA attacks — effective triple advantage. Iridescent Blade generates its own advantage in bright light; every piece of the kit feeds it |
| **L8** | **War Caster** (XPHB) | +1 WIS → **14** | Advantage on Concentration saves stacking with Bladesong's +INT (near-unbreakable); Reactive Spell turns opportunity attacks into blade-cantrip casts |
| **L12** | **Spellfire Adept** (FRHoF; prereq Spellfire Spark ✓) | +1 WIS → **15** | The identity capstone — burn up to 2 Hit Dice for bonus radiant damage once/turn; radiant ignores radiant resistance. Full value contingent on the reskin approval (fallback: Sacred Flame) |
| **L16** | Flex: **Resilient (CON→16)** / **Keen Mind** / **Observant** / **Alert** | varies | Decide by what the campaign has actually been punishing at that point |
| **L19** | Epic Boon — separate pass | — | Also clarify stacking with the table-wide L19 boon house rule |

Stat growth if the plan holds: DEX 18 by L4, WIS 15 by L12, CON 16 by L16 (final line: INT 20 / DEX 18 / CON 16 / WIS 15 / CHA 7 / STR 6 on the assumed array).

### 7. Cantrips — L1 loadout (locked; floaters rotate by design)

Full analysis in `cantrip-tier-list.md`. Economy: 3 class (one swappable/long rest) + 1 lineage (swappable/long rest) + Sacred Flame (feat, fixed) = 5 at L1, two floating.

- **Class, stable: True Strike** (XPHB 2024 rewrite) — weapon attack **with INT**, damage **radiant by choice**, +1d6/2d6/3d6 radiant at 5/11/17. Core-RAW radiant blade identity, zero approval needed; INT-attacks at L1–2 before Bladesong exists; feeds Spellfire Adept later; *and* it's the awakening-scene cantrip ("a flash of magical insight guides his blade")
- **Class, stable: Booming Blade** (TCE) — the movement-punish blade rider; becomes **Echoing Light Blade** if the reskin is approved; combos with War Caster's Reactive Spell at L8
- **Class, floater: Mind Sliver** (XPHB) default — INT save, −1d4 on target's next save, sets up the leveled save-or-suck spells; swaps to Message / Minor Illusion / Mage Hand on intrigue days (Minor Illusion is **somatic-only** — one of the few silent casts under the "verbal is loud" house rule)
- **Lineage, floater: Light** (XPHB) default — 20-ft bright light, colored as he likes (prismatic): manufactures the Iridescent Blade's advantage condition and fuels Elven Accuracy; swaps to Prestidigitation (the printed lineage default, and the most *him* utility cantrip) on court days
- **Feat, fixed: Sacred Flame** as "Spellfire Flame" (see § 4)
- **Growth:** L4 → **Green-Flame Blade** (TCE; "Spellfire Blade" reskin). L10 → utility consolidation (promote Minor Illusion/Message to stable, or Toll the Dead if ranged damage has lagged)

### 8. Spellbook — L1 opening six + L2 additions (locked)

Full analysis in `spell-tier-list-L1.md`. Frame: 6 spells in the book at L1 (4 prepared), +2 per level; **Ritual Adept casts ritual-tagged book spells without preparing them** — rituals cost book space, never prepared slots.

- **Opening book (L1):** **Shield · Mage Armor · Absorb Elements (XGE) · Spellfire Flare (FRHoF) · Color Spray · Find Familiar (ritual)**
- **Prepared (4):** Shield, Mage Armor, Absorb Elements, Spellfire Flare — Find Familiar rides free as a ritual; Color Spray is the first swap-in (joins prepared at L2 when the count hits 5)
- **L2 book additions:** **Comprehend Languages (ritual)** — the Nether Scrolls quest in spell form — and **Alarm (ritual)** — the "long rests need a safe location" house rule, weaponized. Zero prepared cost.
- **Detect Magic cut from the book** — always-prepared free via the lineage from character level 3. Nuance: the lineage grant isn't a *book copy*, so no Ritual Adept casting off it; scribe a book copy later (50 gp) if wanted.
- **⚠ Name-collision note (verified in RAW):** the feat benefit *"Spellfire Flame"* = the Sacred Flame cantrip grant. *"Spellfire Flare"* = an unrelated L1 spell, granted by nothing — it lives in the book like any other spell. Nearly identical names; don't trip twice.
- Mage Armor + Bladesong math: AC **16** out of song, **21** in it (13 + 3 DEX + 5 INT), from L3, in silk.
- For the approval list: faerie-dragon cosmetic form for Find Familiar (CR-0 chassis, fey type — pure cosmetics).

### 9. The tattoo is the leveling system (ported from the parallel build doc)

The table's Session-0 rules require a narrative trigger for every ability's first appearance and flag level 3 as story-critical. The Akh'Faer rank ladder (*Cormanthyr: Empire of Elves* — already cited in the character doc) maps onto the level track one-to-one, so the tattoo itself becomes the visible progression meter:

| Stage | Canon mark | Level → what ignites |
|---|---|---|
| Recruit | Black lightning sigil, backs of hands | **1** — the Art returns; True Strike's "flash of magical insight" guides his blade |
| Officer | Large azure-line tattoo along the forearm | **3** — **Bladesong ignites** (the story-critical subclass beat) |
| Progression | Up to four interlocking circles, added one at a time | **5 / 8 / 12 / 16** — one circle per feat/ASI milestone (Misty Step also arrives at 5) |
| Senior officer | Yellow woven into the azure → reads as **green** | **10** — Song of Defense |
| Higher | Concentric lozenges intersecting the circles | **14** — Song of Victory |
| **Spell-Major** | All designs turn **silver on green** | **20** — Signature Spells; the rank he's chased since level 0, worn at last |

**Dormancy frame (harmonized with § 4's birth-night beat):** the Grove-spark settled in him at birth; its traces surfaced as the ghost of this tattoo at his first childhood dweomercræft. The Fall of Myth Drannor (1487 DR) and the Weave's convulsion drove the Art quiet — the tattoo faded to a shadow through the Semberholme years. Session one, 1495: the Weave hums again, the spark rekindles (Magic Absorption first — instinctive, unexplained — then Spellfire Flame), and the black recruit's sigil re-darkens on his hands. Every level thereafter, the ink climbs. The DM gets a visual, diegetic progression meter to describe at every milestone — no bookkeeping, just skin.

## Known spells

Running tally — updated every time a spell gets locked in, whatever the source (lineage, class, feat, item).

| Spell | Level gained | Source | Casting stat | Notes |
|---|---|---|---|---|
| True Strike | 1 | Wizard class (stable) | INT | Weapon attack w/ INT; radiant by choice; +1d6/2d6/3d6 radiant at 5/11/17 |
| Booming Blade | 1 | Wizard class (stable) | INT | Movement-punish rider; → "Echoing Light Blade" (radiant) if reskin approved |
| Mind Sliver | 1 | Wizard class (**floater** — 1 class cantrip swaps each long rest) | INT | Default; rotates w/ Message / Minor Illusion (somatic-only = silent) / Mage Hand |
| Light | 1 | Elven Lineage slot (**floater** — swaps each long rest) | INT | Default occupant; prismatic bright light = Iridescent Blade advantage engine. Swaps to Prestidigitation (printed lineage default) on court days |
| Sacred Flame ("Spellfire Flame") | 1 | Spellfire Spark feat | INT | At-will as Action; also castable as Bonus Action, Prof./long rest. Reflavor: prismatic spellfire |
| Detect Magic | 3 | Elven Lineage (High Elf) | INT | Always prepared; 1/long rest free, or via a slot |
| *Green-Flame Blade* | *4 (planned)* | Wizard class (4th cantrip) | INT | → "Spellfire Blade" (radiant, per published spellfire) if reskin approved |
| Misty Step | 5 | Elven Lineage (High Elf) | INT | Always prepared; 1/long rest free, or via a slot |

**Spellbook (leveled spells; ✦ = default prepared, ℞ = ritual, castable from book unprepared):**

| Spell | Book level | Notes |
|---|---|---|
| Shield ✦ | 1 (wizard L1) | +5 AC reaction — the bladesinger staple |
| Mage Armor ✦ | 1 (wizard L1) | AC 16 out of song, 21 in it; 8 hrs, no conc |
| Absorb Elements ✦ | 1 (wizard L1, XGE) | Reaction resistance + melee rider |
| Spellfire Flare ✦ | 1 (wizard L1, FRHoF) | 2d10 radiant, attack roll, ignores cover; his signature |
| Color Spray | 1 (wizard L1) | Prismatic AoE blind; joins prepared at wizard L2 |
| Find Familiar ℞ | 1 (wizard L1) | The faerie dragon (cosmetic form — on the approval list) |
| Comprehend Languages ℞ | 1 (wizard L2) | The Nether Scrolls quest, in spell form |
| Alarm ℞ | 1 (wizard L2) | Makes camps "safe and secure" per the rest house rule |

## Skill proficiencies

Running tally — updated every time a proficiency gets locked in.

| Skill | Source | Notes |
|---|---|---|
| Perception | Elf species | Chosen over Insight (redundant with Wizard's class list) and Survival (weak fit / diminished by house rules) |
| Arcana | Mythalkeeper background | Default background skill; not redundant with the Wizard class list since class only needs 2 of 7 options |
| History | Mythalkeeper background | Same as above |
| Investigation | Wizard L1 (class) | INT-based (+7 at L1) — the deduction skill in a mystery game; the lane neither Vesper nor Matt covers |
| Insight | Wizard L1 (class) | The contested check vs. Deception in an intrigue game; overlap with Vesper is deliberate — the "Help needs proficiency" table rule makes shared proficiencies valuable. Beat Religion (most-covered skill at this table) for the slot |
| **Arcana — Expertise** | Wizard L2 (Scholar) | Doubles proficiency on his identity skill |
| Acrobatics | Bladesinger L3 (Training in War and Song) | DEX-keyed; stacks with Bladesong's built-in Acrobatics advantage; and it's his *only* viable grapple escape (Athletics rides the STR 6 dump) |

Full spread at L3: **Perception · Arcana (Expertise) · History · Investigation · Insight · Acrobatics** — notice, deduce, read people, know the Art, know the past, move like a dancer.

## Open questions / pending steps
1. ~~Stats~~ — assumed for now (see § Ability scores above), **actual roll happens live Monday at the table.** Mechanic (per the DM's clarification in DMs, superseding the formal doc's "3 times"): each player rolls 4 arrays (4d6kh3 ×5, 6th stat = 75 − sum of the other five, mulligan the whole array if that 6th falls outside 3–18), discards 1, keeps 3 → shared 9-array pool across 3 players, no array reused, persists as a campaign-long "library." Simulated via `stat-roll-sim.py` in this folder (50k–1M trial runs, all converged): best-fit pick from the pool averages top stat ~17.7 / second stat ~16.0 (median 18/16), vs. ~17.3/15.4 picking solo from just your own 3 — a modest but real edge from the shared pool. Still to settle at the table: the pick order/priority when two players want the same array. **When the real roll happens, replace the assumed array above and re-check every downstream decision that referenced it (ASI/feat math, save DCs, AC).**
2. Items needing DM sign-off (bundled): (a) the three spell reskins in `../Spell reskins - Approval Pending.txt`; (b) the Spellfire Spark narrative-unlock beat (§ 4); (c) whether Origin feats from non-FR books (Child of the Sun, Sharp Eye) are table-legal — useful precedent for future picks; (d) how Alert's initiative-swap interacts with per-round initiative rerolls; (e) the faerie-dragon cosmetic form for Find Familiar (§ 8); (f) whether the level-19 Epic Boon and the table-wide level-19 boon are the same thing or stack.
3. Equipment — no armor/robe, fine clothes, curved blade; background equipment option B (flat gold) pending.
4. Remaining build passes: **magic item wishlist** — the Selu'Kiira is done: full three-card 5e translation (tel'kiira · selu'kiira · the House Durothil vestige) in `kiira-item-cards.md`, DM-ready; the **Ary'Faern'Kerym** card remains as the other long-arc hook. Also pending: higher-level spell selections (L2+ books), Epic Boon pick — then the compressed 1→20 trajectory summary requested at signup ("I'll need to know what your plan is for your build down the line").
