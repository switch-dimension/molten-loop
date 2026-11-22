---
name: mt-auto
description: "Molten Loop — auto mode. Runs the rest of the Agent Development Loop unattended, from a brief or from wherever a feature is (for example after a manual discovery), up to an open PR. Logs every decision it makes for you in `molten-docs/loop/<slug>/auto.md` and stops only for what it must not decide. Use for auto mode, \"take it from here\" or building a feature autonomously."
metadata:
  author: switch-dimension
  version: "0.1.0"
  molten-suite: molten-os
  molten-category: dev-loop
  molten-tier: core
  molten-optional: "true"
---

# Auto

Hand a feature to the agent and come back to a pull request. Auto mode runs the same skills as the manual loop, in the same order, and writes the same docs. The only difference is who answers the questions: instead of asking you, each step answers from the code and the docs, takes its recommended option, and writes down what it chose and why. You review those decisions once, in the PR, instead of one at a time in chat.

**Two ways in:**

- **From the start.** "Run mt-auto: <what you want built>." Auto mode writes discovery from your brief and the code, then carries on.
- **Part-way through.** Run any steps yourself first (most often **mt-discovery**, so the problem comes from you rather than a guess), then say "run mt-auto" or "auto from here". It picks up at the next step.

**Input paths:** whatever exists in `molten-docs/loop/<slug>/`, `molten-docs/config.md` if it exists, and the codebase.

**Output paths:**

- `molten-docs/loop/<slug>/auto.md` — the run file: settings, brief, run log, decisions made for you, and any stop.
- Everything the loop's skills write, from `01-discovery.md` to `08-retro.md`, plus a feature branch and an open PR.

**Next skill:** none. Merging is yours. After you merge, start the next feature with **mt-discovery** or **mt-auto**.

## How auto mode is switched on

Auto mode is per feature, not per project. It is on for a feature while `molten-docs/loop/<slug>/auto.md` has `status: running`. Every loop skill checks that file and, while it is running, follows [references/auto-mode.md](references/auto-mode.md) instead of asking questions. Only this skill sets `status: running`.

| `status` | Meaning | Set by |
| --- | --- | --- |
| `running` | Steps run unattended | mt-auto, at kickoff or resume |
| `paused` | Stopped for something it must not decide; see Stops in `auto.md` | mt-auto |
| `stopped` | You took the feature back; the skills ask you again | You ("stop auto mode"), or mt-auto when you ask |
| `done` | Reached the stop point | mt-auto |

To switch it off, say "stop auto mode" (or set `status: stopped`). The docs are the same in both modes, so you can carry on by hand with **mt-guide** or the next skill at any point.

## Operating Rules

- **One kickoff, then quiet.** Ask everything you need in one message at the start (see Workflow step 3). After that, ask nothing until the run finishes or hits a stop.
- **Same skills, same docs.** Run each step by loading its skill and following it. Never do a freehand version of a step, and never skip one the state calls for.
- **Fresh context per step.** Run each step as a fresh subagent when the host can spawn them, using the step prompt in [references/auto-mode.md](references/auto-mode.md). Run **mt-review** in this session instead, because it spawns its own reviewers. If the host cannot spawn subagents, run the steps in turn in this session; the docs carry everything forward.
- **The docs decide what's next, not memory.** After each step, read the front matter of the doc it wrote and pick the next step from Routing. Log the result in `auto.md` before moving on.
- **Bounded loops.** Count every loop-back (verify fails, review requests changes, ship is blocked). When the count reaches `max_loop_backs`, stop.
- **Never merge, deploy to production, or force-push.** An open PR is as far as auto mode goes.
- **Stop instead of guessing** on anything listed under Hard stops in [references/auto-mode.md](references/auto-mode.md). Set `status: paused`, write what you need under Stops, and tell the user in one short message.
- Ask questions as plain numbered text in chat; for finite choices, list lettered options under the question (1a, 1b, 1c). Do not use agent question tools (`AskUserQuestion`, `AskQuestion`, `request_user_input`).

## Workflow

1. **Find the feature.** Read `molten-docs/loop/`.
   - **New feature:** take the brief from the user's message and pick a short kebab-case slug.
   - **Existing feature:** if several are in flight, ask which. Read its docs and find the next step with Routing.
   - **`auto.md` exists with `status: paused`:** this is a resume. Go to step 4.
