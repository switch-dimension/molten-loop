---
name: mt-prototype
description: "Molten Loop — optional step before the spec. Builds a clickable UX mockup with fake data (default) or a time-boxed technical prototype for one feasibility question. Writes `molten-docs/loop/<slug>/02-prototype.md`. Use to mock up, wireframe, preview the UX, spike or de-risk a feature. Not for production code (use mt-build)."
metadata:
  author: switch-dimension
  version: "0.6.0"
  molten-suite: molten-os
  molten-category: dev-loop
  molten-tier: core
  molten-optional: "true"
---

# Prototype

Build the cheapest thing that lets the user see or test the feature before anyone pays for production code. The output is learning, not shippable software.

**Optional step.** Run this only when discovery leaves a real unknown. If the shape and feasibility are already clear, skip straight to **mt-spec**.

**Input paths (all optional):** `molten-docs/loop/<slug>/01-discovery.md` from **mt-discovery**, `molten-docs/design/design.md` from **mt-design**, `molten-docs/brand/brand.md` from **mt-brand**. If no discovery doc exists, ask what the user wants to see or test (or offer to run **mt-discovery** first).

**Output paths (canonical):**

- Throwaway code: `molten-docs/loop/<slug>/prototype/` (or a clearly named throwaway branch or folder the user chooses)
- Scaffolded mockup pages: the project's own frontend, on a branch
- Decisions and learnings: `molten-docs/loop/<slug>/02-prototype.md`

**Next skill:** **mt-spec**.

## Choose the path

Read the discovery doc and name the riskiest unknown. Then pick the path, confirming with the user unless it is obvious:

| Path | Use when | The question it answers | Read |
| --- | --- | --- | --- |
| **Mockup** (default) | The risk is the user experience: screens, flows, states, copy, layout | "Is this the right experience?" | `references/mockup.md` |
| **Prototype** | The risk is technical: an API, library, integration, performance or algorithm that might not work | "Can this be built the way we think?" | `references/prototype.md` |

If both are risky, do the prototype first: a mockup of something that can't be built wastes the user's time. Read only the reference file for the chosen path.

## Operating Rules

- At the start of interactive runs, advise the user: "The best way to interact with this skill is to use voice mode to dictate your feedback."
- **Auto mode.** When `molten-docs/loop/<slug>/auto.md` has `status: running` (see **mt-auto**), follow `mt-auto/references/auto-mode.md` and take only the prototype path: a feasibility question can be answered without a person, an experience can't. If the risk is UX, skip the mockup and record that as an assumption for the spec. Where the workflow says to show the user, record what you ran and what you saw.
- Confirm what you are building and what "done" looks like before writing code.
- Use the cheapest medium that works. No auth, no real credentials, no polish beyond what the question needs.
- Keep throwaway code isolated from production code and never merge it in as-is. Its lasting outputs are the decisions, not the code.
- If `molten-docs/design/design.md` exists, use its tokens for any UI.
- Stop once the question is answered or the user is happy with the experience.
- Ask every question as plain numbered text in chat; for finite choices, list lettered options under the question (1a, 1b, 1c). Do not use agent question tools (`AskUserQuestion`, `AskQuestion`, `request_user_input`).

## Workflow

1. Read the inputs, name the riskiest unknown, and choose the path.
2. Follow the workflow in the chosen reference file.
3. Show it to the user (or run it with them) and iterate.
4. Write `molten-docs/loop/<slug>/02-prototype.md` using the template below, and point the user to it and to **mt-spec**.

## Output template

```markdown
---
feature: <name>
slug: <slug>
created: <YYYY-MM-DD>
type: mockup | prototype
discovery: molten-docs/loop/<slug>/01-discovery.md | null
design: molten-docs/design/design.md | null
mode: throwaway | scaffold            # mockup only
location: <path, routes, or branch>
branch: <branch name> | null
molten_next_skill: mt-spec
---

# Prototype — <name>

## Question (what this set out to show or test)
## How to run it
## What was built (medium, shortcuts taken, what was deliberately faked)
## Result — answered? yes / partially / no
## Decisions for the spec
<!-- Path-specific sections from the reference file go here -->
## Open questions for the spec
```

## Done checklist

- [ ] Path (mockup or prototype) and the question confirmed before building
- [ ] Throwaway code isolated from production code; scaffolded code on a branch
- [ ] User has seen, clicked through, or run it, and feedback has been applied
- [ ] Path-specific checklist in the reference file is complete
- [ ] `molten-docs/loop/<slug>/02-prototype.md` written with decisions for the spec
