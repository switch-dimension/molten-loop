# Auto mode rules

Every loop skill follows these rules when `molten-docs/loop/<slug>/auto.md` has `status: running`. They change who answers the questions, not what the skill does: follow the skill's workflow, templates and done checklist as normal, plus the skill's own Auto mode rule.

## Answering instead of asking

When the skill says to ask the user, confirm with them, or wait for sign-off:

1. **Answer from what exists:** the brief in `auto.md`, earlier docs in the loop folder, `molten-docs/brand/brand.md` and `molten-docs/design/design.md`, `AGENTS.md`, and the code.
2. **Otherwise take the option the skill recommends.** With no recommendation, choose the smallest in-scope option that is easiest to undo and matches existing patterns.
3. **Record it** in `auto.md` under Decisions made for you: step, question, choice, why, undo cost (`low`, `medium`, `high`) and `by: auto`. Also put it in the doc's own Assumptions section (or Facts / Assumptions / Open questions), so the doc still reads correctly on its own.
4. **Approve with a label.** Where the skill sets `status: approved` only on explicit sign-off, set it and add `approved_by: auto` to the front matter.

Skip the voice-mode advice. Skip offers that need a yes (squash commits, create a changelog, delete a branch, apply retro suggestions), and note each one in the step's report so a person can take it up later.

## Hard stops

Do not guess on these. Stop the step instead:

- **Scope would change.** The spec or plan turns out wrong in a way that adds, drops or changes an acceptance criterion. Corrections that keep every criterion intact are fine; record them as decisions.
- **The brief can't be pinned down.** Discovery cannot state the problem, who has it and what success looks like from the brief and the code.
- **A spec boundary needs a person.** Anything under the spec's **Never** list. Items under **Ask first** may go ahead only when they are reversible on the feature branch (a new dependency, an additive migration on a feature database branch); record each as a decision. Anything else under Ask first stops.
- **Something irreversible or shared is next:** destructive data or schema changes outside a feature database branch (drops, renames, backfills), production deploys, merging, force-pushing, rewriting pushed history, deleting branches or databases, spending money, or contacting people outside the team.
- **A secret is found** (mt-ship's rule), or gitleaks can't run before a push.
- **Access is missing:** credentials, accounts, paid services, or a tool the step can't do without.
- **Limits are reached:** a task is still red after `max_fix_attempts` tries, or `loop_backs` has reached `max_loop_backs`.

To stop: leave the step's doc in its honest state (`draft`, `fail`, `blocked`), and report the reason, what a person needs to decide, and lettered options with your recommendation. **mt-auto** pauses the run and writes them under Stops.

## Commits, pushes and the tracker

- Auto mode counts as the user asking for commits on the feature branch. Never commit to the default branch.
- Push and open the PR only when `auto.md` has `push: true`.
- With `tracker_sync: true` in `molten-docs/config.md`, do the tracker operations the skills describe without asking, including creating issues when the plan is approved and blocker issues during review. Never touch issues outside the feature's parent.
- Without `molten-docs/config.md`, the plan is the task source. Do not create `config.md`; the tracker choice waits until a person is present.

## Reporting back

End every step with a short result for **mt-auto**: the doc written, its `status`, `verdict`, `recommendation` or `result`, how many decisions you added, and the stop reason if there is one.

## Step prompt

What **mt-auto** sends to the fresh subagent for each step:

```text
Auto mode. Run the <skill> skill for the feature in molten-docs/loop/<slug>/.
Load and follow <skill>'s SKILL.md and mt-auto/references/auto-mode.md.
auto.md has status: running, so do not ask questions: answer from the docs and code,
record each decision in auto.md, and stop only on a hard stop.
<loop-back only: Fix what <doc> lists: <one line>.>
When done, reply with the doc you wrote, its status/verdict/recommendation/result,
how many decisions you added, and any stop reason.
```
