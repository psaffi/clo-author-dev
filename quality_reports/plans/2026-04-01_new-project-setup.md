# Project Plan: Securities Lending and Information Acquisition

**Status:** APPROVED
**Date:** 2026-04-01
**Phase:** Project Initialization (Discovery)

---

## Research Question

Do mutual funds use the equity lending market to acquire information about short-sale demand and trade on it?

## Approach

### Identification Strategy

1. **Baseline:** Regress fund position changes on lagged lending indicator/intensity, with saturated FE (Security-Time + Fund-Time + Fund-Security) and double-clustered SE
2. **Information channel:** Interact lending with mandatory short position disclosure events (EU regulation) — if funds trade on lending information, the effect should be stronger when a disclosure follows
3. **Placebo:** Passive funds should not react (they cannot trade on information)
4. **IV/Robustness:** Use passive fund lending as exogenous variation in lending intensity
5. **Timing:** Leads and lags of disclosure — only lead should be significant
6. **Channels:** Decompose by same-manager, cross-manager, family-level lending
7. **Heterogeneity:** Market structure (HHI, number of active agents, fund concentration)

### Paper Structure (9 Tables)

| Table | Content | Source |
|-------|---------|--------|
| 1 | Investment focus breakdown | desc_stats_table.tex |
| 2 | Securities lending behavior | desc_stats_table.tex |
| 3 | Panel descriptive statistics | desc_stats_table.tex |
| 4 | Baseline: PosChange ~ OnLoan | Excel Table 4 |
| 5 | Disclosure interaction | Excel Table 5 |
| 6 | Passive fund lending IV | Excel Table 6 |
| 7 | Leads and lags (timing) | Excel Table 7 |
| 8 | Family channels decomposition | Excel Table 8 |
| 9 | Market structure heterogeneity | Excel Table 9 |

### Literature Positioning

- **vs. Honkanen (2025, JFQA):** Complementary U.S. evidence with hand-collected data. Our regulatory data is more comprehensive (mandatory reporting, all funds)
- **vs. Evans et al. (2017, RoF):** They find funds fail to exploit the signal. We resolve this by showing the disclosure channel
- **vs. Nurisso (2026, JFE):** We provide empirical evidence for the theoretical "learning by lending" model

## Files Created/Modified

### Created
- `Paper/main.tex` — Full paper scaffold with 7 sections + appendix
- `Paper/sections/*.tex` — 10 section stubs
- `.claude/rules/domain-profile.md` — Filled for finance/market microstructure

### Modified
- `CLAUDE.md` — Research summary, project state updated

### Memory Files
- `project_overview.md`, `user_profile.md`, `data_structure.md`, `paper_tables.md`, `literature_map.md`

## Next Steps

1. **Convert regression tables** from Excel to LaTeX format for inclusion in paper
2. **Draft introduction** — frame contribution relative to Honkanen (2025) and Evans et al. (2017)
3. **Draft data section** — expand from institutional_details.md
4. **Draft results sections** — narrate Tables 4-9
5. **Draft conclusion**
6. **Compile paper** — verify LaTeX compilation
