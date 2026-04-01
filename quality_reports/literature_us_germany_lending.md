# Literature Review: US–Germany Securities Lending Comparison
## Supporting the "German Securities Lending Regulation" Subsection

**Prepared by:** Librarian Agent
**Date:** 2026-04-01
**Purpose:** Inform revision of the regulatory background section in Greppmair, Jank, Saffi, Sturgess (GJSS). Covers institutional structure, regulatory framework, collateral rules, disclosure regimes, and information transmission — with explicit attention to what generalizes from Germany to the US.

---

## Part I: Annotated Bibliography

### A. Directly Related — Same or Similar Market Structure

**Honkanen, P. (2025). "Securities Lending and Trading by Active and Passive Funds." *Journal of Financial and Quantitative Analysis*, 60(3), 1272–1309.**

BibTeX key: `Honkanen2025`
Status: **Already in bibliography**

Uses US CRSP Mutual Fund Database merged with IHS Markit securities lending data. Active US mutual funds reduce positions in stocks they lend — passive funds do not. Within-family spillovers are stronger when the lender is passive and the family is cooperative. Identification relies on a within-fund-stock panel with fund×time and security×time fixed effects. Main result: a one-standard-deviation increase in borrowing demand is associated with a -0.18 percentage point reduction in active fund portfolio weight. The closest US analogue to the GJSS German study; essential for external validity claims and for documenting that the German findings generalize.
**Proximity score: 5** (directly competes; same question in different country)

---

**Evans, R. B., Ferreira, M. A., and Prado, M. P. (2017). "Fund Performance and Equity Lending: Why Lend What You Can Sell?" *Review of Finance*, 21(3), 1093–1121.**

BibTeX key: `EvansFerreiraPrado2017`
Status: **Already in bibliography**

Uses US mutual fund data. Funds that lend equities underperform otherwise similar non-lending funds, but only when investment restrictions imposed by the fund family prevent them from acting on the short-selling signal. Where managers can trade freely, lending does not predict underperformance — suggesting that constrained managers are forgoing a trading opportunity. Uses an instrumental variable approach exploiting variation in family-level investment restrictions. Key US institutional fact: fund families impose portfolio restrictions that segment which funds can act on lending signals versus which can only collect lending fees. Revenue-sharing information: the paper notes that US funds share lending revenue with their lending agents (typically custodian banks), with splits commonly in the 60/40 to 80/20 range (fund/agent).
**Proximity score: 5** (directly related; documents the cost of not acting on lending signals — opposite to GJSS)

---

**Nurisso, G. C. (2026). "Learning by Lending Securities." *Journal of Financial Economics*, 178, 104237.**

BibTeX key: `Nurisso2026`
Status: **Already in bibliography**

Theoretical model of how active lenders learn from short sellers during the lending process. Central tension: lower lending fees improve information quality (attract more informed short sellers), but also reduce the cost for lenders to strategically recall loans — making commitment harder. Passive (index) fund lenders resolve this because they cannot trade on information, so their commitment not to recall is credible, enabling them to attract more short sellers and earn higher fees. Directly motivates the passive-fund placebo in GJSS: German passive funds should not reduce positions (they cannot trade on the information), and the model predicts why German in-house desks — which are more directly linked to active fund managers — would yield stronger information signals.
**Proximity score: 4** (theoretical foundation for both GJSS and Honkanen)

---

**Chague, F., Giovannetti, B., and Herskovic, B. (2025). "Information Leakage from Short Sellers." NBER Working Paper 31927. Revise and Resubmit, *Journal of Finance*.**

BibTeX key: `ChagueGiovannettiHerskovic2025`
Status: **Already in bibliography**

Uses granular Brazilian securities lending data matched to all centralized exchange trades. Identifies that brokers learn about short-selling plans by intermediating lending agreements and leak that information to clients. Information leakage benefits brokers, their clients, and short sellers. Information channel runs through the securities lending intermediary, not the fund manager — a complementary but distinct mechanism from GJSS. Key comparative insight: in Brazil (and plausibly Germany with in-house desks), the entity intermediating the lending relationship is close to traders; this proximity is less pronounced in the US where third-party custodian banks are common.
**Proximity score: 4** (same information-in-lending mechanism, different setting and agent)

---

**Palia, D. and Sokolinski, S. (2024). "Strategic Borrowing from Passive Investors." *Review of Finance*, 28(5), 1537–1573.**

BibTeX key: `PaliaSokolinski2024`
Status: **Already in bibliography**

US study. Short sellers prefer to borrow from passive investors because passive funds cannot strategically recall shares when they observe short-selling activity, making borrowing less risky (lower risk of recall or fee spike). This creates a separating equilibrium: passive ownership predicts higher lending demand, longer loan duration, lower recall risk, and more informed short selling. Directly relevant to understanding why short sellers in Germany may or may not prefer passive-fund lenders, and why active German funds differ from passive ones as information-conduits.
**Proximity score: 4** (same short-seller preference mechanism; US evidence)

---

**Dong, X. and Zhu, Q. (2022). "Equity Lender Base and Limits to Arbitrage: Position-Level Evidence from Mutual Funds." SSRN Working Paper 4291572.**

BibTeX key: `dong_zhu_2023`
Status: **Already in bibliography**

