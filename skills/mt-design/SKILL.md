---
name: mt-design
description: "Molten Loop — turns the brand into a DESIGN.md visual system for one surface (landing, web, mobile or desktop) with a live preview. Writes `molten-docs/design/design.md`. Use for a design system, design tokens or visual direction. Not for brand strategy (use mt-brand)."
metadata:
  author: switch-dimension
  version: "1.9.0"
  molten-suite: molten-os
  molten-category: product
  molten-tier: core
  molten-order: "3"
---

# Design System Brief

You help the user produce a design system document that an AI coding agent can apply consistently when generating UI. The file follows Google Labs' DESIGN.md spec (YAML token front matter + ordered prose sections) with optional extension sections for motion, iconography, and accessibility.

**Input path (canonical):** `molten-docs/brand/brand.md` from **mt-brand**. Fall back to `brand.md` at the project root or `/docs/brand.md` on older projects.

**Output path (canonical):** `molten-docs/design/design.md` at the repository root. Create the `molten-docs/design/` directory if it does not exist.

**Preview path (canonical):** `molten-docs/design/example.html`. After writing the design brief, create a self-contained HTML preview that shows the design system in use.

This skill is the visual counterpart to **mt-brand**. Brand strategy lives in the brand brief; visual identity lives in the design brief.

## First Ask: Design Surface

At the start of every run, establish **one design surface** for this session. Do not blend landing-page marketing UI with web-app, mobile-app, or desktop-app product UI in the same pass.

Skip this ask only when the user already named the surface clearly (e.g. "landing page design system", "mobile app UI", "SaaS dashboard").

Ask as a numbered multiple-choice question:

**"What is this design system for?"**

Options:

- **Landing page** — marketing / conversion pages (hero, sections, CTAs); pairs with **mt-landing**
- **Web product** — browser-based app UI (dashboards, forms, nav, dense workflows)
- **Mobile product** — phone-first app UI (lists, tabs, thumb zones, native-like patterns)
- **Desktop product** — desktop app UI (window chrome, menus, multi-pane workflows, keyboard-heavy use)
- **Choose for me — infer from brand.md and context**

When the user picks **Choose for me**, infer from `brand.md` and their prompt:

- Marketing site, waitlist, launch, or single-page conversion → **Landing page**
- SaaS, admin, developer tool, internal tool, dashboard, or responsive browser app → **Web product**
- Consumer app, field tool, or on-the-go phone-first workflow → **Mobile product**
- Electron, native desktop app, menu bar, command palette, IDE/tooling, or keyboard-heavy multi-window app → **Desktop product**

State the choice and one-sentence reason before continuing.

## Surface Reference Routing

After the design surface is chosen, read exactly one surface reference before Pinterest, token, component, or preview decisions:

| Chosen surface | Required reference |
| --- | --- |
| Landing page | `references/landing-page.md` |
| Web product | `references/web-app.md` |
| Mobile product | `references/mobile-app.md` |
| Desktop product | `references/desktop-app.md` |

These references contain the surface-specific guidance: layout, density, component set, Pinterest search anchors, preview slice, and surface do's/don'ts. Keep `SKILL.md` as the shared spine; do not duplicate the whole design workflow into separate skills unless the trigger and output become genuinely different.

### One surface at a time

- Scope **every** decision in this run — tokens, components, Pinterest searches, `example.html`, and Do's and Don'ts — to the chosen surface only.
- Record the surface in the **Overview** and **Assumptions** sections of `design.md` (example: `Design surface: landing page`).
- If the user needs more than one surface (e.g. landing page **and** web app), finish this run for the chosen surface, then run **mt-design** again for the next surface. Do not expand scope mid-session.

## First Ask: Fast Or Detailed

Most users of this skill are not designers, but they should still control the level of guidance they want.

Before creating files, ask which approach they want unless they already said "fast", "quick", "detailed", "guided", or equivalent in their prompt.

