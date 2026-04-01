# Learning by Lending Securities

**George C. Nurisso**  
*Warrington College of Business, University of Florida, Gainesville, FL 32611, USA*

**Journal of Financial Economics 178 (2026) 104237**

---

**JEL classification:** D83 · G14 · G23

**Keywords:** Securities lending · Short-sale constraints · Price efficiency · Information acquisition · Index investing

---

## Abstract

Short sellers convey negative information to securities lenders when borrowing shares. I model how this information generates novel interactions between institutional investors' lending and trading decisions. Lower lending fees improve information quality by facilitating more shorting, but also make it less costly for lenders to strategically recall shares to enhance their trading profits. Lenders may then need to raise fees to commit not to recall shares and thereby attract short sellers. Conversely, index fund lenders cannot trade on lending market information. This restriction enables them to attract greater shorting demand and potentially improve price efficiency—despite charging higher fees.

---

## 1. Introduction

Short sellers are informed market participants who must borrow shares to execute their trading strategies. This observation implies that securities lenders can learn valuable information about a stock during the lending process. Specifically, because short sellers are widely regarded as bearers of high-quality negative information, a lender's valuation should drop the moment one borrows shares.[^1] Recent empirical work supports this prediction: Honkanen (2025) and Greppmair et al. (2024) show that lenders exploit this signal by reducing their exposure to lent-out stocks. These findings challenge the notion that securities lending is merely a standalone revenue stream for institutional investors, instead revealing that lending and trading are tightly interconnected activities. Consequently, a formal analysis of how these activities interact is needed to understand the implications of these information leakages for financial markets.

In this paper, I model how an institutional investor's ability to obtain information by lending securities affects its lending and trading decisions. This framework helps reconcile recent empirical findings about the securities lending market and provides a new perspective on several key questions in financial markets: how the rise of index investing affects price efficiency, what determines equilibrium lending fees, and which frictions most impede short selling.

I generate three main results. First, lower lending fees improve the precision of the lender's signal. When fees are low, speculators with negative information separate from those with positive information by borrowing shares. This outcome makes the borrowing status of the lender's shares a highly informative trading signal. Second, lenders must raise fees as a commitment device to eliminate their incentive to recall shares. Lenders sell following a loan agreement, which tempts them to recall lent-out shares to boost their expected selling price. Short sellers will not borrow when they anticipate this behavior, so lenders must commit not to by increasing the opportunity cost of recalling shares via higher fees. Third, passive lenders (e.g., index funds) cannot trade on lending market information, which enables them to relax short-selling constraints and, in some circumstances, improve price efficiency. This result occurs even though increased indexing also leads to higher lending fees.

My model involves a securities lender ("he") and an informed short seller ("she") interacting in a lending market before submitting orders to a Kyle (1985) style market maker. Lending fees are endogenous and are chosen to maximize lender profits.[^2] Higher lending fees increase revenue per loan but decrease lending volume; less obviously, they also decrease the information conveyed by the lending market. After learning whether the short seller borrowed one of his shares, the lender updates his valuation and decides whether to recall the share (if borrowed) before submitting his order to the market maker. If the lender recalls the share, the short seller cannot sell. The market maker observes the aggregate order flow and sets the price equal to the stock's expected value conditional on that order flow.

I start by considering how the lender's optimal fee choice interacts with his trading strategy. After learning that the short seller borrowed one of his shares, the lender always sells. This trade lowers the short seller's profits by reducing her expected selling price. However, the lender's optimal trading direction conditional on no loan agreement depends on the inference he can make about the stock's payoff given that there was no loan. Intuitively, since borrowing demand is a negative signal, the absence of borrowing demand must be a positive signal. The strength of this inference is decreasing in the fee because when fees are high, the lack of borrowing demand is more likely because of the short seller finding shorting too costly than the stock's payoff being high. Consequently, the lender's optimal fee is decreasing in his planned trading quantity conditional on no loan agreement. When the lender plans on buying following no loan agreement, he favors low fees to ensure that this purchase is well-informed. On the other hand, a lender who always intends to sell prefers high fees to reduce trading competition from short sellers.

I then show that the lender's incentive to recall shares prevents him from having too low a fee. For context, U.S. mutual funds are required by the Investment Company Act of 1940 to be able to recall lent-out shares at will, which, if done, forces the short seller to purchase replacements.[^3] As a result, after learning that the stock is overvalued through the lending market, the lender can improve his expected selling price by recalling shares. Chuprinin and Ruf (2018) provide evidence for this practice. The prospect of a higher expected selling price tempts the lender to recall shares, but the short seller anticipates this action and will not borrow if she believes her lender will behave this way. As a result, the lender must commit not to recall shares if he wishes to learn from the lending market: he does so by increasing fees. The lender relinquishes the fee when he recalls shares, so the foregone lending revenue is the cost of this action from his perspective. Thus, the lender loses the incentive to recall shares once the fee is sufficiently high. This no-recall condition establishes a positive lower bound on the set of fees that a lender can charge while still attracting short sellers. The existence of this lower bound is, to my knowledge, new to the short-selling literature and highlights an unintended cost of the regulatory requirement that mutual funds be able to recall shares at will. My analysis shows that this need to commit can considerably increase lending fees and discourage short selling.

The previous two results show that the lender's ability to trade imposes substantial costs on short sellers, so I compare the short-selling constraints that emerge when the lender trades to a benchmark where he cannot. I refer to a lender who cannot trade as passive, which one can interpret as an index fund. Index funds do not have the discretion to trade on information and are prominent players in the securities lending market, making them a natural benchmark.[^4] Because they never trade, passive lenders aim to maximize expected lending revenue, which results in them choosing higher fees than active lenders in equilibrium. Nevertheless, passive lenders still attract greater shorting demand because they can inherently commit not to trade on information learned during the lending process or strategically recall shares.

This result also helps reconcile three findings from the growing empirical literature on how passive investing impacts short-sale constraints. First, Honkanen (2025) and Greppmair et al. (2024) show that active securities lenders (i.e., those with the ability to trade) trade on information learned while lending. Second, Honkanen (2025), Palia and Sokolinski (2024), and Sikorskaya (2025) find that greater passive ownership of a stock is associated with higher lending fees. Third, von Beschwitz et al. (2025), Palia and Sokolinski (2024), and Sikorskaya (2025) demonstrate that short-selling demand for a stock increases with passive ownership. My model's predictions are consistent with all three findings. In effect, these findings suggest that the information leakage costs imposed by active lenders are more burdensome to short sellers than the higher fees of passive lenders. However, the economic forces that prevent active lenders from setting fees sufficiently low to compensate short sellers for these costs remain unclear. My model provides an answer: the active lender's need to commit not to recall shares prevents him from doing so.

Finally, my model shows that by sufficiently relaxing short-sale constraints, passive lenders can improve price efficiency—a novel result in the theoretical literature on index investing. Empirical evidence by von Beschwitz et al. (2025) and Palia and Sokolinski (2024) supports this prediction. However, even when passive lenders do not improve price efficiency outright, their presence in the lending market still mitigates the damage their lack of informed trading would otherwise cause. Existing theoretical work on index investing typically abstracts from the lending market, often assuming frictionless shorting. My framework therefore suggests that such an abstraction leads to an overestimation of the harm caused by index investing.

### 1.1. Related Literature

To my knowledge, only two other papers explicitly model information spillovers during the securities lending process: independent and contemporaneous works by Pankratov (2020) and Chen et al. (2025).[^5]

Pankratov (2020) numerically analyzes a model of endogenous short-sale constraints in which security lenders balance lending revenue against information when setting fees. In contrast, my paper contributes methodologically by developing a tractable theoretical framework for analyzing the equilibrium consequences of information leakages in the securities lending market. This framework admits closed-form solutions, enabling a more transparent characterization of the underlying economic forces while maintaining the flexibility to incorporate key institutional details.

Chen et al. (2025) study market power in securities lending and find evidence for market concentration and non-competitive fees. The authors then propose a model to explain why such market power exists. They compare two different lending market structures: an over-the-counter setting where lenders with market power set fees to maximize lending revenue (similar to my passive lender case) and a competitive, centralized market where borrowing demand is observed by all participants. A fundamental assumption in this model is that lenders in the over-the-counter setting do not trade on whatever information they learn from the lending market. My paper relaxes this assumption and endogenizes the quality of that information through the lender's fee choice.