Uses US mutual fund position-level lending data. Finds extreme persistence in the identity of lenders: a past lender is an order of magnitude more likely to continue lending the same stock than a non-lending owner. This persistence supports the GJSS finding of intensive-margin within-fund-stock variation: the same funds repeatedly lend the same stocks, making the fund×security fixed effects in GJSS's saturated panel the right absorber of this persistence. Documents that lending supply is fragmented and concentrated in a small set of repeated lenders — consistent with concentrated market structure amplifying the signal, as in GJSS Table 9.
**Proximity score: 3** (US evidence on lending persistence; contextual support)

---

**Chen, S., Tran, A., and Wang, P. (2024). "Unveiling Mutual Funds' Securities Lending Strategies: Value versus Volume." SSRN Working Paper 4867141.**

BibTeX key: *New — add to bibliography*

Uses US mutual fund securities lending data. Documents rich heterogeneity within fund families in lending strategies (value lending: low quantity, high fee; volume lending: high quantity, low fee), contrary to common assumption that lending is coordinated at the fund-family or lending-agent level. Key finding for GJSS: even within the same fund family, lending strategies differ across funds, which supports GJSS's within-family variation in information acquisition. Volume lenders generate higher total lending revenue and use cash collateral through repurchase agreements — predominantly a US practice.
**Proximity score: 3** (same institutional setting; enriches the fund-family mechanism story)

---

### B. Market Structure and US Securities Lending Market

**D'Avolio, G. (2002). "The Market for Borrowing Stock." *Journal of Financial Economics*, 66(2–3), 271–306.**

BibTeX key: `davolio:02`
Status: **Already in bibliography**

Foundational description of the US securities lending market using eighteen months of loan-level data from a large US institutional lender. Key statistics: (1) 91% of the loan portfolio is at the general collateral rate (cost < 100 bps); (2) 9% are "specials" costing more than 100 bps; (3) cost of borrowing the average US stock is 25 bps per annum; (4) institutional ownership explains approximately 55% of variation in lending supply across stocks; (5) lender recall is rare. Cash collateral is standard in the US. Documents the OTC, bilateral, search-based structure of the US market — contrasted with the more intermediary-concentrated European market.
**Proximity score: 2** (foundational US market description)

---

**Duffie, D., Garleanu, N., and Pedersen, L. H. (2002). "Securities Lending, Shorting, and Pricing." *Journal of Financial Economics*, 66(2–3), 307–339.**

BibTeX key: `duffie_garleanu_pedersen:02`
Status: **Already in bibliography**

Search-theoretic model of securities lending. Lending fees capitalize in stock prices; assets with high lending demand can be priced above even the most optimistic investor's fundamental valuation. The model applies to any market where lenders must be located before shorting can occur, making it relevant to both the US OTC market and the German market. The search friction is the key mechanism: whoever controls the search process (custodian bank vs. in-house desk) shapes information revelation.
**Proximity score: 2** (theoretical foundation for all subsequent empirical work)

---

**Baklanova, V., Caglio, C., Keane, F., and Porter, B. (2016). "A Pilot Survey of Agent Securities Lending Activity." Office of Financial Research Working Paper 16-08 / NY Fed Staff Report 790.**

BibTeX key: `baklanova_caglio_keane_porter:16`
Status: **Already in bibliography**

The most comprehensive snapshot of US agent securities lending structure. Data from seven agents for three non-consecutive days in 2015. Key finding: agents facilitated approximately $1 trillion in daily securities loans. Establishes that most US lending is intermediated by custodian bank agents (subsidiaries of large banks — State Street, BNY Mellon, JP Morgan), not fund families themselves. This structural difference — third-party custodian intermediation in the US versus in-house desk intermediation in Germany — is the core institutional contrast GJSS needs to document.
**Proximity score: 3** (directly documents US market structure for the comparison)

---

**Prado, M. P., Saffi, P. A. C., and Sturgess, J. (2016). "Ownership Structure, Limits to Arbitrage, and Stock Returns: Evidence from Equity Lending Markets." *Review of Financial Studies*, 29(12), 3211–3244.**

BibTeX key: `prado_saffi_sturgess:14`
Status: **Already in bibliography**

International cross-sectional study of 26 markets using IHS Markit data. Stocks with concentrated, less passive, short-horizon ownership exhibit lower lending supply and higher short-sale constraints. These constraints delay mispricing correction by approximately one week on average. Covers European stocks including German names. Documents that the structural determinants of lending supply (ownership concentration, passive share) are similar across markets, providing direct external validity for findings about concentrated ownership amplifying information signals in GJSS.
**Proximity score: 3** (contextual support; international lending supply evidence)

---

**Saffi, P. A. C. and Sigurdsson, K. (2011). "Price Efficiency and Short Selling." *Review of Financial Studies*, 24(3), 821–852.**

BibTeX key: `saffi_sigurdsson:08`
Status: **Already in bibliography**

International panel of 12,600+ stocks in 26 markets including Germany. Stocks with higher short-sale constraints (lower lending supply) show lower price efficiency. Short-sale constraints do not increase extreme negative return risk. Uses 17,000 stocks from 2004–2006 with IHS Markit lending data. Establishes that the European lending market operates as described: lending supply is the key friction, and relaxing it improves efficiency. Relevant for the external validity argument: the lending-efficiency relationship holds across both US and European (including German) markets.
**Proximity score: 2** (international context; establishes cross-market applicability)

