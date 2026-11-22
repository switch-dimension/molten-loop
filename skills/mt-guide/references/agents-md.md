# AGENTS.md section

The section **mt-guide** adds to a project's `AGENTS.md` so every agent session knows the Molten Loop skills are installed and how to use them. Keep it short: agents load this file on every turn.

## How to add it

1. Look for `AGENTS.md` at the repository root.
   - **It has a `## Molten Loop skills` heading:** replace that section (from the heading up to the next `##` heading or the end of the file) with the block below. This updates an older version. Leave the rest of the file untouched.
   - **It exists without that heading:** append the block at the end.
   - **It does not exist:** create it with the block as its only content.
2. Claude Code reads `CLAUDE.md`, not `AGENTS.md`. If `CLAUDE.md` exists and doesn't already import or include `AGENTS.md`, offer to add the line `@AGENTS.md` to it. If there is no `CLAUDE.md`, don't create one unless the user uses Claude Code.
3. Remove any line in the block for a skill that isn't installed.
4. Show the user the diff before writing, and write only on a yes.

## The block

```markdown
## Molten Loop skills

This project uses the Molten Loop agent skills (`mt-*`). Their output lives in `molten-docs/`.

- **Not sure what's next?** Run **mt-guide**. It reads `molten-docs/` and recommends the next skill.
- **Building a feature:** follow the Agent Development Loop: **mt-discovery** → **mt-spec** → **mt-plan** → **mt-build** → **mt-verify** → **mt-review** → **mt-ship**. **mt-prototype** is an optional step before the spec. For anything bigger than a tiny fix, don't skip the spec or plan without asking.
- **Auto mode:** **mt-auto** runs the loop unattended up to an open PR. While `molten-docs/loop/<slug>/auto.md` has `status: running`, each step answers its own questions and logs its decisions there instead of asking.
- **The spec is the contract.** Each piece of work has a folder, `molten-docs/loop/<slug>/`, with its docs numbered in loop order. Read its spec (`03-spec.md`) and plan (`04-plan.md`) before working on it. If scope changes, update the spec first.
- **Use the skill, not a freehand version of it.** When a task matches an `mt-*` skill (validating an idea, branding, design, a landing page, a spec, a review, shipping), load that skill and follow it.
```