Contemporaneous work by Sikorskaya (2025) also examines how the rise of passive investing affects shorting demand, albeit through a different channel. In her model, asset managers optimally tilt their portfolios toward the index against which they are benchmarked. This additional institutional demand for index assets increases both lendable supply (via greater institutional ownership) and shorting demand (since the index assets become overvalued), making the equilibrium effect on borrowing fees ambiguous.

This paper also contributes to the theoretical literature on how passive investing impacts price efficiency. There is no overwhelming consensus in this literature. For example, Bond and Garcia (2022) find that passive investors can improve price efficiency, while Coles et al. (2022) find that passive investors have no effect. On the other hand, Baruch and Zhang (2022) and Nurisso (2025) solve models where increased indexing harms price efficiency. However, none of the above papers explicitly analyze how the growth in passive investing impacts price efficiency through the securities lending market.

---

## 2. Model Setup

The model contains four agents: an informed speculator ($S$), a lender ($L$), noise traders, and a market maker. All agents are risk-neutral. There is a single firm whose stock is traded in a financial market. The firm's payoff is $v \in \{0, 1\}$ where $\Pr(v = 1) = \rho \in (0, 1)$. I analyze a static model with two main phases: lending and trading. In the lending phase, the speculator can borrow shares from the lender for a fee $f$. Next, the lender, the speculator, and the noise traders submit their asset demands to the market maker, who sets the stock's price $P(z)$ equal to its expected payoff conditional on the aggregate order flow $z$. After the price is generated, the firm's payoff $v$ is revealed. I assume the speculator is perfectly informed about the realization of $v$ while the lender is uninformed.[^6]

The speculator faces a random opportunity cost of trading, $c$, that is uniformly distributed over $[0, \bar{C}_v]$. In general, this distribution can depend on the underlying firm value $v$. The realization of $c$ is the speculator's private information. The speculator only attempts to trade if her expected profits exceed $c$. One can interpret this situation as the speculator having a finite amount of capital that she can deploy in this period, with $c$ representing the profits of her next best option.[^7]

### 2.1. Lending and Trading

I assume the lender $L$ owns enough shares to lend without constraining his subsequent ability to trade[^8]; this assumption implies that the lender owns $N \geq 2$ shares of the stock.[^9] The lender's asset demand will be $D_L \in \{-1, 0, 1\}$ where $1$ represents a purchase, $0$ represents no trade, and $-1$ represents a sale (not a short sale).[^10] Passive lenders are a special case where $D_L$ always equals zero. On the other hand, the speculator $S$ owns zero shares, so she must borrow shares from the lender to sell the stock short. Her demand is $D_S \in \{-1, 0, 1\}$, but $D_S = -1$ signifies a short sale. The speculator must therefore first borrow a share from the lender to have $D_S = -1$.

The lender chooses a fee $f \geq 0$ to maximize his expected profits. Note that fees will always be non-negative: negative fees amount to the lender paying the speculator to borrow his shares, and this choice is never optimal for the lender.[^11] This fee is a "take-it-or-leave-it" offer sent to the speculator. The speculator borrows if and only if her expected selling profits minus $f$ exceed her cost $c$.[^12] The lender's fee choice resembles a monopolist selecting the profit-maximizing point on a downward-sloping demand curve.[^13] All else equal, a lower fee induces a broader range of speculators (i.e., those with higher values of $c$) to sell the stock short when $v = 0$.

After observing whether the speculator borrowed a share, the lender rationally updates his stock valuation. Denote the lending market signal as $b \in \{1, 0\}$ where $b = 1$ represents the outcome where the speculator borrows the lender's share and $b = 0$ represents the outcome where the speculator does not borrow the lender's share. Motivated by existing regulations, the lender can also recall the lent-out share between the lending and trading stages. If the lender recalls the share, he returns the fee to the speculator and the speculator can no longer sell. This outcome implies that the speculator would make zero trading profits, so her total profits net of opportunity cost $c$ would be negative. Thus, the speculator will not attempt to borrow if she expects her lender to recall the loan.

The financial market is a discrete version of Kyle (1985). Besides the speculator and the lender, there is also noise trade. Aggregate noise demand takes values $D_{NT} \in \{-2, -1, 0, 1, 2\}$ with each outcome having equal probability. I assume that the realization of noise demand is independent of all other random variables and that negative noise demand corresponds to sales and not short sales—only the speculator shorts.[^14] Noise traders also never lend.

All traders submit their demands to a risk-neutral, competitive market maker. The market maker observes the aggregate order flow

$$z \equiv D_S + D_L + D_{NT}$$

and sets the price equal to the expected value of $v$ conditional on that order flow $z$. Thus, I define the price as:

$$P(z) \equiv E[v \mid z] \tag{1}$$

Importantly, the market maker does not observe developments in the lending market (both fees and quantities) and, therefore, cannot distinguish regular sales from the more informative short sales. This inability to observe lending market outcomes allows the lender to trade profitably on the lending market signal $b$.[^15] After the payoff $v$ is revealed, all short sales are completed by the speculator paying her lender the terminal payoff $v$.

### 2.2. Timing

The timing of this game is as follows:

1. The payoff $v$ is generated.
2. The speculator learns the realizations of $v$ and her cost $c$.
3. **Lending Market**
   - (a) The lender chooses a borrowing fee $f \geq 0$ and offers it to the speculator.
   - (b) The speculator decides whether to borrow a share at fee $f$.
   - (c) The lender learns whether his share was borrowed and updates his valuation of the asset.
   - (d) The lender decides whether to recall the loan. If so, the speculator must return the share and the lender must return the fee $f$. If recalled, the speculator can no longer sell.
4. All traders submit their asset demands to the market maker. The price $P(z)$ is then generated through the pricing rule (1).
5. The realization of $v$ is made public. All short sales are completed by the borrower paying the lender $v$.[^16]

### 2.3. Equilibrium Concept

My solution concept for this model is the Perfect Bayesian Equilibrium (PBE). An equilibrium requires (i) a trading strategy for the speculator that maximizes expected profits given the price-setting rule, the fee, the lender's equilibrium trading and recall strategies, and the realizations of the firm's payoff $v$ and her cost $c$; (ii) a fee-setting, trading, and recall strategy for the lender that maximizes expected profits given the price-setting rule, the lending market signal $b$, and the speculator's equilibrium trading strategy; and (iii) a price-setting rule for the market maker that follows Eq. (1) given the strategies of the speculator and the lender. The speculator, the lender, and the market maker have rational expectations in that they update probabilities via Bayes' rule and have correct-in-equilibrium beliefs about the other players' strategies.

One can view the market maker in my model as the "receiver" in a multi-sender signaling game, so I will apply the notion of "unprejudiced beliefs" from Bagwell and Ramey (1991) as my primary equilibrium refinement. This refinement requires the receiver to believe that off-equilibrium outcomes come from the fewest number of deviations from equilibrium play. In my model, a market maker with unprejudiced beliefs should view an off-equilibrium order flow as coming from a single trading deviation by the speculator or the lender instead of by both simultaneously.[^17]

---

## 3. Model Solution

I describe my solution procedure in Section 3.1. In Section 3.2, I solve for the equilibrium with a passive lender under the assumption that the lender cannot recall shares. In Section 3.3, I find all equilibria with an active lender under the assumption that the lender cannot recall shares. In Section 3.4, I analyze how granting the lender the ability to recall shares changes the equilibria. I then compare the various equilibria and examine the implications for price efficiency in Section 3.5.

### 3.1. Solution Procedure

I solve the model under the following parametric assumptions.

**Assumption 1.** $\bar{C}_1$ is low enough to ensure that the speculator always buys when she learns that $v = 1$.

**Assumption 2.** $\bar{C}_0$ is the maximum opportunity cost that ensures the speculator always sells when $v = 0$ in the counterfactual setting where she already owns a share (and thus never needs to borrow).

Assumption 1 says that the exogenous cost of trade $c$ is never high enough to deter the speculator from buying when $v = 1$. This assumption allows me to focus on how the lending market impacts short selling and contrast those results with "frictionless" buying. As such, $\bar{C}_1$, the maximum opportunity cost when $v = 1$, does not play a role in the main analysis. Assumption 2 then facilitates a more exact understanding of how the lending market impacts outcomes by establishing a clear counterfactual benchmark: when the speculator does not need to borrow shares to sell, the unique equilibrium has the speculator always buy when $v = 1$ and always sell when $v = 0$.[^18] The exogenous cost $c$ alone does not deter the speculator's trades: it only does so when combined with lending market frictions. My main results do not depend on these specific parameter restrictions, but they make the model more tractable and easier to interpret.[^19] Given these assumptions, I will hereafter refer to $\bar{C}_0$ as $\bar{C}$ to minimize notational clutter.

