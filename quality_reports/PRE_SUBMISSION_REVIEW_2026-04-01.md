# Pre-Submission Review — Securities Lending and Information Acquisition
**Authors:** Greppmair, Jank, Saffi, Sturgess
**Date:** 2026-04-01
**Status:** Borderline JF; Strong JFQA/RFS

---

## Executive Summary

Six review agents evaluated the paper across spelling/grammar/style, internal consistency, unsupported claims, mathematics/equations, tables/documentation, and a simulated JF referee assessment. The paper presents a compelling, well-identified empirical study. Several equation errors have been corrected in this draft; a number of issues remain open and are documented below with priority flags.

**Overall assessment:** Strong JFQA/Review of Finance submission as-is. JF requires four substantive additions (IV diagnostics, Wald test, return predictability, autocorrelation diagnostic) plus resolution of welfare language and "we plan to" residuals.

---

## Agent 1: Spelling, Grammar, and Style

### Fixed in This Draft

- **"more than doubles" vs "nearly tripling" contradiction** — FIXED: both instances now read "nearly triples"
- **"demonstrate" → "show"** — FIXED in abstract (finance convention: avoid "demonstrate" as it implies physical proof)
- **EFP acronym undefined** — FIXED: now defined at first occurrence in introduction

### Open Issues

| Issue | Location | Priority | Action Required |
|-------|----------|----------|-----------------|
| "consistent with" overuse | 15+ occurrences throughout | Major | Reduce to ~5 meaningful uses; vary with "in line with," "supports," "is consistent with the hypothesis that" |
| "we plan to... in the revision" | `empirical_strategy.tex` lines 42, 54; `information_channel.tex` footnote line 17 | **CRITICAL** | Remove entirely or convert to completed task language before submission |
| "importantly" (line 23 intro) | Introduction | Minor | Near-equivalent "Crucially" present; either form acceptable at top-field journals |
| "interestingly" | Not found | N/A | No action needed |

### Style Notes

Finance convention at JF/JFE: prefer "show" over "demonstrate," "find" over "document," active voice over passive. Abstract reads cleanly once "demonstrate" fix is applied. No instances of "novel" or "innovative" (good). One instance of "contribute to the literature" in introduction — acceptable but consider cutting.

---

## Agent 2: Internal Consistency

### Cross-References Verified

| Claim | Source | Table/Section | Status |
|-------|--------|---------------|--------|
| "~0.33 pp" position reduction | Abstract | Table 4, col (3) active-only | ✓ MATCH |
| "baseline -0.28" for disclosure sample | Introduction | Table 5, col (1) | ✓ MATCH |
| "nearly triples" (disclosure interaction) | Abstract, Introduction | Table 5 interaction coefficient | ✓ MATCH (post-fix) |
| `sh_sec_lend` vs `OnLoan` naming | Data section / Tables | Data section defines both; tables use OnLoan consistently | ✓ ACCEPTABLE |

### Fixed in This Draft

- **"more than doubles" / "nearly tripling"** inconsistency — FIXED: unified to "nearly triples"
- **Columns (5)-(7) of Table 5 undiscussed** — FIXED: explanatory sentence added to results section
- **Table 9 N discrepancy (39,109 vs 39,003)** — FIXED: note added in table body explaining source of difference

### Open Issues

| Issue | Location | Priority |
|-------|----------|----------|
| Table 5 FE structure (cols 1-3 use separate FE; equation shows interacted FE) | Table 5 caption | Major — add caption clarification |
| γ₁ vs γ notation inconsistency between equations (2)/(3) and (4) | Math section | Minor — unify to γ throughout |

---

## Agent 3: Unsupported Claims

### Fixed in This Draft

- **`table_passive_iv` label** — FIXED: corrected to `table_passive_rf`
- **"demonstrate" → "show"** in abstract — FIXED

### Open Issues

| Claim | Location | Issue | Required Action |
|-------|----------|-------|-----------------|
| "consistent only with active information acquisition" | `empirical_strategy.tex` line 52 | "consistent only with" is too strong — no formal test rules out alternative mechanisms | Weaken to "most consistent with" |
| "contemporaneous and lagged disclosures are uninformative" | Abstract | Contradicts `information_channel.tex` line 29 which correctly notes the lagged coefficient (-0.3043, t=-1.34) is "economically non-negligible and one-sided borderline significant" | Remove "uninformative" from abstract; replace with hedged language |
| "generating gains for their investors at the expense of uninformed buyers" | Conclusion | Welfare claim without supporting performance evidence in paper | Either (a) add return predictability table, or (b) remove/weaken this sentence |