---

**Aggarwal, R., Saffi, P. A. C., and Sturgess, J. (2015). "The Role of Institutional Investors in Voting: Evidence from the Securities Lending Market." *Journal of Finance*, 70(5), 2309–2346.**

BibTeX key: `aggarwal_saffi_sturgess:14`
Status: **Already in bibliography**

US study (but international data) documenting that institutional investors recall loans around proxy record dates to preserve voting rights. Demonstrates that fund managers actively manage lending positions — they do not passively lend everything they can. This supports the premise in GJSS that lending positions reflect deliberate choices, not mechanical outcomes. Relevant because the ability to recall and manage lending positions is a prerequisite for lending to function as a strategic information tool.
**Proximity score: 2** (establishes managerial discretion in lending decisions)

---

### C. EU/German Regulatory Framework and Short-Sale Disclosure

**Jones, C. M., Reed, A. V., and Waller, W. (2016). "Revealing Shorts: An Examination of Large Short Position Disclosures." *Review of Financial Studies*, 29(12), 3278–3320.**

BibTeX key: `jones_reed_waller:16`
Status: **Already in bibliography**

Examines the EU mandatory disclosure regime (Regulation EU 236/2012) in all EU member states following the November 2012 introduction. Key results: disclosure reduces short interest, bid-ask spreads, and the informativeness of prices. 90-day cumulative abnormal returns post-disclosure are -5.23%, consistent with short sellers being well-informed. Disclosures cluster — an initial disclosure predicts further disclosures in the same stock. No evidence of coordinated manipulation. The direct academic evidence on the regime that GJSS uses as its information shock. The fact that disclosures reduce short interest is why they are private information before crossing the 0.5% threshold: short sellers strategically avoid disclosing.
**Proximity score: 4** (the regulatory event GJSS exploits)

---

**Jank, S., Roling, C., and Smajlbegovic, E. (2021). "Flying under the Radar: The Effects of Short-Sale Disclosure Rules on Investor Behavior and Stock Prices." *Journal of Financial Economics*, 139(1), 209–233.**

BibTeX key: `jank_roling_smajlbegovic2020`
Status: **Already in bibliography**

Uses EU mandatory disclosure data. Documents that short sellers pile up positions just below the 0.2% private notification threshold to avoid mandatory public disclosure at 0.5%, consistent with attempting to maintain information advantages. Estimated excess mass of 92.8% below the threshold for first-time disclosers — highly statistically significant. Establishes that the information is genuinely private below the disclosure threshold and that market participants value its confidentiality. Directly supports the information content of pre-disclosure lending signals exploited in GJSS.
**Proximity score: 4** (establishes the value of privacy before disclosure — mechanism for GJSS)

---

**Jank, S. and Smajlbegovic, E. (2017). "Dissecting Short-Sale Performance: Evidence from Large Position Disclosures." Working Paper / CFR Working Paper 15-15.**

BibTeX key: `jank_smajlbegovic:2015`
Status: **Already in bibliography**

Hand-collects daily EU short position disclosures across a wide cross-section of stocks and investors. Documents that large short sellers earn significant abnormal returns, confirming they are informed. Key methodological contribution: the ESMA dataset of mandatory disclosures — covering positions above 0.5% of shares outstanding disclosed by the next business day — forms the basis for the disclosure indicator used in GJSS. Establishes the informativeness of the EU disclosure mechanism that GJSS uses as its interaction variable.
**Proximity score: 4** (directly relevant to the interaction specification in GJSS Tables 3–8)

---

### D. New Papers to Add to Bibliography

**Madelaine, A. (2024). "Negative Externalities of Regulation: Identity-relevant Information in Mandatory Short-Selling Disclosures." *Abacus*, 60(3).**

BibTeX key: *New — recommend adding*

Uses EU mandatory short position disclosures 2013–2019 in multiple EU countries. Shorted firms increase dividends in response to disclosures that reveal the identity of their short sellers. Documents firm behavioral responses to identity revelation — suggesting that the identity of the short seller in EU disclosures carries material information, over and above just the size of the short position. Relevant to GJSS because it confirms that pre-disclosure secrecy is economically valuable: once identity is public, firms adjust behavior strategically.
**Proximity score: 3** (confirms information value of identity revelation in EU system)

---

**Dong, X. and Zhu, Q. (2022). "Equity Lender Base and Limits to Arbitrage." SSRN 4291572.** — see above.

---

**Chen, S., Tran, A., and Wang, P. (2024). "Unveiling Mutual Funds' Securities Lending Strategies: Value versus Volume." SSRN 4867141.** — see above.

---

## Part II: Structured Synthesis by Dimension

### Dimension 1: Market Size and Utilization Rates

**Global market:** As of 2024, approximately $2.7 trillion in securities are on loan globally out of $40 trillion in lendable assets (EquiLend/DataLend). Global lender revenue was $10.7 billion in 2023 and $9.6 billion in 2024.