I conjecture that the speculator's trading strategy conditional on $v = 0$ follows a threshold rule. The speculator will short sell when $v = 0$ if and only if $c < c^*$ where $c^* \in [0, \bar{C}]$.[^20] The lender's trading strategy will depend on whether the speculator borrowed one of his shares (i.e., the realization of the lending market signal $b$). Denote $D_L(b) \in \{-1, 0, 1\}$ as the lender's demand when he observes the lending market signal $b$.

**Lemma 1.** *The lender always sells when the speculator borrows a share. That is, $D_L^*(b = 1) = -1$.*

The proof of Lemma 1 is straightforward. The speculator only sells short when she knows $v = 0$, so the lender's valuation also becomes zero after making a loan. Thus, selling is always optimal for the lender since prices can never go below zero. However, the lender's optimal trading strategy following no loan agreement (i.e., the lending market signal $b = 0$) is less obvious. I focus on pure strategies for the lender's trades, so $D_L(b = 0) \in \{-1, 0, 1\}$. I also assume the convention that the lender will not trade if indifferent about doing so for the rest of the paper.

I solve for all equilibria by guessing and verifying whether a particular lender demand conditional on no loan agreement ($D_L(b = 0)$) can be part of the lender's equilibrium trading strategy. I then repeat this process for all possible values of $D_L(b = 0)$.

### 3.2. Passive Lender

I first solve the model in the benchmark case where the lender is passive and not allowed to recall shares. The passive lender's defining characteristic is that he does not trade, so $D_L$ always equals zero (regardless of the realization of the lending market signal $b$). One can interpret the passive lender as an index fund that cannot deviate from its index.

I solve the model backward. First, given the speculator's conjectured trading strategy and the fact that the passive lender never trades, the market maker generates prices $P(z) = \Pr[v = 1 \mid z]$, where $z$ is an integer between negative three and three. The prices are functions of the equilibrium short-selling threshold $c^*$. Specifically,

$$P(z) = \begin{cases} 1 & \text{when } z = 3 \\ \dfrac{\rho}{\rho + (1-\rho)(1 - G(c^*))} & \text{when } z = 2 \\ \rho & \text{when } z \in \{1, 0, -1\} \\ 0 & \text{when } z \in \{-2, -3\} \end{cases} \tag{2}$$

where $G(x) \equiv \frac{x}{\bar{C}}$ is the cumulative distribution function of the opportunity cost $c$ when $v = 0$. Intuitively, $P(z) = 1$ means order flow $z$ only occurs when $v = 1$ and $P(z) = 0$ similarly means that $z$ only appears when $v = 0$. $P(z) = \rho$ implies that $z$ is an uninformative order flow (i.e., can always appear in equilibrium), and $P(z) = \frac{\rho}{\rho + (1-\rho)(1-G(c^*))}$ corresponds to a $z$ that only appears when the speculator does not short sell; that is, when $v = 1$, or $v = 0$ and $c \geq c^*$. Observe that since the prices are functions of conjectured equilibrium strategies, the lender and the speculator take them as given.

I must now derive the equilibrium cutoff $c^*$. Given the lender's choice of fee $f$, the actual short-selling threshold (which I denote as $c(f)$) must satisfy

$$c(f) = E[P(z) \mid D_S + D_L = -1] - f \tag{3}$$

All speculators with $c < c(f)$ will then find it optimal to short when $v = 0$, and all speculators with $c \geq c(f)$ will find it optimal not to trade when $v = 0$.

Next, I solve for the passive lender's optimal fee. Since the passive lender never trades, he chooses the fee to maximize his expected lending revenue.

$$\max_f \; \Pr[D_S = -1] \cdot f = \Pr[v = 0] \left( \frac{E[P(z) \mid D_S + D_L = -1] - f}{\bar{C}} \right) f \tag{4}$$

where $\Pr[v = 0]$ equals $1 - \rho$. Also observe that

$$E[P(z) \mid D_S + D_L = -1] = \frac{1}{5} \sum_{z=-3}^{1} P(z)$$

Solving (4) generates the passive lender's optimal fee.

$$f^* = \frac{E[P(z) \mid D_S + D_L = -1]}{2} = \frac{3\rho}{10} \tag{5}$$

Eq. (5) says the passive lender optimally collects half the short seller's expected selling profits as a fee. Moreover, this fee is increasing in the ex-ante probability that the payoff equals one. Intuitively, when $v$ is expected to equal one with high probability (i.e., $\rho$ is close to one), short sales are unlikely but extremely profitable when $v$ does in fact equal zero. The passive lender then raises his fee accordingly to maximize the revenue that he can collect from this rare but lucrative event.

I then pin down the equilibrium shorting threshold $c^*$ by substituting (5) into Eq. (3), setting $c(f) = c^*$, and solving for $c^*$. Proposition 1 summarizes the findings for the passive lender.

**Proposition 1.** *The passive lender's optimal fee maximizes expected lending revenue and takes half of the short seller's expected profits. The resulting equilibrium fee is described by Eq. (5).*

### 3.3. Active Lender

The solution procedure is quite similar when the lender trades. The only difference is that I now allow the lender to trade optimally instead of imposing $D_L = 0$. That is, the market maker believes that the lender sells following a loan agreement (see Lemma 1) and demands $D_L^*(b = 0) \in \{-1, 0, 1\}$ following no loan agreement. The market maker continues to believe that the speculator always buys when $v = 1$ and will borrow and sell short when $v = 0$ if and only if $c < c^*$. The market maker then sets prices given these conjectures.

First, I must solve for the equilibrium short-selling cutoff given the lender's conjectured trading strategy. Given any fee choice $f$, the actual cutoff is:

$$c(f) = E[P(z) \mid D_S + D_L = -2] - f \tag{6}$$

Eq. (6) only differs from its passive counterpart (3) in that the expected selling price is now conditional on $D_S + D_L = -2$ rather than $-1$. This change follows from the speculator's belief that the lender always sells after making a loan agreement (see Lemma 1).

I next examine the lender's stock valuation after lending at some arbitrary fee $f$.

$$E[v \mid b = 1] = 0 \tag{7}$$

$$E[v \mid b = 0] = \frac{\rho}{\rho + (1-\rho)(1 - G(c(f)))} \tag{8}$$

Since the short seller is perfectly informed, a loan agreement (i.e., $b = 1$) implies $v = 0$. It is always optimal for the lender to sell in this scenario because prices are guaranteed to be no lower than zero. On the other hand, no loan agreement (i.e., $b = 0$) could occur because the speculator knows that $v = 1$ or because the speculator knows that $v = 0$ but has a high realization of $c$. The lender's valuation (8) is a weighted average of these two outcomes.

**Lemma 2.** *The lender's valuation of the asset conditional on no loan agreement is decreasing in $f$.*

Higher fees make the speculator less inclined to short the stock. This response makes the absence of a loan agreement more likely to reflect the case where the speculator knows $v = 0$ but finds shorting too costly, thereby lowering the lender's valuation.

Moving back to the fee-setting stage, the lender's objective is to maximize his expected lending plus trading profits.

$$\max_f \; \Pr[D_S = -1]\bigl(E[P(z) \mid D_S + D_L = -2] + f\bigr) + \bigl(1 - \Pr[D_S = -1]\bigr)\bigl(D_L(b=0)\, E[v - P(z) \mid b = 0, D_L(b=0)]\bigr) \tag{9}$$

The first term in Eq. (9) corresponds to the event where the speculator borrows a share. Conditional on this event, the lender's profits equal the fee $f$ plus his expected selling profits $E[P(z) \mid D_S + D_L = -2] - 0$. The second term corresponds to the event where the speculator does not borrow a share. The lender's profits conditional on this event equal his expected trading profits: $D_L(b=0)\, E[v - P(z) \mid b = 0, D_L(b=0)]$. Eq. (9) furthermore tells us that a higher fee has three effects on the lender's expected profits. First, there is the direct effect of a higher fee leading to greater lending revenue conditional on a loan. Second, a higher fee reduces the likelihood of a short sale when $v = 0$; that is, $\Pr[D_S = -1] = (1-\rho)\frac{E[P(z) \mid D_S + D_L = -2] - f}{\bar{C}}$ is decreasing in $f$. Third, as Lemma 2 states, higher fees decrease $E[v \mid b = 0]$. This third effect implies that the lender's trading profits conditional on no loan agreement are decreasing in $f$ when he buys, increasing in $f$ when he sells, and are unaffected by $f$ when he does not trade.

