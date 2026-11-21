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
- **Building a feature:** follow the Agent Development Loop: `/mt-discovery` → `/mt-spec` → `/mt-plan` → `/mt-build` → **mt-verify** → **mt-review** → `/mt-ship`. **mt-prototype** is an optional step before the spec. For anything bigger than a tiny fix, don't skip the spec or plan without asking.
- **The spec is the contract.** Before working on a feature, read its docs in `molten-docs/` (spec, plan). If scope changes, update the spec first.
- **Some skills only start when the user types them** (shown with `/` above, plus `/mt-validate`, `/mt-brand`, `/mt-design`, `/mt-landing` and `/mt-skill-manage`). When one fits, suggest the command; don't do that skill's work without it.
```
