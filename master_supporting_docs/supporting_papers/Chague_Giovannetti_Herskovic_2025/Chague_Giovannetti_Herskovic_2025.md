# Information Leakage from Short Sellers

**Fernando Chague**† · **Bruno Giovannetti**‡ · **Bernard Herskovic**§

*April 1, 2025*

---

> **Abstract.** Using granular data on the entire Brazilian securities lending market merged with all trades in the centralized stock exchange, we identify information leakage from short sellers. Our identification strategy explores trading execution mismatches between short sellers' selling activity in the centralized exchange and borrowing activity in the over-the-counter securities lending market. We document that brokers learn about informed directional bets by intermediating securities lending agreements and leak that information to their clients. We find evidence that the information leakage is intentional and that brokers, clients and short sellers benefit from it. We also study leakage effects on stock prices.

**Keywords:** short selling, securities lending, brokers, information leakage

**JEL Codes:** G12, G14, G23, G24

---

† Getulio Vargas Foundation – Sao Paulo School of Economics, Brazil. E-mail: fernando.chague@fgv.br.  
‡ Getulio Vargas Foundation – Sao Paulo School of Economics, Brazil. E-mail: bruno.giovannetti@fgv.br.  
§ University of California, Los Angeles (UCLA) – Anderson School of Management; National Bureau of Economic Research (NBER). E-mail: bernard.herskovic@anderson.ucla.edu.

---

## 1 Introduction

There is extensive literature documenting that short sellers are informed investors and that they play a critical role in the price discovery process. However, it is still unclear how their valuable information is disseminated to other market participants. When short selling, investors borrow and sell securities, but these steps happen in different markets. Short selling requires investors to operate both in an over-the-counter (OTC) market to borrow securities and in the centralized exchange to sell them. The OTC nature of securities lending means that a short seller needs to directly contact a broker to borrow securities, which reveals to the broker not only the identity of the short seller but also a short-selling position in the making. We document that brokers actively explore this information, leaking the ongoing shorting bet to their other clients depending on how well-informed they believe the short seller is. We use the securities' selling-borrowing trade execution mismatch to control for trading comovement across market participants, ruling out the possibility that the short seller and the other clients of the broker are trading in response to a common information signal.

The richness of our data and the institutional features of the securities lending market allow us to identify information leakage through brokers, establish brokers' intent, study how they benefit from the leakages, and investigate leakage effects on stock prices. We use two unique datasets. The first is contract-level data for the entire Brazilian OTC securities lending market, and the second includes all transactions realized by all investors in the Brazilian stock market at a daily frequency. Both datasets cover the same sample period, from 2015 to 2018, and by merging these data, we observe every investor's securities lending agreements paired with their trading activity. Our data give us a detailed and complete picture of all equity short-selling and trading activity in Brazil at a daily frequency.

Our empirical analysis proceeds as follows. First, we define **informed securities lending events** when directional bets made by skilled short sellers become salient to brokers. Notably, a broker knows the track record of all clients of its securities lending desk and can screen for skilled ones based on past performance. An informed securities lending event is specific to each broker for a particular stock on a given day, and it happens when one of its skilled clients borrows an unusually large number of shares. The unusual borrowing activity is salient to the broker because it is a pivotal moment when a skilled short seller fully commits to a sizeable directional bet. In our analysis, we identify 1,404 informed securities lending events over a four-year period across 53 different brokers. These events predict future price declines, and brokers intermediating these securities lending agreements observe this valuable information firsthand.

Second, we characterize how institutions trade around informed securities lending events to identify information leakage. Through a differences-in-differences approach, we find that clients of the informed broker further reduce their holdings of the stock involved in an informed securities lending event relative to nonclients of that broker. Our estimates indicate that in the days prior to the event, clients and nonclients keep their positions unchanged in that stock. However, on the event date, clients of the broker change their behavior and become net sellers, with their net volume sold representing **8.1%** of their total gross traded volume.

Third, we document that the transmission of information is intentional by analyzing information leakage in two different placebo events. To rule out leakage by locating securities on the event day, we considered **uninformed securities lending events**. These are instances when unskilled short sellers borrow a large number of shares. Because the broker still needs to locate the shares, information about such a large short position could potentially leak to other clients of the broker. However, we find no evidence of leakage in these uninformed cases.

In another set of placebo events, we consider large borrowing activity by short sellers who appear to be unskilled to a broker (based on poor track records with that broker) but, in fact, have a strong overall track record (with other brokers). We call these **under-the-radar informed securities lending events**. Despite these events accurately predicting price declines, we again see no evidence of broker-driven leakage.

Fourth, we investigate the effects of information leakage on stock prices. We find that the leakage leads to a faster drop in stock prices, lower stock return volatility, and lower serial correlation.

Fifth, we look at the incentives of all three parties involved in the information-sharing arrangement: brokers, short sellers, and clients. We find that all three benefit from information sharing. Short sellers secure their positions before any leak, accelerating price discovery and reducing volatility, enabling them to earn a **net-of-fee return of 2.05%** over their typical 17-day coverage window. Clients receiving this information avoid assets likely to decline, improving their portfolios' risk-adjusted performance, and they reward the broker by bringing more business to its lending desk. Interestingly, the incentives play out through quantities rather than prices: when analyzing the lending fees, we find that the short seller generating events and the clients receiving information pay prevailing market rates when borrowing securities, with no detectable premium or discount.

