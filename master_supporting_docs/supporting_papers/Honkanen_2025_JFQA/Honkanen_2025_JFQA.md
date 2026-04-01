# Securities Lending and Trading by Active and Passive Funds

**Pekka Honkanen**  
Terry College of Business, University of Georgia  
pekka.honkanen@uga.edu

*Journal of Financial and Quantitative Analysis*, Vol. 60, No. 3, May 2025, pp. 1272–1309  
doi:10.1017/S0022109024000966

---

> *U.S. mutual funds in the securities lending market extract information from stock borrowing. Active funds exploit this information, rebalancing away from borrowed stocks whose prices tend to decrease, whereas passive funds do not. Information spillovers within fund families are stronger when the lender is a passive fund and when the family is more cooperative (less competitive). Active funds trade more aggressively on stocks with more negative future returns, suggesting that they are able to identify informed borrowing. Finally, passive funds charge higher lending fees than active funds, consistent with short sellers paying a premium to lower recall risk.*

---

## I. Introduction

At the end of 2018, U.S. mutual funds had \$740 billion of outstanding stock loans, representing almost 85% of all outstanding short interest. Mutual funds earned more than \$2 billion in lending fees during the year, with 28% of active funds and 61% of index funds lending some of their portfolio securities. Importantly, by participating in the securities lending market, mutual funds can gain real-time information about short selling. This information may be valuable given that short interest has been shown to predict stock price declines. These observations raise the question of whether lender funds exploit this information for trading.

This article is, to the best of my knowledge, the first to use stock-loan-level data to study the securities lending practices of U.S. mutual funds. I find that mutual funds acquire information through stock lending and use this information to trade and rebalance their portfolios. Active mutual funds reduce the portfolio weight of stocks that are borrowed by approximately 1.04 percentage points of their net assets in the 2 quarters after a loan compared to similar funds that own but do not lend the stock, whereas there is a small positive effect for passive funds. The effect for active funds is highly economically significant, as the average portfolio weight of a stock is 1.45%. Moreover, the effect persists, and there is no reversal in trading: Eight quarters after a loan, the effect has grown further, to 1.93 percentage points.

This finding closely relates to Evans, Ferreira, and Porras Prado (2017), who raise the idea that stock lenders gain not only lending fees but also information through the lending markets. However, Evans et al. (2017) find that stock lending leads to annualized underperformance of approximately 0.5%, which they attribute to overinvestment in the stocks that they lend relative to their peer groups. Greppmair, Jank, Saffi, and Sturgess (2020) and Palia and Sokolinski (2024) find evidence that supports the findings in this article. Greppmair et al. (2020) test the same hypothesis of information acquisition through securities lending on German regulatory data and, like this article, find that mutual funds avoid capital losses by exiting the stocks that are borrowed. Palia and Sokolinski (2024) study how passive investing impacts securities lending and market efficiency. They find that only lending by passive investors improves price efficiency in the financial markets and that passive investment is associated with higher lending fees and more short selling.

I also find strong evidence of information spillovers within mutual fund families from lender funds to non-lenders. Active funds react more strongly to loans than passive funds, and active funds react more strongly when passive funds in the family lend a security than when they lend themselves.

Active funds in more collaborative — that is, less competitive, more cooperative, and with higher net cooperation — fund families trade more in response to lending by other funds in their fund families, and the effect is particularly strong when the lender is a passive fund.

Stocks borrowed from either active or passive funds earn negative cumulative returns of approximately 3.6% (7.8%–8.8%) in the 2 (8) quarters after a loan, and there is no evidence of a reversal in returns even 12 quarters after a loan.

I also find evidence consistent with the ability of active funds to distinguish between informed and uninformed short selling. Separating stocks borrowed from active funds into two groups based on the change in the number of shares held by lender funds in the quarters following a loan, I find that stocks with a larger reduction in fund holdings experience risk-adjusted cumulative returns of approximately 5% (8%) in the 2 (8) quarters after a loan, whereas stocks with a smaller reduction in fund holdings earn risk-adjusted returns of approximately 1.9% (4.8%).

Finally, I present supporting evidence that the market is aware that lender funds may use the information revealed by stock borrowing to trade. Passive funds earn higher lending fees than active funds, but there is no evidence of the fee differences being due to risk-taking by the lenders.

The analysis relies on a novel data set on securities lending for approximately 3,500 U.S. mutual funds belonging to a sample of the 10 largest mutual fund families, constructed from regulatory filings submitted to the SEC. The final data set contains approximately 22,000 fund-quarter and 456,000 fund-stock-quarter observations from 2003 to 2017.

The main hypothesis is that mutual funds gain real-time information on short selling by lending stocks and then use this information to rebalance their portfolios away from borrowed stocks. This hypothesis relies on three assumptions. First, borrowing must indicate short selling. Second, short selling must predict negative returns. Third, funds must be allowed and able to trade on the information they gain from lending securities.

---

## II. Securities Lending Market

### A. Regulatory Framework

The regulatory framework that governs securities lending by U.S. mutual funds is established in a series of no-action letters between the SEC and fund management companies. The current rules stipulate that funds:

(i) may lend at most one third of their total assets;  
(ii) must receive collateral at least equal to 100% of the value of securities on loan;  
(iii) must be able to terminate the loan at any time; and  
(iv) should earn a reasonable return on the loan.

Additionally, funds should invest cash collateral in securities that offer maximum liquidity and a reasonable return. In practice, mutual funds hold nearly all collateral as money market fund shares or T-bills. The ability to terminate the loans at will means that the loans are effective daily and rolled over until either party terminates them.

