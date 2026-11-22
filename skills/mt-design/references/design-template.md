# design.md template

When enough information is gathered, write the file at **`molten-docs/design/design.md`** with this structure. The YAML front matter is normative; the prose is rationale.

The file should clearly separate:

- **Shared core:** reusable brand system tokens and principles that should remain stable across landing, web, mobile, and desktop surfaces.
- **Surface layer:** the chosen surface's layout, density, component priorities, and preview guidance.

```markdown
---
version: alpha
name: [Design System Name]
description: [One sentence describing the system]
colors:
  primary: "#RRGGBB"
  secondary: "#RRGGBB"
  tertiary: "#RRGGBB"
  neutral: "#RRGGBB"
  surface: "#RRGGBB"
  on-surface: "#RRGGBB"
  error: "#RRGGBB"
typography:
  headline-display:
    fontFamily: [Family]
    fontSize: [Size]
    fontWeight: [Weight]
    lineHeight: [Line height]
    letterSpacing: [Tracking]
  headline-lg:
    fontFamily: [Family]
    fontSize: [Size]
    fontWeight: [Weight]
    lineHeight: [Line height]
  body-md:
    fontFamily: [Family]
    fontSize: 16px
    fontWeight: 400
    lineHeight: 1.6
  label-md:
    fontFamily: [Family]
    fontSize: 14px
    fontWeight: 600
    lineHeight: 1
    letterSpacing: 0.02em
  label-sm:
    fontFamily: [Family]
    fontSize: 12px
    fontWeight: 500
    lineHeight: 1
    letterSpacing: 0.05em
rounded:
  none: 0px
  sm: 4px
  md: 8px
  lg: 12px
  full: 9999px
spacing:
  base: 8px
  xs: 4px
  sm: 8px
  md: 16px
  lg: 32px
  xl: 64px
  gutter: 24px
  margin: 32px
components:
  button-primary:
    backgroundColor: "{colors.primary}"
    textColor: "{colors.on-surface}"
    typography: "{typography.label-md}"
    rounded: "{rounded.md}"
    padding: 12px
  button-primary-hover:
    backgroundColor: "{colors.tertiary}"
---

# [Design System Name]

Visual identity for [product name]. Pairs with `molten-docs/brand/brand.md` for brand strategy and voice.

## Overview

[Holistic description of look and feel. Personality, target audience, emotional response. Reference brand.md. State the design surface — landing page, web product, mobile product, or desktop product — and what this system optimizes for.]

## Shared Core

[Describe the stable cross-surface choices: color philosophy, type family pairing, radius philosophy, spacing base, motion posture, iconography posture, and accessibility defaults. If this file inherited an existing shared core, say so.]

## Colors

[Shared core. Prose describing each key palette with its role. One bullet per palette, named with descriptive language (e.g. "Midnight Forest Green") and the hex from tokens.]

- **Primary (#RRGGBB):** [Role and when to use]
- **Secondary (#RRGGBB):** [Role and when to use]
- **Tertiary (#RRGGBB):** [Role and when to use]
- **Neutral (#RRGGBB):** [Role and when to use]

## Typography

[Shared core. Prose describing the type strategy. Family choices and their roles.]

- **Headlines:** [Family, weight, voice it creates]
- **Body:** [Family, size, readability decisions]
- **Labels:** [Family, treatment, where it appears]

## Layout

[Surface layer. Grid model, max width, spacing rhythm, containment strategy for the chosen surface. Use the selected `references/*.md` file.]

## Elevation & Depth

[How visual hierarchy is conveyed. Shadows, borders, tonal layers, or flat.]

## Shapes

[Corner radius philosophy and where deviations occur.]

## Components

[Surface layer. Per-component prose: anatomy, variants, states, accessibility notes. Token specifics live in front matter. Include only components relevant to the chosen surface from the selected reference — e.g. hero/CTA/proof for landing page; nav/forms/tables for web product; tab bar/list rows/FAB for mobile product; window chrome/menus/panes for desktop product.]

### Buttons

- Anatomy: [parts]
- Variants: [primary, secondary, ...]
- States: default, hover, focus, active, disabled
- Accessibility: [target size, focus ring, ARIA]

### Input Fields

[Same structure]

### Cards

[Same structure]

## Do's and Don'ts

- Do [specific rule]
- Do [specific rule]
- Don't [specific rule]
- Don't [specific rule]
- Don't [specific rule]

## Motion & Animation

[Optional. Only if defined.]

## Iconography

[Optional. Only if defined.]

## Accessibility

[Optional. Minimum contrast, focus rings, target sizes, reduced-motion.]

## Open Questions And Assumptions

### Open Questions
- [Question that still needs a user decision]

### Assumptions
- [Assumption made due to missing information]
- [Design surface: chosen surface]
- [Shared core: newly created or inherited from existing design.md]

### Next Step
Reference `molten-docs/design/design.md` from your agent config (CLAUDE.md, AGENTS.md, `.cursor/rules/`) so it loads every session. Validate with `npx @google/design.md lint molten-docs/design/design.md`.
```
