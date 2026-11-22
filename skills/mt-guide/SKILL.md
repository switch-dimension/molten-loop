---
name: mt-guide
description: "Molten Loop — the \"start here\" router. Reads `molten-docs/` to show where each feature is and recommends the next skill, and can add a Molten Loop section to `AGENTS.md`. Use for \"what's next\", \"where do I start\", which skill to use, or setting up Molten Loop."
metadata:
  author: switch-dimension
  version: "0.7.0"
  molten-suite: molten-os
  molten-category: utility
  molten-tier: core
---

# Molten Guide

Router only. Work out where the user is, recommend **one** next skill, say why, then hand off. Do not do the work of the skill you recommend.

**Input path:** `molten-docs/` at the repository root (read-only).

**Output:** a short recommendation in chat. The only file this skill writes is the Molten Loop section of `AGENTS.md` (see AGENTS.md setup), and only when the user agrees.

## Operating Rules

- **Read before you describe.** The summaries below are for orientation only. Before telling the user what a skill does, or recommending that a step be skipped, read that skill's `SKILL.md`.
- **Only route to installed skills.** Check which `mt-*` skills are available. If the best fit is not installed, say so and give the install command: `npx skills add switch-dimension/molten-loop --skill <name>`.
- **State first, questions second.** If `molten-docs/` answers the question, do not ask.
- Ask at most three questions, as plain numbered text in chat; for finite choices, list lettered options under the question (1a, 1b, 1c). Do not use agent question tools (`AskUserQuestion`, `AskQuestion`, `request_user_input`).
- Recommend one next skill. Mention an optional step only when it clearly earns its cost.
- Do not recap whole documents. Point to the file paths.
## Workflow

1. **Read the project state.** Scan `molten-docs/` (see State map). Each folder under `molten-docs/loop/` is one run of the loop; its highest-numbered file is the furthest step reached. Read that file's front matter (`status`, `verdict`, `recommendation`, `molten_next_skill`). Read task status from the task source (see `mt-plan/references/trackers.md` → Task source). With `tracker_sync: true` in `molten-docs/config.md`, that is the tracker, read using the operations listed there; the plan then only links to issues. Otherwise it is the plan's checkboxes. Mention which tasks are in progress, done, and ready in the current wave.
2. **If there is state, report it and recommend.** Give a short status per active feature, then the next skill. Example:
   > **checkout** — spec approved, plan 3 of 7 tasks done.
   > **Next:** mt-build, starting at task 1.4. It reads `molten-docs/loop/checkout/04-plan.md`.
   If several features are in flight, list each in one line and ask which one to continue.
3. **If there is no state (or the user wants something new), ask.** Pick only the questions you need:
   1. What are you trying to do?
      - 1a. Test whether an idea is worth building
      - 1b. Build a feature or product
      - 1c. Fix something that's broken
      - 1d. Review a change before it merges
      - 1e. Something else (search, manage skills)
   2. Is there an existing codebase?
   3. How big is it? (a. tiny, under an hour · b. a feature · c. a whole product)
4. **Route** using the Skill map and Shortcuts.
5. **Hand off.** Use the Recommendation format, then offer to start the recommended skill.
6. **Check AGENTS.md.** If `AGENTS.md` at the repository root has no `## Molten Loop skills` heading, add one line after the recommendation: "Want me to add a short Molten Loop section to `AGENTS.md` so every agent session knows these skills are here?" Ask once per session, and not if the user declined before.

## AGENTS.md setup

When the user asks to set up Molten Loop, asks to add it to `AGENTS.md`, or says yes to the offer in Workflow step 6, follow `references/agents-md.md`. It holds the section to add, how to create, append or update it, and the `CLAUDE.md` pointer for Claude Code.

## Skill map

Molten Loop splits into two disciplines. **Product Engineering** decides whether the product is worth building: validate → brand → design → landing, once per product. **Software Engineering** builds each feature through the Agent Development Loop: discovery → spec → plan → build → verify → review → ship.

### Product flow (Product Engineering) — idea to a testable landing page

Run in order. For testing an idea with real people before building.

1. **mt-validate** — adversarially score the idea; name the riskiest assumption. → `molten-docs/validate/product-score-N.md`
2. **mt-brand** — audience, pain, positioning, message, voice. → `molten-docs/brand/brand.md`
3. **mt-design** — design system for one surface (landing, web, mobile, desktop). → `molten-docs/design/design.md`
4. **mt-landing** — build or audit a landing page from brand and design.

### Agent Development Loop (Software Engineering) — feature to merged code

Run in order, once per feature. A user who already has a spec can start at step 3.