When entering a stock loan, lenders transfer ownership of the shares and the attached voting rights to the borrower. However, both the loaned securities and the collateral are recorded in the holdings and balance sheet of the lender fund. Consequently, securities lending inflates the lender funds' total assets, as the collateral is also recorded in fund holdings and liabilities. The mandatory high collateralization rate on securities loans (at least 100% of loan value) protects lender funds against borrower default in normal market circumstances; lenders incur losses only in borrower defaults where the security on loan has increased in value by more than the over-collateralization rate, which is 4.69% and 4.28% for active and passive funds, respectively, in the sample.

### B. Market and Information Structure

A typical securities lending transaction involves four parties. At either end of the loan are the lender and the short seller, with the transaction typically being intermediated by a lending agent and the borrower's broker. The lending agent can, additionally, be either internal to the fund issuer or an external third-party agent acting on behalf of multiple clients.

The loans are generally sought by the short seller's broker after a short sale is initiated: The broker sends a "locate request" to lending agents, asking for available quantities and fees. Typically, the broker hides the intended target of short selling by requesting available quantities and fees for a number of different securities to prevent potential lenders from extracting information from loan demand without genuinely participating in the stock lending market.

The loan allocation mechanism within lending agents is crucial to the identification in this paper. In private interviews, lending agents affirm that a lender's position in the lending "queue" is determined by their holdings in the stock relative to other potential lenders, their stock-specific utilization rate (the percentage of the stock position currently on loan), their time of arrival in the queue, or a combination of these factors. The loans are generally allocated to the fund with the lowest utilization rate, highest holdings, and earliest arrival in the queue, all else equal.

---

## III. Hypothesis Development

**Hypothesis 1a (information in stock loans).** Lenders' reaction to stock borrowing hinges on new information being revealed to them through the loans. Given the established connection between short interest and stock returns, stock borrowing is also likely to be a predictor of negative future stock returns. This connection is also important to establish that lender funds reducing their holdings in the stocks that are borrowed is a rational reaction to the signal they receive.

**Hypothesis 1b (precision of information).** If lender funds can distinguish between informed and uninformed borrowing, we should expect more aggressive trading around loans of stocks that experience larger negative ex post returns.

**Hypothesis 2 (the value of information and stock lending fees).** Sophisticated traders produce information about companies and may short sell stocks to benefit from the information they produce. If lenders can extract this information from stock borrowing and use it to trade, short sellers should demand compensation for this. Similarly, if lender funds are aware that stock loan demand is a source of tradable information, they should charge lower lending fees to attract borrowing demand from informed short sellers. Both the supply and demand sides of stock loans thus combine to reduce stock lending fees for lenders that may seek to trade the stocks that are borrowed compared to funds that cannot trade using the information that is revealed by stock borrowing.

To test this hypothesis, I test whether funds that have few explicit restrictions in their trading — namely, active funds — charge lower stock lending fees than passive funds.

---

## IV. Data and Variables

### A. Data

The main data sources are mandatory filings that U.S. mutual funds must submit to the SEC under the Investment Company Act of 1940. The quarterly N-Q and semi-annual N-CSR filings contain all portfolio holdings of mutual funds and are accessible on SEC EDGAR. One previously overlooked feature in these statements is the information they contain regarding securities lending: In particular, they identify the individual securities on loan by each fund as well as the loan collateral aggregated at the fund level.

I hand-collect information for the 10 largest mutual fund issuers in the U.S. as measured by total assets under management at the end of 2017: BlackRock/iShares, FirstTrust, WisdomTree, Fidelity, StateStreet/SPDR, Vanguard, VanEck, Dimensional Fund Advisors, Invesco/PowerShares, and Franklin Templeton Investments. The fund issuers together comprised roughly 50% of total mutual fund assets at the end of 2017. The 10 fund issuers in the sample also accounted on average for 53% of the value of securities lending by U.S. mutual funds in the time period from 2018 to 2021.

I collect item 69 from SEC N-SAR filings to identify index funds and use this item as a proxy for passive funds. The results are robust to different definitions of passive funds, such as using ETFs, the intersection of ETFs and index funds, or the union of ETFs and index funds.

The final sample covers the period from the third quarter of 2003 to the fourth quarter of 2017 and contains approximately 22,000 fund-quarter observations on lending data and approximately 456,000 fund-stock-quarter observations for stocks on loan.

In additional tests in Section V, I use SEC N-PORT filings from September 2019 to December 2020 to validate the identification strategy. These data contain 39,000 funds and 4,800,000 fund-stock observations.

### B. Variable Construction

The main variable of interest is the indicator variable $\text{loan}_{f,s,t}$, which identifies, at the quarterly frequency, that fund $f$ is lending stock $s$ at time $t$.

The SEC filings also provide information on funds' broader securities lending practices. Total collateral on securities loans, the total value of securities on loan, and total net asset values ($\text{collateral}_{f,t}$, $\text{loanvalue}_{f,t}$, $\text{TNA}_{f,t}$) are measured at the fund-quarter level, while securities lending fee income ($\text{lendingincome}_{f,t}$) is measured semi-annually.

The over-collateralization is:

$$\text{Overcollateral}_{f,t} = \frac{\text{collateral}_{f,t}}{\text{loanvalue}_{f,t}} - 1$$

For the main portfolio rebalancing tests, I first compute, for each comparison group $g$, the average holding in stock $s$ at time $t$:

$$\bar{w}^d_{g,s,t} = \frac{1}{N_{g,t}} \sum_{k \in g} w_{k,s,t} \tag{1}$$