### Note on Lagged Coefficient

The tension between calling the lagged coefficient "uninformative" (abstract) while acknowledging it is "economically non-negligible" (body) must be resolved. Preferred fix: the abstract should say "the response is concentrated in the month before mandatory disclosure" or similar, without characterizing lagged and contemporaneous coefficients as uninformative.

---

## Agent 4: Mathematics and Equations

### Fixed in This Draft

| Issue | Fix Applied |
|-------|-------------|
| Eq (3): β₃ phantom term — `OnLoan_{i,t-1} × Active_j` appeared in equation but not in Table 4 | Removed phantom term |
| Eq (4): β₂ phantom term — `OnLoan × OnLoan_{i,t-1}` appeared with no table column or discussion | Removed; renumbered β₃→β₂, β₄→β₃, β₅→β₄ |
| `\mathit{}` missing from variable names in math mode | Applied to OnLoan, PosChange, PosWeight, ILLIQ throughout |
| `eqnarray` environment | Changed to `align` throughout (standard for multi-line equations) |
| Eq (1): `Y(…)` notation reused Y as function name | Changed to `f(…)` |

### Remaining Issues

| Issue | Location | Priority |
|-------|----------|----------|
| Table 5 FE structure inconsistency: equation shows interacted FE, columns 1-3 use separate FE | Table 5 caption | Major — caption must clarify |
| γ₁ vs γ inconsistency between equations (2)/(3) and (4) | Equations section | Minor — unify to γ throughout |

### Pre-Fix Score: 51/100 | Estimated Post-Fix Score: ~80/100

Primary deductions before fix: phantom terms (-20), missing `\mathit{}` (-15), `eqnarray` usage (-8), Y-reuse (-6). Remaining deductions: FE inconsistency (-12), γ notation (-8).

---

## Agent 5: Tables and Documentation

### Fixed in This Draft

| Issue | Fix Applied |
|-------|-------------|
| Table 7 notes: `\scriptsize` → `\footnotesize` | Applied |
| Table 9: SE Clustering and Sample rows missing | Added both rows |
| Table 9: N discrepancy (39,109 vs 39,003) | Note added in table body |

### Remaining Issues

| Issue | Tables Affected | Priority | Action Required |
|-------|----------------|----------|-----------------|
| Adj. R² missing | Tables 6, 8, 9 | **Major** — field convention | Requires Stata re-run with `estadd scalar r2_a` |
| `\hline` → `\midrule` | Tables 1-3 (descriptive stats) | Moderate | Replace with booktabs `\midrule` |
| Panel label style inconsistency | Table 3 uses `\textbf{}`, Tables 8-9 use `\textit{}` | Moderate | Unify to `\textit{}` throughout |
| Notes location inconsistency | Tables 4, 6, 7: notes in `.tex` files; Tables 5, 8, 9: notes in `main.tex` | Moderate | Move all notes to `.tex` files for consistency |
| Sample period missing from captions | Tables 1, 3 | Minor | Add "Dec 2014 -- Dec 2018" to captions |

### Estimated Score: ~75/100 (pre-fix) → ~85/100 (post-fix, excluding Adj. R² which requires re-run)

---

## Agent 6: JF Referee Assessment

**Simulated Rating: Borderline**
**Recommendation: Revise before submitting to JF. Strong JFQA/RFS paper now.**

### Summary Assessment

The paper addresses an important question (do fund managers exploit private information from lending operations?), uses institutional data with genuine advantages over stock-level alternatives, and achieves clean identification via within-fund-security variation and the disclosure event design. The passive fund placebo is convincing. The within-family spillover decomposition (same-manager vs. cross-manager) is the paper's most novel contribution relative to Honkanen (2025, JFQA).

Weaknesses at JF bar: (1) IV design is asserted but not formally implemented with diagnostics; (2) timing asymmetry (β_lead >> |β_lag|) is noted but not tested; (3) no return evidence to support the welfare claim; (4) mechanical autocorrelation from lending-termination confound is not addressed.

### Required for JF Submission (Priority 1)

