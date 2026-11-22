---
name: mt-spec
description: "Molten Loop — Agent Development Loop step 2. Turns discovery (and any prototype) into a testable spec: acceptance criteria, data shape, edge cases and non-goals. Writes `molten-docs/loop/<slug>/03-spec.md`. Use for a spec, PRD, requirements or acceptance criteria. Not for task breakdown (use mt-plan)."
metadata:
  author: switch-dimension
  version: "0.5.0"
  molten-suite: molten-os
  molten-category: dev-loop
  molten-tier: core
  molten-order: "2"
---

# Spec

Define **what** will be built and how we'll know it works — before any code. The spec is the contract between the human and the agent doing the implementation, and the thing every later step (plan, build, verify, review) is checked against.

**Input paths:** `molten-docs/loop/<slug>/01-discovery.md` (from **mt-discovery**), plus the optional `molten-docs/loop/<slug>/02-prototype.md` (from **mt-prototype**, either a UX mockup or a technical prototype) when present. If neither exists, gather the essentials directly or offer to run **mt-discovery** first.

**Output path (canonical):** `molten-docs/loop/<slug>/03-spec.md`. Create the folder if it does not exist.

**Next skill:** **mt-plan**.

## Operating Rules

- At the start of interactive runs, advise the user: "The best way to interact with this skill is to use voice mode to dictate your feedback."
- **Auto mode.** When `molten-docs/loop/<slug>/auto.md` has `status: running` (see **mt-auto**), follow `mt-auto/references/auto-mode.md`: record assumptions instead of confirming them, review the gaps yourself, and set `status: approved` with `approved_by: auto`. A gap you can't close without changing the brief's scope is a hard stop.
- Describe behaviour, not implementation. Leave file-level and task-level decisions to **mt-plan**.
- Every requirement must be testable. Rewrite vague requirements ("fast", "intuitive") into observable criteria, and give each acceptance criterion an ID (AC-1, AC-2 …) so the plan and verification can reference it.
- Surface assumptions early. List what you are assuming and let the user correct it before drafting further.
- Carry forward prototype and mockup decisions (including the mockup's implied data contract); flag any spec item that contradicts them.
- Keep open questions visible — do not silently resolve them with guesses.
- Keep the spec a living document: if scope changes during later steps, update the spec first.
- Ask every question as plain numbered text in chat; for finite choices, list lettered options under the question (1a, 1b, 1c). Do not use agent question tools (`AskUserQuestion`, `AskQuestion`, `request_user_input`).
- Do not write application code while this skill is active.

## Workflow

1. Read discovery, any prototype learnings, and relevant code.
2. **List assumptions** (stack, scope, users, data) and confirm them with the user.
3. Draft the spec using the template below.
4. Review gaps with the user: missing edge cases, unclear acceptance criteria, unresolved questions, anything that crosses a boundary.
5. Finalise and write the spec; point the user to the file. Set `status: approved` only on explicit sign-off.

## Output template

```markdown
---
feature: <name>
slug: <slug>
created: <YYYY-MM-DD>
status: draft | approved
approved_by: user | auto
discovery: molten-docs/loop/<slug>/01-discovery.md
prototype: molten-docs/loop/<slug>/02-prototype.md | null
molten_next_skill: mt-plan
---

# Spec — <name>

## Summary
## Goals
## Non-goals
## Assumptions
## User stories
## Functional requirements
## Acceptance criteria (Given / When / Then)
- **AC-1** …
## Data model & API shape
## UX notes (link design.md / prototype / mockup where relevant)
## Edge cases & error states
## Non-functional requirements (performance, security, accessibility)
## Testing approach (what is unit, integration, end-to-end, manual)
## Boundaries
- **Always:** …
- **Ask first:** … (e.g. schema changes, new dependencies)
- **Never:** … (e.g. touching billing, committing secrets)
## Open questions
```

## Done checklist

- [ ] Assumptions listed and confirmed
- [ ] Every requirement has at least one numbered acceptance criterion
- [ ] Non-goals and boundaries listed
- [ ] Edge cases and error states covered
- [ ] Testing approach stated
- [ ] Open questions visible, not guessed
- [ ] `molten-docs/loop/<slug>/03-spec.md` written; status set to `approved` once the user signs off

## Extending

Common additions: an API contract section (OpenAPI/types), a threat-model pass, an ADR-style "decisions" section, or a Linear/GitHub issue export of the acceptance criteria.