where $N_{g,t}$ is the number of funds in group $g$ at time $t$, and $w_{k,s,t}$ is the holding of fund $k$ in stock $s$ at time $t$. Comparison groups are defined by Active/Passive status, CRSP Investment Objective Code (IOC), and Total Net Asset tercile.

The fund-stock level measure of trading is then:

$$\Delta\text{Trading}_{f,s,t} = \left(w_{f,s,t} - w_{f,s,t-1}\right) - \left(\bar{w}^d_{g,s,t} - \bar{w}^d_{g,s,t-1}\right) \tag{2}$$

Examining the differences in trading between lenders and their comparison group highlights the trading driven by information acquired from lending.

For lending fees, the N-CSR filings identify:

$$\text{lending income}_{f,t} = \sum_b \left(\text{net fee}_{f,b,t} - \text{agent fees}_{f,b,t} + \text{collateral reinv. income}_{f,b,t}\right) \tag{3}$$

$$= \text{net fees}_{f,t} - \text{agent fees}_{f,t} + \text{collateral reinv. income}_{f,t} \tag{4}$$

Rearranging and dividing by the value of securities on loan yields the average lending rate:

$$\frac{\text{net fees}_{f,t}}{\text{loanvalue}_{f,t}} = \frac{\text{lending income}_{f,t} - \text{collateral reinv. income}_{f,t}}{\text{loanvalue}_{f,t}} + \frac{\text{agent fees}_{f,t}}{\text{loanvalue}_{f,t}} \tag{5}$$

I create the lending fee proxy $\widehat{\text{lendingfee}}_{f,t}$ by dividing the difference of lending income and collateral reinvestment income by the value of outstanding securities loans, adjusting for the number of active lending quarters in the semi-annual reporting period, and annualizing:

$$\widehat{\text{lendingfee}}_{f,t} = \frac{\text{lending income}_{f,t} - \text{collateral}_{f,t} \times r^{MMF}_{t}}{\text{loanvalue}_{f,t}} \times \frac{2}{q_{f,t}} \times 2 \tag{6}$$

where $r^{MMF}_{t}$ is the average contemporaneous money market fund yield and $q_{f,t}$ is the number of quarters in which the fund has outstanding securities loans in the half-year period.

I use the Markit Securities Finance database to construct an imputed fund-level average fee:

$$\text{avgfee}_{f,t} = \frac{1}{N}\sum_{s=1}^{N} \text{mktfee}_{s,t} \times \mathbf{1}_{f,s,t}$$

where $\mathbf{1}_{f,s,t}$ is an indicator variable that takes a value of 1 if stock $s$ is on loan by fund $f$ in quarter $t$, and $\text{mktfee}_{s,t}$ is the average Markit stock loan fee for stock $s$ in quarter $t$.

Fund flow is imputed as:

$$\text{fundflow}_{f,t} = \frac{\text{TNA}_{f,t} - (1 + r_{f,t}) \times \text{TNA}_{f,t-1}}{\text{TNA}_{f,t-1}}$$

The high-low ratio is computed as $(\text{high} - \text{low}) / \left(\frac{1}{2} \times (\text{high} + \text{low})\right)$, and the bid-ask ratio is computed as $(\text{ask} - \text{bid}) / \left(\frac{1}{2} \times (\text{ask} + \text{bid})\right)$ using daily CRSP data and averaged at the quarterly level.

### C. Descriptive Statistics

**Table 1: Descriptive Statistics on Securities Lending by Investment Funds**

*Summary statistics for active and passive funds in the SEC EDGAR lending fund sample matched to CRSP Mutual Fund data. All variables except Total Net Assets (TNA) and Loan Avg. Mcap are in percentage points.*

| Variable | Active Mean | Active SD | Passive Mean | Passive SD | Passive − Active | *t* |
|---|---|---|---|---|---|---|
| TNA (Million) | 4,059 | 10,037 | 3,617 | 11,036 | −442\*\* | (2.58) |
| Mgmt fee | 0.30 | 0.41 | 0.29 | 0.26 | −0.01 | (1.79) |
| Lending fee | 1.10 | 4.95 | 2.20 | 4.84 | 1.10\*\*\* | (7.29) |
| Mkt. Lending fee | 0.66 | 1.25 | 0.42 | 0.80 | −0.24\*\*\* | (11.42) |
| Lending yield | 0.01 | 0.02 | 0.02 | 0.04 | 0.01\*\*\* | (10.95) |
| Loanvalue/TNA | 2.91 | 4.84 | 5.52 | 6.65 | 2.60\*\*\* | (17.25) |
| Overcollateralization | 4.69 | 6.24 | 4.28 | 6.12 | −0.41\* | (2.55) |
| Num. loan/Num. hold | 9.93 | 13.32 | 14.47 | 15.52 | 4.54\*\*\* | (12.65) |
| Loanvalue/TS | 41.50 | 134.90 | 89.40 | 205.23 | 47.90\*\*\* | (11.41) |
| Avg. position (pct) | 1.45 | 2.07 | 1.20 | 1.59 | −0.25\*\*\* | (8.25) |
| Avg. position in loans (pct) | 0.74 | 1.02 | 0.84 | 1.05 | 0.10\*\*\* | (4.03) |
| Loan Avg. Short interest | 12.26 | 6.46 | 11.06 | 6.26 | −1.20\*\*\* | (8.51) |
| Loan Avg. Bid-Ask | 0.15 | 0.16 | 0.14 | 0.17 | −0.01\*\*\* | (3.43) |
| Loan Avg. Hi-Lo | 3.87 | 1.86 | 3.68 | 1.83 | −0.19\*\*\* | (4.63) |
| Loan Avg. Mcap | 6,273 | 12,679 | 7,019 | 15,785 | 745\* | (2.23) |
| Competition index | 0.32 | 0.10 | 0.26 | 0.10 | −0.07\*\*\* | (31.95) |
| Cooperation index | 0.45 | 0.08 | 0.39 | 0.07 | −0.06\*\*\* | (38.14) |
| Observations | 16,718 | | 5,226 | | 21,944 | |