**Proposition 2.** *Given some set of prices $P(z) \in [0, 1]$ for $z \in \{-4, \ldots, 4\}$, each possible trading strategy conditional on no loan agreement ($D_L(b = 0) \in \{-1, 0, 1\}$) maps to a unique optimal fee $f^* \geq 0$. Furthermore, the fee associated with buying ($D_L(b=0) = 1$) is no higher than the fee associated with not trading ($D_L(b=0) = 0$), and the fee associated with not trading ($D_L(b=0) = 0$) is strictly lower than the fee associated with selling ($D_L(b=0) = -1$).*

Specifically, these fees are:

$$f^* = \begin{cases} \max\!\left(\dfrac{-E[P(z) \mid D_S + D_L = 1]}{2},\, 0\right) = 0 & \text{when } D_L(b=0) = 1 \\[6pt] 0 & \text{when } D_L(b=0) = 0 \\[6pt] \max\!\left(\dfrac{E[P(z) \mid D_S + D_L = -1]}{2},\, 0\right) = \dfrac{E[P(z) \mid D_S + D_L = -1]}{2} & \text{when } D_L(b=0) = -1 \end{cases} \tag{10}$$

**Proposition 3.** *The active lender always sells after a share is borrowed. Both buying and not trading after no loan agreement are equilibrium trades ($D_L^*(b=0) \in \{0, 1\}$). Selling following no loan agreement is never an equilibrium trade for the active lender. Equilibrium fees equal zero.*

Equilibrium fees follow from the lender's equilibrium trading strategies and Eq. (10).[^23] The lender's optimal trade following no loan agreement depends on his updated valuation of the stock, given by Eq. (8). Observe that this valuation exceeds the lender's prior belief that $v = 1$ (i.e., $\rho$), so the absence of a loan agreement ($b = 0$) is a positive signal. It then follows that selling conditional on $b = 0$ is never optimal.

**Corollary 1.** *For all order flows $z \in \{-4, 4\}$, equilibrium prices $P(z, D_L^*(b=0))$ are weakly decreasing in the lender's equilibrium trade conditional on no loan agreement $D_L^*(b=0)$. Moreover, expected prices conditional on the sum of the speculator's and the lender's trades (i.e., $E[P(z, D_L^*(b=0)) \mid D_S + D_L]$) are strictly decreasing in $D_L^*(b=0)$ for all $D_S + D_L \in \{-2, \ldots, 2\}$.*

### 3.4. Recall Risk

I now allow lenders to recall shares as per the timeline given in Section 2.2. This feature is motivated by existing regulations that require all investment companies covered by the 1940 Investment Company Act (e.g., U.S. mutual funds) to be able to recall lent-out shares at will.

First, the passive lender never wants to recall shares: doing so entails a loss of fee income without any benefit. The active lender, however, may want to. More specifically, conditional on lending a share, an active lender will not want to recall it if and only if the following condition on fees is satisfied:

$$E[P(z) \mid D_S + D_L = -2] + f \geq E[P(z) \mid D_S + D_L = -1]$$

$$\implies f \geq \Delta E[P(z)] \equiv E[P(z) \mid D_S + D_L = -1] - E[P(z) \mid D_S + D_L = -2] \tag{11}$$

By not recalling, the lender expects to sell at $E[P(z) \mid D_S + D_L = -2]$ (the expected price conditional on the speculator and lender selling) and collect the fee $f$. By recalling, the lender loses the fee but expects to sell at the higher price $E[P(z) \mid D_S + D_L = -1]$ (the expected price conditional on the lender selling and the speculator not trading). Note that $\Delta E[P(z)] = \frac{1}{5}(P(1) - P(-4)) > 0$, so $f = 0$ does not satisfy the no-recall condition given by (11). As a result, the lender cannot commit not to recall shares at the equilibrium fee from Section 3.3 ($f^* = 0$), meaning that the speculator will now never borrow from the lender at that fee.[^26] Thus, if the lender wants to attract short sellers, he must raise his fee to satisfy (11).

**Lemma 3.** *The active lender's optimal fee without recall risk (i.e., Eq. (10) from Section 3.3) violates the no-recall condition if and only if he buys or does not trade conditional on no loan agreement. If the lender's optimal fee without recall risk violates the no-recall condition, his new optimal fee with recall risk becomes $\Delta E[P(z)]$. Otherwise, his optimal fee does not change.*

**Proposition 4.** *The unique equilibrium trading strategy for the active lender with recall risk is to sell conditional on a loan agreement and not to trade otherwise. Equilibrium fees equal $\Delta E[P(z)]$.*

**Corollary 2.** *The active lender's expected profits strictly decrease when recall risk is introduced.*

Essentially, giving the lender the ability to recall shares harms his expected profits, as it forces him to deviate from his profit-maximizing fee with no offsetting benefit. As a result, the lender would prefer to write a contract waiving his right to recall shares—if allowed.

### 3.5. Comparison of Equilibria

There are three cases to examine: (1) the passive lender, (2) the active lender without recall risk, and (3) the active lender with recall risk.

The active lender imposes two costs on the short seller: (1) the fee and (2) a reduced expected selling price due to information leakage. By contrast, the only cost associated with the passive lender is the fee.

**Proposition 5.** *The passive lender charges a higher fee than the active lender. Nevertheless, the passive lender also attracts more short selling than the active lender when recall risk is present. Without recall risk, the passive lender only attracts more short selling when the active lender buys following no loan agreement ($D_L^*(b=0) = 1$).*

Finally, I look at price efficiency, which I define as

$$Eff \equiv 1 - E[|v - E[P(z) \mid v]|] \tag{12}$$

The term $|v - E[P(z) \mid v]|$ measures the distance between the expected price conditional on the value and the value. I subtract this expression from one so that my measure has the property that higher values indicate greater efficiency. As a benchmark, a perfectly revealing price has an efficiency measure of one.

**Proposition 6.** *Without recall risk, price efficiency is always higher under the active lender. With recall risk, price efficiency can be higher under the passive lender whenever $\rho$ is sufficiently low.*

---

## 4. Extensions

### 4.1. Lender Reputation

It is perhaps unsurprising that lenders behave so opportunistically in my main model. There is no future relationship or reputation to maintain, so active lenders exploit lending market information to improve short-term trading profits. Applying standard results from infinitely repeated games, the lender will refrain from recalling shares in equilibrium if and only if the following reduced-form condition is satisfied:

$$f + E[P(z) \mid D_S + D_L = -2] + \frac{\delta}{1-\delta}\bar{\pi} > E[P(z) \mid D_S + D_L = -1] + \frac{\delta}{1-\delta}\underline{\pi}$$

$$\implies f > \Delta E[P(z)] - \frac{\delta}{1-\delta}(\bar{\pi} - \underline{\pi}) \tag{13}$$

Here, $\delta$ is the lender's discount factor, $\bar{\pi}$ is the lender's expected per-period profit when he has never recalled shares, and $\underline{\pi}$ is the lender's expected per-period profit when he has previously recalled shares. The short seller plays a "trigger" strategy: she behaves as if there is no recall risk if the lender has never recalled shares before, but reverts to only accepting fees that satisfy the static no-recall condition given by Eq. (11) if the lender has previously recalled shares. Thus, $\bar{\pi} \geq \underline{\pi}$ because the lender can set the fee closer to his profit-maximizing level if he has never recalled shares. If the lender cares sufficiently about the future (i.e., has a large $\delta$), the threat of a permanent switch to the "bad" recall-proof equilibrium from Proposition 4 is enough to deter recall—even when fees are low.

### 4.2. Lender Selling Recalled Shares

In my base model, I do not allow the active lender to sell recalled shares. However, let us now relax that assumption. Suppose the lender is endowed with $N$ shares. Further, suppose a candidate equilibrium includes the speculator shorting $M$ shares when $v = 0$ and the lender selling $N - M - \omega$ out of his remaining inventory after making the loan, where $\omega$ is an integer between zero and $N - M - 1$.[^29] The speculator's expected profits following the loan agreement are $M(E[P(z) \mid D_S + D_L = -N + \omega] - f)$, and the lender's are $(N - M - \omega)E[P(z) \mid D_S + D_L = -N + \omega] + Mf$. Observe that the lender always has the option to recall and sell all $M$ shares to earn an extra $M E[P(z) \mid D_S + D_L = -N + \omega]$ in trading profits in exchange for losing $Mf$ in lending revenue. Thus, the lender requires $f \geq E[P(z) \mid D_S + D_L = -N + \omega]$ to prefer not recalling the shares, which is precisely the condition that eliminates all short selling.