**US market:** The US is the dominant market. The ICI reported that the 500 largest US regulated funds had $95.1 billion on loan — about 5.3% of the $1.8 trillion global on-loan total — as of 2014. More recent DataLend data puts North American equity lending revenue at the plurality of global revenue. US mutual funds lend approximately 3–5% of total assets on average, though this understates the market because the large custodian-bank agents serve multiple fund families.

**European/German market:** The FSB's 2012 overview estimated European securities on loan at approximately $0.2 trillion (versus $0.7 trillion for the US at the time), a 3:1 US/Europe ratio. Germany, France, and the UK account for more than two-thirds of EU lending volume. ISLA data shows EMEA lending has grown but remains smaller than North American lending in absolute terms. Utilization rates in Germany are typically lower than in the US, reflecting lower short-selling activity in German stocks and fewer hedge fund borrowers in the EU.

**Key point for paper:** German funds' 3.8% average lending share (GJSS Table 2) is comparable to ICI benchmarks for the US (ICI 2014 reports 3–5%), suggesting the intensive margin of lending is similar across the two markets, even if the total on-loan stock is smaller in Germany.

---

### Dimension 2: Regulatory Framework

**United States:** Securities lending by registered investment companies is governed primarily by guidance under the Investment Company Act of 1940 (ICA 1940). There is no single statute specifically requiring lending programs; instead, the SEC's Division of Investment Management has issued informal guidelines (most recently IM Guidance Update No. 2014-06). Key requirements: (1) collateral of at least 100% of loan value (in practice 102% for domestic, 105% for international securities); (2) conservative reinvestment of cash collateral; (3) maximum on-loan exposure of one-third of fund NAV; (4) recall rights at all times; (5) lending agent compensation is board-approved and typically shares revenue between the fund and the agent; (6) the SEC does not mandate the revenue split but requires board oversight of agent compensation. No statutory requirement that 100% of net revenue go to the fund (cf. EU/German rules described below).

**Germany (KAGB):** Sections 200–202 of the Kapitalanlagegesetzbuch govern open-end investment funds domiciled in Germany. The five conditions in GJSS's current regulatory section are broadly correct: (i) single-counterparty cap of 10% of NAV; (ii) 100% collateral coverage; (iii) collateral in high-quality sovereign debt, short-term MMFs, or repo; (iv) market-rate remuneration; (v) recall at any time. An important additional requirement: under UCITS V rules (implemented in Germany via the KAGB), 100% of net lending revenue must be returned to the fund (after direct and indirect operational costs). This contrasts with US practice where the fund board determines the agent's share. The Better Finance (Voicu and Prache, 2019) study found that in practice European fund managers retain 5–49% of gross lending revenue as "operational costs," resulting in effective revenue shares of 51–95% going to the fund.

**EU-wide (SFTR 2020):** Regulation EU 2015/2365 (Securities Financing Transactions Regulation, SFTR) became effective from July 2020 for banks and investment firms. SFTR requires: (1) trade-by-trade reporting of all SFTs to authorized trade repositories by end of next business day; (2) investor disclosure in fund prospectuses and periodic reports about use of SFTs; (3) transparency about collateral re-use. SFTR created for the first time a comprehensive, near-real-time regulatory database of European securities lending transactions — but this data is available to regulators, not publicly. GJSS's sample period (December 2014–December 2018) pre-dates SFTR reporting, meaning the lending activity in their sample was not covered by SFTR. The Bundesbank IFS lending data (from December 2014) captures lending positions at the fund-security level but reflects a separate, German-specific reporting requirement rather than SFTR.

**Key regulatory comparison for paper:** The core statutory requirements are similar (100% collateral, recall rights, counterparty limits), but two important differences exist: (1) the EU/German 100%-net-revenue-to-fund rule is stricter than US board-discretion practice, meaning European fund families have less latitude to extract economic rents through lending agent fees; (2) post-SFTR transparency is higher in Europe at the regulatory level (trade repositories), but this does not affect the private information advantage during GJSS's sample period.

---

### Dimension 3: Lending Agent Arrangements

**United States:** The dominant model is third-party custodian agency lending. The Baklanova et al. (2016) pilot survey found that most US lending agents are subsidiaries of large custodian banks (State Street, BNY Mellon, JP Morgan). These agents manage lending for multiple unrelated fund families, pooling securities across dozens of clients. The custodian bank intermediates between the fund and the borrower (typically a prime broker for a hedge fund), and the fund typically does not observe the identity of the ultimate borrower. ICI (2014) notes that US funds "typically compensate lending agents with a share of the revenue" — the agent does not disclose borrower identity to the fund manager.

**Germany/Europe:** German fund families more commonly operate in-house lending desks, particularly the larger families. An in-house desk is a subsidiary or operational unit of the fund management company (KVG) that manages the lending book across all funds in the family, negotiating directly with prime brokers. The in-house structure creates an organizational channel for information: the lending desk, sitting within the same KVG as the portfolio managers, can (at minimum implicitly) inform portfolio managers about borrowing demand patterns, or portfolio managers may directly observe the lending book.

**Information flow implications:** Under a third-party custodian model (US), the information barrier between the fund manager and borrower identity is strong — the custodian has no obligation to reveal borrower identity and strong commercial incentives to maintain confidentiality (to protect its brokerage relationships). Under an in-house model (Germany), the information barrier depends on internal compliance procedures, but organizational proximity increases the likelihood of information transmission. This structural difference is the key institutional mechanism distinguishing the German setting from the US.