\*, \*\*, \*\*\* denote significance at the 10%, 5%, and 1% levels, respectively.

---

## V. Identification

This article examines the signals and information that can be extracted from stock loan demand. The identification strategy relies on the allocation of a stock loan being random between similar lender candidates.

I examine how new loans are allocated using data on the universe of U.S. mutual funds from N-PORT filings for the period of 2019–2020. Formally, I estimate the following regression:

$$Y_{f,s,t} = \beta_1 \text{holdshare}_{f,s,t} + \beta_2 \text{utilization}_{f,s,t-1} + \mathbf{X}_{f,s,t} \tag{7}$$

where the dependent variable is $\text{Newloans}_{f,s,t}$, an indicator variable that takes a value of 1 if fund $f$ has new loans in stock $s$ in quarter $t$ (Panel A of Table 2), and the percentage increase in new loans in stock $s$ allocated to fund $f$ in quarter $t$ (Panel B). $\text{holdshare}_{f,s,t}$ is the market share the fund holds in stock $s$ at time $t$, and $\text{utilization}_{f,s,t-1}$ is the fund's previous quarter utilization rate in stock $s$. $\mathbf{X}_{f,s,t}$ represents a vector of fixed effects capturing unobserved variation for fund family, fund, stock, time, and securities lending agent.

**Table 2: Loan Allocation**

*Analysis of how stock loans are allocated between mutual funds using hand-collected data from SEC N-PORT filings. Panel A reports the results from regressing an indicator variable $\text{newloans}_{f,s,t}$ on fund-level holdings share. Panel B reports results from regressing the share of new loans ($\text{newloanshare}_{f,s,t}$) on fund-level holdings share and utilization rate. Standard errors are clustered by fund family and time.*

**Panel A: Probability of Being Assigned a New Loan**

| | (1) | (2) | (3) | (4) | (5) | (6) |
|---|---|---|---|---|---|---|
| Holdshare (f.family) | 0.473\*\*\* | 0.266\*\*\* | | | 0.465\*\*\* | 0.252\*\*\* |
| | (11.86) | (9.19) | | | (6.35) | (10.35) |
| Holdshare (agent) | | | 0.498\*\*\* | 0.270\*\*\* | 0.170\*\* | 0.022 |
| | | | (13.00) | (14.71) | (2.25) | (0.71) |
| Fund family × Stock × Month FE | Yes | Yes | No | No | Yes | Yes |
| Fund × Month FE | No | Yes | No | Yes | No | Yes |
| Seclend agent × Stock × Month FE | No | No | Yes | Yes | Yes | Yes |
| Observations | 157,237 | 154,877 | 221,987 | 220,528 | 78,810 | 77,211 |
| Adjusted R² | 0.295 | 0.465 | 0.386 | 0.553 | 0.024 | 0.246 |

**Panel B: Share of New Loans Assigned to Fund**

| | (1) | (2) | (3) | (4) | (5) | (6) |
|---|---|---|---|---|---|---|
| Holdshare (f.family) | 0.875\*\*\* | 0.784\*\*\* | | | 0.888\*\*\* | 0.779\*\*\* |
| | (43.05) | (20.22) | | | (35.42) | (16.66) |
| Holdshare (agent) | | | 0.561\*\*\* | 0.396\*\*\* | 0.050 | 0.021 |
| | | | (14.20) | (6.26) | (0.92) | (0.34) |
| Utilization | −0.299\*\*\* | −0.313\*\*\* | −0.155\*\*\* | −0.178\*\*\* | −0.273\*\*\* | −0.293\*\*\* |
| | (7.56) | (7.31) | (12.78) | (6.03) | (6.98) | (6.69) |
| Fund family × Stock × Month FE | Yes | Yes | No | No | Yes | Yes |
| Fund × Month FE | No | Yes | No | Yes | No | Yes |
| Seclend agent × Stock × Month FE | No | No | Yes | Yes | Yes | Yes |
| Observations | 57,959 | 55,606 | 56,106 | 53,916 | 41,642 | 39,899 |
| Adjusted R² | 0.482 | 0.508 | 0.335 | 0.624 | 0.009 | 0.041 |

\*, \*\*, \*\*\* denote significance at the 10%, 5%, and 1% levels, respectively.

The estimates in Panel A confirm that the probability of being allocated a new loan increases with the fund's holdings share within the fund family: a 1-percentage-point increase in market share increases the likelihood of being allocated a loan by 0.25–0.47 percentage points. In Panel B, the share of new lending increases by 0.78–0.89 percentage points for every percentage-point increase in the holdings share, and decreases by approximately 0.30 percentage points for every percentage-point increase in the utilization rate.

---

## VI. Empirical Analysis

### A. Trading on Lending Signals

I identify stock-loan-induced trading by comparing the evolution of trading by mutual funds that lend specific stocks to trading in those stocks by groups of similar funds. The main regression is:

$$\Delta\text{Trading}_{f,s,t} = \sum_{k=-8}^{8} \beta_k \, \text{loan}_{f,s,t+k} + \beta_9 \, \text{loan}_{f,s,t \geq 9} + \gamma \, \text{Active}_f$$
$$+ \sum_{k=-8}^{8} \phi_k \, \text{loan}_{f,s,t+k} \times \text{Active}_f + \phi_9 \, \text{loan}_{f,s,t \geq 9} \times \text{Active}_f + \mathbf{X}_{f,s,t} + \varepsilon_{f,s,t} \tag{8}$$

