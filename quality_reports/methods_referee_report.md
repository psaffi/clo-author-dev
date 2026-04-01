---
name: Methods Referee Report
description: Blind peer review — econometrics/methods specialist — Securities Lending and Information Acquisition
type: project
date: 2026-04-01
score: 72/100
recommendation: Major Revisions
---

# Methods Referee Report

**Date:** 2026-04-01
**Paper:** Securities Lending and Information Acquisition — Greppmair, Jank, Saffi, Sturgess
**Design:** Saturated Three-Way Panel FE with Mandatory Disclosure Interaction; Passive-Fund Lending as Exogenous Variation
**Target Journal:** JF / JFE / RFS
**Recommendation:** Major Revisions
**Overall Score:** 72/100

---

## Summary

This paper asks whether mutual fund managers extract private information from their securities lending activity and reduce portfolio positions accordingly. The core specification is a three-way saturated fixed-effects regression (security×time, fund×time, fund×security), with EU mandatory short-position disclosure events as external validation of the information channel. The question is well-motivated, the data are unique, and the disclosure identification design is the paper's genuine strength.

However, the paper requires major revision on at least four econometric grounds: the fund×security fixed effect with a lagged own-lending regressor creates a mechanical negative-bias risk that is unaddressed; the passive-lending exercise in Table 6 is labelled as addressing endogeneity but is implemented as a reduced-form substitution without a first stage; the timing asymmetry test in Table 7 is partially tautological given the sample window construction; and the switch from fund-level to family-level lending in Table 9 is accompanied by ten simultaneous hypothesis tests and no multiple-testing correction.

---

## Dimension Scores

| Dimension | Weight | Score | Notes |
|-----------|--------|-------|-------|
| Identification | 35% | 68 | Three-way FE conceptually sound; disclosure design genuine strength; timing test partially tautological; mechanical-feedback risk unaddressed |
| Estimation | 25% | 74 | Estimand well-matched in Tables 4–5 and 7–8; Table 6 is not IV; level-of-analysis switch in Table 9 inadequately defended |
| Inference | 20% | 76 | Double-clustering in Tables 5–9 appropriate; fund-only clustering in Table 4 thin; no multiple-testing correction across 10 Table 9 hypotheses |
| Robustness | 15% | 68 | No Oster bounds; no alternative window widths; lag interaction in Table 7 col. 4 at t = −1.34 not as clean as claimed; no placebo on non-disclosure stocks |
| Replication | 5% | 70 | Variable definitions adequate; code and data not provided; standardization procedure in footnote only |
| **Weighted** | **100%** | **72** | |

---

## Sanity Check

- **Sign:** Plausible. Negative β on OnLoan_{i,j,t-1} is consistent with informed selling before short-sale pressure materializes. Direction replicates Honkanen (2025) and matches the theoretical prior from Nurisso (2026).

- **Magnitude:** Plausible but requires calibration. The baseline effect of −0.21 to −0.33 pp per SD of lending on monthly position growth is roughly a 1.3% standardized effect (relative to SD of PosChange = 25.16 pp). The disclosure interaction amplifies this to −0.86 pp. The paper does not provide a back-of-envelope reconciliation with the Evans-Ferreira-Prado underperformance puzzle (50–70 bps/year). Such a calculation is feasible and should appear.

- **Dynamics:** Partially coherent. The lead interaction is −0.82 (t = −2.62) and the contemporaneous interaction is near zero (t = 0.08). However, in the saturated FE column (col. 4), the lagged interaction is −0.30 with t = −1.34 — substantively non-negligible and one-sided borderline. The paper claims this is "small and insignificant" but does not report the Wald test H0: β_lead = β_lag. This is required.

- **Consistency:** Partially stable. The family-level lending baseline is −0.42 (Table 9) versus −0.28 (Table 5 col. 1) — a 50% increase attributed to information aggregation but not formally reconciled.

---

## Major Comments

### 1. Fund×security FE with lagged own-lending creates an unaddressed mechanical negative-bias risk

The fund×security fixed effect α_{i,j} demeans OnLoan_{i,j,t-1} within each fund-stock cell. Because the lending variable is zero in most observations (only 2% have D(On Loan) = 1) and positive in lending months, the within-cell demeaned residual is positive in lending months and negative in non-lending months. If a fund reduces its position precisely because lending terminates — the most natural mechanical story — then PosChange_{i,j,t} is negative in the months following high within-cell lending residuals. This creates a negative β_1 that is partially mechanical.

The authors must: (a) report results excluding fund-stock cells where lending terminates within the next three months; (b) show that results survive using sh_sec_lend_{i,j,t} as an alternative lending measure not mechanically related to absolute position size; and (c) provide an AR(1) test of residuals at the fund-stock level to document the absence of dynamic misspecification.