Ask **Design surface** and **Fast vs Detailed** together as questions 1 and 2 in one message when both are still unknown.

Offer exactly these two choices for the workflow:

- **Fast draft:** Read the brand brief, ask at most 3 plain-language questions if needed, infer token-level choices, then create `design.md` and `example.html`.
- **Detailed guided pass:** Walk through more decisions with the user before writing the files, while still using plain language and avoiding unnecessary jargon.

If the user chooses **Fast draft**, use this flow:

1. Confirm **design surface** (landing page, web product, mobile product, or desktop product).
2. Read the matching surface reference from `references/`.
3. Read the brand brief, existing `design.md` if present, and any existing UI styles.
4. Offer **Visual Reference Discovery (Pinterest)** unless already skipped or completed.
5. Ask at most **3 plain-language questions** only if the answer cannot be inferred (fewer if a confirmed Pinterest reference already covers feel and direction).
6. Make the design decisions yourself — scoped to the chosen surface.
7. Write or update `molten-docs/design/design.md`.
8. Write `molten-docs/design/example.html`.
9. List assumptions so the user can react to a concrete draft.

In Fast draft mode, do **not** ask questions like:

- "What accent strategy should the system use?"
- "What neutral temperature should the interface use?"
- "What background strategy should the design brief specify?"
- "How should semantic colors be handled?"
- "What type pairing should the system use?"
- "What spacing base should the system use?"
- "What elevation strategy should the system use?"
- "What corner radius philosophy should the system use?"

Infer those details from `molten-docs/brand/brand.md`, existing project styles, and conservative defaults.

Only ask the user about plain-language inputs:

- Existing logo, website, or brand colors to respect
- Desired feel, such as serious, friendly, premium, energetic, calm, or utilitarian
- Product type, such as SaaS app, marketing site, developer tool, consumer app, or internal tool
- Optional reference websites/apps that feel close to the brand
- Visual things to avoid

If the user says "choose for me", "use best practices", "you decide", or gives no preference after choosing the fast path, decide and continue.

## Detailed Guided Pass

Use this when the user chooses the detailed option or explicitly asks for granular design control, token tuning, a designer-level workshop, or a deeper second pass after seeing the first draft.

Even in the detailed path, start with plain-language choices and translate the answers into token-level details yourself.

## Operating Rules

- At the start of interactive runs, advise the user: "The best way to interact with this skill is to use voice mode to dictate your feedback."
- **Read the brand brief before design decisions:** `molten-docs/brand/brand.md`, then legacy `brand.md` at the project root or `/docs/brand.md`. Extract every visual implication (maturity, personality, references, anti-references, first-impression cues, accent guidance). Do this after the design surface is known (or while inferring **Choose for me** for surface).
- **Read the matching surface reference before design decisions:** `references/landing-page.md`, `references/web-app.md`, `references/mobile-app.md`, or `references/desktop-app.md`.
- Ask the **design surface** question at the start of every run unless already clear from the user's prompt.
- Ask the Fast vs Detailed approach question before creating files unless the user already chose an approach.
- Scope the entire run to **one** surface (landing page, web product, mobile product, or desktop product). Never mix surfaces in one pass.
- Ask concise questions in small batches, within the Fast draft question budget unless the user chooses the detailed path.
- Prefer inference over questions. Offer multiple-choice options only when they are plain-language and genuinely reduce user effort.
- Ask every question as plain numbered text in chat so the user can answer by reference, especially when dictating in voice mode. Do not use agent question tools (`AskUserQuestion`, `AskQuestion`, `request_user_input`).
- For multiple-choice questions, list the options as lettered sub-items under the numbered question (1a, 1b, 1c) so the user can reply with something like "1b, 2a".
- Ask open-ended questions as numbered prose questions when the answer is free text, such as reference websites, existing assets, visual dislikes, or product context.
- Batch related questions into a single message when they belong to the same phase.
- **Act as a consultant, not a survey form.** Every multiple-choice question after the initial startup questions (design surface and fast vs detailed) must include a final "Choose for me" option so the user can defer to your judgment. When chosen, pick the option that best matches `brand.md` and the strategic context, then state the choice and the one-sentence reason before moving on. Do not silently choose — always surface the decision.
- For free-text questions in chat, offer the same opt-out: end with "or say *you choose* and I'll pick based on `brand.md`." If they defer, propose a specific value (exact hex, exact font name, exact dimension) plus a one-sentence rationale.
- If `brand.md` already answers a question, do not ask it again. Cite the value back to the user for confirmation only when ambiguous.
- Push back on vague taste words ("modern", "clean", "premium", "minimal"). Replace them with concrete tradeoffs.
- When making design decisions, keep the system practical: max two font families, 8-12 typography levels by default, 4-6 named color palettes, and one consistent spacing base.
- Separate facts, assumptions, and open questions.
- Do not generate app code while this skill is active.
- Do not define brand persona, voice, or messaging. Defer to the brand brief.
- Create or update the design brief only after the user has provided enough signal **and** any Pinterest reference has been confirmed or explicitly skipped.
- If file writing is available, write **`molten-docs/design/design.md`** and **`molten-docs/design/example.html`** (create parent directories as needed). Otherwise, provide the full contents for both files and tell the user the target paths.

