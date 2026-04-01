---
name: Domain Referee Report
description: Blind peer review — domain specialist — Securities Lending and Information Acquisition
type: project
date: 2026-04-01
score: 74/100
recommendation: Major Revisions
---

# Domain Referee Report

**Date:** 2026-04-01
**Paper:** Securities Lending and Information Acquisition
**Authors:** Greppmair, Jank, Saffi, Sturgess
**Field:** Financial Economics — Market Microstructure, Securities Lending, Institutional Investors
**Target Journal:** JF / JFE / RFS
**Recommendation:** Major Revisions
**Overall Score:** 74/100

---

## Summary

This paper asks whether active mutual fund managers exploit securities lending as a private information channel, reducing portfolio positions in stocks they lend when short-selling demand signals are high. Using unique regulatory data from the Deutsche Bundesbank (320 German open-end equity mutual funds, December 2014–December 2018), the authors document that active funds reduce positions in lent stocks by approximately 0.33 percentage points per standard deviation of lending activity, with no corresponding reaction among passive funds. The paper's most distinctive contribution is using mandatory EU short-position disclosures as an external validation device: active lenders reduce positions substantially more in the month before a large short position becomes public, a timing pattern consistent with information acquisition rather than mechanical effects.

The paper is positioned well in an active literature, the Bundesbank data are genuinely unique, and the disclosure identification strategy is creative. However, the paper has significant unresolved issues in causal identification, sample scope, statistical power in the key tables, and missing robustness checks that must be addressed before publication at a top-5 finance journal.

---

## Dimension Scores

| Dimension | Weight | Score | Notes |
|-----------|--------|-------|-------|
| Contribution & Novelty | 30% | 76 | Incrementally strong over Honkanen (2025); disclosure design genuinely novel; but German-only sample and monthly frequency limit scope |
| Literature Positioning | 25% | 78 | Good coverage of core papers; several related works missing; Evans/Ferreira/Prado "resolution" claim overstated |
| Substantive Arguments | 20% | 68 | Economic magnitudes meaningful but several key interactions only marginally significant; mechanism plausible but not airtight; welfare discussion thin |
| External Validity & Scope | 15% | 62 | German market has idiosyncratic lending structure; four-year sample includes exceptional macro events; passive fund placebo has internal threats |
| Journal Fit | 10% | 78 | Right question for JF/JFE/RFS; data uniqueness supports top-journal case; revision work needed before competitive at this tier |
| **Weighted** | 100% | **74** | |

---

## Major Comments

### 1. The Disclosure Sample Creates a Severe Selection Problem

The key identification test is estimated on only 39,109–42,512 observations (compared with over one million in the baseline). This is a 96% reduction. The paper restricts to "stocks that were ever publicly disclosed as having a large net short position" and then further to ±3 months of a first-time disclosure event.

This creates a serious selection problem. Stocks with mandatory disclosure events are not a random subset: they are precisely the stocks with the most intense short-selling activity. The treatment group — "lend stock i before it crosses the disclosure threshold" — is mechanically correlated with the stock being heavily shorted, which is also when informationally-motivated selling would be highest for any fund, not just lenders.

The authors must either: (a) demonstrate that the disclosure interaction effect is present for lenders but not for non-lenders holding the same stock and show this comparison explicitly; (b) use the full sample with a broader set of disclosure events; or (c) provide a falsification test using stocks with similar aggregate short interest that do not receive a disclosure within the sample period.

### 2. The Passive Fund Placebo Has Internal Validity Threats

The paper's central identification argument relies on the active-passive split: passive funds "cannot freely adjust holdings" and serve as a placebo. Several unaddressed threats:

First, passive funds in Germany are not all pure index trackers. Some use sampling-based or optimization-based replication that allows non-trivial benchmark deviation. The paper should document the tracking error distribution for passive funds and verify the "passive" designation is well-defined. If R-squared is below 95–98% against benchmark, the no-trading assumption is not clean.