| Item | Description | Output |
|------|-------------|--------|
| **3.1 Formal IV Design** | Implement passive family lending as instrument with first-stage F-stat and exclusion restriction discussion | New table (Table 6 revision or appendix) |
| **3.2 Wald Test: Timing Symmetry** | Formal H₀: β_lead = β_lag (currently -0.87 vs -0.30, t=-1.34); report χ² and p-value | Footnote + table addition |
| **3.3 Return Predictability** | Risk-adjusted returns for active lenders in month before disclosure; confirms economic benefit of information | New table (Internet Appendix or paper) |
| **3.4 Mechanical Autocorrelation Diagnostic** | Exclude lending-termination months; test AR(1) residuals (Wooldridge); lending decreases mechanically follow position reductions | Robustness table row |
| **3.5 Remove "we plan to" language** | `empirical_strategy.tex` lines 42, 54; `information_channel.tex` footnote 17 | Text edit |

### Suggested for JF (Priority 2–3)

| Item | Description | Impact |
|------|-------------|--------|
| **5.1 Event-study figure** | Position changes for active lenders vs non-lenders around disclosure window (months -6 to +6) | High visual impact; standard at JF |
| **5.2 Short-seller identity heterogeneity** | Do funds respond more when borrower is a historically accurate short seller? Requires borrower identity data | High — strengthens information channel |
| **5.3 SFTR post-period** | SFTR implemented 2020; compare pre/post as falsification | Moderate |
| **5.4 Multiple testing corrections** | Romano-Wolf corrections for Table 9 triple interactions | Moderate — standard at JF for multiple outcomes |

### Missing Citations

| Citation | Why Needed |
|----------|-----------|
| Blocher & Ringgenberg (2023, JFE) | Short interest and return predictability; highly relevant |
| Massa, Qian, Shi, Zhang (2015, JF) | Fund managers and information acquisition from institutional networks |

### JF Referee Score: ~60/100 as-is | ~75/100 for JFQA/RFS | ~85/100 for JF post-required additions

---

## Consolidated Priority List

### Critical (block submission at any journal)
1. Remove "we plan to... in the revision" language (3 locations)
2. Remove phantom equation terms — DONE
3. Resolve "uninformative" vs "economically non-negligible" contradiction in abstract

### Major (block JF; strong JFQA recommendation to fix)
4. Add Adj. R² to Tables 6, 8, 9 (requires Stata re-run)
5. Formal IV with first-stage diagnostics
6. Wald test for timing symmetry
7. Welfare language in conclusion (add evidence or remove)
8. Weaken "consistent only with" language
9. Table 5 FE structure caption clarification

### Moderate (improve paper quality)
10. Return predictability table
11. Mechanical autocorrelation diagnostic
12. Add missing citations (Blocher & Ringgenberg 2023; Massa et al. 2015)
13. Fix descriptive tables (\hline → \midrule; panel label unification)
14. Standardize table notes location
15. Add sample period to Table 1 and 3 captions

### Minor (polish)
16. Reduce "consistent with" frequency (15+ → ~5)
17. γ₁ vs γ notation unification
18. Sample period in Table 1 and 3 captions

---

## Quality Score Summary

| Component | Agent | Pre-Fix Score | Post-Fix Score | Threshold | Status |
|-----------|-------|--------------|----------------|-----------|--------|
| Spelling/Grammar/Style | Agent 1 | 88/100 | 88/100 | 80 | PASS |
| Internal Consistency | Agent 2 | 78/100 | 82/100 | 80 | PASS (post-fix) |
| Unsupported Claims | Agent 3 | 75/100 | 75/100 | 80 | FAIL — welfare language open |
| Math/Equations | Agent 4 | 51/100 | ~80/100 | 80 | PASS (post-fix) |
| Tables/Documentation | Agent 5 | 75/100 | ~85/100 | 80 | PASS (post-fix, Adj. R² pending) |
| JF Referee | Agent 6 | 60/100 | — | 80 (JF) | FAIL for JF; ~75 for JFQA |

**Weighted aggregate (renormalized, excluding code/lit/data):**
- Manuscript polish (Agent 1): 15% weight → 88 × 0.15 = 13.2
- Internal consistency (Agent 2): 15% weight → 82 × 0.15 = 12.3
- Claims (Agent 3): 20% weight → 75 × 0.20 = 15.0
- Equations (Agent 4): 15% weight → 80 × 0.15 = 12.0
- Tables (Agent 5): 15% weight → 85 × 0.15 = 12.75
- Referee (Agent 6): 20% weight → 75 × 0.20 = 15.0 (JFQA target)

**Estimated aggregate: ~80/100 (JFQA target) | ~70/100 (JF target)**

**Verdict:** Paper meets JFQA/RFS submission threshold post-fix. JF submission requires completion of Priority 1 items.