In short, allowing the active lender to sell recalled shares exacerbates the commitment problem examined in Section 3.4 to such an extent that short selling no longer occurs in equilibrium.

### 4.3. Informed Active Lender

The base model assumes that the active lender is uninformed, but let us now relax that assumption and instead allow him to observe some private signal $y \in \{0, 1\}$ about the payoff $v$ where $\Pr[y = v \mid v] = q \in [0.5, 1]$. My base model is therefore the case where $q = 0.5$.

**Lemma 4.** *Without recall risk, the informed active lender's optimal fee remains as described by Eq. (10). With recall risk, the informed active lender's optimal fee remains as described by Lemma 3.*

**Corollary 3.** *The negatively informed lender ($L_0$) always sets a fee at least as high as the positively informed lender ($L_1$) and sets a strictly higher fee whenever $L_0$ attracts a positive amount of short sellers in equilibrium (i.e., when $c_0^* > 0$).*

### 4.4. Lender Competition

I assume that the lender is a monopolist in the base model. I now examine how my results change when lenders engage in Bertrand fee-setting competition with each other. I consider three cases: (1) competition between active lenders, (2) competition between an active and a passive lender, and (3) competition between passive lenders.

Competition between active lenders has no impact on fees—both with and without recall risk. From Proposition 3, the active lender already sets fees equal to marginal cost (i.e., zero) as a monopolist to acquire more precise information about the stock. With recall risk, competition cannot lower fees because each lender is already selecting their lowest possible fee $f^* = \Delta E[P(z)]$.

When an active and a passive lender compete, the passive lender does not need to undercut the active lender's fee to win the competition. The short seller is concerned about the total cost of borrowing, which includes the fee and the cost of information leakage. Because passive lenders do not trade, they impose no information leakage costs on the speculator.

Finally, competition between two passive lenders yields the textbook Bertrand outcome: competition drives fees down to marginal cost, which in this setting is zero. This result implies that efforts to increase competition in the lending market will have the greatest impact on fees when the lenders involved are passive, as they are the only ones using their market power to charge elevated fees.

---

## 5. Discussion

### 5.1. Empirical Predictions

My model makes predictions about how lending market information affects lenders' trades. First, active securities lenders sell stocks they have on loan, consistent with Honkanen (2025) and Greppmair et al. (2024). Second, my model generates new predictions about how fees relate to lenders' trades on stocks made available for loan but not taken up. Eq. (10) states that high fees and low utilization predict lender sales, while low fees and low utilization predict lender purchases. Intuitively, lenders who plan to sell raise fees to limit trading competition, whereas lenders who plan to buy prefer low fees to make better informed purchases.

My model also predicts that strategic recall risk increases lending fees. Active lenders are tempted to recall shares to improve their selling price and must raise fees to commit not to. Passive lenders have no such incentive because they cannot trade. Thus, since lenders cannot contractually commit not to recall shares, they must do so endogenously through higher fees.

I expect my results to be more salient for lenders with an in-house lending agent. Large mutual fund families—such as Fidelity, BlackRock, and Vanguard—manage their own lending operations. I would therefore expect in-house lenders to show greater care in tailoring fees to maximize fund (or fund family) profits as described in this paper, compared to third-party agents.

The lender's time-preference parameter $\delta$ from Eq. (13) affects his willingness to recall shares in a repeated game. Specifically, he will not recall the share when $f > \Delta E[P(z)] - \frac{\delta}{1-\delta}(\bar{\pi} - \underline{\pi})$. One can view the discount factor $\delta$ as the probability that the game will continue for another period. Naturally, the lender will be less inclined to recall a high-type speculator's share because he expects future business from her. Thus, from (13), we expect repeat customers to get lower fees. The implication that the incumbent is the only lender who can commit not to recall loans at low fees is a novel source of market power in the short-selling literature.

Finally, consider the case where the short seller has to close out their position before the fundamental value $v$ is revealed. It seems likely that this close-out price will be higher with a passive lender because he does not trade. However, activist short sellers often proactively publicize their positions and release research reports explaining their reasoning. Assuming such disclosure is costly, short sellers should be more willing to bear those costs when the no-disclosure price is expected to be higher. Thus, we should expect activist short sale disclosures to become more frequent as index investing rises.

### 5.2. Policy Implications

Throughout the paper, I exploit the institutional detail that lenders governed by the 1940 Investment Company Act (e.g., U.S. mutual funds) must retain the ability to recall lent-out shares at will. This regulation is driven in part by corporate governance concerns, as lenders cannot cast votes associated with lent-out shares. However, my analysis reveals that this flexibility comes at a cost: since lenders cannot contractually commit not to recall shares, they must instead increase fees as a commitment device. As a result, this regulation inadvertently raises the cost of borrowing shares.

Lender market power is also a growing concern in the securities lending market. Section 4.4 analyzes how competition between lenders affects equilibrium fees and shows that efforts to promote competition are especially effective when that competition is between passive lenders. This result arises because only passive lenders exploit their market power to charge high fees; active lenders instead prefer low fees to improve the quality of their information. Consequently, my analysis suggests that the rise of passive investing makes efforts to improve competition in the lending market more effective for two reasons. First, index investing may contribute to greater lending market concentration. Second, even holding the level of concentration fixed, heightened competition has a larger effect on fees when lenders are passive.

---

## 6. Conclusion

In this paper, I model securities lending as an information acquisition problem, where lenders infer information about a stock from the level of borrowing demand. Active lenders, who maximize the sum of lending revenue and trading profits, can extract more information by reducing fees from the revenue-maximizing level. However, low fees also make it less costly for them to recall shares to disguise their trades. As a result, active lenders must maintain fees above a certain level as a commitment device to continue to attract short sellers. The combined costs of the fee and information leakage harm short sellers so much that passive lenders, who do not trade, can relax short-sale constraints and potentially improve price efficiency—despite charging higher fees.

Information leakage in the securities lending market is a relatively unexplored research topic, perhaps because securities lending occurs in an opaque, over-the-counter setting, making it difficult to find quality data. However, the SEC has recently taken steps to increase transparency. Rule 10c-1a (adopted in October 2023) requires lenders to report loan-level quantities and fees for the first time. Assuming these rules survive ongoing legal challenges, the availability of such granular data should spur further research in this area.

---

## Appendix A: Proofs from Main Text

### Supplementary Result S1: Price Calculations

Without loss of generality, I calculate prices with an active lender; the passive lender is just a special case where $D_L$ is always zero.

From the main text, the price that order flow $z$ maps to is

$$P(z) = \Pr[v = 1 \mid z] = \frac{\Pr[z \mid v = 1]\Pr[v = 1]}{\Pr[z \mid v = 1]\Pr[v = 1] + \Pr[z \mid v = 0]\Pr[v = 0]} \tag{14}$$

Observe that $\Pr[v = 1] = \rho$ and $\Pr[v = 0] = 1 - \rho$. We next need to calculate the two $\Pr[z \mid v]$ terms. Expanding gives us:

$$\Pr[z \mid v = 0] = G(c^*)\Pr[z \mid v = 0, c < c^*] + (1 - G(c^*))\Pr[z \mid v = 0, c \geq c^*] \tag{15}$$

where $c^*$ is the speculator's shorting cutoff. Recall that the speculator always buys when $v = 1$ due to Assumption 1, so there is no analogous breakdown of $\Pr[z \mid v = 1]$.

Denote $w_{-1} \equiv -1 + D_L^*(b = 1)$. Then

$$\Pr[z \mid v = 0, c < c^*] = \begin{cases} \frac{1}{5} & \text{if } z \in \{w_{-1},\, w_{-1} \pm 1,\, w_{-1} \pm 2\} \\ 0 & \text{otherwise} \end{cases} \tag{16}$$

Next, denote $w_0 \equiv 0 + D_L^*(b = 0)$. Then

$$\Pr[z \mid v = 0, c \geq c^*] = \begin{cases} \frac{1}{5} & \text{if } z \in \{w_0,\, w_0 \pm 1,\, w_0 \pm 2\} \\ 0 & \text{otherwise} \end{cases} \tag{17}$$

Denote $w_1 \equiv 1 + D_L^*(b = 0)$. We then have