**Why GJSS findings may generalize to the US:** Honkanen (2025) documents the same trading response to lending signals in the US, suggesting that even with third-party intermediation, fund managers learn from lending activity — possibly through lending revenue reports, custodian summaries, or informal communication. However, the transmission channel in the US likely involves greater friction, which could explain why GJSS finds stronger effects concentrated in same-manager lending relative to Honkanen's US estimates.

---

### Dimension 4: Revenue Sharing

**United States:** No statutory revenue floor. Typical splits documented in the literature are roughly 60–80% to the fund, 20–40% to the lending agent (custodian bank). The ICI (2014) notes that "funds typically compensate their lending agents with a share of the revenue" but does not prescribe specific percentages. Evans, Ferreira, and Prado (2017) document that the main benefit of lending — the lending fee income — goes primarily to the fund, not the agent.

**Germany/UCITS:** Under UCITS rules, 100% of net lending revenue (after direct and indirect operational costs) must be returned to the fund. The Better Finance (Voicu and Prache, 2019) study found that in practice, UCITS funds retain 51–95% of gross revenue as net revenue paid to investors, with the gap absorbed by "operational costs." The KAGB's Section 201 specifies that remuneration must reflect current market conditions. The GJSS paper states splits range from approximately 50/50 to 95/5 (fund/agent), citing Voicu and Prache (2019), which is consistent with the Better Finance findings.

**Key point:** Revenue sharing is not the mechanism GJSS relies on — the paper's claim is about information, not income. But the revenue-sharing structure matters for one reason: it establishes that fund families have economic incentives to engage in lending (they retain the bulk of income), so the lending decision reflects a positive choice, not a residual. This is important for the interpretation that lending activity is a choice variable that reveals information.

---

### Dimension 5: Collateral Rules

**United States:** Cash collateral is the norm (~80% of US lending volume). Collateral reinvestment in short-duration, high-quality instruments is standard but not strictly mandated; funds have historically reinvested in money market funds, commercial paper, and short-term debt. The 2008 financial crisis revealed risks in cash collateral reinvestment (the Reserve Primary Fund "broke the buck" partly due to securities lending collateral losses). Post-2008, US practice shifted toward more conservative reinvestment.

**Germany/Europe:** Non-cash collateral is dominant (~60% of European lending). Under UCITS rules and KAGB Section 200, collateral must be "high-quality" sovereign debt, short-term MMFs, or repo. German KAGB Section 200(2) specifically states that collateral must be invested in high-quality sovereign debt, short-term money market funds, or repurchase agreements. UCITS funds face a seven-day maximum loan duration constraint, which limits their ability to lend on longer terms and requires more frequent collateral management. The pledge structure (common in US) is less common in Europe, where title transfer is standard.

**Why this matters for information:** The type of collateral does not directly affect information transmission, but it affects the economics of lending. Non-cash collateral reduces reinvestment income, making lending fee income more important to European funds. This strengthens the incentive to monitor lending activity — managers who rely on fee income pay closer attention to borrowing demand, which may amplify information acquisition.

---

### Dimension 6: Transparency and Reporting Regimes

**United States:** FINRA requires biweekly (twice-monthly) reporting of aggregate short interest by broker-dealers. This data is publicly released approximately one week after the reporting date — so public short interest data is always at least two weeks stale. There is no public disclosure of the identity of large short sellers in the US. The SEC has proposed expanded short-sale disclosure rules under Rule 13f-2 (proposed 2022, partially finalized 2023), but implementation has been contested.

**EU (Regulation EU 236/2012):** Since November 2012, short sellers must notify the national competent authority (BaFin in Germany) when their short position exceeds 0.2% of issued shares. Positions above 0.5% are publicly disclosed on BaFin's website by the next business day, including the identity of the short seller (name), position size, and date. Each additional 0.1% change triggers a new notification or disclosure. This creates a uniquely granular, real-time, public identification of large short sellers — information that has no direct US equivalent.

**SFTR (post-2020):** Trade repository reporting under SFTR provides European regulators with near-real-time information on all SFT transactions. However, SFTR data is not public — it is submitted to authorized trade repositories and accessed only by regulators. This does not alter the information available to fund managers.

**Key contrast for paper:** In the EU, large short positions become publicly known (with identity) within one business day of crossing 0.5%. In the US, short interest is published biweekly at an aggregate, anonymous level. This means the information asymmetry between lending funds (who observe borrowing demand in real time through their lending book) and the public is more pronounced in the EU. The EU mandatory disclosure creates a scheduled, identifiable moment when private information becomes public — this is what GJSS exploits as their identification variable. No equivalent US natural experiment exists, which makes the German setting particularly well-suited for the GJSS identification strategy.

---

### Dimension 7: Short Seller Identity Revelation

**EU (Germany):** As described above, positions above 0.5% of issued shares require next-business-day public disclosure of the short seller's identity. Short sellers strategically position themselves below the 0.2% private notification threshold to avoid any disclosure (Jank, Roling, Smajlbegovic, 2021). When positions do cross 0.5% and become public, prices adjust and short selling decreases (Jones, Reed, Waller, 2016). The identity of the short seller is material information: larger, more centrally located short sellers attract copycat behavior (Jones et al., 2016); shorted firms adjust dividend policy in response to identity revelation (Madelaine, 2024).

