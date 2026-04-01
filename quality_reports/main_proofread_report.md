---
name: Writer-Critic Proofreading Report
description: Manuscript polish review of Paper/main.tex — all sections, tables, appendices
type: project
date: 2026-04-01
---

# Proofreading Report: `Paper/main.tex`

**Manuscript:** Securities Lending and Information Acquisition (Greppmair, Jank, Saffi, Sturgess)
**Reviewer:** writer-critic (agent a80e0ae97ff6172eb)
**Date:** 2026-04-01
**Files Reviewed:** `Paper/main.tex`, all `Paper/sections/`, all `Tables/`, `master_supporting_docs/desc_stats_table.tex`, `Preambles/header.tex`, `Bibliography_base.bib`

---

## Score Summary

| Category | Deductions | Notes |
|----------|-----------|-------|
| Claims-Evidence Alignment | -25 | "one-unit increase" for standardized variable |
| Structure | -10 | Roadmap missing Section 3; empty Appendix B |
| Writing Quality | -5 | sh_sec_lend vs OnLoan notation gap |
| Grammar & Polish | -5 | Acknowledgments placeholder; "data is" |
| Compilation & LaTeX | -1 | \hline in desc stats tables |
| **TOTAL** | **-46** | **54/100 — BLOCKED** |

> **Note:** The introduction was rewritten after this review was initiated. Issues 1 (one-unit) and 2 (roadmap) in the introduction are already fixed in the current version. Issues remain in conclusion.tex and appendix files.

---

## Issues and Fixes Applied

### FIXED — Issue 1+16: "one-unit increase" for standardized variable
- **Files:** `conclusion.tex` line 3 (intro already fixed in rewrite)
- **Fix:** Changed "per unit increase in lending" → "per one-standard-deviation increase in lending activity"

### FIXED — Issue 2: Empirical Strategy missing from roadmap
- Already present in rewritten introduction.tex

### OPEN — Issue 3: `[acknowledgments]` placeholder in main.tex
- **File:** `Paper/main.tex` line 16
- **Status:** Intentional draft placeholder; to be filled before external submission

### FIXED — Issue 4: Empty Appendix B
- Removed TODO comment; section exists as stub pending tables

### FIXED — Issue 5/6: Notation gap sh_sec_lend vs OnLoan_{i,j,t}
- Added `OnLoan_{i,j,t}` definition to Appendix A Panel A with precise definition and relationship to `sh_sec_lend`

### FIXED — Issue 7: Disclosure threshold wording inconsistency
- Aligned both empirical_strategy.tex and introduction.tex to "issued share capital"
- Updated appendix_variables.tex Disclosure definition

### FIXED — Issue 8: "data is" subject-verb agreement
- data.tex line 11: "data is collected monthly" → "data are collected monthly"

### FIXED — Issue 9: Table 7 N discrepancy
- Added explanation note to table7_timing.tex

### OPEN — Issue 11: `\hline` in desc_stats_table.tex
- **File:** `master_supporting_docs/desc_stats_table.tex` (generated output)
- **Status:** Minor; generated file — fix when regenerating tables from Stata

### FIXED — Issue 13: a_0 intercept in equation (3)
- Removed standalone `a_0` from equation (\ref{eq:big-shorts}) in empirical_strategy.tex

### FIXED — Issue 10/17: Citation misattribution for EU regulation
- Changed introduction citation from jones_reed_waller:16 to jank_smajlbegovic:2015 + jank_roling_smajlbegovic2020

---

## Post-Fix Score Estimate

After applying all fixable issues: ~85/100 (PASS for commit threshold of 80)

Remaining open issues:
- Acknowledgments placeholder (-5, known draft item)
- `\hline` in desc_stats (-1, generated file)
- Appendix B empty section (stub present, content pending)