### Related Literature

We contribute to various strands of literature. The market structure of securities lending implies that brokers are among the first institutions to learn about the short position being made. We are the first to shed light on how brokers play a crucial role in the ways in which information from short sellers gets transmitted to other investors.

Closest to our work is recent literature investigating the role of brokers in information transmission. Di Maggio, Franzoni, Kermani, and Sommavilla (2019) explore the network between 360 managers and 30 brokers, showing that central brokers share information from institutional investors with their best clients. Additionally, Barbon, Di Maggio, Franzoni, and Landier (2019) document that brokers spread information about 385 large portfolio liquidations. Kumar, Mullally, Ray, and Tang (2020) showed that brokers share information acquired from their corporate loans with their hedge fund clients. Li, Mukherjee, and Sen (2021) document that brokers also share information acquired from clients who are corporate insiders.

We make several key contributions to this area of research. First, we provide evidence of information leakage from the securities lending market directly controlling for trading comovement among clients of the same broker. Second, we show that the information leakage is intentional. Third, we measure the broker's gains from information leakage. Fourth, we document that information leakage has implications for asset prices, increasing efficiency and accelerating price discovery.

---

## 2 Dataset

Transactions in the Brazilian stock market occur in a centralized electronic market, and the transactions in the Brazilian securities lending market occurred over-the-counter (OTC) during our sample period. The U.S. and many other countries have the same market structure.

The data is provided by the Securities and Exchange Commission of Brazil (*Comissão de Valores Mobiliários*), which is equivalent to the U.S. SEC. At the investor-stock-day level, we observe a unique identifier for each investor, the investor type (institution or individual), and any volume—the monetary value and the number of shares—purchased and sold in the centralized stock market. In addition, for the OTC securities lending market, we have granular contract-level data.

To rule out concerns regarding the illiquidity of stocks, we focus on stocks with trading volume every trading day in the year before being included in the sample. As a result, our sample has **304 different stocks**—all 92 stocks included in the Bovespa Index and more than 200 other liquid stocks. Our sample represents 92% of the stock market capitalization in Brazil on average.

Our data contains 741,618 different investors (25,500 institutions and 716,118 individual investors) who traded these 304 stocks in the centralized exchange, out of which 101,057 investors (8,664 institutions and 92,393 individuals) engaged in either borrowing or lending at least one of the 304 stocks in the OTC securities lending market.

### 2.1 Securities Lending Market in Brazil

#### 2.1.1 Locate Requirement

In Brazil, there is no formal locate requirement before selling securities. In practice, short sellers inform brokers about their borrowing intentions after executing the short sale. B3, the Brazilian exchange, acts as both the only exchange and the central counterparty, which allows it to implement multiple risk-management measures.

The lack of a formal locate requirement—which allows short sellers in Brazil to sell short before communicating their borrowing intentions to their brokers—provides a methodological advantage for identifying information leakage. This mismatch between selling and borrowing enables us to isolate the impact of each lending transaction from potential trading comovements among a broker's clients that could arise from shared, unobservable signals.

#### 2.1.2 Role of Securities Lending Desk and Timing of Information

In addition to the nonexistent location requirement, another aspect of the Brazilian market is that brokers cannot definitively tell whether a client's selling activity is a short sale. The only time a broker can infer that a client is short selling is when the client contacts the broker to borrow a security, often after the sale has already occurred. Consequently, securities lending desks are typically the first to learn about a short position through formal channels.

In the United States, short sellers generally need broker approval before selling a security because of the locate requirement. Thus, the potential benefits of leaking that information can be greater in the U.S., while in Brazil, the relevant information could be partially dated by the time the lending desk learns of the short position. Given that Brazilian security lending desks receive information later, **our empirical findings likely serve as a lower bound on the possible extent of information leakage**.

#### 2.1.3 Legal Implications

Information leakage may lead to legal consequences, including criminal charges (particularly for insider information) and administrative sanctions for breaches of confidentiality or unfair practices. In the United States and Brazil, brokers have fiduciary duties to safeguard sensitive client information.

#### 2.1.4 Securities Lenders

Typically, brokerage agreements allow brokers to lend stocks on behalf of their clients. This is often the case for retail investors, who passively receive compensation for lending stocks. However, some large pension funds and passive funds may have dedicated personnel negotiating securities lending agreements through multiple brokers.

#### 2.1.5 Conflict of Interests: Internal versus External Leakage

Brokers often have multiple lines of business, including asset management and proprietary trading, which can lead to conflicts of interest. A key concern is whether leakage occurs among the broker's own funds (internal leakage) or among external clients (external leakage).

Our analysis identifies 292 investors whose trading patterns changed drastically on the event day by selling securities, consistent with receiving information. Interestingly, 72% obtained information from multiple brokers for different informed events. This pattern strongly indicates **external leakage** because, under internal leakage, funds would repeatedly receive information from the same broker.

---

## 3 Informed Securities Lending Events

In this section, we characterize events in which brokers become aware of a sizeable directional bet made by an informed short seller.