1. **mt-discovery** — interview before code; find the riskiest unknown. → `molten-docs/loop/<slug>/01-discovery.md`
2. **mt-spec** — testable spec with acceptance criteria. → `molten-docs/loop/<slug>/03-spec.md`
3. **mt-plan** — vertical-slice tasks with checkpoints. → `molten-docs/loop/<slug>/04-plan.md`
4. **mt-build** — implement one slice at a time, test first; records task status in the task source (tracker issues, or the plan when there's no tracker).
5. **mt-verify** — prove every acceptance criterion with evidence; debug failures. → `molten-docs/loop/<slug>/05-verify.md`
6. **mt-review** — pre-merge review by fresh-context Spec and Quality reviewers, with severity-labelled findings. → `molten-docs/loop/<slug>/06-review.md`
7. **mt-ship** — final gates (build, tests, gitleaks, audit), tidy, PR, tracker close-out, then a short retro. Never merges. → `molten-docs/loop/<slug>/07-ship.md`, `molten-docs/loop/<slug>/08-retro.md`

**Optional detour between discovery and spec.** Skip it when the shape and feasibility are already clear.

- **mt-prototype** — a clickable UX mockup with fake data (default), or a time-boxed technical prototype for one risky feasibility question. → `molten-docs/loop/<slug>/02-prototype.md`

### Where the flows meet

The spec is the handoff between the two disciplines. The product flow feeds the dev loop: mt-discovery, mt-prototype and mt-spec pick up `brand.md` and `design.md` when they exist. Neither flow requires the other: the dev loop works on its own in any codebase.

### Utility — any time

- **mt-search** — route a search or research query (competitors, prior art, recent discussion).
- **mt-skill-manage** — install, update, remove or find skills.
- **mt-guide** — this skill.

## State map

| Found in `molten-docs/` | Means | Recommend |
| --- | --- | --- |
| Nothing | Fresh start | Ask (Workflow step 3) |
| `validate/` only | Idea scored | Read the latest score's verdict. Promising → **mt-brand**. Weak → re-run the experiment, then **mt-validate** (re-validate mode) |
| `brand/brand.md`, no `design/` | Brand done | **mt-design** |
| `design/design.md` | Design system done | **mt-landing**, or **mt-discovery** if they're ready to build |
| `loop/<slug>/01-discovery.md` only | Feature explored | Its `molten_next_skill` (default **mt-spec**) |
| `loop/<slug>/02-prototype.md`, no spec | Detour done | **mt-spec** |
| `loop/<slug>/03-spec.md` `status: draft` | Spec unfinished | **mt-spec** to finish and approve |
| `loop/<slug>/03-spec.md` `status: approved`, no plan | Ready to plan | **mt-plan** |
| `loop/<slug>/04-plan.md` `draft` | Plan unfinished | **mt-plan** to finish and approve |
| `loop/<slug>/04-plan.md` `approved` / `in-progress` | Building | **mt-build**, from the next ready task (lowest wave, not claimed). Read status from the task source: issues with a tracker, plan checkboxes without |
| `loop/<slug>/04-plan.md` `done`, no verify | Built | **mt-verify** |
| `loop/<slug>/05-verify.md` `verdict: fail` / `partial` | Not proven | **mt-build** to fix, then **mt-verify** again |
| `loop/<slug>/05-verify.md` `verdict: pass`, no review | Proven | **mt-review** |
| `loop/<slug>/06-review.md` `request-changes` | Changes needed | **mt-build** for the fixes, then **mt-verify** and **mt-review** |
| `loop/<slug>/06-review.md` `approve` / `approve-with-suggestions`, no ship | Ready to ship | **mt-ship** |
| `loop/<slug>/07-ship.md` `result: blocked` | Ship gate failed | The skill named under "Blocked on" (usually **mt-build** → **mt-verify**), then **mt-ship** again |
| `loop/<slug>/07-ship.md` `result: pr-open` | PR open | Human merges; then **mt-discovery** for the next feature |

If an artifact's front matter has `molten_next_skill`, prefer it over this table unless its status says the step is unfinished.

### Older layout

Before v3, loop docs lived in one folder per step (`molten-docs/discovery/<slug>.md`, `molten-docs/spec/<slug>.md`, and so on, with prototype code in `molten-docs/prototype/<slug>/`). If you find any of those folders, offer to move them to the current layout, show the moves first, and use `git mv` so history follows:

| Old | New |
| --- | --- |
| `discovery/<slug>.md` | `loop/<slug>/01-discovery.md` |
| `prototype/<slug>.md` (or `mockup/<slug>.md`) | `loop/<slug>/02-prototype.md` |
| `prototype/<slug>/` (or `mockup/<slug>/`) | `loop/<slug>/prototype/` |
| `spec/<slug>.md` | `loop/<slug>/03-spec.md` |
| `plan/<slug>.md` | `loop/<slug>/04-plan.md` |
| `verify/<slug>.md` | `loop/<slug>/05-verify.md` |
| `review/<slug>.md` | `loop/<slug>/06-review.md` |
| `ship/<slug>.md` | `loop/<slug>/07-ship.md` |
| `retro/<slug>.md` | `loop/<slug>/08-retro.md` |

Then update the paths inside the moved files' front matter (`discovery:`, `spec:`, `prototype:` and similar). Until the user agrees, read the old layout as if it were the new one.

## Shortcuts

Not every job needs the whole loop. Use these when they fit:

| Situation | Route |
| --- | --- |
| Tiny, obvious change | **mt-build** with a one-line plan in chat |
| Something is broken | **mt-verify** (debugs from root cause) → **mt-build** for the fix → **mt-review** |
| A diff or PR to check | **mt-review** |
| Approved branch, just needs a PR | **mt-ship** |
| Spec already written elsewhere | **mt-plan** (point it at that spec) |
| Turn a spec into tickets or issues | **mt-plan** (creates issues in GitHub, Linear or Jira on approval) |
| Clear feature, no unknowns | **mt-discovery** → **mt-spec**, skip mt-prototype |
| Existing landing page to improve | **mt-landing** (audit mode) |
| Only need research | **mt-search** |

## Recommendation format

```markdown
**Where you are:** <one line, or "Fresh start">
**Next:** <skill> — <why, in one sentence>
**It reads:** <input paths, or "nothing yet">
**It writes:** <output path>
**Optional:** <one detour worth considering, or omit this line>
```

Then ask: "Want me to start **<skill>** now?"

## Checklist

- [ ] Read `molten-docs/` before asking anything
- [ ] Read the recommended skill's `SKILL.md` before describing it or suggesting a step be skipped
- [ ] Checked the recommended skill is installed (or gave the install command)
- [ ] One clear next skill, in the recommendation format- [ ] No files written, except the `AGENTS.md` section after the user agreed
