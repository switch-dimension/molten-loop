# example.html preview

After writing `molten-docs/design/design.md`, create **`molten-docs/design/example.html`** as a human-readable preview of the design system.

Purpose:

- Make the abstract design tokens tangible for non-designers.
- Give the user something they can open immediately in a browser.
- Help future agents understand the intended look and feel from a visual specimen.

Rules:

- Keep it self-contained: one HTML file with inline CSS. Do not require a framework, build step, package install, CDN, or external assets.
- Use CSS custom properties derived from the finalized tokens in `design.md`.
- Do not create production app code. This is documentation and a preview only.
- Keep the example polished but small enough to scan quickly.
- If a token is missing or ambiguous, use the assumption already recorded in `design.md`; do not ask another question just for the preview.

The preview should include:

- A short title and one-sentence design thesis (name the design surface).
- Color swatches with token names and hex values.
- Typography samples for display/headline, body, label, and caption styles.
- Button examples: primary, secondary, destructive, disabled, and focus-visible.
- Input examples: default, focused, error, and disabled (web and mobile product surfaces).
- Card examples showing spacing, radius, borders, shadows, and content hierarchy.
- One realistic combined UI section scoped to the chosen surface:
  - **Landing page:** hero + CTA + one proof/feature section
  - **Web product:** nav/sidebar slice with cards, form, or table
  - **Mobile product:** phone-width frame (~390px), status/header area, list or tab bar, thumb-friendly controls
  - **Desktop product:** desktop-width app window with title/menu area, sidebar or split pane, and keyboard-oriented control surface

Use this structure:

```html
<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>[Design System Name] Preview</title>
    <style>
      :root {
        --color-primary: [value from design.md];
        --color-secondary: [value from design.md];
        --color-tertiary: [value from design.md];
        --color-neutral: [value from design.md];
        --color-surface: [value from design.md];
        --color-on-surface: [value from design.md];
        --color-error: [value from design.md];
        --font-body: [font stack from design.md];
        --radius-sm: [value from design.md];
        --radius-md: [value from design.md];
        --space-sm: [value from design.md];
        --space-md: [value from design.md];
        --space-lg: [value from design.md];
      }
    </style>
  </head>
  <body>
    <!-- Preview content goes here. -->
  </body>
</html>
```

Prefer real-looking labels over placeholders. For example, "Start project", "Book a demo", "Email address", and "Launch readiness" are better than "Button" or "Card title".