Second, passive funds can and do engage in minor rebalancing around corporate events, constituent changes, and dividend dates. If these coincide systematically with disclosure events, the placebo test is contaminated.

Third, passive funds in Germany lend at a dramatically higher rate (69.81%) than active funds (25.47%). The text should address why passive funds with high lending rates do not develop any informal trading discretion, and whether German passive fund managers have documented compliance-enforced restrictions.

### 3. Reverse Causality Is Not Adequately Addressed

The paper argues funds observe short-selling demand through lending and then trade. The alternative — that funds plan to reduce a position for unrelated reasons, lend the stock as a transitional holding strategy while reducing, and then close — is not fully ruled out. The three-way fixed effects absorb stock-time, fund-time, and fund-stock levels, but not the joint fund-stock-time interaction itself.

The passive fund IV is valuable, but the instrument — passive fund lending in the same family — is not exogenous if passive and active funds share portfolio review meetings or if the family's CIO coordinates sector exposures across fund types.

A sharper falsification: does the trading response to passive fund lending in family f differ for active funds in family f versus active funds in a different family holding the same stock?

### 4. The Market Structure Results Have an Aggregation Problem

Section 6 switches from fund-level to family-level lending ($OnLoan_{i,f,t-1}$). When the regressor moves to family-level, family-level time-varying unobservables — e.g., the family's investment committee simultaneously deciding to underweight a sector and shifting lending decisions for that sector — are not absorbed by any of the three fixed effects. The "unreported robustness tests" at the fund level should be included as a formal table.

### 5. Statistical Power Is Marginal in Key Specifications

The paper's flagship result rests on interactions with modest t-statistics in the most demanding specifications:

- Table 5, column 4 (saturated FE): t = -2.22 (barely 5%)
- Table 7, column 4 (timing, saturated FE): t = -2.27
- Table 9, column 3 (stock HHI triple): t = -1.80 (10% only)
- Table 9, column 7 (family HHI triple): t = -1.94 (10% only)
- Table 9, column 9 (1/StocksHeld triple): t = -1.72 (10% only)

With double-clustering in a disclosure sample of ~39,000 observations, standard error estimates depend critically on cluster counts. The paper must report the number of unique time and fund clusters in the disclosure sample, and should provide wild cluster bootstrap p-values for the key interaction terms.

### 6. No Return Prediction Test

A conspicuous absence is any test linking the documented position changes to subsequent fund performance or stock returns. If active lenders are genuinely acquiring information and trading on it, the stocks they reduce before disclosure should deliver negative abnormal returns over the subsequent one to three months. Without this test, the paper demonstrates a trading pattern but not that the information is actually valuable — and therefore does not deliver on its title's promise of "information acquisition."

The paper must include at minimum: (a) a stock-level test of whether stocks reduced more heavily by active lenders before disclosure deliver lower abnormal returns; and (b) a fund-level performance comparison of active lending funds against observationally equivalent non-lending active funds in the German sample.

### 7. Sample Period and Temporal Generalizability

The sample covers only four years (2014–2018), a period including the Brexit referendum, the 2016 U.S. presidential election, and the 2018 global equity drawdown — exceptional periods for short selling. The paper should provide evidence that results are stable across subperiods and should discuss how SFTR (effective 2020) affects the channel going forward.

---

## Minor Comments

1. **Introduction, Evans/Ferreira/Prado claim:** The claim that "our results offer a partial resolution" to the EFP underperformance puzzle is overstated. EFP document underperformance for lending funds versus non-lending funds; the current paper documents that lending funds reduce positions in lent stocks. A fund can reduce a position while still underperforming if the lending revenue drag outweighs the information benefit. Soften this claim or provide performance evidence.

2. **Clustering inconsistency:** The baseline SE clustering (fund-only, Table 4) should be checked for robustness to double-clustering, since aggregate lending demand is also correlated across funds in the same month.