where the dummy $\text{loan}_{f,s,t}$ takes a value of 1 when stock $s$ is on loan by fund $f$ at time $t$, $\text{Active}_f$ is an indicator variable for active funds, and $\mathbf{X}_{f,s,t}$ represents fixed effects controls. The coefficients $\beta_k$ on the leads and lags of the $\text{loan}_{f,s,t}$ dummy estimate the event-time variation in $\Delta\text{Trading}_{f,s,t}$ for passive funds, comparing the portfolio weight changes of stocks on loan to those of passive non-lender funds in the same category group (TNA group, IOC). The coefficients $\phi_k$ similarly estimate the portfolio weight changes of stocks on loan compared to other active funds that are in the same size and style group but do not lend the stock. The sum of the $\beta_k$ and $\phi_k$ coefficients gives the total effect for active lenders.

Fixed effects included progressively across specifications:
- Specification (3): Stock × Quarter FE  
- Specification (4): Stock × Quarter FE, Stock × Fund FE  
- Specification (5): Stock × Quarter FE, Stock × Fund FE, IOC × Quarter FE  
- Specification (6): above + Fund Family × Stock × Quarter FE

**Table 3: Portfolio Rebalancing Around Stock Lending**

*Dependent variable $\Delta\text{Trading}_{f,s,t}$ measures the difference in trading in stock $s$ between a fund and the fund's comparison group. The baseline coefficients are the event-time dummy variables for Passive funds. The Active fund event-time dummies measure trading relative to their benchmark groups and passive funds. For brevity, leads up to 2 quarters and lags up to 6 quarters are reported. Standard errors are clustered at the stock, fund, and quarter levels.*

| | (1) | (2) | (3) | (4) | (5) | (6) |
|---|---|---|---|---|---|---|
| **Passive** | | | | | | |
| $t-2$ | −0.002 | −0.002 | −0.002\* | 0.000 | −0.001 | −0.001 |
| $t-1$ | −0.004\*\* | −0.004\*\* | −0.004\*\*\* | −0.004\*\*\* | −0.002\* | −0.002 |
| $t=0$ | 0.003\* | 0.003\* | 0.003\*\* | 0.001 | 0.001 | 0.002 |
| $t+1$ | 0.002 | 0.002 | 0.001 | 0.004\*\*\* | 0.003\*\* | 0.004\*\*\* |
| $t+2$ | 0.000 | 0.000 | 0.000 | 0.002 | 0.002 | 0.001 |
| $t+3$ | −0.001 | −0.001 | −0.002 | −0.001 | −0.001 | 0.000 |
| $t+4$ | 0.000 | 0.000 | 0.000 | 0.000 | 0.001 | 0.001 |
| $t+5$ | 0.000 | −0.001 | 0.000 | 0.000 | 0.000 | 0.002\* |
| $t+6$ | −0.001 | −0.001 | −0.001 | −0.001 | −0.001 | −0.001 |
| **Active** | | | | | | |
| $t-2$ | −0.001 | −0.001 | −0.001 | −0.002 | −0.002 | −0.003\* |
| $t-1$ | −0.001 | −0.001 | −0.001 | 0.000 | −0.002 | −0.002 |
| $t=0$ | −0.006\*\*\* | −0.006\*\*\* | −0.006\*\*\* | −0.001 | −0.001 | 0.000 |
| $t+1$ | −0.006\*\* | −0.006\*\* | −0.006\*\*\* | −0.003 | −0.004\* | −0.003\*\* |
| $t+2$ | −0.005\*\*\* | −0.005\*\*\* | −0.004\*\*\* | −0.002 | −0.002 | −0.004\*\* |
| $t+3$ | −0.003\* | −0.003\* | −0.003\*\* | −0.002 | −0.003\*\* | −0.002\*\* |
| $t+4$ | −0.003\*\*\* | −0.003\*\*\* | −0.002\* | −0.001 | 0.000 | −0.001 |
| $t+5$ | −0.002\*\* | −0.002\* | −0.002\* | −0.001 | −0.001 | 0.000 |
| $t+6$ | −0.001 | −0.001 | −0.001 | 0.000 | −0.001 | −0.001 |
| Fund flow control | No | Yes | No | No | No | No |
| Stock × Quarter FE | No | No | Yes | Yes | Yes | Yes |
| Stock × Fund FE | No | No | No | Yes | Yes | Yes |
| IOC × Quarter FE | No | No | No | No | Yes | Yes |
| F.Family × Stock × Quarter FE | No | No | No | No | No | Yes |
| Observations | 31,356,250 | 30,837,398 | 31,326,947 | 30,759,547 | 28,251,261 | 16,660,066 |
| Adjusted R² | 0.000 | 0.000 | 0.005 | 0.068 | 0.096 | 0.281 |

\*, \*\*, \*\*\* denote significance at the 10%, 5%, and 1% levels, respectively.

Active funds sharply decrease their holdings relative to otherwise similar active non-lenders as a reaction to the stock loans, with no indication of a reversal even after 8 quarters. In contrast, passive funds show little change in their positions through the event window. The cumulative effect for active funds at 8 quarters is approximately −1.93 percentage points.

### B. Information Spillovers

Section VI.A shows that active funds trade on the information they gain from securities lending, while passive funds do not. I identify stock lending by each fund type and examine whether funds that do not lend a security trade it, indicating that information is transmitted from lenders to non-lenders within mutual fund families. I estimate model (8) with the same regression specifications.

