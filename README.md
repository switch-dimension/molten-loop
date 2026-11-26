# Molten Loop - Idea in, shipped feature out

![Molten Loop](assets/molten-loop-header.png)

### Validate the idea, give it a brand and a landing page, then build it with your coding agent using a disciplined loop: discovery, spec, plan, build, verify, review, ship.

Molten Loop is a set of AI agent skills from [Switch Dimension](https://switchdimension.com) and AI builder YouTuber [Rob Shocks](https://youtube.com/robshocks). It splits the work into two disciplines:

- **Product Engineering: are we building the right thing?** Challenge the idea, then give it a brand, a design system and a landing page to test with real people.
- **Software Engineering: are we building it well?** Run each feature through the Agent Development Loop. Your coding agent discovers and specs the feature, plans it, builds it in thin tested slices, proves every acceptance criterion, reviews the change, ships it as a clean, secret-scanned pull request, and runs a retro that improves the loop for next time.

Drop this prompt into your AI agent to get started:

```
install all the skills in this repo to my project, then run mt-guide to add the Molten Loop section to my AGENTS.md - https://github.com/switch-dimension/molten-loop
```

Not sure where to start? Ask your agent to run **mt-guide**. It reads your `molten-docs/` folder, tells you where you are and recommends the next skill. It also offers to add a short Molten Loop section to your `AGENTS.md` (and point `CLAUDE.md` at it), so every agent session knows the skills are there and follows the loop.

> Released under the MIT license — copy it, fork it, and use it as inspiration for your own evolving system. [Full install options below.](#installation)

## What you get

Every skill writes its output as Markdown under `molten-docs/`, so each step builds on the last and you (or another agent) can pick up where you left off.

| Discipline | Skills | You end up with |
| --- | --- | --- |
| **Product Engineering** (once per product) | mt-validate → mt-brand → mt-design → mt-landing | A validated idea and a landing page to test it |
| **Software Engineering** (once per feature) | mt-discovery → mt-spec → mt-plan → mt-build → mt-verify → mt-review → mt-ship, plus optional mt-prototype and mt-auto (auto mode) | A reviewed, secret-scanned pull request with evidence for every acceptance criterion |
| **Utility skills** | mt-guide, mt-ask, mt-search, mt-skill-manage | Routing, discussion, research and skill management. Start with **mt-guide** if you're unsure which skill to use |

You don't need both. Testing an idea? Use Product Engineering on its own. Working in an existing codebase? Run Software Engineering once per feature.
## Product Engineering

Most AI-built products fail by building the wrong thing. These skills turn a raw idea into a validated landing page you can test with real people — score, brand, design system and page — in an afternoon, not a quarter. Run them in order.

| Step | Skill | What it does for you |
| --- | --- | --- |
| 1 | **mt-validate** | Adversarially scores a product idea with quick, full-interview or re-validation modes and names the riskiest assumption to test. Writes `molten-docs/validate/product-score-N.md`. |
| 2 | **mt-brand** | Pins down who you're for, the pain you solve, your positioning, message and voice. Writes `molten-docs/brand/brand.md`. |
| 3 | **mt-design** | Turns that brand into a practical design system for one surface at a time (landing, web, mobile or desktop) plus a live visual preview. Writes `molten-docs/design/design.md`. |
| 4 | **mt-landing** | Creates (or audits) a high-converting landing page from your brand and design system, so you can test the idea with an audience fast. |

### Why validate before building?

A good validation pass and landing page force you to answer the questions that decide whether a product works: **who** is this for, **what** pain are they feeling, **why** does it matter to them right now, and **how** does your product remove it?

Add a waitlist or a paid pre-order and you get the only feedback that counts: will people act? You learn that **before** you commit months to building the wrong thing.

## Software Engineering

Your coding agent is the production line. The Agent Development Loop takes one feature from a vague request to a pull request you can trust, the same way every time. Run the steps in order. The early steps pick up `brand.md` and `design.md` when they exist, so what you build matches what you tested.

| Step | Skill | What it does for you |
| --- | --- | --- |
| 1 | **mt-discovery** | Interviews you before any code is written: goals, users, constraints, codebase context and the riskiest unknown. Writes `01-discovery.md`. |
| optional | **mt-prototype** | See or test the feature before you spec it. Mainly a clickable UX mockup with mocked data and a fake API, either throwaway or as real pages in your app. When the risk is technical, it builds a time-boxed prototype that answers one feasibility question instead. Writes `02-prototype.md`. |
| 2 | **mt-spec** | Turns discovery (and any prototype or mockup learnings) into a testable spec with acceptance criteria, data shape, edge cases and non-goals. Writes `03-spec.md`. |
| 3 | **mt-plan** | Breaks the spec into ordered vertical-slice tasks with checkpoints, grouped into parallel waves so several agents or people can work at once. Says whether the feature needs a database branch. Writes `04-plan.md`. |
| 4 | **mt-build** | Implements the plan one slice at a time on a feature branch with a lightweight red-green-refactor loop, keeping the app runnable. Creates a database branch only when the plan requires one, and gives parallel agents their own worktrees. |
| 5 | **mt-verify** | Checks every acceptance criterion against evidence (tests, the real app) and debugs failures from root cause. Writes `05-verify.md`. |
| 6 | **mt-review** | Reviews the change with two fresh-context reviewers, Spec and Quality (correctness, readability, architecture, security, performance), and checks each finding against the code. Optional second opinion from another model. Writes `06-review.md`. |
| 7 | **mt-ship** | Re-runs build, tests, lint and type-check, scans the branch for secrets with gitleaks, audits dependencies, tidies commits, updates docs and changelog, writes the PR with evidence and a "merge danger" call, and watches CI and the preview deploy. It never merges. Writes `07-ship.md`. |
| auto mode | **mt-auto** | Runs the rest of the loop unattended, from a brief or from wherever the feature is, up to an open PR. Logs every decision it made for you in `auto.md` and pauses only for what it must not decide. See [Auto mode](#auto-mode). |

Each run of the loop, whether it's a feature, a fix or a refactor, gets one folder, with its docs numbered in loop order:

```
molten-docs/loop/invite-members/
  01-discovery.md
  02-prototype.md    # only if you ran mt-prototype
  03-spec.md
  04-plan.md
  05-verify.md
  06-review.md
  07-ship.md
  08-retro.md
  auto.md            # only if you ran mt-auto
```

Skip mt-prototype if the shape and feasibility are already clear. Already have a spec? Put it in `molten-docs/loop/<slug>/03-spec.md` and start at **mt-plan**.

### Auto mode

Don't want to answer every question? Hand the feature to **mt-auto** and come back to a pull request. It runs the same skills and writes the same docs, but each step answers its own questions from your code and docs and writes down what it chose.

- **From the start:** "run mt-auto: let team owners invite members by email".
- **Part-way through:** run **mt-discovery** yourself so the problem comes from you, then say "run mt-auto" or "auto from here".

mt-auto asks everything it needs in one message (the brief, how far to go, and whether it may push), then works quietly. Every decision it made for you goes into `molten-docs/loop/<slug>/auto.md`, with how hard each one is to undo, and the PR links to it. It never merges, deploys or force-pushes. It pauses instead of guessing when scope would change, a secret turns up, something irreversible is next, access is missing, or fixes keep failing. Run mt-auto again to answer and resume, or say "stop auto mode" to take over by hand.

### The loop improves itself

Every **mt-ship** run ends with a retro (`08-retro.md`). It looks at what slowed the feature down or slipped through (a missing check, an unclear doc, a skill step that misfired) and suggests concrete fixes, so each feature leaves the loop a little better than it found it.

### Issue trackers

The first time **mt-plan** runs, it looks for GitHub Issues, Linear or Jira, confirms the choice with you, and saves it in `molten-docs/config.md`. From then on, mt-plan creates one issue per task, mt-build closes them as tasks go green, mt-verify and mt-review post their verdicts, and mt-ship links the PR so the feature closes on merge.

No tracker? The plan file holds the tasks and they're ticked off as they're done.

## Utility skills

Cross-cutting helpers. Install and use as needed.

| Skill | What it does for you |
| --- | --- |
| **mt-guide** | The "start here" router. Reads `molten-docs/` to show where each feature is and what comes next, or asks a few questions and recommends the right skill, including shortcuts for small fixes, bugs and reviews. |
| **mt-ask** | Discussion only. Talks a topic through briefly without touching files or starting implementation, until you say to build. Like Cursor's Ask mode, in any agent. |
| **mt-search** | Routes search and research queries to the right backend: quick web lookup, recent social pulse, platform-specific fetch or cited web research. Handy during validation and discovery. |
| **mt-skill-manage** | Manages skills via the skills.sh CLI (`npx skills`): install, update, remove, list and find skills. |

## Installation

Paste this repo into your agent with the prompt above, or install manually with the [skills.sh](https://github.com/vercel-labs/skills) CLI.

Install all skills:

```bash
npx skills add switch-dimension/molten-loop
```

Install Software Engineering only, plus mt-guide. Drop `mt-prototype` or `mt-auto` if you don't want the optional step or auto mode:

```bash
npx skills add switch-dimension/molten-loop --skill mt-guide mt-discovery mt-prototype mt-spec mt-plan mt-build mt-verify mt-review mt-ship mt-auto
```

Install Product Engineering only, plus mt-guide:

```bash
npx skills add switch-dimension/molten-loop --skill mt-guide mt-validate mt-brand mt-design mt-landing
```

Install a single skill:

```bash
npx skills add switch-dimension/molten-loop --skill mt-landing
```

All skills use the **`mt-<name>`** convention so they are easy to distinguish from third-party skills in `npx skills ls`.

### Claude Code plugin

In Claude Code you can install Molten Loop as a plugin instead:

```
/plugin install molten-loop --marketplace switch-dimension/molten-loop
```

### Updating

**mt-guide** checks for a new Molten Loop release once per session and offers to update you. To update yourself:

```bash
npx skills update            # skills.sh installs (add -g for global installs)
```

For a Claude Code plugin install, run `claude plugin update molten-loop@molten-loop` and restart Claude Code, or turn on auto-update for the marketplace in `/plugin`. Read the [changelog](CHANGELOG.md) before a major version: it lists breaking changes.

## Changelog

Release history and version notes: [CHANGELOG.md](CHANGELOG.md). Current release: **v3.1.0**.

## License

Released under the [MIT License](LICENSE). You may use, copy, modify, merge, publish, distribute, sublicense, and sell copies, provided the license and copyright notice are included in redistributions.