**United States:** No public threshold-based identity disclosure comparable to Regulation 236/2012. Short positions are aggregated in FINRA biweekly reports without identifying individual short sellers. Institutional investors who build large short positions through swaps or other derivatives are not captured in traditional short interest data. The result is that in the US, the fund manager's private information from observing borrowing demand in the lending book is not subject to a scheduled, identifiable disclosure event — the "information shock" cannot be cleanly dated.

**Implications for GJSS identification:** The interaction between lending activity and subsequent mandatory disclosure is only feasible in the EU/German context. In the US, Honkanen (2025) exploits the correlation between lending and subsequent stock returns, without a clean identification of when private information becomes public. GJSS's sharper identification (the disclosure event) is a specific advantage of the German/EU regulatory environment.

---

### Dimension 8: Fund Constraints on Lending

**United States:** Under ICA 1940 guidance, the maximum amount on loan at any time is one-third of fund NAV. There is no regulatory cap on lending to any single counterparty, though board-approved procedures typically impose counterparty concentration limits. Recall rights must be preserved; loans are generally callable on demand or with short notice.

**Germany (KAGB Sections 200–202):** Single-counterparty cap of 10% of fund NAV (more restrictive than in the US). Collateral must cover 100% of loan value. Recall rights must be preserved. Maximum exposure per borrower is explicitly constrained. Additionally, fund families may impose internal caps that are more restrictive than statutory requirements, and many German fund families cap lending at a maximum percentage of AUM (e.g., 20–30%).

**Key comparison:** The KAGB's 10% single-counterparty limit is stricter than standard US practice, which typically imposes counterparty limits through board procedures rather than statute. This affects market concentration: German funds are forced to spread loans across more borrowers (or lend less in total), which could dilute the information signal per lending relationship. However, GJSS finds that families with more concentrated lending (fewer active agents, fewer stocks lent) exhibit stronger trading responses — consistent with the view that counterparty limit restrictions reduce, not amplify, the signal.

---

## Part III: Frontier Map

### What Has Been Done

1. **US evidence on information in lending (Honkanen, 2025; Evans, Ferreira, Prado, 2017):** Active US funds adjust positions in response to borrowing demand signals. The mechanism operates through the lending book (active funds reduce weight in lent stocks). Family spillovers exist.

2. **Theoretical framework (Nurisso, 2026; Duffie, Garleanu, Pedersen, 2002):** Lending fees capitalize private information. Passive fund commitment enables better information transmission.

3. **EU mandatory disclosure effects (Jones, Reed, Waller, 2016; Jank, Roling, Smajlbegovic, 2021):** EU public disclosure at 0.5% reduces short selling and market liquidity. Short sellers strategically avoid the 0.2% notification threshold. Identity revelation is economically material.

4. **International lending constraints and efficiency (Saffi, Sigurdsson, 2011; Prado, Saffi, Sturgess, 2016):** Lending supply constraints reduce price efficiency across markets including Germany. Ownership structure determines lending supply.