**Table 4: Information Spillovers from Lending**

*Panel A studies lending by passive funds within a fund family; Panel B studies lending by active funds. Fund-stock observations that are on loan themselves are excluded from the analysis. Standard errors are clustered at the stock, fund, and quarter levels.*

**Panel A: Lending by Passive Funds**

| | (1) | (2) | (3) | (4) | (5) | (6) |
|---|---|---|---|---|---|---|
| **Passive** | | | | | | |
| $t-2$ | −0.003\*\* | −0.003\*\* | −0.003\*\*\* | −0.002\* | −0.001 | −0.011\*\*\* |
| $t-1$ | −0.002 | −0.002 | −0.001 | −0.003\*\* | −0.003\* | −0.023\*\*\* |
| $t=0$ | −0.005\*\*\* | −0.005\*\*\* | −0.006\*\*\* | −0.003\*\*\* | −0.002\*\*\* | 0.000 |
| $t+1$ | −0.003\*\* | −0.003\*\* | −0.002 | −0.004\*\*\* | −0.004\*\*\* | −0.005\*\*\* |
| $t+2$ | −0.001 | 0.000 | −0.001 | −0.002 | −0.002 | −0.001 |
| $t+3$ | −0.001 | −0.001 | −0.001 | −0.001 | −0.001 | 0.000 |
| $t+4$ | 0.000 | 0.000 | 0.000 | 0.000 | 0.001 | 0.002 |
| $t+5$ | −0.001 | −0.001 | 0.000 | 0.000 | 0.000 | 0.002\*\* |
| $t+6$ | −0.001 | −0.001 | −0.001 | −0.001 | −0.001 | −0.002 |
| **Active** | | | | | | |
| $t-2$ | −0.002 | −0.002 | −0.003\* | −0.002 | −0.003\* | −0.003\* |
| $t-1$ | −0.001 | −0.001 | 0.000 | −0.001 | −0.002 | −0.005\*\*\* |
| $t=0$ | −0.009\*\*\* | −0.009\*\*\* | −0.010\*\*\* | −0.003\*\* | −0.002\* | −0.005\*\*\* |
| $t+1$ | −0.005\*\* | −0.005\*\* | −0.004\*\* | −0.002 | −0.003 | −0.002 |
| $t+2$ | −0.006\*\*\* | −0.006\*\*\* | −0.004\*\*\* | −0.003\* | −0.003\* | −0.004\*\* |
| $t+3$ | −0.003 | −0.003 | −0.002 | −0.001 | −0.002 | −0.002\* |
| $t+4$ | −0.004\*\*\* | −0.004\*\*\* | −0.002\*\* | −0.001 | 0.000 | 0.000 |
| $t+5$ | −0.002 | −0.002 | −0.001 | 0.000 | 0.000 | −0.001 |
| $t+6$ | −0.002 | −0.002 | −0.001 | 0.000 | 0.000 | −0.001 |
| Observations | 31,356,250 | 30,837,398 | 31,326,947 | 30,759,547 | 28,251,261 | 16,660,066 |
| Adjusted R² | 0.000 | 0.000 | 0.005 | 0.068 | 0.096 | 0.281 |

**Panel B: Lending by Active Funds** *(selected rows)*

| | (1) | (2) | (3) | (4) | (5) | (6) |
|---|---|---|---|---|---|---|
| **Active**, $t=0$ | −0.008\*\*\* | −0.008\*\*\* | −0.009\*\*\* | −0.004\*\*\* | −0.003\*\*\* | −0.006\*\*\* |
| **Active**, $t+1$ | −0.002 | −0.002 | −0.003 | −0.003 | −0.003\* | −0.002 |
| **Active**, $t+2$ | −0.003\*\* | −0.003\*\* | −0.003\* | −0.002 | −0.002 | −0.004\*\* |
| **Active**, $t+3$ | −0.001 | −0.001 | −0.001 | −0.002 | −0.002\*\* | −0.002\*\* |
| Fixed effects | — as in Panel A — | | | | | |
| Observations | 31,356,250 | 30,837,398 | 31,326,947 | 30,759,547 | 28,251,261 | 16,660,066 |

\*, \*\*, \*\*\* denote significance at the 10%, 5%, and 1% levels, respectively.

Active funds trade more aggressively when passive funds in the family lend a security than when they lend themselves. There is no evidence of passive funds trading when other funds in the family lend securities.

### C. Cross-Sectional Effects on Trading and Information Spillovers

I split fund families into high and low groups within each calendar quarter based on the competition, cooperation, and composite net cooperation indices from Evans et al. (2020), and estimate model (8) on the groups separately.

**Table 5: Cross-Sectional Effects on Trading** *(selected rows)*

*Panel A shows sample splits based on fund family competition, cooperation, and net cooperation following Evans et al. (2020). Panel B shows splits based on past fund returns, imputed fund flow, total net assets, and past returns within the CRSP IOC group. Stock × Quarter FE included throughout.*

**Panel A: Fund Family Competition and Cooperation**

| Event | Competition Low | Competition High | Cooperation Low | Cooperation High |
|---|---|---|---|---|
| Active $t=0$ | −0.006\* | −0.022\* | −0.032 | −0.005\*\* |
| Active $t+1$ | −0.010\*\*\* | −0.018 | −0.020 | −0.011\*\*\* |
| Active $t+2$ | −0.008\*\*\* | −0.003 | −0.003 | −0.009\*\*\* |
| Active $t+3$ | −0.006\*\*\* | −0.004 | −0.010 | −0.006\*\* |
| Observations | 11,342,979 | 3,030,342 | 2,129,836 | 12,240,191 |

