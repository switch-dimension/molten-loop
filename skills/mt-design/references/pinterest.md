# Visual reference discovery (Pinterest)

After ingesting `brand.md`, curate Pinterest inspiration **before** locking design tokens or writing `design.md`. This gives non-designers concrete visual direction without asking them to articulate taste in design-system jargon.

Do not write `design.md` until this phase is complete (reference confirmed) or explicitly skipped.

### Generate 5 Pinterest search terms

Derive **exactly five** search terms from `brand.md`, the chosen **design surface**, any plain-language feel answers already given, and the **Pinterest search angles** in the selected surface reference. Do this **before** presenting the phase to the user.

Rules:

- Keep all five terms inside the chosen surface. Do not spread searches across unrelated concepts (palette-only, generic typography, abstract mood boards, editorial print, logo marks, etc.).
- Use the anchor words and example patterns from the selected surface reference.
- Add **one** brand/context modifier from `brand.md` where natural (category, feel, B2B/B2C, dark/light), but the surface anchor words stay mandatory in every term.
- Keep terms **3–6 words**, visual and Pinterest-friendly — not abstract strategy words ("modern", "premium", "aesthetic" alone).
- **Exclude** anti-references and things the user said to avoid.
- Do not duplicate the same pattern twice; vary within the chosen surface's patterns.
- If the five terms do not all clearly belong to the chosen surface, rewrite them before showing the list to the user.

### Offer the phase

Skip this subsection if the user already attached a reference image or explicitly said to skip references.

Do **not** ask whether they want to browse Pinterest. Present what you have already prepared, then offer to open it.

In chat, say something like:

> I've collected some visual inspiration for you on Pinterest that aligns with your brand. I can open those for you to take a look and pick one example as a favourite to aid design direction.
>
> Here are the five searches I put together:
>
> 1. …
> 2. …
> 3. …
> 4. …
> 5. …

Then ask:

**"Shall I open these Pinterest searches for you?"**

Options:

- **Yes — open them so I can pick a favourite**
- **Skip — infer from brand.md alone**
- **Choose for me — recommend based on brand.md**

If they pick **Choose for me**: recommend **Skip** when `brand.md` already has strong visual references or a clear maturity/personality signal; recommend **Yes** when the brand brief is thin on visual cues or the user chose the detailed path. State the recommendation in one sentence, then follow it.

Only generate new search terms if the user asks for different angles; do not re-ask whether to use Pinterest at all.

### Open 5 Pinterest tabs

Build one URL per term:

`https://www.pinterest.com/search/pins/?q={url_encoded_term}`

(URL-encode spaces as `+` or `%20`.)

Open all five in the user's **default browser**, in separate tabs. Prefer the first method that works in the current environment; do not block the workflow if opening fails.

1. **Shell (macOS):** `open "url1" "url2" "url3" "url4" "url5"`
2. **Shell (Linux):** `xdg-open "url1" "url2" ...` (one invocation with multiple URLs when supported)
3. **Shell (Windows):** `start "" "url1"` for each URL
4. **`cursor-app-control` `open_resource`:** one call per URL, if available
5. **Fallback:** paste the five links as markdown so the user can open them manually

After opening (or on fallback), tell the user:

> Take a look through the five tabs. Pick **one** pin as your favourite — the example that feels closest to the direction you want. Paste or attach **that single image** here (screenshot, saved image, or drag-and-drop). I'll describe what I take from it before we lock the design system.

Wait for the image. Do not proceed to token decisions until they submit one reference **or** say to skip (e.g. "skip", "no reference", "continue without").

### Interpret the reference image

When the user attaches **one** image, analyze it and summarize in plain language under these headings:

- **Colors** — dominant palette, accent usage, light vs dark, warm vs cool, saturation
- **Typography feel** — sans/serif/mono tendency, weight contrast, headline vs body hierarchy (exact font names only when obvious)
- **Layout & density** — whitespace, grid vs editorial, information density
- **Shape & depth** — corner radius, borders vs shadows, flat vs layered
- **Mood** — 2–3 concrete adjectives tied to what you see, not vague taste words
- **Adopt into tokens** — specific implications for `design.md` (example: "12px radius", "warm off-white surface ~#FAF8F5", "single saturated accent on neutral base")
- **Avoid** — anything that conflicts with `brand.md` anti-references or would hurt usability (contrast, tap targets)

If the image is unclear, low resolution, or off-topic, say so and ask for a different pin or permission to skip.

### Confirmation gate (mandatory)

Before applying the reference to tokens, get explicit approval with a numbered multiple-choice question:

**"Does this match what you liked in the reference?"**

Options:

- **Yes — lock this direction into the design system**
- **Adjust — I'll describe what to change**
- **Different reference — I'll paste another image**
- **Skip reference — use brand.md only**

Then:

- **Yes:** map the adopted signals into concrete YAML tokens and prose in `design.md`. Record in **Assumptions**: `Visual reference: user-selected pin → [one-line summary of adopted signals]`.
- **Adjust:** take their correction, revise the interpretation, and ask again until they confirm or skip.
- **Different reference:** repeat interpret + confirmation with the new image only (still one reference at a time).
- **Skip:** do not let the discarded reference influence tokens; continue from `brand.md` alone.

Never silently apply a reference. The user must confirm (or skip) before `design.md` is written.