$$\Pr[z \mid v = 1] = \begin{cases} \frac{1}{5} & \text{if } z \in \{w_1,\, w_1 \pm 1,\, w_1 \pm 2\} \\ 0 & \text{otherwise} \end{cases} \tag{18}$$

We can now plug Eqs. (16) and (17) into (15), and (15) and (18) into (14) to get our price $P(z)$. Expected prices are then calculated by averaging:

$$E[P(z) \mid D_S + D_L] = \frac{1}{5} \sum_{z = D_S + D_L - 2}^{D_S + D_L + 2} P(z) \tag{19}$$

**Proposition S1.** *Suppose the speculator is endowed with a share, so she never needs to borrow. Then the speculator will always sell when $v = 0$ if and only if $\bar{C} \leq \frac{3\rho}{5}$. If this condition is met, then the unique equilibrium in this setting is for the speculator to always trade in the direction of her signal and for the lender to not trade. Assumption 2 therefore implies $\bar{C} = \frac{3\rho}{5}$.*

### Proof of Lemma 2

From Eq. (8), $E[v \mid b = 0] = \frac{\rho}{\rho + (1-\rho)(1 - G(c(f)))}$ where $G(c(f)) = \frac{E[P(z) \mid D_S + D_L = -2] - f}{\bar{C}} \in [0, 1]$. Note that the fee only appears in the valuation via $G(c(f))$. It then follows that since the valuation is increasing in $G(c(f))$ and $G(c(f))$ is decreasing in $f$, the valuation must be decreasing in $f$. $\square$

### Proof of Proposition 3

From Lemma 1, we know the lender's optimal trade conditional on $b = 1$ is to sell. Thus, we only need to discover the lender's equilibrium trades conditional on $b = 0$.

I demonstrate that $D_L(b = 0) = -1$ is not an equilibrium by showing that selling conditional on $b = 0$ is unprofitable for the lender. Given this proposed trading strategy, the prices as a function of $c^*$ are:

$$P(z) = \begin{cases} 1 & \text{when } z = 2 \\ \dfrac{\rho}{\rho + (1-\rho)(1-G(c^*))} & \text{when } z = 1 \\ \rho & \text{when } z \in \{0, -1, -2\} \\ 0 & \text{when } z \in \{-3, -4\} \end{cases}$$

We pin down the cutoff $c^*$ by plugging the lender's optimal fee into Eq. (6) and setting $c(f) = c^*$:

$$E[P(z) \mid D_S + D_L = -2] - \frac{E[P(z) \mid D_S + D_L = -1]}{2} = c^*$$

The lender's expected selling profits conditional on $b = 0$ are:

$$E[P(z) \mid b = 0] - E[v \mid b = 0] = \frac{\rho E[P(z) \mid D_S + D_L = 0] + (1-\rho)(1 - G(c^*))E[P(z) \mid D_S + D_L = -1] - \rho}{\rho + (1-\rho)(1-G(c^*))} \tag{20}$$

Expanding (20) tells us that the lender's expected selling price is $\frac{2}{5}\left(\frac{\rho}{\rho + (1-\rho)(1-G(c^*))}\right) + \frac{3}{5}\rho$, which is always no greater than the lender's valuation of $\frac{\rho}{\rho + (1-\rho)(1-G(c^*))}$ (and strictly less than whenever $G(c^*) > 0$). Thus, it can never be an equilibrium for the lender to sell conditional on $b = 0$.

**Table 1: Prices without recall**

| $z$ | $D_L(b=0) = 0$ | $D_L(b=0) = 1$ |
|---|---|---|
| $P(4)$ | $1$ | $1$ |
| $P(3)$ | $1$ | $\dfrac{\rho}{\rho + (1-\rho)(1-G(c^*))}$ |
| $P(2)$ | $\dfrac{\rho}{\rho + (1-\rho)(1-G(c^*))}$ | $\dfrac{\rho}{\rho + (1-\rho)(1-G(c^*))}$ |
| $P(1)$ | $\dfrac{\rho}{\rho + (1-\rho)(1-G(c^*))}$ | $\dfrac{\rho}{\rho + (1-\rho)(1-G(c^*))}$ |
| $P(0)$ | $\rho$ | $\rho$ |
| $P(-1)$ | $\rho$ | $0$ |
| $P(-2)$ | $0$ | $0$ |
| $P(-3)$ | $0$ | $0$ |
| $P(-4)$ | $0$ | $0$ |

For the $D_L(b=0) = 0$ case, the lender sets the fee equal to zero, which leads to the short-selling cutoff $c^* = E[P(z) \mid D_S + D_L = -2] = \frac{2\rho}{5}$. Holding fees constant, the lender's profits from deviating to buying conditional on $b = 0$ are:

$$E[v - P(z) \mid b = 0] = \frac{\rho - \rho E[P(z) \mid D_S + D_L = 2] - (1-\rho)(1-G(c^*))E[P(z) \mid D_S + D_L = 1]}{\rho + (1-\rho)(1-G(c^*))} \tag{21}$$

After algebraic rearrangement, the lender will not deviate to buying so long as $\bar{C} \geq \frac{2\rho(1+2\rho)}{5(1+\rho)}$. This condition is always satisfied under Assumption 2.

A necessary condition for positive deviant selling profits is:

$$\rho(E[P(z) \mid D_S + D_L = 0] - 1) + (1-\rho)(1-G(c(f)))(E[P(z) \mid D_S + D_L = -1] - 0) > 0 \tag{22}$$

This expression can be no higher than $\rho E[P(Z) \mid D_S + D_L = 0] + (1-\rho)E[P(z) \mid D_S + D_L = -1] - \rho$. Plugging in, this expression equals $-\frac{3\rho^2}{10\rho + 5} < 0$, so deviating to selling is always unprofitable for the lender. $\square$

### Proof of Lemma 3

From Eq. (10), lenders who buy or do not trade have optimal fees of $f^* = 0$. Since $\Delta E[P(z)] = \frac{1}{5}(P(1) - P(-4)) > 0$, this optimal fee violates the no-recall condition.

Observe that the no-recall condition is always satisfied when the lender sets the optimal selling fee $\frac{E[P(z) \mid D_S + D_L = -1]}{2}$. From (11), the condition will be satisfied if $\frac{E[P(z) \mid D_S + D_L = -1]}{2} > E[P(z) \mid D_S + D_L = -1] - E[P(z) \mid D_S + D_L = -2]$, which amounts to $E[P(z) \mid D_S + D_L = -2] - \frac{E[P(z) \mid D_S + D_L = -1]}{2} > 0$. This equals the shorting threshold for the speculator when $D_L(b=0) = -1$. So, if $c^* > 0$, it must be satisfied.

I must now show that the lender will choose $f^* = \Delta E[P(z)]$ when his optimal fee violates the no-recall constraint. I have already shown that the lender's expected profits are decreasing in $f$ for all $f \in [0, E[P(z) \mid D_S + D_L = -2]]$ (and constant after that) when $D_L(b=0) = 1$. As a result, this lender will choose the minimum fee that satisfies the no-recall constraint, $\Delta E[P(z)]$, as opposed to a fee that violates the constraint because such a fee is equivalent to setting an infinitely high fee. $\square$

### Proof of Proposition 4

I start by ruling out $D_L(b=0) \in \{-1, 1\}$ as equilibrium trading strategies. When $D_L(b=0) = 1$, the equilibrium shorting threshold must satisfy the following fixed-point problem:

$$E[P(z) \mid D_S + D_L = -2] - (E[P(z) \mid D_S + D_L = -1] - E[P(z) \mid D_S + D_L = -2]) = c^*$$

$$\iff \rho - \frac{\rho}{\rho + (1-\rho)(1-G(c^*))} = 5c^* \tag{23}$$

First, note that $c^* = 0$ is a solution. Since the left-hand side is strictly decreasing in $c^*$ while the right-hand side is strictly increasing, $c^* = 0$ is the unique solution—all short sales are eliminated. However, if all short sales are eliminated, the lending market signal is uninformative, which means that the lender becomes an uninformed trader. Thus, the lender cannot earn positive profits by buying, and he will not trade.

For $D_L(b=0) = 0$, the equilibrium shorting threshold solves:

$$2\rho - \frac{\rho}{\rho + (1-\rho)(1-G(c^*))} = 5c^*$$

Only the lower root of this quadratic equation solves the model:

$$c^* = \frac{5\bar{C} + 2\rho - \sqrt{25\bar{C}^2 + 4\rho^4 - 8\rho^3 + 4\rho^2 - 2\rho^2}}{10(1-\rho)}$$

To show that the solution is interior, observe that