2. **Preflight.** Check these and report them in the kickoff message:
   - It is a git repo with a clean working tree. If not, ask the user to commit or stash first.
   - The project's test, lint, type-check and build commands (from `package.json`, `Makefile`, CI config or equivalent). With no test command, say that build and verify will be weaker.
   - A way to open a PR (`gh` signed in, or the platform's CLI). Without one, the furthest stop point is mt-review.
   - **gitleaks** or Docker is available for the secrets gate. If neither is, offer to install gitleaks now (mt-ship lists the options); auto mode will not push without it.
   - `molten-docs/config.md`: tracker or local. If it is missing, auto mode uses the plan as the task source and does not create the file.
3. **Kickoff.** One message. Say which steps will run, that it never merges, and the hard stops in one line. Then ask only what is not already known:
   1. **The brief** (only when there is no discovery doc): what to build, for whom, and any must-haves or never-dos. A paragraph is enough.
   2. **How far should it go?**
      - 2a. Open a PR (recommended)
      - 2b. Stop after the plan, so I can check the spec and plan first
      - 2c. Stop after review, with nothing pushed
   3. **OK to commit to a feature branch and push it?** (needed for 2a)

   Then write `auto.md` from the template below with `status: running`, and say: "Auto mode is on for **<slug>**. Say 'stop auto mode' to take over."
4. **Resume (paused runs only).** Show the stop from `auto.md`, ask for what is missing, record the answer under Decisions made for you with `by: you`, clear Stops, set `status: running`, and continue from the step that stopped.
5. **Run the loop.** Until Routing says stop: run the next step, read the doc it wrote, add a row to the Run log, check Hard stops, pick the next step.
6. **Finish.** Set `status: done` (or leave it `paused`). Then report in chat:
   - The PR link and its merge danger, or where the run stopped and why
   - **Decisions made for you** worth checking first (highest undo cost), one line each, with a pointer to `auto.md` for the rest
   - Acceptance criteria marked `not verified`, and any gate recorded as `partial` or `skipped`
   - Retro suggestions waiting for your yes; auto mode applies none of them

## Routing

Take the first row that matches. Rows marked loop-back add one to `loop_backs` in `auto.md`. After any loop-back **mt-build**, run **mt-verify** next, then follow the table again.

| State of `molten-docs/loop/<slug>/` | Next |
| --- | --- |
| No `01-discovery.md` | **mt-discovery** |
| Discovery says `molten_next_skill: mt-prototype`, no `02-prototype.md` | **mt-prototype** (prototype path only) |
| No `03-spec.md`, or spec `draft` | **mt-spec** |
| No `04-plan.md`, or plan `draft` | **mt-plan**, then stop if `stop_after: mt-plan` |
| Plan `approved` or `in-progress` | **mt-build** |
| Plan `done`, no `05-verify.md` | **mt-verify** |
| Verify `fail`, or `partial` for any reason other than the environment | **mt-build** to fix (loop-back) |
| Verify `pass`, or `partial` only because of the environment (credentials, browser) | **mt-review** |
| Review `request-changes` | **mt-build** for the blockers (loop-back) |
| Review `approve` or `approve-with-suggestions` | Stop if `stop_after: mt-review`, otherwise **mt-ship** |
| Ship `blocked` | The skill under "Blocked on" (loop-back) |
| Ship `pr-open` | Done |

## Run file template

```markdown
---
feature: <name>
slug: <slug>
created: <YYYY-MM-DD>
status: running | paused | stopped | done
started_at: <first skill auto mode ran>
stop_after: mt-ship | mt-review | mt-plan
push: true | false
max_fix_attempts: 3
max_loop_backs: 2
loop_backs: 0
pr: <URL> | null
---

# Auto — <name>

## Brief
<the user's words, unedited, or "From 01-discovery.md">

## Run log
| # | Step | Result | Next |
| --- | --- | --- | --- |
| 1 | mt-spec | approved by auto, 7 ACs | mt-plan |

## Decisions made for you
| # | Step | Question | Chose | Why | Undo cost | By |
| --- | --- | --- | --- | --- | --- | --- |
| 1 | mt-spec | Paginate or infinite scroll? | Paginate | Matches the existing list pages | low | auto |

## Stops
<only while paused: what stopped the run, what you need to decide, and lettered options with a recommendation>
```

## Done checklist

- [ ] One kickoff message; no questions after it except at a stop
- [ ] `auto.md` written with status, stop point, push permission and limits
- [ ] Every step run through its own skill, in a fresh context where the host allows
- [ ] Run log has a row per step; every unattended decision is under Decisions made for you
- [ ] Loop-backs within the limit, or the run paused with the reason
- [ ] Nothing merged, force-pushed or deployed to production
- [ ] Final summary gives the PR (or the stop), the decisions to check first, the gaps, and the pending retro suggestions

## Extending

Common additions: a project default in `molten-docs/config.md` so **mt-guide** suggests auto mode for small features, running a wave's tasks in parallel worktrees, a scheduled run that picks up issues labelled for auto mode, or posting the run log to a team channel.