We assume that a broker perceives an investor as an **informed short seller** if the investor has a good recent track record in borrowing securities that underperform the market after the borrowing date. Formally, we classify an investor as an informed short seller at a given moment in time from the perspective of a broker if she meets two conditions:

1. The investor borrowed securities **at least 10 times** in the previous 90 days from that broker with an average borrowed volume of at least R\$100,000 (approximately US\$29,325); and
2. In the same previous 90 days, the probability of a stock borrowed by the investor subsequently underperforming the market in the 20 trading days after the borrowing date (the average duration of the loan deals) is **statistically greater than 50%** at the 10% confidence level.

An **informed securities lending event** is a day in which a directional bet made by an informed short seller becomes salient to the broker. Specifically, a stock $i$ on date $t$ constitutes an informed securities lending event for broker $j$ if one of the broker's informed short sellers borrows the **largest amount** of that stock on that day relative to all borrowing activity of that short seller in the previous 90 days.

### 3.1 Characterizing Informed Securities Lending Events

Based on our definition, our sample includes **1,404 informed securities lending events**. These events involve 96 different stocks and 53 of the 98 brokers operating in the Brazilian securities lending market during our sample period. A total of 461 investors initiated these 1,404 events: 143 individuals triggered 239 events, while 318 institutions triggered the remaining 1,165 events. The median lending amount was slightly above US\$740,000. Events are well-distributed over time, averaging 351 occurrences per year.

**Table 1** presents summary statistics of lending agreements at three aggregation levels: deal level, borrower level, and broker level.

To investigate what triggers these events, we estimate a stock-day panel regression of a dummy variable indicating whether an event occurred on the following explanatory variables:

- $\text{Ret}^{ex}_{s,t-5,t-1}$: cumulative excess returns over the five trading days preceding the event
- $\log(\text{Vol}_{s,t-10,t-1})$: average logarithm of trading volume over the last ten trading days
- $\text{Volat}_{s,t-10,t-1}$: standard deviation of stock returns over the last ten trading days
- $\text{EA}_{s,t-10,t-1}$: dummy variable indicating an earnings announcement in the last ten trading days
- $\text{Ret}^{ex}_{s,t}$: excess return of stock $s$ on day $t$ relative to the market return
- $\log(\text{Vol}_{s,t})$: logarithm of the trading volume for stock $s$ on day $t$

Our regression estimation includes fixed effects at the stock level (results reported in **Table 2**).

### 3.2 Do Informed Securities Lending Events Forecast Returns?

Yes. To test predictive power, we estimate panel regressions at the stock-day level of future excess returns on an event dummy, controlling for various variables known to predict returns.

**Table 3** presents results predicting cumulative returns over different horizons. The event dummy $\text{Event}_{s,t}$ is defined as:

$$\text{Event}_{s,t} = \mathbf{1}[\text{informed securities lending event for stock } s \text{ on day } t]$$

The dependent variables are:

$$\text{Ret}^{ex}_{s,t+1,t+5}, \quad \text{Ret}^{ex}_{s,t+1,t+10}, \quad \text{Ret}^{ex}_{s,t+1,t+20}$$

Across all columns, the coefficient on $\text{Event}_{s,t}$ is negative and statistically significant:

- 5-day horizon: $-37.9$ basis points (most robust specification: $-36.6$ bps)
- 10-day horizon: $-53.6$ bps ($-51.6$ bps)
- 20-day horizon: $-96.5$ bps ($-93.8$ bps)

The volume-weighted average lending fee for our events is approximately **135 bps annually** (median 21 bps). Converting to the relevant horizons yields roughly 2.7, 5.3, and 10.6 bps. Hence, of the total price decline, about **7 to 11%** is paid back to the broker in fees.

---

## 4 Evidence of Information Leakage

### 4.1 Institutions Likely to Receive Information

In our baseline analysis, we focus on institutions that meet four criteria:

1. Buy or sell securities at least **once a week** on average;
2. Short sell at least **once a month** on average;
3. Trade an average volume of at least **R\$100,000** (US\$29,325);
4. Trade at most **10 different stocks** on the median day the institution trades.

In our sample, 463 institutions satisfy these criteria. On average, they represent 12.9% of the daily volume, with an average daily trading volume of around R\$4 million (≈US\$1.2 million). These institutions also use multiple brokers on average, about 9.16 different brokers.

We define an institution as a broker's client on the event day if it had any open securities lending agreement with that broker during the **90 days preceding the event date**.

### 4.2 First-Pass Evidence

We quantify the trading behavior of clients and nonclients around each event by computing two different trading imbalance measures. Let $\nu = (s, b, l, \tau)$ be an informed securities lending event intermediated by broker $b$ and generated by short seller $l$ on security $s$ and day $\tau$.

**Volume-based imbalance** ($V\text{Imbalance}$):

$$V\text{Imbalance}^c_{\nu,t} = \frac{V\text{Buy}^c_{\nu,t} - V\text{Sell}^c_{\nu,t}}{V\text{Buy}^c_{\nu,t} + V\text{Sell}^c_{\nu,t}}$$

where $V\text{Buy}^c_{\nu,t}$ is the total volume of security $s$ purchased by clients of event broker $b$ on day $t$, and $V\text{Sell}^c_{\nu,t}$ is the total volume sold. This measure ranges from $-1$ (only sales) to $+1$ (only purchases).