Active funds in less competitive and more cooperative families show statistically significant trading responses, while those in more competitive/less cooperative families do not.

### D. Stock Returns

To confirm the information content of stock loans, I perform forward-looking event studies on stock returns for stocks borrowed from active and passive funds, computing CAPM, Fama and French (1993) 3-factor, and Carhart (1997) 4-factor risk-adjusted abnormal returns.

Stocks borrowed from either lender type earn cumulative risk-adjusted returns of approximately −3.6% (−8%) in the 2 (8) quarters following a loan. There is no indication of a reversal even 12 quarters after a loan.

Separating stocks borrowed from active funds into two groups based on the change in the number of shares held in the 4 quarters starting with $t = 0$ to $t = 3$:

- **Low rebalancing group** (more negative rebalancing): cumulative returns of approximately −9.5% in 12 quarters.
- **High rebalancing group** (less negative rebalancing): cumulative returns of approximately −5.2% in 12 quarters.

The absence of a return reversal in either group indicates the effect is not due to price pressure, affirming the information-based explanation.

### E. Trading Ability and Lending Fees

I regress the lending fee proxy and over-collateralization measure on the passive fund indicator:

$$Y_{f,t} = \beta \, \text{Passive}_f + \varepsilon_{ft} \tag{9}$$

where $Y_{f,t}$ is the lending fee proxy (specifications (1)–(4) of Table 7) or the overcollateral measure (specifications (5)–(8)). The coefficient $\beta$ measures the difference in fees and overcollateralization between passive and active funds, after controlling for fund issuer-time fixed effects and investment objective code fixed effects.

**Table 7: Lending Fees and Collaterals**

*Dependent variable in columns 1–4 is $\widehat{\text{lendingfee}}_{f,t}$; in columns 5–8 it is Overcollateral. All specifications include Issuer × Quarter FE and CRSP Obj Cd FE.*

| | LendingFee (1) | LendingFee (2) | LendingFee (3) | LendingFee (4) | Overcollateral (5) |
|---|---|---|---|---|---|
| Passive | 0.570\*\*\* | 0.687\*\*\* | 0.749\*\*\* | 0.679\*\*\* | 0.029 |
| | (3.16) | (3.74) | (3.86) | (3.62) | (0.15) |
| ln(TNA) | | −0.116\*\*\* | | | |
| | | (3.36) | | | |
| Loanvalue/TS | | | 0.000 | | |
| ln(Loan Avg. Shortint) | | | | −0.144 | |
| ln(Loan Avg. Mcap) | | | | −0.794\*\*\* | |
| Num. loan/Num. hold | | | | 0.022\*\*\* | |
| Observations | 4,189 | 4,174 | 3,449 | 3,096 | 6,114 |
| Adjusted R² | 0.464 | 0.465 | 0.521 | 0.547 | 0.210 |

\*, \*\*, \*\*\* denote significance at the 10%, 5%, and 1% levels, respectively.

Passive funds earn lending fees approximately 0.57 to 0.75 percentage points higher than active funds on an annualized basis — approximately 50–70% of the average stock lending fee for active funds. The coefficient for overcollateralization is close to 0 and statistically insignificant, ruling out the explanation that the fee difference arises from passive funds taking more risks by setting lower collateral requirements.

**Table 8: Marketwide Average Fees (Counterfactual)**

*Uses Markit market-average lending fees, uniform across lenders at the stock level. No significant difference between active and passive funds, indicating that the fee premium is not due to passive funds lending different stocks.*

| | (1) | (2) | (3) | (4) |
|---|---|---|---|---|
| Passive | −0.007 | −0.006 | −0.008 | −0.011 |
| | (0.97) | (0.87) | (1.14) | (1.58) |
| Observations | 9,914 | 9,812 | 9,914 | 8,100 |
| Adjusted R² | 0.946 | 0.945 | 0.946 | 0.948 |

### F. Market Participation

I test whether passive funds participate more in the securities lending market using the following regression:

$$Y_{f,t} = \alpha + \beta_1 \, \text{Passive}_{f,t} + \gamma \mathbf{X}_{f,t} + \varepsilon_{f,t} \tag{10}$$

where $Y_{f,t}$ is a lending participation or intensity variable. Controls include log total net assets, management fee, portfolio average market capitalization, short interest, bid-ask spread, dollar volume, and the competition and cooperation indices from Evans et al. (2020).

**Table 9: Lending Market Participation**

*Dependent variable in columns 1–3 is an indicator for any securities lending; in columns 4–6 it is Loanvalue/TNA; in columns 7–9 it is the intensive margin (value of outstanding loans divided by total holdings in the stocks on loan).*

| | Lending (1) | Lending (2) | Lending (3) | LV/TNA (4) | LV/TNA (5) | LV/TNA (6) |
|---|---|---|---|---|---|---|
| Passive | 0.111\*\*\* | 0.013\* | 0.037\*\*\* | 1.944\*\*\* | 0.525\*\*\* | 2.532\*\*\* |
| | (14.55) | (1.70) | (3.64) | (23.84) | (5.73) | (18.75) |
| ln(TNA) | | 0.042\*\*\* | 0.026\*\*\* | | 0.098\*\*\* | 0.275\*\*\* |
| Competition index | | | −0.496\*\*\* | | | −2.559\*\*\* |
| Cooperation index | | | 1.215\*\*\* | | | 4.742\*\*\* |
| Quarter FE | Yes | No | Yes | Yes | No | Yes |
| Issuer × Quarter FE | No | Yes | No | No | Yes | No |
| CRSP Obj Cd FE | No | Yes | Yes | No | Yes | Yes |
| Observations | 21,944 | 15,649 | 9,527 | 13,002 | 10,140 | 5,539 |
| Adjusted R² | 0.065 | 0.480 | 0.293 | 0.073 | 0.519 | 0.327 |