## Question Style And "Choose For Me"

Offer lettered options only for plain-language outcomes from a finite set (surface, overall feel, product type, visual archetype), never design-system internals. Use open questions for free text (reference sites, existing colors, things to avoid), for pushing back on vague answers, and for confirming a summary.

The user must always be able to delegate a decision to you:

- **Multiple choice:** end with a lettered option such as "Choose for me — recommend based on brand.md". When picked, choose the option that best fits `brand.md` and the context, say "Picking **X** because [one-sentence reason]", and move on. Confirm first only if the choice is costly to reverse (primary color, type families).
- **Free text:** end with "…or say *you choose* and I'll propose a value based on `brand.md`." When they defer, propose an exact value (hex, font name, dimension) with a one-sentence rationale, never a range.
- **Already constrained:** if `brand.md` or the conversation already settles it, don't ask; apply it and say so.

Example:

> **1. What should the product feel like?**
> a) Serious  b) Friendly  c) Premium  d) Energetic  e) Calm  f) Utilitarian  g) **Choose for me — recommend based on brand.md**
>
> *User picks g.* "Picking **calm SaaS** because `brand.md` calls for quiet confidence and a clear, trustworthy interface."

## Ingest The Brand Brief

After the **design surface** is chosen (or inferred), and before Pinterest or token work:

1. Check for **`molten-docs/brand/brand.md`** (canonical). If missing, fall back to `brand.md` at the project root or `/docs/brand.md` for older projects.
2. If present, read it and extract:
   - Brand maturity, personality traits, paired tone descriptors
   - First-impression words
   - Visual references and anti-references
   - Risk posture and category stance
   - Density and emotional state implications from persona
3. Use the extracted visual signal directly. Only ask the user to confirm or correct it if there is a real ambiguity or contradiction.
4. If `brand.md` is missing, ask the user whether to run **mt-brand** first (recommended) or proceed without it.

## Existing Design Briefs And Surface Layers

Use one canonical design brief at **`molten-docs/design/design.md`**. Do not create separate unrelated design systems for landing, web, mobile, and desktop unless the user explicitly asks for separate brands.

Structure the output as:

- **Shared core:** colors, semantic colors, typography families, base type scale, radius philosophy, spacing base, motion principles, iconography, accessibility defaults.
- **Surface layer:** layout, density, component set, navigation patterns, section patterns, interaction states, and preview slice for the chosen surface.

If `molten-docs/design/design.md` already exists:

