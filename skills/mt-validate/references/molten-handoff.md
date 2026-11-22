# Molten Loop handoff

After scoring, set **`molten_next_skill`** in the report front matter only. Do not duplicate handoff guidance in chat (see **Chat closing** below).

**mt-brand**, **mt-design** and **mt-landing** come from [Molten Loop](https://github.com/switch-dimension/molten-loop). If they aren't installed, give the install command: `npx skills add switch-dimension/molten-loop --skill mt-brand mt-design mt-landing`.

## Decision table

| Total (after caps) | Verdict | `molten_next_skill` | Guidance |
|--------------------|---------|---------------------|----------|
| 40–50 | Pursue | `mt-brand` | Run the riskiest-assumption test **in parallel** with early **mt-brand** only if the experiment takes under 2 weeks; otherwise run the experiment first, then `mt-brand` |
| 30–39 | Pursue cautiously | `mt-validate` | Close the gaps from **Gaps to close** or a full interview; re-validate before `mt-brand` |
| 20–29 | Pivot | `mt-validate` | Use the pivot hints; re-validate after the pivot, not `mt-brand` yet |
| <20 | Kill | `none` | Do not invoke mt-brand, mt-design or mt-landing unless the user explicitly reframes the idea |

## Product chain (when pursuing)

```
mt-validate → mt-brand → mt-design → mt-landing
```

- **mt-brand** reads the latest `molten-docs/validate/product-score-N.md` when it exists.
- **mt-design** requires `brand.md`.
- **mt-landing** uses `brand.md` and `design.md` when building a page.

## Output path (required)

Write and read score files **only** under `molten-docs/validate/`. Create the directory if missing. See [`report-template.md`](report-template.md).

## Chat closing (always)

Point the user to the markdown report. **No supplementary summary** (no verdict recap, score breakdown, red flags, experiment, or `molten_next_skill` in chat).

Example:

> Review your evaluation in **`molten-docs/validate/product-score-3.md`**.

Follow [`report-template.md`](report-template.md) § After writing.