$$c^* < \frac{5\bar{C} + 2\rho - \sqrt{25\bar{C}^2 - 2\rho^2}}{10(1-\rho)} = \frac{\rho}{5} < \bar{C} \tag{24}$$

since $4\rho^4 - 8\rho^3 + 4\rho^2 > 0$ for all $\rho \in (0, 1)$, by the definition of $\bar{C} = \frac{3\rho}{5}$ in Assumption 2 and Proposition S1. $\square$

### Proof of Proposition 5

I start by showing that the passive lender always sets a higher fee. Denote $f_p^*$ as the passive lender's fee and $f_a^*$ as the active lender's fee. With recall risk:

$$f_p^* > f_a^* \iff \frac{3\rho}{10} > \frac{\rho}{5(\rho + (1-\rho)(1-G(c_a^*)))} \iff 1 > 3(1-\rho)G(c_a^*) \iff \frac{\rho}{5} > c_a^*(1-\rho)$$

The claim then immediately follows because we know $c_a^* < \frac{\rho}{5}$ from the proof of Proposition 4.

Regarding equilibrium shorting thresholds: from Proposition 1, $c^* = \frac{3\rho}{10}$ with a passive lender. From Proposition 3, $c^* = \frac{\rho}{5}$ when $D_L^*(b=0) = 1$ and $c^* = \frac{2\rho}{5}$ when $D_L^*(b=0) = 0$. Thus, without recall risk, the passive lender attracts more short selling than the active lender if and only if $D_L^*(b=0) = 1$.

From Proposition 4, we have $c_a^* < \frac{\rho}{5} < \frac{3\rho}{10}$, so with recall risk, the passive lender attracts greater shorting than the active lender. $\square$

### Proof of Proposition 6

Price efficiency is defined as $1 - E[|v - E[P(z) \mid v]|] = 1 - \rho + \rho E[P(z) \mid v=1] - (1-\rho)E[P(z) \mid v=0]$.

For the passive lender, using the prices from Eq. (2) and the result from Proposition 1 that $c^* = \frac{3\rho}{10}$:

$$Eff_p = \frac{50\bar{C} - 15\rho - 80\bar{C}\rho + 80\bar{C}\rho^2 + 39\rho^2 - 42\rho^3 + 18\rho^4}{5(3\rho^2 - 3\rho + 10\bar{C})}$$

For the active lender without recall risk when $D_L^*(b=0) = 1$ (cutoff $c^* = \frac{\rho}{5}$):

$$Eff_a(NR,1) = \frac{25\bar{C} - 5\rho - 40\bar{C}\rho + 40\bar{C}\rho^2 + 13\rho^2 - 10\rho^3 + 2\rho^4}{5(\rho^2 - \rho + 5\bar{C})}$$

For the active lender without recall risk when $D_L^*(b=0) = 0$ (cutoff $c^* = \frac{2\rho}{5}$):

$$Eff_a(NR,0) = \frac{25\bar{C} - 10\rho - 40\bar{C}\rho + 40\bar{C}\rho^2 + 26\rho^2 - 24\rho^3 + 8\rho^4}{5(2\rho^2 - 2\rho + 5\bar{C})}$$

For the active lender with recall risk, letting $\phi \equiv \sqrt{25\bar{C}^2 + 4\rho^4 - 8\rho^3 + 4\rho^2}$:

$$Eff_a(R) = \frac{25\bar{C} - 10\rho - 40\bar{C}\rho - 8\rho\phi + 5\phi + 60\bar{C}\rho^2 + 4\rho^2\phi + 26\rho^2 - 24\rho^3 + 8\rho^4}{5(5\bar{C} - 2\rho + \phi + 2\rho^2)}$$

First, $Eff_p - Eff_a(NR,1) = -\frac{6\rho^3(2\rho^2 + \rho)(1-\rho)}{5(3\rho^4 + 9\rho^3 + 6\rho^2)} < 0$ when $\bar{C} = \frac{3\rho}{5}$. Similarly, $Eff_p - Eff_a(NR,0) < 0$. Thus, passive efficiency is always lower when there is no recall risk.

Finally, $Eff_p - Eff_a(R)$ will be positive if and only if

$$9\rho\sqrt{4\rho^4 - 8\rho^3 + 13\rho^2} + 3\rho^2\sqrt{4\rho^4 - 8\rho^3 + 13\rho^2} + 6\rho^4 > 27\rho^2 + 15\rho^3$$

which holds for all $\rho \in \left(0, \frac{\sqrt{13}-2}{3}\right)$. Thus, passive efficiency can be higher than active efficiency with recall risk when $\rho$ is sufficiently small. $\square$

### Proof of Lemma 4

The lender's objective functions are:

If $D_L^y(b=0) = 1$:

$$\Pr[v=0 \mid y]\, G(c_y^*)\bigl(E[P(z) \mid D_S + D_L = -2] + f\bigr) + \Pr[v=1 \mid y]\bigl(1 - E[P(z) \mid D_S + D_L = 2]\bigr) + \Pr[v=0 \mid y](1-G(c_y^*))\bigl(0 - E[P(z) \mid D_S + D_L = 1]\bigr)$$

If $D_L^y(b=0) = 0$:

$$\Pr[v=0 \mid y]\, G(c_y^*)\bigl(E[P(z) \mid D_S + D_L = -2] + f\bigr)$$

If $D_L^y(b=0) = -1$:

$$\Pr[v=0 \mid y]\, G(c_y^*)\bigl(E[P(z) \mid D_S + D_L = -2] + f\bigr) + \Pr[v=1 \mid y]\bigl(E[P(z) \mid D_S + D_L = 0] - 1\bigr) + \Pr[v=0 \mid y](1-G(c_y^*))\bigl(E[P(z) \mid D_S + D_L = -1] - 0\bigr)$$

where $G(c_y^*) = \frac{E[P(z) \mid D_S + D_L = -2] - f}{\bar{C}}$. Observe that the fee only appears in the first and third terms of these objective functions. Thus, in the lender's first-order condition, $\Pr[v=0 \mid y]$ cancels out (since it is a multiplicative constant) and $\Pr[v=1 \mid y]$ does not appear, meaning that $q$ does not affect the lender's optimal fee as a function of the equilibrium prices. $\square$

### Proof of Corollary 3

Lemma 1 is still valid, so the lender continues to sell following a loan agreement regardless of his private signal. Moreover, the unique equilibrium trade conditional on no loan agreement is for the positively informed $L_1$ to buy and the negatively informed $L_0$ to sell. This outcome follows because $L_1$'s valuation is arbitrarily close to one and the expected buying price is always strictly less than one.

Thus, by Lemma 4, $L_1$ sets $f_1^* = 0$ without recall risk and $f_1^* = \Delta E[P(z)]$ with recall risk, while $L_0$ always chooses $f_0^* = \frac{E[P(z) \mid D_S + D_L = -1]}{2}$. With recall risk, the condition that determines whether $f_0^* > f_1^*$ is simply:

$$f_0^* > f_1^* \iff \frac{E[P(z) \mid D_S + D_L = -1]}{2} > E[P(z) \mid D_S + D_L = -1] - E[P(z) \mid D_S + D_L = -2]$$

$$\iff E[P(z) \mid D_S + D_L = -2] - \frac{E[P(z) \mid D_S + D_L = -1]}{2} > 0 \iff c_0^* > 0 \quad \square$$

---

## References

Atmaz, A., Basak, S., Ruan, F., 2023. Dynamic equilibrium with costly short-selling and lending market. *Review of Financial Studies* 37(2), 444–506.

Bagwell, K., Ramey, G., 1991. Oligopoly limit pricing. *RAND Journal of Economics* 22(2), 155–172.

Baldauf, M., Mollner, J., 2024. Competition and information leakage. *Journal of Political Economy* 132(5), 1603–1641.

Baruch, S., Zhang, X., 2022. The distortion in prices due to passive investing. *Management Science* 68(8), 6219–6234.

von Beschwitz, B., Honkanen, P., Schmidt, D., 2025. Passive ownership and short selling. *Review of Finance* 29(4), 1137–1188.

Blocher, J., Reed, A.V., Van Wesep, E.D., 2013. Connecting two markets: An equilibrium framework for shorts, longs, and stock loans. *Journal of Financial Economics* 108(2), 302–322.

Blocher, J., Whaley, R., 2016. Two-sided markets in asset management: Exchange-traded funds and securities lending. Working Paper.

Bond, P., Garcia, D., 2022. The equilibrium consequences of indexing. *Review of Financial Studies* 35(7), 3175–3230.