1. Read it before making new token decisions.
2. Treat shared core tokens as locked unless the user explicitly asks to redesign the brand system.
3. Add or update only the chosen **surface layer**.
4. Record the inheritance in **Assumptions**: `Shared core inherited from existing design.md; updated surface layer: [surface]`.

If this is the first design run, create a complete `design.md` for the chosen surface and label which decisions are shared core vs. surface layer so future surface passes can inherit the core.

## Visual Reference Discovery (Pinterest)

After ingesting `brand.md`, curate Pinterest inspiration **before** locking design tokens or writing `design.md`. This gives non-designers concrete visual direction without asking them to describe taste in design-system jargon. Follow [references/pinterest.md](references/pinterest.md): five surface-specific search terms, open them, have the user pick one pin, interpret it, and confirm before applying it.

Do not write `design.md` until this phase is complete (reference confirmed) or explicitly skipped. Never silently apply a reference.

## Detailed Second Pass

Only run this after the first `design.md` and `example.html` draft if the user explicitly asks for deeper control.

In that second pass, you may tune colors, typography, spacing, layout, elevation, shapes, components, motion, iconography, imagery, and accessibility. Start by asking what feels wrong in the current preview, then make targeted changes. Avoid restarting the whole interview.

Even in the detailed second pass, prefer plain-language questions first. Translate the user's answer into token-level details yourself whenever possible.

## Generate `molten-docs/design/design.md`

When enough information is gathered, read [references/design-template.md](references/design-template.md) and write **`molten-docs/design/design.md`** with that structure. The YAML front matter is normative; the prose is rationale. Clearly separate the **shared core** (tokens and principles stable across every surface) from the **surface layer** (the chosen surface's layout, density, components and preview guidance).

## Generate `molten-docs/design/example.html`

After writing `design.md`, create **`molten-docs/design/example.html`**: a self-contained, single-file visual preview of the tokens (swatches, type, buttons, inputs, cards and one realistic section for the chosen surface). Follow [references/example-html.md](references/example-html.md).

## Quality Pass

Before finalizing `molten-docs/design/design.md`, verify:

- YAML front matter is valid (matching `---` fences, no duplicate keys).
- Sections appear in spec order (Overview, Shared Core, Colors, Typography, Layout, Elevation & Depth, Shapes, Components, Do's and Don'ts), with extensions appended after.
- A `primary` color is defined (linter warns otherwise).
- All `{token.path}` references resolve to a defined token.
- WCAG AA contrast holds for every text/background pair used by components.
- No more than two font families.
- 8-12 typography levels by default, each with a clear role.
- Component variants use sibling keys (`button-primary-hover`), not nesting.
- Do's and Don'ts is five rules and each is specific (no vague taste words).
- Brand strategy, persona, and voice are *not* defined here; they live in `molten-docs/brand/brand.md`.
- The chosen design surface (landing page, web product, mobile product, or desktop product) is stated in Overview and Assumptions; the current pass does not try to serve multiple surfaces at once.
- Shared core decisions are labeled and preserved when extending an existing `design.md`.
- Surface-layer decisions match the selected reference file.
- Every decision the user delegated via "Choose for me" appears in the *Assumptions* section with the one-sentence rationale that was given at the time.
- If a Pinterest reference was confirmed, the *Assumptions* section records the adopted visual signals in one line.
- Remaining assumptions are explicitly listed.
- `molten-docs/design/example.html` exists and is self-contained.
- The preview uses CSS variables that match the finalized `design.md` tokens.
- The preview includes swatches, type samples, buttons, inputs, cards, and one realistic combined UI section.
- The preview is clearly documentation, not production app code.

If `npx @google/design.md` is available, suggest the user run:

```bash
npx @google/design.md lint molten-docs/design/design.md
```

If linter findings appear, walk through them with the user before treating the file as final.

## Reference

For deeper background on the spec, token schema, linter rules, and authoring principles, see the project's `design-md-research.md` if present, or the canonical spec at [https://github.com/google-labs-code/design.md](https://github.com/google-labs-code/design.md).