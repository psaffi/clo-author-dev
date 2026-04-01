# Domain Profile

## Field

**Primary:** Financial Economics — Market Microstructure, Securities Lending, Institutional Investors
**Adjacent subfields:** Asset Pricing, Corporate Finance, Information Economics

---

## Target Journals (ranked by tier)

| Tier | Journals |
|------|----------|
| Top-5 | JF, JFE, RFS, AER, Econometrica |
| Top field | JFQA, Management Science, RCFS |
| Strong field | Review of Finance, JBF, JFAI |
| Specialty | Journal of Banking & Finance, JFM |

---

## Common Data Sources

| Dataset | Type | Access | Notes |
|---------|------|--------|-------|
| Bundesbank IFS | Admin/regulatory panel | Restricted (on-site) | Security-level fund holdings and lending positions, monthly |
| IHS Markit (now S&P) | Securities lending data | Commercial | Stock-level lending supply, demand, fees, utilization |
| Datastream | Stock prices/returns | Commercial | Standard stock-level data for developed markets |
| Morningstar | Fund characteristics | Commercial | Fund style, AUM, flows, expenses, age, manager info |
| CRSP MF Database | US fund data | Academic | Standard for US mutual fund research |
| Thomson Reuters 13F | US institutional holdings | Public (SEC) | Quarterly holdings for US institutions |
| Kenneth French Library | Risk factors | Public | Regional Fama-French and Carhart factors |

---

## Common Identification Strategies

| Strategy | Typical Application | Key Assumption to Defend |
|----------|-------------------|------------------------|
| Within-fund variation (saturated FE) | Security x Time + Fund x Time + Fund x Security FE | Absorbs all time-varying fund and stock heterogeneity; variation comes from within-fund-stock changes in lending |
| Disclosure events as information shocks | Mandatory short position disclosure (EU regulation) as exogenous revelation of short-seller identity | Disclosure timing is regulatory, not strategic; funds do not anticipate specific disclosure events |
| Passive fund lending as instrument | Passive fund lending as source of exogenous lending variation | Passive funds do not trade on lending information; lending driven by portfolio composition |
| Within-family spillovers | Same-manager vs. cross-manager lending within fund family | Family organizational structure is pre-determined relative to lending decisions |

---

## Field Conventions

- Double-cluster standard errors by Fund and Time for panel regressions
- Report t-statistics in parentheses (not standard errors) — field convention in finance
- Use Carhart four-factor alpha (market, SMB, HML, UMD) as primary risk adjustment
- Report economic magnitudes alongside statistical significance
- Saturated fixed effects (three-way FE) as gold standard for within-variation identification
- Active vs. passive fund distinction is standard in mutual fund literature
- Securities lending variables: On Loan as % of market cap (stock level) or % of position (fund level)
- Report Adjusted R-squared, not R-squared

---

## Notation Conventions

| Symbol | Meaning | Anti-pattern |
|--------|---------|-------------|
| $PosChange_{i,j,t}$ | Position change (%) of stock $i$ by fund $j$ in month $t$ | Don't use $\Delta h$ without subscripts |
| $OnLoan_{i,j,t}$ | Share of position $i$ lent by fund $j$ at time $t$ | Don't use generic $L$ or $Lend$ |
| $D(Lender)_{j,t}$ | Indicator: fund $j$ is lending at time $t$ | Don't use $I_{lend}$ |
| $Disclosure_{i,t}$ | Indicator: stock $i$ has mandatory short disclosure at $t$ | Specify lead/lag: $Disclosure_{i,t+1}$ |
| $sh\_sec\_lend_{i,j,t}$ | Fraction of position $i$ lent by fund $j$ at $t$ | Use consistent naming across tables |

---

## Seminal References

| Paper | Why It Matters |
|-------|---------------|
| Duffie, Garleanu, Pedersen (2002) | Theoretical foundation: lending fees capitalize in stock prices |
| Prado (2015, JFQA) | Institutions buy stocks in response to lending fee increases |
| Evans, Ferreira, Prado (2017, RoF) | Lending funds underperform — fail to exploit borrowing demand signal |
| Honkanen (2025, JFQA) | US evidence: active funds reduce positions in lent stocks; family spillovers |
| Nurisso (2026, JFE) | Theory: learning by lending, commitment problem, passive lender advantage |
| Palia, Sokolinski (2024, RoF) | Short sellers strategically borrow from passive investors |
| Chague, Giovannetti, Herskovic (2025) | Brokers leak information about short sellers to clients |
| Jones, Reed, Waller (2016, RFS) | Mandatory short disclosure reduces short selling and price informativeness |
| Chen, Desai, Krishnamurthy (2013, JFQA) | Funds that short sell demonstrate stock-picking skill |
| Saffi, Sigurdsson (2011, RFS) | Short-sale constraints and stock price informational efficiency |

---

## Field-Specific Referee Concerns

- "Is this just reverse causality — do funds sell first and then stop lending?" Must show lending precedes trading
- "Why don't passive funds react?" Must demonstrate clean placebo
- "Is this mechanical — fewer shares to lend after selling?" Must use intensive margin / saturated FE
- "External validity — German market is small" Must compare to US evidence (Honkanen 2025)
- "Family-level coordination vs. manager-level information" Must decompose channels (Table 8)
- "Why not use stock-level lending data (Markit) instead?" Must justify fund-level data advantage
- "Endogeneity of lending participation" Must address selection into lending
- "Economic significance — how large are the position changes?" Must report magnitudes relative to mean

---

## Quality Tolerance Thresholds

| Quantity | Tolerance | Rationale |
|----------|-----------|-----------|
| Point estimates | 1e-4 | Coefficient precision in panel regressions |
| t-statistics | 0.01 | Clustering affects inference |
| Adjusted R-squared | 0.001 | Saturated FE models have high R-squared |
| Observation counts | Exact match | Must match across specifications |