**Number-based imbalance** ($N\text{Imbalance}$):

$$N\text{Imbalance}^c_{\nu,t} = \frac{N\text{Buy}^c_{\nu,t} - N\text{Sell}^c_{\nu,t}}{N\text{Buy}^c_{\nu,t} + N\text{Sell}^c_{\nu,t}}$$

where $N\text{Buy}^c_{\nu,t}$ is the number of different clients who purchased the stock on day $t$ and $N\text{Sell}^c_{\nu,t}$ is the number who sold. This measure also ranges from $-1$ to $+1$.

To test whether clients and nonclients trade differently on the event day, we estimate the following difference-in-differences regression:

$$y^j_{\nu,t} = \beta_0 + \beta_1 \text{Clients}^j_{\nu,t} + \beta_2 \text{EventDay}^j_{\nu,t} + \beta_3 \text{Clients}^j_{\nu,t} \times \text{EventDay}^j_{\nu,t} + \mu_\nu + \epsilon^j_{\nu,t}$$

for $t = \tau - 10, \tau - 9, \ldots, \tau - 1, \tau$, where:

- $y^j_{\nu,t}$ is either $V\text{Imbalance}^j_{\nu,t}$ or $N\text{Imbalance}^j_{\nu,t}$
- $\text{Clients}^j_{\nu,t}$ is a dummy equal to one if $y^j_{\nu,t}$ refers to clients of the broker
- $\text{EventDay}^j_{\nu,t}$ is a dummy equal to one on the day of the event
- $\mu_\nu$ represents event fixed effects

**Coefficient $\beta_3$** is our parameter of interest, measuring whether the change in $y^j_{\nu,t}$ on the event day compared to the previous 10 days is different between clients and nonclients. Results in **Table 4** show a negative and significant $\hat{\beta}_3$ in all columns.

### 4.3 Main Identification: Controlling for Trading Comovement

Our setting allows us to control for possible trading comovement among clients of the same broker, exploiting the interplay between two drastically different market structures: OTC securities lending and the centralized stock exchange.

In Brazil, settlement in the OTC securities lending market occurs **on the same day** that the loan deal is closed. However, settlement in the centralized stock market occurs **3 business days** after the trade is executed. Accordingly, short sellers can wait a few days to borrow the stock after selling. As a result, the selling dynamics of short sellers no longer necessarily coincides with the borrowing date—which is when the broker becomes aware of directional bets.

To control for trading comovement, we include in the regression the actual selling activity of the short seller generating the informed event. Define $\pi_{\nu,t}$ as the fraction of the short seller's total 4-day volume sold on day $t$:

$$\pi_{\nu,t} = \frac{\text{Volume sold by short seller on day } t}{\text{Total volume sold by short seller over days } \tau-3, \tau-2, \tau-1, \tau}$$

Our main specification is estimated on the **4-day period** of each informed securities lending event:

$$y^j_{\nu,t} = \beta_0 + \beta_1 \text{Clients}^j_{\nu,t} + \beta_2 \text{EventDay}^j_{\nu,t} + \beta_3 \text{Clients}^j_{\nu,t} \times \text{EventDay}^j_{\nu,t} + \beta_4 \pi^j_{\nu,t} + \beta_5 \text{Clients}^j_{\nu,t} \times \pi^j_{\nu,t} + \mu_\nu + \epsilon^j_{\nu,t} \tag{2}$$

By including $\pi^j_{\nu,t}$ and $\text{Clients}^j_{\nu,t} \times \pi^j_{\nu,t}$, we allow for direct comovement in trading activity between the short seller generating the event and other clients of that broker (captured by $\beta_4 + \beta_5$), as well as between nonclients and the short seller (captured by $\beta_4$). As a result, **$\beta_3$ measures only the effect of the informational shock received by the broker on the event day**.

The average fraction of the borrowed volume that the short seller has already sold, in the three days before the event, is $16.6\% + 38.2\% + 46.0\% = 100.8\%$.

Results in **Table 5** confirm:

- Significant comovement between the short seller and other clients of the same broker: $\hat{\beta}_4 + \hat{\beta}_5 = 0.030 - 0.132 = -0.102$
- After controlling for $\pi$: $\hat{\beta}_2$ is not significant, and $\hat{\beta}_3$ is significantly negative ($-0.081$, $t = -2.98$ for $V\text{Imbalance}$)
- The net volume clients sell on the event day represents **8.1%** of their total gross traded volume

### 4.4 Short Sellers' Choice of Lending Desks

The short seller's choice of which securities lending desk to borrow from is likely endogenous. Two scenarios are plausible:

1. **Short seller welcomes leakage**: The short seller strategically chooses a broker known to be more likely to leak information, to induce additional selling pressure and accelerate price discovery.
2. **Short seller wants to avoid leakage**: The short seller tries to conceal its trade and minimize information leakage by choosing a less "leaky" desk or borrowing across multiple brokers.

Both scenarios are plausible and likely coexist. Our events are probably capturing short-selling activity more similar to the first scenario, as we are purposely not focusing on short sellers trying to conceal their trades.

---

## 5 Intentional or Unintentional Information Leakage?

We use two types of placebo securities lending events to establish intent.