Brown, D.C., Davies, S.W., 2017. Moral hazard in active asset management. *Journal of Financial Economics* 125(2), 311–325.

Buffa, A.M., Vayanos, D., Woolley, P., 2022. Asset management contracts and equilibrium prices. *Journal of Political Economy* 130(12), 3146–3201.

Cen, X., Dou, W.W., Kogan, L., Wu, W., 2024. Fund flows and income risk of fund managers. NBER Working Paper 31986.

Chague, F.D., Giovannetti, B., Herskovic, B., 2025. Information leakage from short sellers. NBER Working Paper 31927.

Chen, S., Kaniel, R., Opp, C., 2025. Market power in the securities lending market. Available at SSRN.

Chinco, A., Sammon, M., 2024. The passive ownership share is double what you think it is. *Journal of Financial Economics* 157, 103860.

Christoffersen, S.E., Geczy, C.C., Musto, D.K., Reed, A.V., 2007. Vote trading and information aggregation. *Journal of Finance* 62(6), 2897–2929.

Chuprinin, O., Ruf, T., 2018. Let the bear beware: What drives stock recalls. Available at SSRN.

Cohen, L., Diether, K.B., Malloy, C.J., 2007. Supply and demand shifts in the shorting market. *Journal of Finance* 62(5), 2061–2096.

Coles, J.L., Heath, D., Ringgenberg, M.C., 2022. On index investing. *Journal of Financial Economics* 145(3), 665–683.

Duffie, D., Gârleanu, N., Pedersen, L.H., 2002. Securities lending, shorting, and pricing. *Journal of Financial Economics* 66(2), 307–339.

Duong, T., Huszar, Z., Tan, R., Zhang, W., 2017. The information value of stock lending fees: Are lenders price takers? *Review of Finance* 21(6), 2353–2377.

Engelberg, J.E., Reed, A.V., Ringgenberg, M.C., 2018. Short-selling risk. *Journal of Finance* 73(2), 755–786.

Greppmair, S., Jank, S., Saffi, P., Sturgess, J., 2024. Securities lending and information acquisition. Available at SSRN.

Honkanen, P., 2025. Securities lending and trading by active and passive funds. *Journal of Financial and Quantitative Analysis* 60(3), 1272–1309.

Ibert, M., Kaniel, R., Van Nieuwerburgh, S., Vestman, R., 2017. Are mutual fund managers paid for investment skill? *Review of Financial Studies* 31(2), 715–772.

Johnson, T.L., Weitzner, G., 2025. Distortions caused by lending fee retention. *Management Science* 71(1), 35–58.

Jones, C., Lamont, O., 2002. Short-sale constraints and stock returns? *Journal of Financial Economics* 66(2–3), 207–239.

Kashyap, A.K., Kovrijnykh, N., Li, J., Pavlova, A., 2023. Is there too much benchmarking in asset management? *American Economic Review* 113(4), 1112–1141.

Kolasinski, A., Reed, A., Ringgenberg, M., 2013. A multiple lender approach to understanding supply and search in the equity lending market. *Journal of Finance* 68(2), 559–595.

Kyle, A.S., 1985. Continuous auctions and insider trading. *Econometrica* 53(6), 1315–1335.

Lamont, O.A., 2012. Go down fighting: Short sellers vs. firms. *Review of Asset Pricing Studies* 2(1), 1–30.

Ljungqvist, A., Qian, W., 2016. How constraining are limits to arbitrage? *Review of Financial Studies* 29(8), 1975–2028.

Mainardi, F., 2023. A demand-based approach to short-selling. Available at SSRN.

Nezafat, M., Schroder, M., 2021. Private information, securities lending, and asset prices. *Review of Financial Studies* 35(2), 1009–1063.

Nurisso, G., 2025. Paying for peer performance: Index investing on managerial incentives. Available at SSRN.

Palia, D., Sokolinski, S., 2024. Strategic borrowing from passive investors. *Review of Finance* 28(5), 1537–1573.

Pankratov, A., 2020. Securities lending and information transmission: A model of endogenous short-sale constraints. Available at SSRN.

Reed, A.V., 2013. Short selling. *Annual Review of Financial Economics* 5, 245–258.

Sikorskaya, T., 2025. Institutional investor mandates, securities lending, and short-selling constraints. Available at SSRN.

---

## Footnotes

[^1]: In a survey article on short selling, Reed (2013) refers to short sellers being informed traders as "one of the most robust findings of the literature".
[^2]: One can interpret this process as either the lender directly setting fees or an unmodeled lending agent setting fees on the lender's behalf.
[^3]: The implication is that lenders covered by the Investment Company Act of 1940 (e.g., mutual funds) must have this provision in their lending agreements. Engelberg et al. (2018) document recall risk as a unique risk faced by short sellers.
[^4]: Blocher and Whaley (2016) document that lending revenue can exceed management fees for indexed ETFs, and Chinco and Sammon (2024) estimate that passive investing comprises over one-third of the US stock market.
[^5]: Baldauf and Mollner (2024) model information leaks in a more general over-the-counter setting. See Duffie et al. (2002); Blocher et al. (2013); Atmaz et al. (2023); Johnson and Weitzner (2025); Mainardi (2023); and Nezafat and Schroder (2021) for models of securities lending without information spillovers.
[^6]: I discuss the case where the lender also has perfect information in Section 4.3 and the case where the lender has an imperfect private signal in Online Appendix E.
[^7]: In Online Appendix C, I discuss an alternative modeling approach in which the speculator's information quality is a random variable and her opportunity cost is constant. My main results continue to hold under this alternative approach.
[^8]: This assumption is motivated by existing regulations that prohibit mutual funds from lending more than one-third of their total asset value. Furthermore, Sikorskaya (2025) shows that mutual fund families often voluntarily restrict securities lending by setting position-level caps below 100%.
[^9]: This analysis takes the lender's ex-ante portfolio as given, thereby abstracting from any initial portfolio differences between active and passive lenders. However, this distinction is less relevant when the active lender is uninformed, as he may behave as a "closet indexer" and hold a portfolio close to that of the passive lender (see Brown and Davies, 2017).
[^10]: I assume the lender cannot sell recalled shares. When a lender recalls shares, the borrower returns them on the standard settlement cycle. I relax this assumption in Section 4.2.
[^11]: With a negative fee, it is always optimal for the speculator to borrow, regardless of the realization of $v$. This outcome destroys the informativeness of the lending market signal and produces negative lending revenue. Thus, a negative fee can never be optimal.
[^12]: In the base model, I rule out "manipulative" borrowing strategies to focus on the fundamental case where informed traders only borrow shares to short sell. See Online Appendix B for an analysis of manipulative borrowing.
[^13]: There is strong evidence that securities lenders have market power. See Duffie et al. (2002), Kolasinski et al. (2013), and Chen et al. (2025). I discuss competition between lenders in Section 4.4.
[^14]: Allowing noisy short sales would make $b = 1$ a less negative signal about firm value. My model therefore analyzes the extreme case where short-selling demand is perfectly informative about $v = 0$ rather than just highly informative.
[^15]: This assumption is justified as long as there is some gap in time between when the lender and borrower complete the loan and when this information becomes publicly available.
[^16]: The fact that the lender is perfectly informed and returns the share at fundamental value implies zero credit risk.
[^17]: Given the structure of noise demand, off-equilibrium order flows will only be at the endpoints of the set of feasible order flows: $z = 4$ or $z = -4$. At these potential off-equilibrium order flows, the speculator must either be buying or shorting, respectively, so unprejudiced beliefs are sufficient to pin down the price as $P(4) = 1$ and $P(-4) = 0$.
[^18]: See Proposition S1 in the appendix for more details.
[^19]: See Online Appendix A for an analysis of what happens when these assumptions are relaxed.
[^20]: Assumption 2 implies that the imposition of any costs on short sellers (either direct via fees or indirect via information leakage) will result in an equilibrium $c^* < \bar{C}$, allowing us to focus on the more relevant interior case where shorting demand is cost-sensitive.
[^23]: The result that the active lender's equilibrium fee equals zero depends on the assumption that $c$ is uniformly distributed. However, the broader insight that the lender wants to lower fees below the revenue-maximizing level to learn holds for any distribution of trading costs where $G'(f) < 0$.
[^26]: The speculator earns zero trading profits when recalled, which is never above her opportunity cost $c \in [0, \bar{C}]$.
[^29]: The active lender will always sell at least one share due to Lemma 1.
