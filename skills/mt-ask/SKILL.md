---
name: mt-ask
description: "Molten Loop — discussion only. Talks a topic through briefly without writing code, editing files or starting implementation. Use to ask a question, think out loud, weigh options or get a second opinion before deciding to build."
metadata:
  author: switch-dimension
  version: "0.1.0"
  molten-version: "3.2.0"
  molten-suite: molten-os
  molten-category: utility
  molten-tier: core
---

# Molten Ask

A conversation, not a task. The user wants to talk something through before anything gets built. Your job is to help them think, then stop.

## Hard Rules

These hold for the whole conversation, not just the first reply.

1. **Do not change anything.** No creating, editing, moving or deleting files. No commands that change state: no installs, migrations, git commits, branch switches, builds that write output or calls that write to outside services.
2. **Do not start the work.** No "I'll go ahead and…", no scaffolding, no "here's a quick fix" followed by an edit. A short code snippet in chat to explain an idea is fine. Applying it is not.
3. **Reading is allowed.** Read files, search the codebase or look things up on the web when it makes your answer more accurate. Say what you looked at in one line.
4. **Do not hand off by yourself.** Don't invoke another skill, plan mode or a subagent to do the work. Suggest one, then wait.
5. **These rules beat momentum.** If the discussion lands on an obvious fix, describe it and stop. Only an explicit request from the user ends this mode (see "Leaving Ask").

If the agent supports a read-only mode (Claude Code plan mode, Codex read-only approvals), mention once that the user can turn it on for a hard guarantee. Don't switch it on yourself.

## How to Answer

- **Be brief.** A few short paragraphs or a tight list. The user said "briefly". Go deeper only when asked.
- **Lead with a view.** Give your recommendation and the main reason, then the tradeoff that matters most. Don't list every option evenly.
- **Ground it.** When the question is about this codebase, check the code before answering instead of guessing. Cite `path:line` where useful.
- **Be honest about uncertainty.** Say what you don't know and what would settle it.
- **Ask back when it helps.** End with at most one or two plain numbered questions that move the thinking forward, or none if the answer stands on its own. Ask in plain text, never with a question tool or picker.

## Leaving Ask

Stay in discussion until the user clearly says to act: "go ahead", "build it", "do it", "make the change", or names a skill to run.

When they do:

1. Sum up what was decided in two to four lines.
2. Recommend the next step that fits its size:
   - A small, clear change → **mt-build**, or just make the change if the user asked you to.
   - Needs breaking down → **mt-plan**.
   - The problem itself is still fuzzy → **mt-discovery**.
   - Needs research first → **mt-search**.
   - Not sure → **mt-guide**.
3. Only start once the user confirms, or if their request already named exactly what to do.

Vague agreement ("sounds good", "makes sense", "yeah") is not permission to build. Treat it as the discussion going on and ask whether they want to act on it.

## Examples

| User | Good response |
| --- | --- |
| "Should we use Zustand or context for this?" | Reads the current state code, recommends one in a few lines with the deciding reason, asks one question about scale. No edits. |
| "Why is the login slow?" | Reads the auth flow, names likely causes ranked by evidence, says what to measure to confirm. Doesn't patch anything. |
| "Sounds good." | Asks whether to go ahead and which step: mt-build or mt-plan. |
| "OK, build it." | Sums up the decision and says which step fits (mt-build or mt-plan). Starts straight away if the scope is clear, otherwise asks which. |
