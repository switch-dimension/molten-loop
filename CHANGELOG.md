# Changelog

All notable changes to [Molten Loop](https://github.com/switch-dimension/molten-loop) are documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## Version guidance

| Tag | When to use |
| --- | --- |
| **`v3.0.0`** (recommended) | Loop docs in one numbered folder per run: `molten-docs/loop/<slug>/`. mt-ship offers to create a changelog. |
| **`v2.0.0`** | Molten Loop: the Agent Development Loop, skills renamed to `mt-*`, mt-mockup merged into mt-prototype. |
| **`v1.3.1`** | README product/utility split and `molten-category` metadata. |
| **`v1.3.0`** | Adds `molten-search` search router skill. |
| **`v1.2.0`** | Adds `molten-validate`, surface-routed `molten-design`, README/changelog updates, and the full public skill pack. |
| **`v1.1.0`** | Includes the full initial skill pack, `molten-skill-manage`, MIT license, and the conversion-focused README with install prompts. |
| **`v1.0.0`** | Retroactive baseline if you prefer the first public tag to stop at 2026-05-29 (skills + MIT + banner/workflow only, before the June README pass). |

Per-skill versions in skill front matter (independent of repo tags):

| Skill | Version in `SKILL.md` |
| --- | --- |
| mt-auto | 0.1.0 |
| mt-brand | 1.3.0 |
| mt-design | 1.9.0 |
| mt-build | 0.6.0 |
| mt-discovery | 0.5.0 |
| mt-guide | 0.8.0 |
| mt-landing | 1.2.0 |
| mt-plan | 0.6.0 |
| mt-prototype | 0.6.0 |
| mt-review | 0.7.0 |
| mt-ship | 0.6.0 |
| mt-search | 1.0.0 |
| mt-skill-manage | 1.4.0 |
| mt-spec | 0.5.0 |
| mt-validate | 1.2.1 |
| mt-verify | 0.5.0 |

## [Unreleased]

### Added

- **Auto mode with mt-auto.** Hand a feature to the agent and come back to a pull request. Start it from a brief ("run mt-auto: …") or part-way through, for example after running **mt-discovery** yourself. mt-auto asks everything it needs in one kickoff message (the brief, how far to go, and permission to push), then runs the remaining steps through the same skills and docs, each in a fresh context where the host allows. It never merges, deploys or force-pushes, and it stops only for things it must not decide: scope changes, secrets, destructive or shared actions, missing access, or hitting its fix and loop-back limits.
- **`molten-docs/loop/<slug>/auto.md`**, the run file. Auto mode is on for a feature while it has `status: running`. It holds the brief, a run log, every decision made without you (with its undo cost), and what's needed when a run pauses. Say "stop auto mode" to take the feature back; the docs are the same in both modes.

### Changed

- **Every loop skill has an Auto mode rule.** While `auto.md` is running, a skill answers its own questions from the docs and code, takes its recommended option, and logs the decision. These rules live in `mt-auto/references/auto-mode.md`. mt-prototype takes only the technical prototype path, mt-build commits each green task without pausing at checkpoints, and mt-ship leaves history alone, won't push without gitleaks, and applies no retro suggestions.
- **Specs and plans record who approved them** with `approved_by: user | auto`. In auto mode, the PR body counts the decisions made without a person and links `auto.md`.
- **mt-guide** recognises running and paused auto runs, and suggests mt-auto when a feature is ready to hand over. **mt-discovery** mentions mt-auto as a way to continue, and the AGENTS.md section explains auto mode.

## [3.0.0] - 2026-11-22

One folder per run of the loop.

### Breaking

- **Loop docs move to `molten-docs/loop/<slug>/`, numbered in loop order.** Each run of the loop (a feature, fix or refactor) now keeps all its docs in one folder: `01-discovery.md`, `02-prototype.md`, `03-spec.md`, `04-plan.md`, `05-verify.md`, `06-review.md`, `07-ship.md` and `08-retro.md`. Steps keep their number when skipped. Throwaway prototype code moves to `molten-docs/loop/<slug>/prototype/`. Product docs (`validate/`, `brand/`, `design/`) and `config.md` stay where they were. **mt-guide** spots the old per-step folders and offers to move them with `git mv`, including front matter paths; until then it reads the old layout as if it were the new one.

### Added

- **mt-ship creates a changelog** when a project has none. It offers to start `CHANGELOG.md` in Keep a Changelog format with this change under `## [Unreleased]`, and records `changelog: none` in `molten-docs/config.md` if the user declines, so it asks only once. Changelog entries are written for users, under Added, Changed, Fixed or Removed.
- **Lint rule** that fails if a skill uses the old per-step doc folders.

### Changed

- **README** shows the loop folder layout once instead of a full path in every row, and mt-ship's row mentions the preview deploy check.
- **AGENTS.md section** points agents at `molten-docs/loop/<slug>/` and its spec and plan.

## [2.0.0] - 2026-11-21

Molten Loop: the Agent Development Loop, a Product Engineering / Software Engineering split, and skills renamed to `mt-*`.

### Breaking

- **Renamed all skills** from `molten-<name>` to `mt-<name>` for brevity (`mt-validate`, `mt-brand`, `mt-design`, `mt-landing`, `mt-search`, `mt-skill-manage`). Re-install with the new names; `molten-docs/` output paths and `molten-*` metadata keys are unchanged.
- **Renamed to Molten Loop.** The GitHub repo is `switch-dimension/molten-loop`. GitHub keeps a redirect from `switch-dimension/molten-os-core`. Skill ids stay `mt-*`, the suite id stays `molten-os`, and output stays in `molten-docs/`.
- **mt-mockup merged into mt-prototype.** One optional step between discovery and spec with two paths: a clickable UX mockup (the default; throwaway or scaffolded pages, with a choice of variations) in `references/mockup.md`, and a time-boxed technical prototype for one feasibility question in `references/prototype.md`. Output moves from `molten-docs/mockup/` to `molten-docs/prototype/<slug>.md`, with a `type: mockup | prototype` field. Remove `mt-mockup` if you installed it. **mt-discovery**, **mt-spec**, **mt-plan**, **mt-ship**, **mt-guide** and **mt-skill-manage** updated to match.

### Added

- **Agent Development Loop** — new `dev-loop` skill category. Seven core steps run in order (`molten-order` 1–7):
  - **mt-discovery** — explore a feature before code; writes `molten-docs/discovery/<slug>.md`.
  - **mt-spec** — testable feature spec with acceptance criteria; writes `molten-docs/spec/<slug>.md`.
  - **mt-plan** — agent-executable implementation plan; writes `molten-docs/plan/<slug>.md`.
  - **mt-build** — implements the plan one slice at a time with red-green-refactor.
  - **mt-verify** — proves every acceptance criterion with evidence; writes `molten-docs/verify/<slug>.md`.
  - **mt-review** — pre-merge review with severity-labelled findings; writes `molten-docs/review/<slug>.md`.
  - **mt-ship** — final gates, PR and retrospective; writes `molten-docs/ship/<slug>.md` and `molten-docs/retro/<slug>.md`.
- **mt-prototype** — optional step between discovery and spec: a clickable UX mockup with fake data (default) or a time-boxed technical prototype. Writes `molten-docs/prototype/<slug>.md`.
- **mt-ship** — seventh and final dev-loop step. Confirms review, verify and plan are done; tidies the branch (clean tree, no debug leftovers or throwaway code); re-runs build, tests, lint and type-check; scans branch history with gitleaks (installed via Homebrew, release binary, Go, Scoop/Chocolatey, or Docker) and audits changed dependencies; updates docs, `.env.example` and CHANGELOG; opens a PR with summary, evidence and a merge-danger call; watches CI; closes out the tracker. Never merges. Always ends with a short retrospective (`references/retro.md`) that draws on the session, logs and Molten docs, and applies improvements only with approval. Writes `molten-docs/ship/<slug>.md` and `molten-docs/retro/<slug>.md`.
- **mt-guide** — "start here" utility skill that routes users to the right Molten skill. Reads `molten-docs/` front matter (`status`, `verdict`, `recommendation`, `molten_next_skill`) to report where each feature is and what comes next; otherwise asks up to three questions. Includes shortcuts for tiny changes, bugs, PR reviews and existing specs, and only routes to installed skills. Inspired by Addy Osmani's `using-agent-skills` and Matt Pocock's `ask-matt`.
- **Issue tracker sync** — **mt-plan** detects GitHub Issues, Linear or Jira, confirms once, and records the tracker, status names and operations in `molten-docs/config.md` (sync on by default). On plan approval it creates a parent issue per feature and one issue per task with blocking links. **mt-build** claims and closes task issues with commit links; **mt-verify** and **mt-review** comment verdicts on the parent; **mt-guide** reads task status from the tracker. With no tracker, the plan file remains the task list. Shared details live in `mt-plan/references/trackers.md`.
- **Parallel waves** — **mt-plan** groups tasks into waves that can run at the same time (no shared dependencies or files); **mt-build** picks the next ready task by wave and skips tasks already claimed.
- **Branches and worktrees** — **mt-build** always works on a feature branch (`feat/<slug>`, with the issue key when there is a tracker) and never on the default branch. A new optional "Running a wave in parallel" section covers one worktree and task branch per parallel task, merging back when green, and who ticks the plan with and without a tracker; it defers to worktrees the agent host already manages. **mt-ship** checks for a feature branch, confirms task branches are merged, and offers to clean up worktrees. **mt-plan** notes that parallel waves pair with worktrees. A database branch is separate: **mt-plan** marks it yes or no (schema or seed changes on a branchable database, or parallel writers that would collide), **mt-build** creates one only when the plan says yes, and **mt-ship** offers to delete it rather than deleting it with the PR.
- **AGENTS.md setup.** **mt-guide** offers to add a short Molten Loop section to the project's `AGENTS.md`, under a `## Molten Loop skills` heading so later runs update it in place. It tells every agent session that the skills are installed, to follow the loop, and that the spec is the contract. For Claude Code it offers to add `@AGENTS.md` to `CLAUDE.md`. The section lives in `mt-guide/references/agents-md.md`, and the README install prompt asks for it.
- **Preview deploy gate in mt-ship.** When the project deploys previews (Vercel, Cloudflare, Netlify and similar), mt-ship waits for the preview, reads the build log if it failed, and smoke-tests the preview URL. A failed deploy blocks the ship like failing CI. Details in `mt-ship/references/preview-deploy.md`.
- **Skill lint.** `scripts/lint-skills.rb` checks every skill for valid front matter, a name matching its folder, required metadata, descriptions under 400 characters, broken links and reference files, unknown skill names, and a CHANGELOG version table that matches. Runs in GitHub Actions on every push and pull request.

### Changed

- **One task source.** Task status now lives in one place. With a tracker and sync on, that is the tracker: **mt-build** moves issues and comments with commits, and the plan only links to issues. Without a tracker, it is the plan's checkboxes. **mt-plan**, **mt-guide**, **mt-verify**, **mt-review**, **mt-ship** and the retro follow the same rule (see `mt-plan/references/trackers.md` → Task source).
- **mt-review** reviews with agents that did not write the code. Two fresh-context reviewers run in parallel: **Spec** (missing, wrong, or unasked-for behaviour against the acceptance criteria) and **Quality** (correctness, readability, architecture, security, performance, plus structural smells). The two get separate verdicts so one cannot hide the other. The main session then acts as lead: it checks each finding against callers and tests, merges duplicates, and records what it dropped in a **Dismissed** list. Before reviewing, it pins the diff to a resolved base, checks for a clean checkout, and states the intent. For risky changes it offers a second opinion from a different model (such as Codex or Gemini CLI, read-only) and reports when that is skipped. Reviewer prompts live in `mt-review/references/reviewer-briefs.md`. Draws on Matt Pocock's `code-review`, Lauren Tan's `interrogate`, and Addy Osmani's `code-review-and-quality`.
- **README** splits the work into Product Engineering (validate, brand, design, landing) and Software Engineering (the whole Agent Development Loop, discovery through ship).
- **Shorter skill descriptions.** Every description is now about 300 characters (what it does, when to use it, and the one skill it's confused with), halving what agents load on every turn.
- **mt-design and mt-brand split into reference files.** The `design.md` template, `example.html` preview and Pinterest phase move to `mt-design/references/`, and the `brand.md` template to `mt-brand/references/`. mt-design drops from 633 to about 255 lines and mt-brand from 402 to 180; the detail loads only when it's needed.
- **mt-brand** reads the latest `molten-docs/validate/product-score-N.md` when it exists, so it doesn't re-ask what validation already answered.
- **mt-skill-manage:** taxonomy documents core vs optional dev-loop skills.
- **All skills:** ask questions as plain numbered text, with multiple-choice options as lettered sub-items (1a, 1b, 1c). Removed instructions to use agent-specific question tools (`AskUserQuestion`, `AskQuestion`, `request_user_input`).

### Fixed

- **mt-validate** pointed to a `references/molten-handoff.md` file that had been deleted. It's restored with the current skill names.
- **mt-build** front matter is valid YAML again.

## [1.3.1] - 2026-08-25

Product vs utility skill taxonomy.

### Added

- **`molten-category` metadata** — `product` for pipeline skills (validate → brand → design → landing); `utility` for cross-cutting helpers (search, skill-manage).
- **molten-skill-manage:** Skill taxonomy section documenting product vs utility conventions.

### Changed

- README split into **Product skills** and **Utility skills** sections; workflow diagram covers product pipeline only.
- README install examples for product-only and utility-only installs.
- Utility skills no longer carry `molten-order` in front matter.

## [1.3.0] - 2026-08-25

Search routing for live web and social research during product work.

### Added

- **molten-search** — routes search and research queries to Cursor WebSearch, last30days, agent-reach, or parallel-cli web search.

## [1.2.0] - 2026-06-02

Validation-first workflow and surface-specific design-system guidance.

### Added

- **molten-validate** — adversarial product-idea validation skill with quick score, full 5-round interview, and re-validation modes. Outputs reports to `molten-docs/validate/product-score-N.md`.
- **molten-design:** Surface reference files for landing page, web product, mobile product, and desktop product design systems.

### Changed

- README workflow now starts with **molten-validate** before brand, design, and landing page creation.
- README skill table now lists all five discovered skills.
- **molten-design:** Restructured into a shared routing spine plus surface-specific references, with one canonical `design.md` model using shared core tokens and a surface layer.

## [1.1.1] - 2026-06-02

Skill portability and design-reference workflow polish.

### Changed

- **molten-brand:** Document agent-specific structured question tools (`AskQuestion`, `AskUserQuestion`, `request_user_input`) and microphone/dictation hint for discovery intake.
- **molten-design:** Added Pinterest visual-reference discovery, a design-surface first ask, and focused surface-specific Pinterest search terms.

## [1.1.0] - 2026-06-01

Documentation and onboarding polish after the initial public skill pack.

### Added

- README install prompt with full GitHub repo URL for agent-assisted setup.
- README “tag” / release callout line for discoverability.

### Changed

- README restructured as a conversion-focused product page (value prop, why landing pages, skill table, workflow).
- Simplified install instructions and intro copy.
- Clarified agent-assisted vs manual `npx skills` installation paths.

## [1.0.0] - 2026-05-29

First public Molten OS Core skill pack — brand → design → landing workflow for idea validation.

### Added

- **molten-brand** — brand discovery workflow; outputs `molten-docs/brand/brand.md`.
- **molten-design** — design system workflow; outputs `molten-docs/design/design.md` and `molten-docs/design/example.html` preview.
- **molten-landing** — landing page build and 22-point audit workflows with references and `audit_metrics.py`.
- **molten-skill-manage** — skills.sh CLI management (`npx skills` install, update, list, remove).
- README with banner (`molten-os-banner.png`) and workflow diagram (`molten-workflow.png`).
- Agent-assisted install hint in README.
- [MIT License](LICENSE).

### Changed

- Renamed skills from `brand` / `design` / `landing` to **`molten-brand`**, **`molten-design`**, **`molten-landing`** for clarity in `npx skills ls`.
- Relicensed project to MIT (from prior license in initial commit).

### Fixed

- **molten-design:** Prompt user to choose fast vs guided design workflow.
- **molten-design:** Quote YAML front matter `description` for valid parsing.
- **molten-design:** Reduced design intake question count.

---

## Commit history (reference)

| Date | Commit | Summary |
| --- | --- | --- |
| 2026-06-01 | `10aba51` | added readme tag |
| 2026-06-01 | `074fe60` | docs: include repo URL in agent install prompt |
| 2026-06-01 | `7884ce5` | docs: restructure README as conversion-focused product page |
| 2026-06-01 | `7b5cf99` | docs: simplify README install instructions and intro copy |
| 2026-05-29 | `b938f31` | docs: clarify agent vs manual install in README |
| 2026-05-29 | `b087222` | docs: add agent-assisted install hint to README |
| 2026-05-29 | `ddb34d5` | docs: add workflow diagram to README |
| 2026-05-29 | `9729f93` | docs: refine README and relicense to MIT |
| 2026-05-29 | `b2d12f0` | docs: add README banner |
| 2026-05-29 | `eefbf71` | feat(molten-skill-manage): add skills.sh management skill |
| 2026-05-29 | `727f839` | fix(molten-design): ask for design workflow choice |
| 2026-05-29 | `75afab5` | fix(molten-design): quote front matter description |
| 2026-05-29 | `c4e0ba0` | fix(molten-design): reduce design intake questions |
| 2026-05-29 | `992b89d` | feat(molten-design): add design preview output |
| 2026-05-29 | `65cdbdf` | feat(molten-design): write design brief to molten-docs/design/design.md |
| 2026-05-29 | `4f32572` | feat(molten-brand): write brand brief to molten-docs/brand/brand.md |
| 2026-05-29 | `f79a58d` | refactor(skills): rename to molten-brand, molten-design, molten-landing |
| 2026-05-29 | `908f33c` | feat: add Molten OS Core lifecycle skill pack |