3. **Table 5, columns 5–7 appear redundant:** Coefficients in columns 5–7 nearly replicate columns 1–3. The distinction must be explained explicitly or the columns dropped.

4. **Table 7 N discrepancy:** The discrepancy (col 2: N=42,522 vs. cols 3–4: N=42,512) is noted in the table footnote but should be mentioned in the text where Table 7 is discussed.

5. **Family channels: large coefficient variation:** Same-manager coefficient ranges from -0.7283 (col 2) to -1.9166 (col 6) — a factor of 2.6x. Explain what drives this variation.

6. **Six-month disclosure lookback is ad hoc:** Show robustness to three-month and twelve-month lookback windows.

7. **Lending fee heterogeneity not explored:** Prado (2015) shows institutions buy stocks in response to lending fee increases. The complementary test — whether funds with stocks commanding higher fees show amplified position reductions — is a natural heterogeneity test.

8. **Welfare discussion incomplete:** The claim that fragmenting the lending market "may diminish informational efficiency gains" conflates the efficiency channel (faster price discovery) with the redistribution channel (trading against uninformed investors). These should not be conflated.

9. **Notation inconsistency:** The data section introduces $sh\_sec\_lend_{i,j,t}$ (fraction of position lent) but the regression uses $OnLoan_{i,j,t}$ (lending/market cap). The appendix now notes the relationship but should be more explicit about why market-cap normalization is preferred.

10. **±3 month window sensitivity:** Show robustness to ±1 month and ±6 month windows.

---

## Missing Literature

1. **Cohen, Diether, Malloy (2007, JF):** CDM's decomposition of demand vs. supply shifts is directly relevant to interpreting $OnLoan_{i,j,t-1}$ as a demand signal.

2. **Ozsoylev, Walden, Yavuz, Bildik (2014, RFS):** "Investor Networks in the Stock Market." The family spillover results imply an information network; this literature provides theoretical grounding.

3. **Cohen, Frazzini, Malloy (2008, JF):** Connected funds trade similarly — directly relevant to why same-manager lending generates stronger responses.

4. **Jank, Roling, Smajlbegovic (2020):** Should be engaged more deeply on the "shadow zone" below the 0.5% threshold — exactly where the paper's private information channel operates.

5. **Palia and Sokolinski (2024, RoF):** If active funds trade on lending signals, why don't short sellers avoid them? The endogenous matching between borrowers and lenders should be discussed explicitly.

---

## Questions for the Authors

1. How many unique stocks, unique disclosure events, unique fund-stock pairs, and unique months are in the disclosure sample?
2. How many unique fund and time clusters in the double-clustered specifications?
3. What is the tracking error distribution for the 53 passive funds?
4. What are the results if the "new disclosure" lookback window is 3 months or 12 months?
5. Do active lending funds earn higher Carhart four-factor alpha than non-lending active funds in German data?
6. Is the trading response to passive fund lending (Table 6) exclusive to same-family active funds, or do cross-family active funds holding the same stock also respond?
7. Please provide the formal market structure table using fund-level lending.
8. Are ever-disclosed stocks systematically larger/more liquid than other portfolio stocks?

---

## Overall Assessment

This is a well-motivated paper with a genuinely unique dataset and a creative identification strategy. The Bundesbank IFS data — security-level lending positions for the universe of German funds — is a real contribution. The use of mandatory EU short-position disclosures as an external validation device is novel.

The paper is not ready for publication at JF/JFE/RFS in current form. The fundamental concerns are: (1) disclosure sample selection is unresolved; (2) the passive fund placebo needs validation; (3) there is no return prediction test; (4) the market structure section's family-level aggregation is not robustly supported; and (5) several key t-statistics are below 2.5 in the most demanding specifications. These are addressable but require substantial new analysis.

**Recommendation: Major Revisions.** If the authors address comments 1, 5, and 6 (selection, power, and return tests) in particular, the paper would be substantially stronger and competitive for the target journal tier.