### 5.1 Uninformed Securities Lending Events

**Uninformed securities lending events** involve short sellers with a losing track record with the broker of the event—i.e., the probability that a stock borrowed by the investor subsequently underperformed the market is statistically **lower than 50%** at the 10% confidence level.

There are **973 uninformed securities lending events**. Re-estimating Equation (2) around these 973 events (reported in **Table 6**, Columns 1–4), we find the estimate of $\hat{\beta}_3$ to be **statistically insignificant** with close-to-zero point estimates. This is evidence of **intentional information leakage**.

### 5.2 Under-the-Radar Informed Securities Lending Events

In this second type of placebo, the short seller is skilled overall (based on agreements with other brokers, $t$-statistic $> 1.64$) but the broker of the event does not have enough evidence of this (the $t$-statistic across the deals intermediated by the event broker is below 1).

There are **562 under-the-radar informed securities lending events**. Re-estimating Equation (2) around these 562 events (reported in **Table 6**, Columns 5–8), we again find **no significant estimate for $\hat{\beta}_3$**. This is additional evidence of intentional information leakage and also rules out direct information sharing from the short seller with other clients.

### 5.3 Comparing Events

**Table 7** reports statistics for the baseline informed events, uninformed events, and under-the-radar events. Under-the-radar events are nearly identical to the baseline events in all observable security characteristics (Column 5 differences are statistically insignificant), confirming that the key determining factor for leakage is the broker's awareness of short sellers' past performance.

### 5.4 Testing Leakage Differences

To formally test whether leakage under placebo events differs from baseline, we augment Equation (2) by including a dummy $P_1$ (equal to one on the day of an uninformed event) and $P_2$ (equal to one on the day of an under-the-radar event):

$$y^j_{\nu,t} = \beta_0 + \beta_1 \text{Clients}^j_{\nu,t} + \beta_2 \text{EventDay}^j_{\nu,t} + \beta_3 \text{Clients}^j_{\nu,t} \times \text{EventDay}^j_{\nu,t} + \beta_4 \pi^j_{\nu,t} + \beta_5 \text{Clients}^j_{\nu,t} \times \pi^j_{\nu,t} + \text{interactions with } P_1, P_2 + \mu_\nu + \epsilon^j_{\nu,t}$$

Results in **Table 8** show that the coefficients on $\text{Clients} \times \text{EventDay} \times P_1$ and $\text{Clients} \times \text{EventDay} \times P_2$ are positive and significant when using $V\text{Imbalance}$ as the dependent variable, confirming that leakage in baseline events is statistically different from either placebo.

---

## 6 Effects on Stock Prices

To measure the implications of information leakage for asset prices, we compare two types of events generated by skilled short sellers: the 1,404 baseline informed events (with leakage) and the 562 under-the-radar events (without leakage).

We estimate the following cross-sectional regression:

$$y_{\nu,h} = \beta_0 + \beta_1 \text{Leakage}_\nu + \mu_l + \epsilon_\nu \tag{3}$$

where $y_{\nu,h}$ can be:

- the **cumulative stock return** $h$ trading days ahead ($h = 5, 10, 20$),
- the **volatility** (standard deviation of daily returns) over those periods, or
- a measure of **serial correlation** of stock returns measured by the $R^2$ of the regression of the daily stock return on its 3 lags.

The subscript $\nu = (s, b, l, \tau)$ indicates an informed securities lending event. The variable $\text{Leakage}_\nu$ equals one for baseline informed events and zero for under-the-radar events. $\mu_l$ represents **short seller fixed effects**.

Results in **Table 9** show:

**Panel A (Cumulative Return):** At the 5-day horizon, stock prices drop more when there is leakage ($\hat{\beta}_1 \approx -0.004$ to $-0.006$, significant). At the 20-day horizon, the price level is similar for both types of events.

**Panel B (Return Volatility):** When information is leaked, stocks are about **10% less volatile**. For example, at the 20-day window:
- Volatility without leakage: $\approx 0.024$ (38.1% annualized)
- Volatility with leakage: $\approx 0.022$ (34.9% annualized)

**Panel C (Return Serial Correlation):** The $R^2$ measure of serial correlation is about **10% lower** for events with leakage.

These results indicate that information leakage does not affect the new price level 20 days ahead but affects how stock prices reach that new level: prices adjust more quickly, volatility is lower, and returns become less serially correlated—consistent with **leakage making price discovery more efficient**.

---

## 7 Incentives

An investor receiving information about an informed securities lending event may regard this leakage as a valuable service the broker provides. Based on Table 3 (Columns 2, 4, and 6), reducing exposure to the event stock yields risk-adjusted returns of $-36.6$, $-51.6$, and $-93.8$ basis points over the subsequent 5, 10, and 20 trading days, respectively.

### 7.1 Short Sellers Generating Informed Securities Lending Events

**Front-running.** In 609 out of 1,404 events, the short seller did not continue selling in the three days following the event. In 929 of these events, either (i) the short seller exhibits no selling activity in the three days post-event, or (ii) post-event sales account for less than 25% of the total volume sold in the 7-day window. Thus, **front-running concerns are minimal** for the majority of cases.