### 2. Table 6 is a reduced-form substitution, not an IV — the endogeneity claims are overstated

No first stage is reported, no Kleibergen-Paap or Cragg-Donald F-statistic is provided, and the coefficient is not scaled to produce a LATE. Table 6 is a legitimate robustness exercise but cannot be characterized as resolving endogeneity without a formal IV structure.

The exclusion restriction — that passive fund lending affects active fund trading only through the family's private information channel — is asserted but not tested. Two violations are plausible: (a) correlated supply shocks where a large short seller approaching family f triggers both passive lending and active rebalancing; and (b) common benchmark exposure where passive and active funds are both overweight stock i due to index composition. The fund×time FE does not absorb these family-stock-time coincidences.

The authors must either implement a genuine 2SLS with a reported first stage and weak-IV diagnostic, or re-label Table 6 as a "reduced-form robustness check" and temper the endogeneity language throughout.

### 3. The timing asymmetry test in Table 7 is partially tautological

The ±3-month disclosure window means Disclosure_{i,t-1} = 1 precisely in months when the short position is already public. In these months, any information-driven reduction has already occurred and position changes revert toward zero. This mechanically suppresses the lagged interaction independent of any true asymmetry. The window construction therefore tilts toward finding the lead coefficient significant and the lag coefficient zero by construction.

The authors must: (a) formally test H0: β_lead = β_contemporaneous, H0: β_lead = β_lag, and H0: β_contemporaneous = β_lag using Wald tests; (b) report robustness to ±1-month and ±6-month windows; and (c) acknowledge in the text that the lag coefficient is mechanically dampened by the post-disclosure information environment.

### 4. Level-of-analysis switch in Table 9 is inadequately defended and creates a multiple-testing problem

Tables 4–8 use OnLoan_{i,j,t-1} (fund-security-level). Table 9 switches to OnLoan_{i,f,t-1} (family-level aggregate) but retains fund×security fixed effects — a mismatch where multiple active fund observations within the same family and stock-month share the identical RHS value. Double-clustering by fund and time does not adequately address this if the relevant cluster is (family × time).

Additionally, Table 9 tests ten distinct interaction hypotheses (five concentration measures × two interaction terms). No multiple-testing correction is applied. A Bonferroni threshold at 5% family-wise error rate requires |t| ≥ 3.29 for ten simultaneous tests. Seven of the ten interaction estimates fall below this threshold. Romano-Wolf step-down corrections must be applied.

The "unreported robustness" using fund-level lending must be reported as a formal table — not merely referenced in a footnote.

### 5. Exclusion restriction for passive family lending is asserted, not tested

The exclusion restriction requires that passive fund lending does not predict active fund position changes through any channel other than within-family information transmission. Two alternative channels are economically plausible and untested:

(a) Common lender-borrower relationship: a short seller who approaches family f simultaneously negotiates borrowing from both passive and active funds; active fund position reduction then reflects a direct demand signal from the borrower, not internal information transmission.

(b) Benchmark-driven joint exposure: both passive and active funds in family f hold concentrated positions in stock i due to common benchmark weights; any shock to stock i simultaneously increases passive lending and decreases active fund positions.

At minimum, estimate the Table 6 specification on the subsample where the passive fund's benchmark weight in stock i is in the bottom quartile, where the correlated-benchmark channel is least operative.

---

## Minor Comments

**6. N discrepancy in Table 7 (Replication):** Column 2 has N = 42,522 versus N = 42,512 in columns 1, 3, 4. The table note explains this, but the ten extra observations should be excluded from column 2 as well, so that the stepwise addition of variables is fully comparable across all columns.

**7. Winsorization specification is ambiguous (Estimation):** "Winsorized at the 99.5% level" — does this mean one-sided (top 0.5%) or two-sided (top and bottom 0.5%)? For the paper's hypothesis, the left tail of PosChange (large sales) is the informative tail. Symmetric truncation of the bottom 0.5% censors the most relevant variation. Clarify and report robustness at 99th and 99.9th percentile.

**8. Uninteracted Disclosure coefficient is positive in non-saturated specs (Specification):** In Table 5 columns 2–3, uninteracted Disclosure_{i,t+1} is +0.36 (t = 1.25). This implies non-lenders are growing positions in stocks about to be disclosed. Combined with the negative interaction for lenders, this means non-lenders actually increase positions when a disclosure is imminent — worth brief acknowledgment.

**9. Fund-level clustering in Table 4 needs additional defense (Inference):** Verify that t-statistics in Table 4 do not shrink materially under double-clustering by fund and time (as used in Tables 5–9). The inconsistency in clustering between Table 4 and Tables 5–9 is at minimum cosmetically undesirable.