5. **US lending market structure (D'Avolio, 2002; Baklanova et al., 2016):** Third-party custodian bank dominance; ~$1 trillion daily on-loan; cash collateral standard; borrower identity not disclosed to fund manager.

6. **Intermediary information leakage (Chague, Giovannetti, Herskovic, 2025):** Brokers exploit information from intermediating lending agreements. Works through direct broker-client relationship.

### The Gap GJSS Fills

GJSS is the first paper to:
- Use **security-level lending data** from the fund's own perspective (not aggregate stock-level data), enabling within-fund-stock variation
- Test information acquisition in a setting where the information revelation event (EU mandatory disclosure) provides **clean identification of when private information becomes public**
- Decompose information flows through **same-manager vs. within-family spillovers**, distinguishing organizational proximity effects
- Conduct the **passive-fund placebo** as a within-data identification test (German data includes both active and passive funds in the same regulatory environment)
- Exploit **concentrated lending market structure** to test whether information is amplified by fewer intermediary relationships

### External Validity

The German setting generalizes to the US in the following respects:
- The core mechanism (fund managers observe borrowing demand → reduce position) is confirmed by Honkanen (2025) in US data
- The passive-fund placebo holds in both settings
- Family spillover effects exist in both settings
- The lending supply determinants (ownership, passive share) are similar across markets

The German setting offers **unique identification advantages** over the US:
- The EU mandatory disclosure creates a scheduled information event with no US analogue
- In-house lending desks in Germany create stronger organizational proximity between lending and trading, making the information transmission mechanism more transparent
- The Bundesbank IFS provides security-level lending positions from the fund's perspective — this data is unavailable in the US (where fund-level lending is reported at an aggregate level in CRSP)

---

## Part IV: Positioning Statement

### Suggested 2–3 Paragraph Rewrite of the "German Securities Lending Regulation" Subsection

The current subsection accurately describes the KAGB framework but lacks three elements that a referee would expect: (1) a comparison to the US to establish external validity, (2) an explanation of the in-house lending desk structure and why it matters for information transmission, and (3) a precise description of the EU mandatory short position disclosure regime and how it differs from FINRA short interest reporting.

**Suggested additions to the regulatory subsection:**

*On the in-house vs. third-party agent distinction:* "Unlike the typical US model in which custodian banks act as third-party agents [Baklanova et al., 2016], most German fund families operate in-house securities lending desks. An in-house desk — a subsidiary or operational unit within the fund management company — intermediates lending directly with prime brokers, creating organizational proximity between the lending book and the portfolio managers. This proximity is essential to the information acquisition channel we study: a portfolio manager whose family operates an in-house desk has access to the borrowing demand signal without relying on a third-party custodian to communicate it."

*On collateral and revenue differences:* "European lending differs from US practice in two additional respects. First, non-cash collateral (primarily sovereign debt) dominates in Europe (~60% of loans), while the US market relies predominantly on cash collateral reinvestment [FSB, 2012]. Second, under UCITS rules, 100% of net lending revenue (after operational costs) must be returned to the fund [Voicu and Prache, 2019], whereas US fund boards have discretion over the revenue split between the fund and the lending agent [ICI, 2014]. These differences affect the economics but not the information content of lending."

*On disclosure regimes:* "The EU short position disclosure regime — Regulation EU 236/2012 — creates a distinctively sharp information event absent from the US context. Short sellers who accumulate positions above 0.5% of issued shares must publicly disclose their identity (name), position size, and the relevant issuer to the national competent authority (BaFin in Germany) by the next business day. The position is then publicly accessible on BaFin's website. In contrast, US FINRA short interest reporting is biweekly, aggregate, and anonymous — no individual position holder is identified regardless of position size. This regulatory difference makes Germany particularly well-suited for the identification strategy we employ: the mandatory disclosure event creates a precise, stock-specific date at which private information about short-seller identity transitions to public knowledge [Jones, Reed, Waller, 2016; Jank, Roling, Smajlbegovic, 2021]."

---

## Part V: Similarity and Difference Table

| Dimension | United States | Germany / EU | Implication for Generalizability |
|---|---|---|---|
| **Market size (on loan)** | ~$0.7T (2012); $1–2T+ (2024) | ~$0.2T (2012); smaller share of global | German market is smaller; absolute effect sizes may differ but intensive margins comparable |
| **Fund utilization rates** | ~3–5% of AUM on average | ~3.8% of AUM (GJSS Table 2) | Similar; lending participation rates differ more than lending intensity among lenders |
| **Statutory framework** | Investment Company Act 1940 + SEC guidance | KAGB Sections 200–202 + UCITS rules | Core conditions similar; EU/Germany imposes 100% net revenue to fund, stricter counterparty cap (10% vs. no statutory cap in US) |
| **Lending agent structure** | Third-party custodian bank (dominant: State Street, BNY, JPM) | In-house family desk (more common in Germany) | US has stronger organizational barrier between fund manager and borrower identity; Germany has greater proximity — key institutional difference |
| **Revenue sharing** | Board-discretion; typically 60–80% to fund, 20–40% to agent | 100% net revenue to fund (after operational costs); in practice 51–95% net | EU rules are stricter; fund families have less latitude to extract rents through agent fees |
| **Collateral type** | Cash (~80% of US loans) | Non-cash / sovereign debt (~60% of EU loans) | Affects economics not information; different reinvestment risks |
| **Collateral level** | 102% domestic, 105% international | 100% minimum (KAGB); UCITS requires diversification | Marginally lower in Germany; both markets fully collateralized |
| **Max loan per counterparty** | No statutory cap; board-set procedures | 10% of NAV (statutory, KAGB S.200) | Germany more concentrated per-borrower limit; may dilute the signal |
| **Recall rights** | Fully preserved; on demand | Fully preserved; on demand | Identical; both markets have immediate recall rights |
| **Short interest reporting** | FINRA biweekly; aggregate, anonymous | ESMA/BaFin daily public disclosure for positions >0.5%; identity included | EU is far more granular, more frequent, and identity-revealing; this is the identification advantage of the German setting |
| **Private notification threshold** | None equivalent | BaFin notification at 0.2%; not public | EU creates a two-tier system: private information up to 0.5%, then public |
| **Borrower identity to fund** | Not disclosed by custodian agents | In-house desks may have access through internal coordination | Key mechanism difference; German in-house model may reveal identity through organizational proximity |
| **Collateral re-use** | Permitted under FINRA rules | Restricted under SFTR; limited re-hypothecation | Less relevant for information channel |
| **Post-trade transparency** | Limited (no trade repository; FINRA only collects aggregate data) | SFTR requires trade-repository reporting to regulators (post-2020); not public | SFTR post-dates the GJSS sample; both markets were opaque to researchers during 2014–2018 |
| **US generalizability** | N/A | Honkanen (2025) finds same fund trading response in the US; active/passive split holds | Core mechanism (information in lending → position reduction) generalizes; identification via disclosure event is Germany-specific |

---

## Part VI: Key Citable Facts and Statistics

1. **Global securities lending on loan:** Approximately $2.7 trillion in lendable assets on loan globally as of early 2024, out of $40 trillion lendable (EquiLend/DataLend).

2. **US vs. Europe market size (2012):** US on-loan approximately $0.7 trillion (74% cash collateral); Europe approximately $0.2 trillion (59% non-cash collateral) [FSB, 2012].

3. **UCITS mutual fund lending underutilization:** Mutual funds account for approximately 46% of lendable securities but only 14% of actual loans in Europe — a structural supply-demand gap reflecting regulatory constraints and risk management choices (ISLA/Funds Europe, 2017).

4. **US lending agent concentration:** The Baklanova et al. (2016) survey found seven agents facilitated approximately $1 trillion in daily securities loans in 2015; most agents are subsidiaries of large custodian banks.

5. **EU mandatory disclosure threshold:** Positions above 0.5% of issued shares are publicly disclosed (identity + size) next business day on BaFin/NCA websites; 0.2% threshold triggers private notification [Regulation EU 236/2012].

6. **EU shadow zone:** Short sellers pile up positions below the 0.2% private notification threshold to avoid disclosure; estimated excess mass of 92.8% below the threshold for first-time disclosers [Jank, Roling, Smajlbegovic, 2021].

7. **EU mandatory disclosure effects on short interest:** Public disclosure at >0.5% reduces short interest, bid-ask spreads, and price informativeness [Jones, Reed, Waller, 2016].

8. **EU lending revenue allocation:** UCITS rules require 100% of net lending revenue to fund; in practice European funds retain 51–95% of gross revenue after operational costs [Voicu and Prache, 2019].

9. **German fund lending utilization:** 3.8% of AUM on loan on average among lending funds; approximately 33% of funds participate in lending (GJSS Table 2; comparable to ICI 2014 estimate of 3–5% in the US).

10. **GJSS main result:** Active funds reduce positions by approximately 0.33 percentage points per unit increase in lending; interaction with subsequent mandatory disclosure adds approximately -0.80 to -0.86 pp.

11. **US Honkanen benchmark:** One-standard-deviation increase in borrowing demand is associated with -0.18 pp active fund portfolio weight reduction [Honkanen, 2025] — same sign and direction as GJSS, supporting generalizability.

12. **FINRA short interest reporting:** Biweekly; data published approximately one week after reporting date; aggregate by security, anonymous (no individual position identification).

---

## Part VII: Bibliography Cross-Reference

### Papers Already in `Bibliography_base.bib`

| BibTeX Key | Status |
|---|---|
| `Honkanen2025` | In bib (as `honkanen:20` and `Honkanen2025`) |
| `EvansFerreiraPrado2017` | In bib |
| `Nurisso2026` | In bib |
| `ChagueGiovannettiHerskovic2025` | In bib |
| `PaliaSokolinski2024` | In bib (also earlier version as `palia_Sokolinski:2021`) |
| `dong_zhu_2023` | In bib |
| `davolio:02` | In bib |
| `duffie_garleanu_pedersen:02` | In bib |
| `baklanova_caglio_keane_porter:16` | In bib |
| `prado_saffi_sturgess:14` | In bib |
| `saffi_sigurdsson:08` | In bib |
| `aggarwal_saffi_sturgess:14` | In bib |
| `jones_reed_waller:16` | In bib (also as `JonesReedWaller2016`) |
| `jank_roling_smajlbegovic2020` | In bib |
| `jank_smajlbegovic:2015` | In bib |
| `ICI2014Viewpoints` | In bib |
| `voicu_prache:2019` | In bib |

### New Papers Not Currently in Bibliography (Recommended Additions)

| Paper | BibTeX Key | Priority |
|---|---|---|
| Madelaine (2024). "Negative Externalities of Regulation." *Abacus*, 60(3). | `Madelaine2024` | Medium — confirms identity revelation matters |
| Chen, Tran, Wang (2024). "Unveiling Mutual Funds' Securities Lending Strategies." SSRN 4867141. | `ChenTranWang2024` | Low — US study on within-family heterogeneity |
| FSB (2012). "Securities Lending and Repos: Market Overview and Financial Stability Issues." FSB Report. | `FSB2012` | Medium — sole source for the US/EU market size comparison numbers |
| Baklanova, Caglio, Keane, Porter (2016) | Already in bib as `baklanova_caglio_keane_porter:16` | Already covered |

### Suggested BibTeX Entries for New Papers

```bibtex
@article{Madelaine2024,
  author    = {Madelaine, Alexandre},
  title     = {Negative Externalities of Regulation: Identity-Relevant Information
               in Mandatory Short-Selling Disclosures},
  journal   = {Abacus},
  year      = {2024},
  volume    = {60},
  number    = {3},
  doi       = {10.1111/abac.12339}
}

@unpublished{ChenTranWang2024,
  author    = {Chen, Shuaiyu and Tran, Anh and Wang, Pingle},
  title     = {Unveiling Mutual Funds' Securities Lending Strategies: Value versus Volume},
  year      = {2024},
  note      = {SSRN Working Paper 4867141}
}

@techreport{FSB2012,
  author      = {{Financial Stability Board}},
  title       = {Securities Lending and Repos: Market Overview and
                 Financial Stability Issues},
  institution = {Financial Stability Board},
  year        = {2012},
  month       = {April}
}
```

---

*Note: This document is intended for use by the Strategist agent (to see what identification approaches have been used by comparable papers) and the Writer agent (for the regulatory background section). It does not constitute a quality score — scoring is the responsibility of the librarian-critic.*