**Net-of-fee performance.** We track the net flow for each shorting event from the first sale date until the position is fully covered (median: **17 days to cover**). The raw average return is **2.14%**. After incorporating actual borrowing fees (average: 1.45% per year), the average **net-of-fee return is 2.05%** across events.

**Lending fees.** Our analysis shows that informed short sellers do not pay significantly different fees for these events. One explanation is that the opposing incentives cancel each other out. Another is that brokers must charge uniform fees for comparable agreements to avoid legal exposure of any perceived quid pro quo.

### 7.2 Broker Leaking Information

We identify clients who possibly received the information as broker clients who (i) are not the short seller responsible for the event, (ii) sold the stock on the day of an event, and (iii) were not selling that stock in the 15 days before the event. According to this definition, **292 institutions** (out of 463) are likely to have received event-related information from their brokers.

**Loyalty dynamics.** We compute for each event-investor pair $i$ the gross volume borrowed and lent as a fraction of total volume across all brokers:

$$\text{Loyalty}_{i,t} = \frac{\text{Vol}^b_{i,t}}{\text{Vol}_{i,t}}$$

where $\text{Vol}^b_{i,t}$ is the total volume borrowed and lent by investor $i$ using the event broker $b$ in period $t$ and $\text{Vol}_{i,t}$ is the total volume across all brokers. We define periods $t \in \{-2, -1, 0, +1\}$, each covering a 90-day window.

We estimate loyalty dynamics via:

$$\text{Loyalty}_{i,t} = \beta_0 + \beta_1 \cdot t_{i,t} + \beta_2 \cdot \text{After}_{i,t} + \mu_i + \epsilon_{i,t} \tag{4}$$

where $\text{After}$ is a dummy equal to one for $t = 0, 1$, and $\mu_i$ are event-investor fixed effects.

Results in **Table 10** show that $\hat{\beta}_2 = 0.026$ (Column 2) is positive and significant for investors who received information: they bring an additional **2.6 percentage points** of their gross volume to that broker after the event. In contrast, $\hat{\beta}_2$ for the short sellers generating the events is positive but **not significant**, indicating their loyalty after the event remains unchanged.

**Lending fees.** Clients receiving information from brokers do not pay significantly higher or lower fees when borrowing the event stock, consistent with brokers charging uniform fees for comparable agreements.

---

## 8 Robustness

### 8.1 Alternative Informed Securities Lending Events

Results remain robust to alternative definitions. **Table 11** reports robustness estimates:

- **Skill threshold $t > 1$**: 1,982 events; $\hat{\beta}_3$ negative and significant.
- **Skill threshold $t > 1.96$**: 1,180 events; $\hat{\beta}_3$ larger in magnitude, negative and significant.
- **Average volume cutoff R\$50k**: 1,774 events; $\hat{\beta}_3$ negative and significant.
- **Volume threshold 50% of max**: 4,728 events; $\hat{\beta}_3$ negative and significant.
- **180-day rolling window**: 1,170 events; $\hat{\beta}_3$ negative and significant.
- **Shifted 20-day window**: 1,295 events; results nearly identical.

### 8.2 Alternative Institutions Likely to Receive Information

Results remain robust to alternative definitions of receiving institutions. **Table 12** reports estimates:

- **Trade once a month**: 714 investors; $\hat{\beta}_3$ negative and significant.
- **Short once a semester**: 587 investors; $\hat{\beta}_3$ negative and significant.
- **Volume cutoff R\$50k**: 512 investors; $\hat{\beta}_3$ negative and significant.
- **At most 5 stocks per day**: 370 investors; $\hat{\beta}_3$ larger and significant.
- **More than 10 stocks per day** (market makers/index funds): 158 investors; $\hat{\beta}_3$ **not significant** — serving as a placebo for institutions less likely to follow stock-picking strategies.

### 8.3 Selective Leakage

Consistent with Di Maggio et al. (2019), we find no significant differences in the trading behavior of the bottom 100 clients by securities lending volume on the event day. Brokers **selectively disclose information** to their most valuable clients.

### 8.4 Other Tests

**Actual short sales.** We classify a sale as a short sale if the investor borrowed the stock from the day before the sale until up to three days after. Using $V\text{Short}$ (log volume shorted relative to 7-day average) and $N\text{Short}$ (number of investors shorting relative to 7-day average), we observe an increase in shorting activity among clients relative to nonclients on the event day (**Table IA.6**).

**Leakage after event day.** The results in **Table IA.7** extend the analysis window to five days post-event and show clients continue to reduce their buying activity more than nonclients in the days following the event, though effects are weaker once short interest data become public.

**Lead-lag effects and longer window.** Expanding the event window to 10 days before the event and adding lead and lag values of $\pi$ (reported in **Table IA.8**), our findings remain largely unchanged.

**Events without public information disclosures.** Restricting to 1,180 events with no earnings announcement or material fact disclosure within a 5-day window around the event day, results remain robust (**Table IA.9**).

---

## 9 Conclusion

In this paper, we examine how information from short sellers is transmitted to other investors. We find that a broker, intermediating a large securities lending agreement by a skilled short seller, leaks information to its clients. We find evidence that this relation is not due to trading comovement among clients of the same broker. We also show evidence that the information leakage is intentional and makes the clients receiving the information more loyal to the broker providing the information. Finally, we find the information leakage accelerates the price discovery process.