**10. ever_LSP=1 filter selects on realized outcomes (Sample Construction):** Conditioning on stocks that were ever publicly disclosed means stocks in the disclosure sample are those that attracted large short positions at some point during the sample — forward-looking selection. Report the Table 4 baseline restricted to ever_LSP=1 stocks to verify the disclosure subsample is not unusual on the baseline lending-position relationship.

**11. Table 8 FE structure jump is unexplained (Specification):** The same-manager coefficient roughly doubles from separate FE (cols. 1–4: ~−0.80) to saturated FE (cols. 5–6: ~−1.56). Adding FE typically attenuates coefficients; the reversal here is unexplained and should be addressed.

**12. No placebo test using wrong-group or wrong-timing disclosures (Robustness):** A stronger placebo would: (a) test the specification on lenders in stocks about to receive a second or third disclosure (where information content is lower); or (b) test active lenders in stocks where the fund was not lending at the time — if non-lenders also reduce positions ahead of disclosure, the information-from-lending story is undermined.

---

## Technical Suggestions

1. **Mechanical feedback diagnostic.** Estimate equation (2) augmented with PosChange_{i,j,t-1}. Additionally, report results excluding observations where lending terminates (OnLoan_{i,j,t-1} > 0 and OnLoan_{i,j,t} = 0).

2. **Implement a genuine IV first stage.** Report first-stage regression with OnLoan_{i,j,t-1} as dependent variable and OnLoan_{i,f-passive,t-1} as instrument. Report Kleibergen-Paap clustered F-statistic. Add 2SLS column and report LATE.

3. **Formal Wald tests for timing asymmetry.** In Table 7, add a panel reporting chi-squared tests for H0: β_lead = β_contemporaneous, β_lead = β_lag, and β_contemporaneous = β_lag.

4. **Window sensitivity.** Report the key disclosure interaction coefficient from Table 5 column 3 at ±1, ±2, ±3, ±4, and ±6-month windows.

5. **Romano-Wolf corrections for Table 9.** Apply step-down corrections to all 10 interaction p-values (Stata: rwolf; R: wyoung). Report both uncorrected and corrected p-values.

6. **Report fund-level Table 9.** Include the market structure analysis using fund-level lending as a reported appendix table.

7. **Oster (2019) sensitivity.** Apply the Oster delta-bound to the disclosure interaction to assess how large omitted-variable bias would need to be to eliminate the effect.

8. **Economic magnitude calibration.** Translate the −0.33 pp baseline estimate into annualized performance terms and compare to the Evans-Ferreira-Prado 50–70 bps underperformance benchmark.

---

## Questions for the Authors

1. Can you demonstrate — using simulation calibrated to your panel dimensions (T ≈ 49 months, ~2% D(On Loan) prevalence) — that the within-cell autocorrelation of OnLoan does not mechanically generate a negative β_1 through the Nickell-type mechanism?

2. What fraction of active-fund observations in the disclosure sample have at least one passive fund in the same family also holding stock i? Table 6 may be estimated on a differently selected subsample.

3. What is the unit interpretation of the triple interaction coefficient in Table 9, column 5 (−9.21)? A one-SD increase in family lending, combined with a one-SD increase in 1/ActiveAgents, when a disclosure follows — what economically interpretable position reduction does this imply?

4. In Table 8, the same-manager interaction roughly doubles from separate-FE to saturated-FE. What accounts for the reversal — that the saturated FE yields a larger coefficient?

5. The ever_LSP=1 filter: is it applied at the stock level or the stock-time level? Are stocks included in months before they receive their first disclosure?

6. For the passive fund placebo in Table 5 column 8: do passive funds hold the same set of ever-disclosed stocks as active funds in similar proportions? If passive funds' benchmark weights make them less likely to hold heavily-shorted stocks, the passive sample in column 8 may test a different cross-section.

---

## Overall Assessment

The paper has a genuine identification asset in the EU mandatory disclosure design, and the core result is directionally sound and replicates Honkanen (2025). The five major comments identify problems that are serious but addressable within a revision cycle.

The four most critical items requiring substantive new work are:

1. The mechanical negative-bias risk from the fund×security FE must be formally diagnosed and ruled out.
2. Table 6 must be restructured as a genuine IV with a reported first stage, or re-labeled as reduced-form with reduced endogeneity claims.
3. Table 7 must add formal Wald tests for β_lead = β_lag and window-sensitivity analysis before the asymmetry claim is credible.
4. Table 9 must report fund-level robustness, apply Romano-Wolf corrections, and formally justify the family-level aggregation.

**Recommendation: Major Revisions. Score: 72/100.**