\*, \*\*, \*\*\* denote significance at the 10%, 5%, and 1% levels, respectively.

Passive funds are 11% more likely to participate in the stock lending markets when controlling only for time fixed effects. This difference decreases to 1.3% when including fund and portfolio controls and issuer-time fixed effects, and to 3.7% when controlling for fund family incentives. Passive funds also lend a larger share of their portfolios (approximately 1.9 to 2.5 percentage points more in Loanvalue/TNA), and lend more intensively at the stock level (approximately 45–60 percentage points more in the intensive margin measure).

---

## VII. Conclusion

I use a unique hand-collected data set to study mutual funds' stock-level securities lending and their subsequent trading of borrowed stocks. The key findings are:

1. **Active funds exploit information from stock lending**: They reduce portfolio weights in borrowed stocks by approximately 1.04 percentage points of net assets in the 2 quarters after a loan, with no subsequent reversal (growing to −1.93 pp after 8 quarters). Passive funds do not respond.

2. **Information spillovers within fund families**: Active funds trade in response to lending by passive peer funds in the same family, more so than in response to their own lending. This effect is strongest in more cooperative, less competitive fund families.

3. **Active funds can identify informed borrowing**: Stocks from which lender funds rebalance more aggressively experience significantly more negative returns (−9.5% vs. −5.2% over 12 quarters), with no reversals.

4. **Passive funds earn higher lending fees**: Passive funds earn 0.57–0.75 percentage points more than active funds on an annualized basis, with no difference in collateral requirements, consistent with short sellers paying a quality premium to reduce recall risk, and with active funds offering an "information discount" to attract borrowers.

5. **Passive funds participate more in lending markets**: Both at the extensive margin (11% more likely) and the intensive margin (lending 45–60 percentage points more of their lendable supply).

These results suggest that mutual fund managers possess the skill to extract and use information collected by more skilled market participants (short sellers), but that actually receiving these signals is partly based on the random allocation of stock loans.

---

## References

Agarwal, V., and H. Zhao. "Interfund Lending in Mutual Fund Families: Role in Liquidity Management." *Review of Financial Studies*, 32 (2019), 4079–4115.

Appel, I.; T. A. Gormley; and D. B. Keim. "Passive Investors, Not Passive Owners." *Journal of Financial Economics*, 121 (2016), 111–141.

Appel, I.; T. A. Gormley; and D. B. Keim. "Identification Using Russell 1000/2000 Index Assignments: A Discussion of Methodologies." *Critical Finance Review*, 13 (2025), 151–224.

Bhattacharya, U.; J. H. Lee; and V. K. Pool. "Conflicting Family Values in Mutual Fund Families." *Journal of Finance*, 68 (2013), 173–200.

Boehmer, E.; C. M. Jones; and X. Zhang. "Which Shorts Are Informed?" *Journal of Finance*, 63 (2008), 491–527.

Carhart, M. M. "On Persistence in Mutual Fund Performance." *Journal of Finance*, 52 (1997), 57–82.

Chaudhuri, R.; Z. Ivković; and C. Trzcinka. "Cross-Subsidization in Institutional Asset Management Firms." *Review of Financial Studies*, 31 (2017), 638–677.

Dannhauser, C. D., and H. D. Spilker. "The Modern Mutual Fund Family." *Journal of Financial Economics*, 148 (2023), 1–20.

Engelberg, J. E.; A. V. Reed; and M. C. Ringgenberg. "How Are Shorts Informed? Short Sellers, News, and Information Processing." *Journal of Financial Economics*, 105 (2012), 260–278.

Evans, R. B.; M. A. Ferreira; and M. Porras Prado. "Fund Performance and Equity Lending: Why Lend What You Can Sell?" *Review of Finance*, 21 (2017), 1093–1121.

Evans, R. B.; M. Porras Prado; and R. Zambrana. "Competition and Cooperation in Mutual Fund Families." *Journal of Financial Economics*, 136 (2020), 168–188.

Fama, E. F., and K. R. French. "Common Risk Factors in the Returns of Stocks and Bonds." *Journal of Financial Economics*, 33 (1993), 3–56.

Gaspar, J.-M.; M. Massa; and P. Matos. "Favoritism in Mutual Fund Families? Evidence on Strategic Cross-Fund Subsidization." *Journal of Finance*, 61 (2006), 73–104.

Greppmair, S.; S. Jank; P. C. Saffi; and J. Sturgess. "Securities Lending and Information Acquisition." Working Paper (2020).

Jones, C. M.; A. V. Reed; and W. Waller. "Revealing Shorts: An Examination of Large Short Position Disclosures." *Review of Financial Studies*, 29 (2016), 3278–3320.

McCullough, A. "Securities Lending: An Examination of the Risks and Rewards." Morningstar Manager Research, December 2018.

Palia, D., and S. Sokolinski. "Strategic Borrowing from Passive Investors." *Review of Finance*, 28 (2024), 1537–1573.

Porras Prado, M. "Future Lending Income and Security Value." *Journal of Financial and Quantitative Analysis*, 50 (2015), 869–902.

Rapach, D. E.; M. C. Ringgenberg; and G. Zhou. "Short Interest and Aggregate Stock Returns." *Journal of Financial Economics*, 121 (2016), 46–65.

---

*© The Author(s), 2025. Published by Cambridge University Press on behalf of the Michael G. Foster School of Business, University of Washington. Open Access under Creative Commons Attribution licence (CC BY 4.0).*