A key question is why short sellers rely on brokers to share information rather than doing so themselves. First, short sellers cannot easily prevent brokers from disseminating information. Second, consistent with Ljungqvist and Qian (2016), short sellers may actually want to share information as widely as possible. Third, brokers may serve as especially credible sources given their long-term reputational concerns in these markets.

---

## References

Ahern, K. R., 2017. Information networks: Evidence from illegal insider trading tips. *Journal of Financial Economics* 125, 26–47.

Ahern, K. R., 2020. Do proxies for informed trading measure informed trading? Evidence from illegal insider trades. *The Review of Asset Pricing Studies* 10, 397–440.

Aitken, M. J., Frino, A., McCorry, M. S., Swan, P. L., 1998. Short Sales Are Almost Instantaneously Bad News: Evidence from the Australian Stock Exchange. *Journal of Finance* 53, 2205–2223.

Allen, J., Wittwer, M., 2023. Centralizing over-the-counter markets? Forthcoming at the *Journal of Political Economy*.

Asquith, P., Pathak, P. A., Ritter, J. R., 2005. Short interest, institutional ownership, and stock returns. *Journal of Financial Economics* 78, 243–276.

Babus, A., Kondor, P., 2018. Trading and Information Diffusion in Over-the-Counter Markets. *Econometrica* 86, 1727–1769.

Barber, B. M., Odean, T., 2008. All That Glitters: The Effect of Attention and News on the Buying Behavior of Individual and Institutional Investors. *Review of Financial Studies* 21, 785–818.

Barbon, A., Di Maggio, M., Franzoni, F., Landier, A., 2019. Brokers and Order Flow Leakage: Evidence from Fire Sales. *The Journal of Finance* 74, 2707–2749.

Boehmer, E., Huszár, Z. R., Wang, Y., Zhang, X., Zhang, X., 2022. Can Shorts Predict Returns? A Global Perspective. *The Review of Financial Studies* 35, 2428–2463.

Boehmer, E., Jones, C. M., Zhang, X., 2008. Which Shorts Are Informed? *The Journal of Finance* 63, 491–527.

Boehmer, E., Wu, J. J., 2013. Short Selling and the Price Discovery Process. *Review of Financial Studies* 26, 287–322.

Bris, A., Goetzmann, W. N., Zhu, N., 2007. Efficiency and the Bear: Short Sales and Markets Around the World. *The Journal of Finance* 62, 1029–1079.

Cereda, F., Chague, F., De-Losso, R., Genaro, A., Giovannetti, B., 2022. Price transparency in OTC equity lending markets: Evidence from a loan fee benchmark. *Journal of Financial Economics* 143, 569–592.

Chague, F., De-Losso, R., Genaro, A., Giovannetti, B., 2017. Well-connected short-sellers pay lower loan fees: A market-wide analysis. *Journal of Financial Economics* 123, 646–670.

Chague, F., De-Losso, R., Giovannetti, B., 2019. The short-selling skill of institutions and individuals. *Journal of Banking & Finance* 101, 77–91.

Chen, S., Kaniel, R., Opp, C. C., 2022. Market power in the securities lending market. Working paper.

Christophe, S. E., Ferri, M. G., Angel, J. J., 2004. Short-Selling Prior to Earnings Announcements. *The Journal of Finance* 59, 1845–1876.

Christophe, S. E., Ferri, M. G., Hsieh, J., 2010. Informed trading before analyst downgrades: Evidence from short sellers. *Journal of Financial Economics* 95, 85–106.

Cohen, L., Diether, K. B., Malloy, C. J., 2007. Supply and Demand Shifts in the Shorting Market. *The Journal of Finance* 62, 2061–2096.

Di Maggio, M., Franzoni, F., Kermani, A., Sommavilla, C., 2019. The relevance of broker networks for information diffusion in the stock market. *Journal of Financial Economics* 134, 419–446.

Diether, K. B., Lee, K.-H., Werner, I. M., 2009. Short-Sale Strategies and Return Predictability. *Review of Financial Studies* 22, 575–607.

Drechsler, I., Drechsler, Q. F., 2018. The shorting premium and asset pricing anomalies. Working Paper.

Duffie, D., Malamud, S., Manso, G., 2009. Information Percolation With Equilibrium Search Dynamics. *Econometrica* 77, 1513–1574.

Duffie, D., Malamud, S., Manso, G., 2014. Information percolation in segmented markets. *Journal of Economic Theory* 153, 1–32.

Engelberg, J. E., Reed, A. V., Ringgenberg, M. C., 2012. How are shorts informed? Short sellers, news, and information processing. *Journal of Financial Economics* 105, 260–278.

Evgeniou, T., Hugonnier, J., Prieto, R., 2022. Asset pricing with costly short sales. Working paper.

Figlewski, S., 1981. The Informational Effects of Restrictions on Short Sales: Some Empirical Evidence. *Journal of Financial and Quantitative Analysis* 16, 463–476.

Gargano, A., Sotes-Paladino, J., Verwijmeren, P., 2022a. Out of Sync: Dispersed Short Selling and the Correction of Mispricing. *Journal of Financial and Quantitative Analysis* pp. 1–73.

Gargano, A., Sotes-Paladino, J., Verwijmeren, P., 2022b. Short of capital: Stock market implications of short sellers' losses. Working Paper.

Gârleanu, N. B., Panageas, S., Zheng, G. X., 2021. A long and a short leg make for a wobbly equilibrium. Working paper.

Jiang, H., Habib, A., Hasan, M. M., 2022. Short selling: A review of the literature and implications for future research. *European Accounting Review* 31, 1–31.

Karpoff, J. M., Lou, X., 2010. Short Sellers and Financial Misconduct. *The Journal of Finance* 65, 1879–1913.

Kumar, N., Mullally, K., Ray, S., Tang, Y., 2020. Prime (information) brokerage. *Journal of Financial Economics* 137, 371–391.

Li, F. W., Mukherjee, A., Sen, R., 2021. Inside brokers. *Journal of Financial Economics* 141, 1096–1118.

Ljungqvist, A., Qian, W., 2016. How constraining are limits to arbitrage? *The Review of Financial Studies* 29, 1975–2028.

Muravyev, D., Pearson, N. D., Pollet, J. M., 2022. Anomalies and their short-sale costs. Working paper.

Rapach, D. E., Ringgenberg, M. C., Zhou, G., 2016. Short interest and aggregate stock returns. *Journal of Financial Economics* 121, 46–65.

Reed, A. V., 2013. Short selling. *Annu. Rev. Financ. Econ.* 5, 245–258.

Saffi, P. A. C., Sigurdsson, K., 2011. Price Efficiency and Short Selling. *Review of Financial Studies* 24, 821–852.

Seneca, J. J., 1967. Short Interest: Bearish or Bullish? *Journal of Finance* 22, 67–70.

Walden, J., 2019. Trading, Profits, and Volatility in a Dynamic Information Network Model. *Review of Economic Studies* 86, 2248–2283.

---

## Internet Appendix

### A Settlement Timing at the Brazilian Exchange

When a security purchase transaction is executed at date $T$, the transaction is settled at $T + 3$. The timing of the settlement process is as follows:

- **10:00 AM – 2:00 PM**: The clearinghouse processes the transfer of assets from the seller to the clearinghouse's settlement account.
- **2:00 PM – 3:49 PM**: Confirmation of the availability of assets and final financial balances, along with execution of procedures to resolve possible delivery failures.
- **3:50 PM**: The clearinghouse makes payments owed to creditor clients and coordinates delivery of assets against simultaneous, final, and irrevocable payment.

**Delivery failure.** If by 2:00 PM the assets have not been deposited, the "failure handling" protocol is automatically triggered. The clearinghouse compulsorily borrows the assets in the name of the buyer through the exchange's asset lending system at rates typically **100 times or more** the usual rental rates. A "repurchase order" is then issued by the clearinghouse on $T+3$ in favor of the buyer; once executed, the buyer receives the shares on $T+6$.

### B Lending Fees Paid by Short Sellers When Triggering an Informed Event

We estimate:

$$\text{LoanFee}_{t,s,b,i,c} = \lambda_{b,s,t} + \beta_1 \text{EventBorrow}_{t,s,b,i} + \text{Controls} + \epsilon_{t,s,b,i,c} \tag{IA.1}$$

where $\lambda_{b,s,t}$ are broker–stock–day fixed effects. Controls include $\text{Retail}_i$, $\text{Connections}_i$, and $\log(\text{ContractVolume})_{t,s,b,i,c}$.

We also estimate using broker–stock–investor fixed effects:

$$\text{LoanFee}_{t,s,b,i,c} = \lambda_{b,s,i} + \beta_1 \text{EventBorrow}_{t,s,b,i} + \text{Controls} + \epsilon_{t,s,b,i,c} \tag{IA.2}$$

Across all specifications (**Table IA.1**), $\hat{\beta}_1$ is statistically indistinguishable from zero, with economically small point estimates ranging from $-0.5$ to $4.6$ bps per year.

### C Lending Fees Paid by Clients Likely Receiving Information

We estimate:

$$\text{LoanFee}_{t,s,b,i,c} = \lambda_{b,s,t} + \beta_1 \text{Leakage}_{t,s,b,i,c} + \text{Controls} + \epsilon_{t,s,b,i,c} \tag{IA.3}$$

where $\text{Leakage}_{t,s,b,i,c}$ equals one if (i) there is an informed event on day $t$ for security $s$ through broker $b$, (ii) contract $c$ did not trigger the informed event, (iii) investor $i$ sold security $s$ on the event day, (iv) investor $i$ was not selling security $s$ in the 15 days before the event, and (v) investor $i$ borrowed security $s$ from broker $b$ on day $t$, $t+1$, or $t+2$.

We also estimate using broker–stock–investor fixed effects:

$$\text{LoanFee}_{t,s,b,i,c} = \lambda_{b,s,i} + \beta_1 \text{Leakage}_{t,s,b,i,c} + \text{Controls} + \epsilon_{t,s,b,i,c} \tag{IA.4}$$

Across all specifications (**Table IA.2**), $\hat{\beta}_1$ remains statistically indistinguishable from zero (point estimates range from $-0.5$ to $3.0$ bps per year), confirming that clients receiving information do not pay significantly higher or lower fees.
