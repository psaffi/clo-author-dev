# Information Disclosure in Financial Markets

**Itay Goldstein**¹ and **Liyan Yang**²

¹ Department of Finance, Wharton School, University of Pennsylvania, Philadelphia, Pennsylvania 19104; email: itayg@wharton.upenn.edu

² Department of Finance, Joseph L. Rotman School of Management, University of Toronto, Toronto, Ontario M5S 3E6, Canada; email: liyan.yang@rotman.utoronto.ca

*Annu. Rev. Financ. Econ.* 2017. 9:101–25

https://doi.org/10.1146/annurev-financial-110716-032355

**JEL codes:** D82, G14, M41

**Keywords:** disclosure, market quality, crowding-out effect, learning from prices, real efficiency, welfare

---

## Abstract

Information disclosure is an essential component of regulation in financial markets. In this article, we provide a cohesive analytical framework to review certain key channels through which disclosure in financial markets affects market quality, information production, efficiency of real investment decisions, and traders' welfare. We use our framework to address four main aspects. First, we demonstrate the conventional wisdom that disclosure improves market quality in an economy with exogenous information. Second, we illustrate that disclosure can crowd out the production of private information and that its overall market-quality implications are subtle and depend on the specification of information-acquisition technology. Third, we review how disclosure affects the efficiency of real investment decisions when financial markets are not just a side show, as real decision makers can learn information from them to guide their decisions. Last, we discuss how disclosure in financial markets affects investors' welfare through changing trading opportunities and through beauty-contest motives. Overall, our review suggests that information disclosure is an important factor for understanding the functioning of financial markets and that there are several trade-offs that should be considered in determining its optimal level.

---

## 1. Introduction

Disclosure of information in financial markets is at the forefront of regulatory efforts to improve financial market quality and stability. Greenstone, Oyer & Vissing-Jorgensen (2006, p. 399) write that "since the passage of the Securities Act of 1933 and the Securities Exchange Act of 1934, the federal government has actively regulated US equity markets. The centerpiece of these efforts is the mandated disclosure of financial information." Recently, these efforts have been very prominent, with the Sarbanes–Oxley Act of 2002 and the Dodd–Frank Act of 2010 emphasizing various aspects of improved disclosure. For example, the Sarbanes–Oxley Act was passed "to protect investors by improving the accuracy and reliability of corporate disclosures made pursuant to the securities laws, and for other purposes" (Pub. L. 107–204, 116 Stat. 745).

Disclosure regulation comes in different forms and affects different activities. Over time, firms have increasingly been required to disclose information about their operations and financial activities in financial reports to their investors. Similarly, investors are required to disclose information about their holdings in firms that might pertain to activism, intentions of activism, or acquisitions intentions that could ultimately affect firm value. Moreover, improved quality of public information is also achieved by increasing the reliability of credit ratings and by greater disclosure of macroeconomic and industry-related information. Recently, following the financial crisis of 2008, governments increased the amount of disclosure available about banks by conducting annual stress tests and making their results publicly available. This has led to significant public debate (Goldstein & Sapra 2013).

The academic literature is quite ambiguous about the effects of disclosure and its overall desirability. It is well understood that disclosure can potentially promote some important goals: By leveling the playing field in financial markets, it can increase market liquidity and market efficiency and can decrease the cost of capital for firms. However, much has been written about potential unintended consequences of disclosure, which occur because of the crowding out of private information production, the destruction of risk-sharing opportunities, and the promotion of destabilizing beauty-contest incentives. Given the flow of new regulations related to disclosure in recent years, researchers have been delving more and more into the topic, trying to understand the pros and cons and answering key questions, such as: What is the optimal level of disclosure in terms of promoting market quality and social welfare? What types of disclosure are most beneficial? In what circumstances is disclosure desirable?

Our goal in this review is to present the main forces that have been put forward in the discussion on the effects of disclosure in financial markets. As this is a review of theoretical literature, we use a workhorse model that has been used extensively in the literature on information and disclosure in financial markets, and we show how the main forces are manifested within this framework. We hope this will be useful to researchers who wish to build on existing theories in developing new ones, testing existing empirical implications, or understanding ongoing policy debates. We do not attempt an all-inclusive survey of the extant disclosure literature (some excellent surveys include those of Dye 2001, Verrecchia 2001, Kanodia 2006, Leuz & Wysocki 2008, and Kanodia & Sapra 2017). Instead, we aim to organize a few leading forces within a cohesive analytical framework, so that the pros and cons of disclosure can be more easily sorted out and evaluated for different environments.

The structure of this review is as follows. Section 2 presents the basic framework for studying information and disclosure in financial markets, building on the work of Grossman & Stiglitz (1980), Hellwig (1980), and Verrecchia (1982a). We show basic results demonstrating how increased precision of public information, which is achieved via enhanced disclosure, improves common measures of market quality. That is, we show that disclosure increases liquidity and market efficiency and decreases the cost of capital and return volatility. These results capture the usual intuition that guides regulators in imposing greater disclosure.

In Section 3, we extend the basic framework to endogenize the acquisition of private information by market participants, building on work by Verrecchia (1982b), Diamond (1985), and others. We demonstrate the basic argument that increased disclosure leads to crowding out of private-information acquisition. This implies that the effect of disclosure on market quality is more nuanced once private information is endogenized and that it depends on the amount of information being disclosed, on the information-acquisition technology, and on the measure of market quality being considered.

Although the analysis in Sections 2 and 3 considers measures of market quality, these measures do not translate easily into a clear objective function to tell how much disclosure is desirable. Section 4 extends the framework, reviewing papers that emphasize the role of the financial market in producing information that guides decisions on the real side of the economy. This is in the spirit of the literature on the market feedback effect, which is reviewed by Bond, Edmans & Goldstein (2012). This enables the analysis of optimal disclosure in light of its effect on the efficiency of real investment decisions (e.g., Gao & Liang 2013; Han, Tang & Yang 2016). An interesting dimension revealed by papers in this realm of work is that the type of information being disclosed is key in determining whether disclosure is desirable (Bond & Goldstein 2015, Goldstein & Yang 2016).

Finally, Section 5 considers extensions of the basic framework that allow us to study the effect of disclosure on the welfare of investors in financial markets and, as a result, to pin down optimal disclosure. Whereas the traditional view is that disclosure enhances the welfare of investors, a classic result by Hirshleifer (1971) shows that disclosure destroys risk-sharing opportunities and is thus welfare reducing. More recently, Kurlat & Veldkamp (2015) suggested a reduction in trading opportunities as another way in which disclosure's effects can be negative. Another common argument is that disclosure can be harmful because of beauty-contest incentives, leading all investors to want to do the same thing. In such a case, greater precision of public information leads investors to put too much weight on it, thus reducing welfare (Morris & Shin 2002).

---

## 2. A Basic Model of Information and Disclosure

We introduce a basic framework that enables us to discuss the various effects of disclosure in financial markets in a unified way. We rely on the noisy rational-expectations equilibrium (noisy REE) model, which is a workhorse model that has been used extensively in the literature on information and disclosure in financial markets. The model we describe in this section builds on early contributions by Grossman & Stiglitz (1980), Hellwig (1980), and Verrecchia (1982a). The model has the traditional CARA-normal feature; that is, traders have constant absolute risk aversion (CARA) preferences, and all random variables are normally distributed.

### 2.1. Setup

There are two dates, $t = 1$ and $t = 2$. At date 1, two assets are traded in a competitive financial market: a risk-free asset and a risky asset. The risky asset is usually thought of as equity issued by a firm, but it can also be a different asset, e.g., a corporate bond. The risk-free asset has a constant value of 1 and is in unlimited supply. The risky asset pays an uncertain cash flow at the final date $t = 2$, denoted by $\tilde{v}$. We assume that $\tilde{v}$ is normally distributed with a mean of 0 and a precision (reciprocal of variance) of $\tau_v$—that is, $\tilde{v} \sim N(0, \tau_v^{-1})$, with $\tau_v > 0$.[^1] The risky asset is traded at an endogenous price $\tilde{p}$ and has a fixed supply $Q \geq 0$.

[^1]: We use a tilde ($\tilde{\cdot}$) to signify an exogenous random variable and use $\tau$ to denote its precision; i.e., for a random variable $\tilde{z}$, we have $\tau_z = 1/\mathrm{Var}(\tilde{z})$.

There are three types of traders in the financial market: informed traders, uninformed traders, and liquidity traders. The first two types of traders have CARA utility over their wealth at date 2 with a risk aversion coefficient of $\gamma > 0$. They can represent individuals or institutions who trade the risky asset. The total mass of the first two types of traders is 1, with a fraction $\mu \in [0, 1]$ being informed traders and a fraction $1 - \mu$ being uninformed traders. Prior to trading, informed trader $i$ observes a private signal $\tilde{s}_i$, which contains information about the fundamental value $\tilde{v}$ of the risky asset in the following form:

$$\tilde{s}_i = \tilde{v} + \tilde{\varepsilon}_i, \quad \text{with} \quad \tilde{\varepsilon}_i \sim N(0, \tau_\varepsilon^{-1}) \quad \text{and} \quad \tau_\varepsilon > 0, \tag{1}$$

where $(\tilde{v}, \{\tilde{\varepsilon}_i\}_{i \in [0,\mu]})$ are mutually independent. For now, we take both $\mu$ and $\tau_\varepsilon$ as exogenous. We endogenize them later.

A common way to introduce disclosure into this model is to add a public signal $\tilde{y}$ as follows:

$$\tilde{y} = \tilde{v} + \tilde{\eta}, \quad \text{with} \quad \tilde{\eta} \sim N(0, \tau_\eta^{-1}) \quad \text{and} \quad \tau_\eta \geq 0 \tag{2}$$

(see, e.g., Diamond 1985; Verrecchia 2001; Morris & Shin 2002; Hughes, Liu & Liu 2007; Lambert, Leuz & Verrecchia 2007). For example, $\tilde{y}$ can be thought of as announcements made by the firm about its future prospects or as economic statistics published by government agencies, central banks, or other parties (e.g., credit rating agencies). The precision $\tau_\eta$ controls the quality of the public signal $\tilde{y}$, with a high value of $\tau_\eta$ signifying that $\tilde{y}$ is more informative about the asset cash flow $\tilde{v}$ (i.e., signifying more disclosure). More disclosure can be achieved by making more frequent announcements or by releasing more accurate data. Much of our analysis is concerned with how the parameter $\tau_\eta$ affects market outcomes. Note that we focus on the effect of ex ante disclosure quality, in the sense of an improvement in the precommitted precision of public information. We do not address strategic ex post disclosure, where firms choose whether to disclose based on their signal, which involves a signaling effect.

Liquidity traders, also called noise traders in the literature, demand $\tilde{x}$ units of the risky asset, where $\tilde{x} \sim N(0, \tau_x^{-1})$, with $\tau_x \in (0, \infty)$, is independent of other shocks in the economy. Noise trading provides the randomness that makes the rational-expectations equilibrium partially revealing, which is crucial to sustaining trading in equilibrium.

### 2.2. Equilibrium

The equilibrium requires that (a) informed and uninformed traders choose investments in assets to maximize their expected utility conditional on their respective information sets, including the asset price $\tilde{p}$, the public signal $\tilde{y}$, and (for informed traders) the private signal $\tilde{s}_i$; (b) the markets clear so that the demand for the risky asset equals the exogenous supply $Q$; and (c) informed and uninformed traders have rational expectations in the sense that their beliefs about all random variables are consistent with the true underlying distributions and equilibrium behaviors.

Constructing a noisy REE boils down to solving a price function that depends on the public information $\tilde{y}$, informed traders' private information $\tilde{s}_i$, and noise trading $\tilde{x}$. By the law of large numbers, the noise terms $\tilde{\varepsilon}_i$ in the private signals $\tilde{s}_i$ wash out, and thus we conjecture that the price $\tilde{p}$ is a function of $(\tilde{y}, \tilde{v}, \tilde{x})$. The literature focuses on a linear price function of the form

$$\tilde{p} = p_0 + p_y \tilde{y} + p_v \tilde{v} + p_x \tilde{x}, \tag{3}$$

where the $p$-coefficients are endogenously determined in equilibrium.

Informed trader $i$ has an information set $\{\tilde{y}, \tilde{s}_i, \tilde{p}\}$. The CARA-normal setup implies that the demand function of informed trader $i$ is

$$D_I(\tilde{y}, \tilde{s}_i, \tilde{p}) = \frac{E(\tilde{v}|\tilde{y}, \tilde{s}_i, \tilde{p}) - \tilde{p}}{\gamma \, \mathrm{Var}(\tilde{v}|\tilde{y}, \tilde{s}_i, \tilde{p})}.$$

For trader $i$, the information contained in the price is equivalent to the signal $\tilde{s}_p$:

$$\tilde{s}_p \equiv \frac{\tilde{p} - (p_0 + p_y \tilde{y})}{p_v} = \tilde{v} + \rho^{-1} \tilde{x}, \quad \text{with} \quad \rho = \frac{p_v}{p_x}, \tag{4}$$

which is normally distributed, with mean $\tilde{v}$ and precision $\rho^2 \tau_x$. Applying Bayes' rule to compute the conditional moments in the demand function, we can obtain

$$D_I(\tilde{y}, \tilde{s}_i, \tilde{p}) = \frac{\tau_\varepsilon \tilde{s}_i + \tau_\eta \tilde{y} + \rho^2 \tau_x \tilde{s}_p - (\tau_v + \tau_\varepsilon + \tau_\eta + \rho^2 \tau_x)\tilde{p}}{\gamma}. \tag{5}$$

Similarly, an uninformed trader has an information set $\{\tilde{y}, \tilde{p}\}$, and we can compute this trader's demand function for the risky asset as follows:

$$D_U(\tilde{y}, \tilde{p}) = \frac{E(\tilde{v}|\tilde{y}, \tilde{p}) - \tilde{p}}{\gamma \, \mathrm{Var}(\tilde{v}|\tilde{y}, \tilde{p})} = \frac{\tau_\eta \tilde{y} + \rho^2 \tau_x \tilde{s}_p - (\tau_v + \tau_\eta + \rho^2 \tau_x)\tilde{p}}{\gamma}. \tag{6}$$

The market-clearing condition is

$$\int_0^\mu D_I(\tilde{y}, \tilde{s}_i, \tilde{p})\, di + (1 - \mu) D_U(\tilde{y}, \tilde{p}) + \tilde{x} = Q. \tag{7}$$

To derive the equilibrium price function, we insert Equations 5 and 6 into Equation 7 to solve the price in terms of the public signal $\tilde{y}$, the fundamental $\tilde{v}$, and the noise trading $\tilde{x}$, and we then compare with the conjectured price function in Equation 3 to obtain a system defining the unknown $p$-coefficients.

Solving this system yields the following result: For any $\mu \in [0, 1]$ and $\tau_\varepsilon \geq 0$, there exists a unique partially revealing noisy REE, with price function of the form in Equation 3, where

$$p_0 = \frac{-\gamma Q}{\mu\tau_\varepsilon + \tau_v + \tau_\eta + \rho^2 \tau_x}, \qquad p_y = \frac{\tau_\eta}{\mu\tau_\varepsilon + \tau_v + \tau_\eta + \rho^2 \tau_x},$$

$$p_v = \frac{\mu\tau_\varepsilon + \rho^2 \tau_x}{\mu\tau_\varepsilon + \tau_v + \tau_\eta + \rho^2 \tau_x}, \qquad p_x = \frac{\rho\tau_x + \gamma}{\mu\tau_\varepsilon + \tau_v + \tau_\eta + \rho^2 \tau_x}, \tag{8}$$

with $\rho = \mu\tau_\varepsilon / \gamma$.

### 2.3. Market Quality and Disclosure

The effect of disclosure is often understood by examining different measures of market quality. We now define four common measures, explain their origins, and discuss how they are affected by greater disclosure.

#### 2.3.1. Market Liquidity

Market liquidity refers to a market's ability to facilitate the purchase or sale of an asset without drastically affecting the asset's price. The literature has used the coefficient $p_x$ in the price function (Equation 3) to inversely measure market liquidity: A smaller $p_x$ means that liquidity trading $\tilde{x}$ has a smaller price impact, and thus the market is deeper and more liquid. Formally,

$$\text{Liquidity} \equiv \frac{1}{p_x}. \tag{9}$$

This measure of market liquidity is often referred to as Kyle's (1985) lambda.

The illiquidity measure $p_x$ can also be linked to another often used measure, the bid-ask spread. Suppose that a liquidity trader comes to the market with a buying order $\tilde{x} = +1$. By Equation 3, this trader expects on average to fulfill this order at an ask price quoted by the market, $\mathrm{Ask} \equiv E(\tilde{p}|\tilde{x} = +1) = p_0 + p_x$. Similarly, if the liquidity trader wants to sell an order $\tilde{x} = -1$, then, on average, the trader expects to fulfill the order at a bid price $\mathrm{Bid} \equiv E(\tilde{p}|\tilde{x} = -1) = p_0 - p_x$. As a result, the bid-ask spread is

$$\text{Bid-ask spread} = \mathrm{Ask} - \mathrm{Bid} = 2p_x.$$

Thus, $p_x$ is indeed positively associated with the bid-ask spread.

From Equation 8, we know that disclosure improves market liquidity; that is, $\partial \text{Liquidity} / \partial\tau_\eta > 0$. Intuitively, more precise public information implies that there is less uncertainty about the asset value, so rational traders trade more aggressively against liquidity traders. As a result, changes in liquidity trading are absorbed with a smaller price change.

#### 2.3.2. Market Efficiency

Market efficiency, also called price efficiency or informational efficiency, concerns how informative the prevailing market prices are about the future values of the traded assets. An underlying reason for promoting market efficiency is that it is believed to be a good proxy for real efficiency, by which more information in prices about underlying values improves real investment decisions. In Section 4, we refine this statement. In the literature (e.g., Vives 2008, Peress 2010, Ozsoylev & Walden 2011), researchers measure market efficiency using the precision of the posterior about an asset fundamental conditional on its price,[^2] that is,

$$\text{Market efficiency} \equiv \frac{1}{\mathrm{Var}(\tilde{v}|\tilde{p})}. \tag{10}$$

[^2]: Equation 10 gives the most standard measure for market efficiency. In the context of learning from prices examined in Section 4, one can also measure the additional information contained in the price relative to that in the disclosure as $1/\mathrm{Var}(\tilde{v}|\tilde{p}, \tilde{y}) - 1/\mathrm{Var}(\tilde{v}|\tilde{y})$.

Given that $\tilde{v}$ and $\tilde{p}$ are normally distributed, $1/\mathrm{Var}(\tilde{v}|\tilde{p})$ is positively related to the correlation coefficient $\mathrm{Corr}(\tilde{v}, \tilde{p})$ between $\tilde{v}$ and $\tilde{p}$, that is,

$$\frac{1}{\mathrm{Var}(\tilde{v}|\tilde{p})} = \frac{\tau_v}{1 - [\mathrm{Corr}(\tilde{v}, \tilde{p})]^2}.$$

For this reason, one can also use $\mathrm{Corr}(\tilde{v}, \tilde{p})$ to measure market efficiency (e.g., Goldstein & Yang 2014).

Using Equation 8, we can show that disclosure improves market efficiency, that is, $\partial[1/\mathrm{Var}(\tilde{v}|\tilde{p})]/\partial\tau_\eta > 0$. Intuitively, more public information before the price is formed directly injects more fundamental information into the price through updating traders' forecasts about the asset payoff. This implies that the price tracks fundamental value more closely.

#### 2.3.3. Cost of Capital

In this one-period model, the return on the risky asset is $\tilde{v} - \tilde{p}$, as at date 2, the uncertainty is resolved and the asset price is its fundamental value $\tilde{v}$. The expected return $E(\tilde{v} - \tilde{p})$ is often interpreted as the cost of capital on the risky asset (e.g., Easley & O'Hara 2004; Hughes, Liu & Liu 2007; Lambert, Leuz & Verrecchia 2007). A lower cost of capital benefits the issuer of the security, as it enables the issuer to sell the security at a higher price.

From Equation 8, we have

$$E(\tilde{v} - \tilde{p}) = \frac{\gamma Q}{\mu\tau_\varepsilon + \tau_v + \tau_\eta + \left(\dfrac{\mu\tau_\varepsilon}{\gamma}\right)^2 \tau_x}. \tag{11}$$

Thus, the cost of capital $E(\tilde{v} - \tilde{p})$ is positively affected by risk aversion $\gamma$ and asset supply $Q$ in the numerator. This is because traders are willing to pay a lower price when they are more risk averse and have to hold more of the asset on average, so the risk they have to bear is higher. The expression in the denominator is equal to

$$\frac{\mu}{\mathrm{Var}(\tilde{v}|\tilde{y}, \tilde{s}_i, \tilde{p})} + \frac{1 - \mu}{\mathrm{Var}(\tilde{v}|\tilde{y}, \tilde{p})},$$

which is inversely related to the average risk perceived by traders per unit of the security. When the perceived risk goes up, the cost of capital also increases. Disclosure affects the cost of capital only through affecting the perceived risk: A higher level of disclosure lowers the cost of capital by lowering traders' average risk; that is, $\partial E(\tilde{v} - \tilde{p})/\partial\tau_\eta < 0$.

#### 2.3.4. Return Volatility

Return volatility $\sigma(\tilde{v} - \tilde{p}) = \sqrt{\mathrm{Var}(\tilde{v} - \tilde{p})}$ is another measure that attracts attention from academics and regulators. Using Equation 8, we can show that disclosure lowers return volatility; that is, $\partial\sigma(\tilde{v} - \tilde{p})/\partial\tau_\eta < 0$. This is because more public information improves market efficiency, which thus brings the asset price $\tilde{p}$ closer to the fundamental $\tilde{v}$.

#### 2.3.5. Summary

To summarize the results discussed thus far, we can see that for a given fraction $\mu$ of informed traders and a given precision of their information $\tau_\varepsilon$, disclosure improves all typical measures of market quality. It increases market liquidity and market efficiency and decreases the cost of capital and return volatility. This is the conventional wisdom that is often put forward to argue for greater disclosure with the intent of improving the functioning of the financial market. This is consistent with many academic papers (e.g., Diamond & Verrecchia 1991; Verrecchia 2001; Easley & O'Hara 2004; Hughes, Liu & Liu 2007; Lambert, Leuz & Verrecchia 2007; Gao 2008) and with the logic behind recent regulatory acts, such as the Sarbanes–Oxley Act of 2002 and the Dodd–Frank Act of 2010.[^3]

[^3]: For example, in its final ruling on shortening the reporting deadline for insider trading to two business days, the Securities and Exchange Commission (SEC 2002) argues that "making this information available to all investors on a more timely basis should increase market transparency, which will likely enhance market efficiency and liquidity."

---

## 3. Information Acquisition and Crowding-Out Effect

In Section 2, both the fraction $\mu$ of informed traders and the precision $\tau_\varepsilon$ of informed traders' private information were exogenous. In this setup, disclosure was shown to improve various measures of market quality, as it enabled more information to get into prices, improving market liquidity, market efficiency, etc. However, a natural question is: How do changes in disclosure affect private-information production, which is central to financial markets? Beginning to think about the effects of disclosure more broadly, various researchers have endogenized the variables $\mu$ and $\tau_\varepsilon$ that capture the amount of private information in the market (e.g., Verrecchia 1982b; Diamond 1985; Kim & Verrecchia 1994; Gao & Liang 2013; Colombo, Femminis & Pavan 2014). One key finding in their studies is that more public information can weaken the incentives of traders to become informed and/or to acquire more precise information. In other words, public information crowds out the production of private information. This can weaken and potentially reverse the direct effect of disclosure on some market-quality variables. In this section, we augment the baseline model in Section 2 with information acquisition to illustrate the crowding-out effect.

### 3.1. Setup

We add an information-acquisition date, $t = 0$, to the baseline model in Section 2. The information-acquisition technology closely follows Grossman & Stiglitz (1980) and Verrecchia (1982a). At date 0, there exists a unit mass of identical CARA traders. Trader $i$ can become informed by paying a cost to acquire a private signal $\tilde{s}_i$ in the form of Equation 1, which has a trader-specific precision $\tau_{\varepsilon i}$. The information-acquisition cost $C(\tau_{\varepsilon i})$ has two parts:[^4] a fixed cost $c_F \geq 0$ and a variable cost $c_V(\tau_{\varepsilon i})$, where $c_V(\cdot)$ is an increasing, smooth, and convex function satisfying $c_V(0) = 0$.

[^4]: Although the information-acquisition cost is measured in terms of traders' wealth at date 0, it can represent both the monetary cost and the time cost. Recently, Dugast & Foucault (2017) and Kendall (2017) have explicitly modeled the time cost of information.

In equilibrium, an endogenous fraction $\mu$ of traders decide to acquire private information, and these traders become the informed traders in the financial market at date 1. We can show that the informed traders choose the same precision level $\tau_\varepsilon$ in equilibrium, and thus the economies at dates 1 and 2 are the same as in the baseline model.

The equilibrium in this extended economy consists of an information-acquisition equilibrium at date 0 and a noisy REE at date 1. The noisy REE at date 1 is still characterized by Equations 3 and 8. The information-acquisition equilibrium at date 0 is characterized by (a) an intensive margin, $\tau_\varepsilon^*$—how precise is the information that informed traders acquire?—and (b) an extensive margin, $\mu^*$—how many traders decide to become informed?

Let us consider a particular trader $i$. Suppose that a fraction $\mu$ of traders are informed and acquire signals with precision $\tau_\varepsilon$. When trader $i$ stays uninformed, we use $\mathrm{CE}_U(\tau_\varepsilon, \mu)$ to denote this trader's ex ante expected utility (certainty equivalent) at the trading stage. When trader $i$ decides to become informed and acquire a private signal with precision $\tau_{\varepsilon i}$, we use $\mathrm{CE}_I(\tau_{\varepsilon i}; \tau_\varepsilon, \mu)$ to denote this trader's ex ante expected utility. Note that in $\mathrm{CE}_I(\tau_{\varepsilon i}; \tau_\varepsilon, \mu)$, trader $i$ can only choose $\tau_{\varepsilon i}$ and will take $(\tau_\varepsilon, \mu)$ as given. Following an argument similar to that of Grossman & Stiglitz (1980), we can compute $\mathrm{CE}_U(\tau_\varepsilon, \mu)$ and $\mathrm{CE}_I(\tau_{\varepsilon i}; \tau_\varepsilon, \mu)$ and analyze equilibrium outcomes.

Three types of information-acquisition equilibriums arise. First, when $c_F$, the fixed cost of information acquisition, is sufficiently small, all traders become informed, that is, $\mu^* = 1$; this case mimics the one studied by Verrecchia (1982b). Here, $\mathrm{CE}_U(\tau_\varepsilon^*, 1) \leq \mathrm{CE}_I(\tau_\varepsilon^*; \tau_\varepsilon^*, 1)$, so traders choose to become informed when all others are informed, and the precision of information $\tau_\varepsilon^*$ is pinned down by the first-order condition: $\partial \mathrm{CE}_I(\tau_\varepsilon^*; \tau_\varepsilon^*, 1)/\partial\tau_{\varepsilon i} = 0$. Second, when $c_F$ takes an intermediate value, an intermediate proportion of traders choose to become informed: $\mu^* \in (0, 1)$. The equilibrium is pinned down by a condition that makes traders indifferent between producing the equilibrium amount of information and remaining uninformed, $\mathrm{CE}_U(\tau_\varepsilon^*, \mu^*) = \mathrm{CE}_I(\tau_\varepsilon^*; \tau_\varepsilon^*, \mu^*)$, and by a first-order condition that guarantees that the level of precision is chosen optimally, $\partial \mathrm{CE}_I(\tau_\varepsilon^*; \tau_\varepsilon^*, \mu)/\partial\tau_{\varepsilon i} = 0$. It turns out that in equilibrium, the precision of information produced $\tau_\varepsilon^*$ is independent of disclosure quality $\tau_\eta$, and thus this case mimics the one studied by Diamond (1985). Finally, when $c_F$ is sufficiently large, no trader chooses to become informed, which is guaranteed by the condition $\mathrm{CE}_U(0, 0) \geq \max_{\tau_{\varepsilon i}} \mathrm{CE}_I(\tau_{\varepsilon i}; 0, 0)$.

**Figure 1** graphically illustrates these equilibrium outcomes. For this illustration, we assume that the variable cost function takes a quadratic form, $c_V(\tau_{\varepsilon i}) = (k/2)\tau_{\varepsilon i}^2$, and that the parameter values are $\tau_v = \tau_x = \gamma = Q = 1$ and $k = 0.1$. The figure plots the regimes of equilibrium types in the parameter space of $(c_F, \tau_\eta)$. Generally speaking, as $c_F$ and $\tau_\eta$ become larger, an equilibrium with a lower $\mu^*$ is more likely to prevail. This feature is a reflection of the crowding-out effect, which we explain in more detail in Section 3.2.1.

### 3.2. The Effect of Disclosure

We now reexamine the effect of disclosure when private information is endogenous.

#### 3.2.1. The Crowding-Out Effect on Private Information

The results below follow directly from the equilibrium analysis in Section 3.1 and demonstrate the crowding-out effect. First, when all traders are informed, so that $\mu^* = 1$, the equilibrium precision of information $\tau_\varepsilon^*$ decreases with increasing quality of public information $\tau_\eta$. Second, when an intermediate fraction of traders choose to become informed, so that $\mu^* \in (0, 1)$, this fraction decreases with increasing quality of public information $\tau_\eta$ (in this case the precision $\tau_\varepsilon^*$ is unaffected). These two results reproduce the crowding-out effects studied by Verrecchia (1982b) and Diamond (1985), respectively. Intuitively, when both public information and private information are about the same random variable $\tilde{v}$, they are substitutes, and thus additional public information motivates traders to cut back on their costly private acquisition activities either in the form of producing less-precise private information or in the form of becoming uninformed.

**Figure 2** continues this example with the same parameters, illustrating the crowding-out effect more directly. We now also set $c_F = 0.07$. We plot the equilibrium fraction $\mu^*$ of informed traders and the equilibrium precision $\tau_\varepsilon^*$ of private information as functions of the precision $\tau_\eta$ of public information. We see that globally, both $\mu^*$ and $\tau_\varepsilon^*$ weakly decrease with $\tau_\eta$. Starting from low disclosure, all traders choose to become informed, and an increase in disclosure reduces the precision of their information. Then, at some point, the fraction of informed traders starts decreasing as disclosure continues to improve, eventually drying up all the information produced privately in the market. Hence, public disclosure clearly crowds out private information. We now examine the effect that this has on the measures of market quality studied in Section 2.3.

#### 3.2.2. Effect on Market Quality

In Section 2, disclosure had an unambiguous effect on four measures of market quality—market liquidity, market efficiency, cost of capital, and return volatility—increasing the first two and decreasing the other two. However, things ought to be more complicated once we consider the crowding-out effect on private information. We use **Figure 3** to demonstrate the overall effect of disclosure on these measures once private information adjusts endogenously on the basis of the analysis above. Figure 3 uses the same parameter values as does Figure 2. It turns out that the effect of disclosure is often nonmonotonic and that the results depend on whether crowding out happens in the extensive margin (as in Diamond 1985) or the intensive margin (as in Verrecchia 1982b) and on which measure of market quality we inspect.

Let us consider the effect of disclosure $\tau_\eta$ on the cost of capital $E(\tilde{v} - \tilde{p})$. Recall that without considering private information to be endogenous, disclosure has a direct negative effect on the cost of capital. Figure 3 shows that, in the presence of endogenous private information, there are three different regimes. First, when $\tau_\eta$ is small, $E(\tilde{v} - \tilde{p})$ decreases as $\tau_\eta$ increases. In this regime, $\mu^*$ is fixed at 1 and $\tau_\varepsilon^*$ decreases with increasing $\tau_\eta$, which corresponds to the work of Verrecchia (1982b). Here, the crowding out of private information happens in the intensive margin. The decrease in private information following an increase in disclosure increases the risk faced by traders, pushing to an average increase in the cost of capital, but this is not strong enough to overcome the direct reducing effect that disclosure has on the cost of capital. Second, when $\tau_\eta$ takes intermediate values, $E(\tilde{v} - \tilde{p})$ starts to increase with $\tau_\eta$. Here, $\mu^* \in (0, 1)$ decreases with $\tau_\eta$ and $\tau_\varepsilon^*$ is fixed, which corresponds to the work of Diamond (1985), where the crowding out happens in the extensive margin. Now the decrease in private information as a result of increased disclosure is sufficiently strong that the cost of capital increases with disclosure, in opposition to the direct effect. Hence, the indirect effect of crowding out on the extensive margin is more powerful in this regime. Third, when $\tau_\eta$ is high, $E(\tilde{v} - \tilde{p})$ decreases with increasing $\tau_\eta$ again. Here, $\mu^* = 0$, so disclosure no longer affects private information, and only the direct reducing effect of disclosure on the cost of capital is present.[^5] Overall, we see that the crowding out of private information by public information implies that disclosure no longer has a uniformly negative effect on the cost of capital, so the total effect must be evaluated more carefully and depends on the exact information structure in place.

[^5]: Tang (2014) uses a figure similar to Figure 3 to explain the nonmonotonic relation between the cost of capital and disclosure, but her model follows that of Diamond (1985), so her analysis does not recognize the contrasting implications of extensive versus intensive margins.

Considering the effect of disclosure on market efficiency and return volatility, we can see effects very similar to those described above for the cost of capital. The exception is the measure of liquidity, which is monotonically increasing in disclosure. Here, the crowding-out effect of private information does not interfere with the positive direct effect that disclosure has on liquidity. This is because the crowding-out effect partly benefits market liquidity, as it weakens adverse selection induced by private information.

---

## 4. Disclosure and Real Efficiency

The above analysis has shown the effect that disclosure has on four commonly mentioned variables that capture different dimensions of market quality. We first showed how disclosure unambiguously improves these measures when we consider only its direct effect, but then showed that disclosure tends to crowd out private-information production and, as a result, has a more nuanced effect on the different measures. One issue with the above analysis is that these measures do not translate easily into a clear objective function that will help us tell when disclosure is desirable and when it is not.

In this section we address this issue and extend our basic framework, reviewing papers that have attempted to pin down optimal disclosure policy with a clear objective function in mind. The papers reviewed here emphasize the role of the financial market in producing information and in guiding the decisions on the real side of the economy, e.g., investment decisions made by firm managers. This idea goes back to Hayek (1945), who argued that prices are an important source of information because they aggregate information from many market participants. There is a vast recent literature exploring the implications of this market feedback effect; a recent survey is provided by Bond, Edmans & Goldstein (2012). The papers reviewed here explore optimal disclosure policy, taking into account how disclosure affects the information provided by the market and the efficiency of the investment decisions that are guided by the market. This, of course, is related to the concept of market efficiency discussed in Section 2. However, as should be clear from the analysis here, market efficiency and real efficiency are not always aligned. The latter refers to the efficiency of the market in revealing information needed for decisions on the real side of the economy. Real efficiency is what the models here feature, based on an objective function developed from first principles. For a broader discussion, see Bond, Edmans & Goldstein (2012) and the distinction they make between forecasting price efficiency and revelatory price efficiency.

### 4.1. Crowding-Out Effect and Optimal Disclosure Policy

The crowding-out effect reviewed in Section 3 suggests that disclosure can reduce the amount of private information in the price. Thus, if a firm manager tries to learn information from the price, the crowding-out effect tends to harm the manager's learning quality. However, as we reviewed in Section 2, disclosure can benefit the firm by lowering the cost of capital when information is exogenous. Gao & Liang (2013) study the resulting trade-off to examine the optimal disclosure policy of a firm. We now present an extension of our CARA-normal setup that captures their trade-off.

We extend the model in Section 3 to include another active player (the firm) and an intermediate date ($t = 1\tfrac{1}{2}$). We interpret the traded risky asset as the asset-in-place of a firm. The firm is endowed with information $\tilde{s}_F = \tilde{v} + \tilde{\varepsilon}_F$, with $\tilde{\varepsilon}_F \sim N(0, \tau_F^{-1})$ and $\tau_F > 0$. At the beginning of date 0, the firm chooses a disclosure policy that commits it to disclose a noisy version of $\tilde{s}_F$ to the financial market at date 1 in the following form:

$$\tilde{y} = \tilde{s}_F + \tilde{\delta}, \quad \text{with} \quad \tilde{\delta} \sim N(0, \tau_\delta^{-1}) \quad \text{and} \quad \tau_\delta \in [0, \infty]. \tag{12}$$

All of the underlying random variables $(\tilde{v}, \tilde{\varepsilon}_F, \tilde{\delta}, \{\tilde{\varepsilon}_i\}_i, \tilde{x})$ are mutually independent. We can rewrite $\tilde{y}$ in Equation 12 in the form defined in Equation 2 by defining $\tilde{\eta} \equiv \tilde{\varepsilon}_F + \tilde{\delta}$, where $\tilde{\eta} \sim N(0, \tau_\eta^{-1})$ with $\tau_\eta = (\tau_F^{-1} + \tau_\delta^{-1})^{-1} \in [0, \tau_F]$. The parameter $\tau_\eta$ still controls the disclosure quality. In particular, when $\tau_\eta = 0$, the firm does not disclose any information, and when $\tau_\eta = \tau_F$, the firm discloses its information $\tilde{s}_F$ without error.

The firm also has a growth opportunity whose productivity is related to $\tilde{v}$. The firm invests in the growth opportunity at $t = 1\tfrac{1}{2}$, so it can look into the asset price $\tilde{p}$ to extract information about $\tilde{v}$. The growth opportunity's cash flow $\tilde{G}$ is realized at date 2, and it takes the following form:

$$\tilde{G} = \sqrt{\Phi}\, \tilde{v}\, I - \frac{I^2}{2}, \tag{13}$$

where $I$ is the investment made by the firm at $t = 1\tfrac{1}{2}$ and the parameter $\Phi > 0$ captures the size of the growth option. In this extended economy, the firm makes two decisions: a disclosure-policy decision at $t = 0$ and a real-investment decision at $t = 1\tfrac{1}{2}$. We assume that the firm is risk-neutral and cares about both the asset-in-place and the growth opportunity.

The noisy REE in the financial market at date 1 is still characterized as in Section 2, and the information-acquisition equilibrium at date 0 is still characterized as in Section 3. We now examine the two decisions of the firm. At $t = 1\tfrac{1}{2}$, the firm has an information set $\{\tilde{s}_F, \tilde{p}, \tilde{y}\} = \{\tilde{s}_F, \tilde{s}_p\}$, where $\tilde{s}_p$ is the market signal given by Equation 4. The firm's optimal investment policy maximizes the expected value of the growth opportunity in Equation 13 given the information available, implying that $I(\tilde{s}_F, \tilde{s}_p) = \sqrt{\Phi}\, E(\tilde{v}|\tilde{s}_F, \tilde{s}_p)$. Inserting $I(\tilde{s}_F, \tilde{s}_p)$ back into the growth opportunity and taking the unconditional expectation yields the expected growth value:

$$E(\tilde{G}) = \frac{\Phi}{2}\left(\frac{1}{\tau_v} - \frac{1}{\tau_v + \tau_F + (\tau_\varepsilon/\gamma)^2 \tau_x}\right). \tag{14}$$

We can see that the expected growth value increases with the precision $(\tau_\varepsilon/\gamma)^2 \tau_x$ of the price signal $\tilde{s}_p$. This is a result of the feedback effect. The firm benefits from having more precise information in the price about the fundamental $\tilde{v}$ because then it can make a more efficient investment decision. By the crowding-out effect, additional disclosure lowers the precision $\tau_\varepsilon$ of private information produced and so makes the price signal $\tilde{s}_p$ less accurate. As a result, disclosure can harm the firm by reducing the value of the growth option.

At $t = 0$, the firm chooses an optimal disclosure policy $\tau_\eta$. Following Langberg & Sivaramakrishnan (2010), we assume that the firm's objective at date 0 is a weighted average of the expected price of the asset-in-place and its expected growth opportunity value, $\alpha E(\tilde{p}) + (1 - \alpha)E(\tilde{G})$, with $\alpha \in (0, 1)$. Then the optimal disclosure policy $\tau_\eta^{\text{opt}}$ balances two forces. On the one hand, greater disclosure increases $E(\tilde{p})$ by reducing the uncertainty faced by financial-market traders, thus reducing the cost of capital they impose on the firm.[^6] On the other hand, greater disclosure crowds out private information production and so deprives the firm of valuable information, thereby reducing the efficiency of its investment decision and the value of its growth option. As a result, one can show that when $\Phi/Q$ is relatively high, that is, when the firm's growth opportunity is large relative to its asset-in-place, the negative effect of disclosure dominates, and thus the firm chooses to disclose less. This model therefore implies that growth firms are endogenously more opaque than value firms.

[^6]: Recall that, for simplicity, we assumed here that information acquisition does not have a fixed cost. Then, based on the results in the previous section, the crowding-out effect of disclosure only happens in the intensive margin, and the cost of capital decreases as the level of disclosure increases.

### 4.2. Liquidity-Chasing Noise Trading

Another negative effect of disclosure on real efficiency is studied by Han, Tang & Yang (2016). They follow the approach of modeling discretionary liquidity traders in the market microstructure literature (e.g., Admati & Pfleiderer 1988, Foster & Viswanathan 1990) and show that greater disclosure attracts more noise trading. We now modify the model presented in Section 4.1 to illustrate this mechanism.

We shut down the information-acquisition activities of the CARA traders at date 0 and endow each of them with a private signal $\tilde{s}_i$ with precision $\tau_\varepsilon$. There is also a large mass of discretionary liquidity traders who are risk-neutral, uninformed, and ex ante identical.[^7] These traders are discretionary in the sense that at date 0, each chooses whether to participate in the market at date 1 by optimally balancing the expected loss from trading against informed CARA traders versus an exogenous liquidity benefit $B$ of market participation. If discretionary liquidity trader $l$ decides to trade, this trader has to trade $\tilde{u}$ units of risky asset, where $\tilde{u} \sim N(0, 1)$ and is perfectly correlated across liquidity traders. The equilibrium mass $L^*$ of liquidity traders participating in the market determines the noise trading active in the market: $\tilde{x} \equiv L^* \tilde{u}$ and $\tau_x^{-1} = L^{*2}$.

[^7]: In practice, these traders can represent institutional traders—e.g., index funds or exchange-traded funds—who need to rebalance portfolios around index recompositions or when receiving flow shocks.

We now characterize the market participation equilibrium of discretionary liquidity traders at date 0. At that point, discretionary liquidity trader $l$ faces the following trade-off. First, trading generates an exogenous benefit $B > 0$, which represents the exogenous liquidity needs. Second, because liquidity traders are trading against informed CARA traders, they will incur endogenous trading losses on average. Then the expected utility of participating in the market for discretionary liquidity trader $l$ is

$$W(L; \tau_\eta) = B + E[\tilde{u} \cdot (\tilde{v} - \tilde{p})] = \underbrace{B}_{\text{liquidity benefit}} - \underbrace{p_x(L; \tau_\eta) \times L}_{\text{trading cost}}. \tag{15}$$

Here, $L$ is the mass of liquidity traders choosing to participate in the market and $p_x(L; \tau_\eta)$ is given by Equation 8, with $\tau_x^{-1} = L^2$. Note that, given market liquidity, expected trading losses are increasing in $L$ because when more liquidity traders participate, they exert stronger price pressure, given that they trade in the same direction. In equilibrium, an endogenous mass $L^*$ of liquidity traders choose to participate in the market, while the rest choose not to. Hence, $L^*$ is determined by the indifference condition: $W(L^*; \tau_\eta) = 0$.

Equation 15 shows that discretionary liquidity traders have incentives to chase market liquidity. That is, if a change in the trading environment improves market liquidity (i.e., $p_x$ decreases), then, other things being equal, expected trading losses decrease and discretionary liquidity traders are more likely to participate in the market. As disclosure promotes market liquidity, releasing public information induces more discretionary liquidity traders to choose to participate in the market; that is, $\partial L^*/\partial\tau_\eta > 0$.

Disclosure also affects real efficiency through affecting the firm's learning from the price. By observing the price $\tilde{p}$, the firm obtains a signal $\tilde{s}_p$ with a precision $(\tau_\varepsilon/\gamma)^2 \tau_x$. Recall that in this economy, the precision of noise trading is given by $\tau_x = 1/L^{*2}$, which implies that the precision of the information in the price decreases as the level of disclosure increases: $\partial[\tau_\varepsilon/(\gamma L^*)]^2/\partial\tau_\eta < 0$. That is, more public information attracts additional liquidity trading and, as a result, the price reveals less fundamental information, thereby reducing real efficiency.

### 4.3. Multiple Dimensions of Disclosure

The models discussed in Sections 4.1 and 4.2 highlight the negative real-efficiency effects of disclosure. Two recent papers, by Bond & Goldstein (2015) and Goldstein & Yang (2016), point out that in the presence of multiple dimensions of information, the real-efficiency implications of disclosure might be different depending on what dimension of information is disclosed.

Bond & Goldstein (2015) show that a decision maker on the real side of the economy should disclose information about issues on which he or she knows more than the market and keep silent about issues on which he or she wants to learn from the market. Bond & Goldstein cast their idea in a trading model where the decision maker is the government, which makes an intervention decision. We now extend the baseline model in Section 2 to illustrate the mechanism. Suppose that the firm's cash flow $\tilde{v}$ at date 2 is given by $\tilde{v} = T + \tilde{v}_B$, where $\tilde{v}_B \sim N(0, \tau_B^{-1})$ with $\tau_B > 0$. The component $T$ is the result of endogenous government intervention based on its private information and the asset price $\tilde{p}$. Specifically, we add an additional date, $t = 1\tfrac{1}{2}$, at which the government chooses $T$ to maximize

$$E\left[-\frac{(T - \tilde{v}_A)^2}{2} + cT \;\Bigg|\; \mathcal{I}_G\right],$$

where $\tilde{v}_A \sim N(0, \tau_A^{-1})$ (with $\tau_A > 0$), $c > 0$ is a constant, and $\mathcal{I}_G$ is the government's information set. As discussed by Bond & Goldstein (2015), this objective function qualitatively captures many government motives, such as promoting social surplus and maintaining stability in the financial sector.

Note that in this setting, the asset cash flow $\tilde{v}$ is ultimately driven by two underlying random variables, $\tilde{v}_A$ and $\tilde{v}_B$. We assume that the government wants to learn from the market more about element $\tilde{v}_A$ than about element $\tilde{v}_B$. The government knows $\tilde{v}_B$ perfectly and only receives a private signal $\tilde{s}_G$ on $\tilde{v}_A$, where $\tilde{s}_G = \tilde{v}_A + \tilde{\varepsilon}_G$ with $\tilde{\varepsilon}_G \sim N(0, \tau_G^{-1})$ and $\tau_G > 0$. Traders have private information on $\tilde{v}_A$ in the form of Equation 1 but know nothing about $\tilde{v}_B$. That is, trader $i$ receives a signal $\tilde{s}_i = \tilde{v}_A + \tilde{\varepsilon}_i$ with $\tilde{\varepsilon}_i \sim N(0, \tau_\varepsilon^{-1})$ and $\tau_\varepsilon > 0$. So the asset price $\tilde{p}$ will aggregate private signals $\tilde{s}_i$ and convey information on $\tilde{v}_A$.

The government can use disclosure to affect the information-aggregation process of the price. Specifically, at date 1 before the financial market opens, the government discloses two public signals, $\tilde{y}_A = \tilde{s}_G + \tilde{\eta}_A$ and $\tilde{y}_B = \tilde{v}_B + \tilde{\eta}_B$, where $\tilde{\eta}_A \sim N(0, \tau_{\eta A}^{-1})$ (with $\tau_{\eta A} \in [0, \infty]$) and $\tilde{\eta}_B \sim N(0, \tau_{\eta B}^{-1})$ (with $\tau_{\eta B} \in [0, \infty]$). All the underlying random variables $(\tilde{v}_A, \tilde{v}_B, \tilde{\varepsilon}_G, \tilde{\eta}_A, \tilde{\eta}_B, \{\tilde{\varepsilon}_i\}_i)$ are mutually independent.

The price function in the financial market at date 1 takes the form $\tilde{p} = p_0 + p_{yA}\tilde{y}_A + p_{yB}\tilde{y}_B + p_v\tilde{v}_A + p_x\tilde{x}$, where the $p$-coefficients are endogenous. At $t = 1\tfrac{1}{2}$, the government has an information set $\mathcal{I}_G = \{\tilde{s}_G, \tilde{y}_A, \tilde{y}_B, \tilde{v}_B, \tilde{p}\}$. To the government, the price is still equivalent to the signal $\tilde{s}_p$ as in Equation 4, i.e.,

$$\tilde{s}_p = \frac{\tilde{p} - p_0 - p_{yA}\tilde{y}_A - p_{yB}\tilde{y}_B}{p_v} = \tilde{v}_A + \rho^{-1}\tilde{x}, \quad \text{with} \quad \rho = \frac{p_v}{p_x}.$$

Thus, the government's intervention policy is

$$T(\tilde{s}_G, \tilde{s}_p) = \arg\max_T\, E\left[-\frac{(T - \tilde{v}_A)^2}{2} + cT \;\Bigg|\; \tilde{s}_G, \tilde{y}_A, \tilde{y}_B, \tilde{v}_B, \tilde{p}\right]$$
$$= E(\tilde{v}_A|\tilde{s}_G, \tilde{s}_p) + c = \frac{\tau_G}{\tau_A + \tau_G + \rho^2\tau_x}\tilde{s}_G + \frac{\rho^2\tau_x}{\tau_A + \tau_G + \rho^2\tau_x}\tilde{s}_p + c. \tag{16}$$

The precision $\rho^2\tau_x$ of signal $\tilde{s}_p$ still captures the extra information that the government learns from the market. As in Section 4.1, in equilibrium, the government's utility increases with precision $\rho^2\tau_x$, as a higher $\rho^2\tau_x$ means that the government is making a more informed intervention decision. In this sense, $\rho^2\tau_x$ is a measure of real efficiency.

Financial trader $i$ has an information set $\{\tilde{s}_i, \tilde{y}_A, \tilde{y}_B, \tilde{p}\}$, which is equivalent to $\{\tilde{s}_i, \tilde{y}_A, \tilde{y}_B, \tilde{s}_p\}$. The CARA-normal setup implies that trader $i$'s demand for the risky asset is

$$D(\tilde{s}_i, \tilde{y}_A, \tilde{y}_B, \tilde{p}) = \frac{E[T(\tilde{s}_G, \tilde{s}_p) + \tilde{v}_B\,|\, \tilde{s}_i, \tilde{y}_A, \tilde{y}_B, \tilde{s}_p] - \tilde{p}}{\gamma\,\mathrm{Var}[T(\tilde{s}_G, \tilde{s}_p) + \tilde{v}_B\,|\, \tilde{s}_i, \tilde{y}_A, \tilde{y}_B, \tilde{s}_p]}. \tag{17}$$

Using the expression for $T(\tilde{s}_G, \tilde{s}_p)$ in Equation 16 and the market-clearing condition, $\int_0^1 D(\tilde{s}_i, \tilde{y}_A, \tilde{y}_B, \tilde{p})\,di + \tilde{x} = Q$, we can solve for $\tilde{p}$ in terms of $(\tilde{y}_A, \tilde{y}_B, \tilde{v}_A, \tilde{x})$.

The key results can be summarized as follows: Disclosing information about $\tilde{v}_A$ harms the government through impairing its learning quality from the price, whereas disclosing information about $\tilde{v}_B$ benefits the government.

The mechanism in the work of Goldstein & Yang (2016) is different and does not rely on risk aversion, as they study an environment in which all players are risk neutral. In their model, what matters for determining which information will be reflected by prices is the relative intensity at which agents trade on different pieces of information. Assuming again two dimensions of information, which in the context of a regular firm could represent the demand for the firm's products and the quality of its production technology, and assuming that agents have access to signals on both, Goldstein & Yang show that revealing more precise information on the dimension about which the firm already knows will cause traders to trade more aggressively on the dimension about which the firm wants to learn and will enable the firm to learn more from the price. The opposite will be true if more precise public information is revealed on what the firm is trying to learn; this will crowd out valuable private information from being incorporated into the price, reducing the firm's ability to learn from the price.

The analysis of multiple dimensions of information can be linked to the debate on the optimal disclosure of stress-test results (for a survey, see Goldstein & Sapra 2013). Stress-test results are useful for regulators to make intervention decisions and for creditors to determine whether to roll over their debt or extend more credit to financial institutions. However, one must keep in mind that disclosure of these results will crowd out information from the financial market. Based on the papers described here, disclosure is undoubtedly beneficial when the stress-test result is about issues in which the regulator or creditors have a relative informational advantage over the financial market. However, when the stress-test result is about something that the regulator or creditors know relatively less than the financial market, disclosing such information makes market prices less informative, which can lead to negative efficiency outcomes.

---

## 5. Investors' Welfare

The previous section described the various effects of disclosure on the efficiency of real investment decisions. Another important issue that has to be considered in evaluating the effects of disclosure is the implications for the welfare of traders in the financial market. As mentioned in Section 2, the usual argument invoked in favor of disclosure is that it improves market quality, which is perceived to have positive effects for investors in financial markets. However, as we discuss in this section, several models in the literature have shown that disclosure can have negative effects on investors' welfare. Hence, it is not always warranted to implement "investor protection" regulations that improve disclosure. In the next two subsections, we discuss two families of models that develop ideas along these lines.

### 5.1. Destruction of Trading Opportunities

The well-known Hirshleifer (1971) effect is a powerful argument against public disclosure of information. The idea is that when traders face idiosyncratic risks arising from, say, heterogeneous endowment shocks, public disclosure decreases welfare by reducing the risk-sharing opportunities available to traders. More recently, Kurlat & Veldkamp (2015) studied a related channel through which disclosure harms investors. In their setting, investors benefit when they have access to assets with a higher risk and a higher return, and these opportunities are eliminated by public disclosure of information. The common theme of both channels is that disclosure harms investors through destroying trading opportunities.

For the Hirshleifer effect to arise, we assume that traders trade to share risks rather than to speculate on private information. Specifically, we assume that at date 2, trader $i$ receives an endowment of labor income, $\tilde{q}_i \tilde{v}$, where $\tilde{q}_i \sim N(0, \sigma_q^2)$ with $\sigma_q \geq 0$, and $\tilde{q}_i$ is independent of $\tilde{v}$ and also independent across traders. When trading at date 1, trader $i$ knows his or her exposure $\tilde{q}_i$ to the risky asset but has no private information about the asset value $\tilde{v}$. To simplify things further, we assume that there are no noise traders in the model. In this economy, trader $i$'s demand for the risky asset is

$$D_i(\tilde{y}, \tilde{p}) = \frac{E(\tilde{v}|\tilde{y}, \tilde{p}) - \tilde{p}}{\gamma\,\mathrm{Var}(\tilde{v}|\tilde{y}, \tilde{p})} - \tilde{q}_i. \tag{18}$$

In Equation 18, the first term is the demand of a CARA trader without endowment shocks, who is attempting to make a profit on the deviations of prices from the expected fundamental value, and the second term is the hedging term capturing trader $i$'s attempt to reduce the endowment risk. Combining Equation 18 with the market-clearing condition, we can compute the asset price $\tilde{p}$ as

$$\tilde{p} = E(\tilde{v}|\tilde{y}) - \gamma\,\mathrm{Var}(\tilde{v}|\tilde{y})\,Q. \tag{19}$$

As there is no private information or noise trading, the price depends only on the public signal $\tilde{y}$.

Inserting Equation 18 into trader $i$'s objective function yields the indirect utility at the trading stage as follows:

$$U_i(\tilde{y}, \tilde{p}, \tilde{q}_i) = -\exp\!\left(-\underbrace{\frac{[E(\tilde{v}|\tilde{y}) - \tilde{p}]^2}{2\,\mathrm{Var}(\tilde{v}|\tilde{y})}}_{\text{trading gains}} - \gamma \underbrace{\tilde{p}\,\tilde{q}_i}_{\text{wealth}}\right). \tag{20}$$

In Equation 20, the term $\tilde{p}\tilde{q}_i$ captures the fact that each unit of labor income increases trader $i$'s wealth by the price $\tilde{p}$ of the risky asset, as it has the same cash flow as the risky asset. The term $[E(\tilde{v}|\tilde{y}) - \tilde{p}]^2/[2\,\mathrm{Var}(\tilde{v}|\tilde{y})]$ represents the benefit from trading the risky asset given the trading behavior in Equation 18. This term essentially captures the effect highlighted by Kurlat & Veldkamp (2015).

We can use the certainty equivalent $\mathrm{CE} \equiv -(1/\gamma)\log(-E[U_i(\tilde{y}, \tilde{p}, \tilde{q}_i)])$ to study the ex ante utility of trader $i$. To formally see the effect shown by Kurlat & Veldkamp (2015), let us turn off the Hirshleifer effect by dropping traders' idiosyncratic endowments and assuming that they simply trade the quantity put on the market by the issuer, that is, $\sigma_q = 0$ and $Q > 0$. Using Equation 19, the first term in the utility function in Equation 20 can be expressed as

$$\frac{[E(\tilde{v}|\tilde{y}) - \tilde{p}]^2}{2\,\mathrm{Var}(\tilde{v}|\tilde{y})} = \frac{\gamma^2 Q^2}{2}\,\mathrm{Var}(\tilde{v}|\tilde{y}) = \frac{\gamma^2 Q^2}{2}\cdot\frac{1}{\tau_v + \tau_\eta}. \tag{21}$$

Then

$$\mathrm{CE} = \frac{\gamma Q^2}{2}\cdot\frac{1}{\tau_v + \tau_\eta},$$

which decreases as disclosure quality $\tau_\eta$ increases. The intuition is as follows: Greater disclosure brings the asset price closer to its fundamental, so traders cannot enjoy the benefit of trading a risky asset. In the limit, if $\tilde{y}$ perfectly reveals $\tilde{v}$, then the risky asset becomes riskless, and traders lose all access to risk in their portfolio.

Now let us turn off the effect of Kurlat & Veldkamp (2015) and demonstrate the Hirshleifer effect; that is, suppose that $\sigma_q > 0$ and $Q = 0$. In this case, the asset is no longer provided by the issuer and traders trade among themselves to hedge against their endowment shocks. We can compute

$$\mathrm{CE} = \frac{1}{2\gamma}\log\!\left(1 - \gamma^2\sigma_q^2\,\frac{\tau_\eta}{\tau_v(\tau_v + \tau_\eta)}\right),$$

which again decreases with increasing $\tau_\eta$. Intuitively, as traders are risk averse, they benefit from trading risk-sharing contracts that insure against their exposure to idiosyncratic shocks. Disclosure reduces risk-sharing opportunities, as once the asset value is known, it is no longer possible to insure against its realization.

The Hirshleifer effect suggests that disclosure is unambiguously bad. This is true when there is enough capital in risk-sharing markets to allow them to work. However, this is not always the case. Consider, for example, the interbank market, which is used to share risk among banks. During the recent financial crisis, when aggregate conditions were bleak, this market was not able to function, as too many banks suffered shortages. This arguably led to market breakdown. Goldstein & Leitner (2015) study a model to consider a trade-off between the negative Hirshleifer effect and a positive effect of disclosure to prevent market breakdown. They find that, in good times, disclosure is undesirable because of the Hirshleifer effect. In bad times, however, some disclosure is necessary to get the risk-sharing market to work. They characterize optimal disclosure schemes in the spirit of the Bayesian persuasion literature following Kamenica & Gentzkow (2011). Importantly, full disclosure is not desirable, and optimal disclosure is just enough to restart the risk-sharing market by separating traders into different groups and excluding some of them from risk-sharing arrangements.

### 5.2. Coordination and Beauty Contests

Keynes (1936) argues that stock markets share the essence of a beauty contest because the actions of traders are governed not only by their expectations about the true value of traded assets, but also by their expectations about what other traders believe. There are many other environments, such as currency attacks or bank runs, in which agents have not only fundamental concerns but also strategic concerns. In these contexts, public disclosure provides more than just information about fundamentals, as it plays a coordination role of informing agents of what other agents know and so helping each agent to predict the actions of others. This coordination role can be detrimental to efficiency and welfare in the sense that agents place too much weight on the public signal relative to weights that would be used by a social planner.

The coordination mechanism and its general implications are best demonstrated by Morris & Shin (2002). We now review their model. The underlying state is given by $\tilde{v}$, which is drawn from an improper uniform prior over the real line (i.e., $\tau_v = 0$). There is a continuum $[0, 1]$ of agents. Agent $i$ chooses action $D_i$, and we use $\mathbf{D}$ to denote the action profile over all agents. Agent $i$ has access to both a private signal $\tilde{s}_i$ and a public signal $\tilde{y}$, given by Equations 1 and 2, respectively.

In the work of Morris & Shin (2002), the beauty-contest motive is directly built into agents' preferences. Specifically, the utility for agent $i$ is given by

$$u_i(\tilde{v}, \mathbf{D}) = -(1 - b)(D_i - \tilde{v})^2 - b(L_i - \bar{L}), \tag{22}$$

where $b \in (0, 1)$ is a constant, $L_i = \int_0^1 (D_j - D_i)^2\,dj$, and $\bar{L} = \int_0^1 L_j\,dj$. Hence, the agent has an incentive (with weight $1 - b$) to take an action close to the fundamentals (e.g., buy more of the asset when the fundamentals are high) and an incentive (with weight $b$) to take an action close to others' actions (e.g., buy when others are buying). Then the action taken by agent $i$ is given by

$$D(\tilde{s}_i, \tilde{y}) = \arg\max_{D_i} E[u_i(\tilde{v}, \mathbf{D})\,|\, \tilde{s}_i, \tilde{y}] = (1 - b)E(\tilde{v}|\tilde{y}, \tilde{s}_i) + b\,E(\bar{D}|\tilde{y}, \tilde{s}_i), \tag{23}$$

where $\bar{D}$ is the average action in the population, i.e., $\bar{D} = \int_0^1 D(\tilde{s}_i, \tilde{y})\,di$. Hence, the agent makes a decision based on the expected level of the fundamental $\tilde{v}$ and the expectation of what other agents will do. Parameter $b$ controls the intensity of the beauty-contest motive.

We consider an equilibrium in which each agent follows a linear strategy of the form $D(\tilde{s}_i, \tilde{y}) = \kappa_s \tilde{s}_i + \kappa_y \tilde{y}$, where $\kappa_s$ and $\kappa_y$ are endogenous coefficients. Inserting this conjectured strategy into Equation 23, we can find the expression for $D(\tilde{s}_i, \tilde{y})$. We then compare coefficients in this computed expression with those in the conjectured linear strategy to compute $\kappa_s$ and $\kappa_y$ as follows:

$$\kappa_s = \frac{\tau_\varepsilon(1 - b)}{\tau_\varepsilon(1 - b) + \tau_\eta} \qquad \text{and} \qquad \kappa_y = \frac{\tau_\eta}{\tau_\varepsilon(1 - b) + \tau_\eta}. \tag{24}$$

When there is no beauty-contest motive (i.e., when $b = 0$), the weight $\kappa_y$ that is put on the public signal is based on the precision of the two signals, as in Bayesian updating. When the beauty-contest motive arises and strengthens (i.e., when $b > 0$ and increases), the weight $\kappa_y$ on the public signal increases. The reason is that whereas both signals provide information about the fundamental, the public signal carries additional weight, given that it also provides information about what other agents know, and hence it helps in predicting their actions.

In the work of Morris & Shin (2002), the excessive weight on the public signal harms social welfare, which is defined as the (normalized) average of individual utilities. By Equation 22, social welfare is

$$W(\tilde{v}, \mathbf{D}) \equiv \frac{1}{1 - b}\int_0^1 u_i(\tilde{v}, \mathbf{D})\,di = -\int_0^1 (D_i - \tilde{v})^2\,di. \tag{25}$$

A social planner would seek to keep all agents' actions close to $\tilde{v}$. This is because the beauty-contest motive cancels out across individuals and so does not affect social welfare. Thus, if the social planner can specify the weight that each agent puts on the public signal $\tilde{y}$, that weight would be $\kappa_y^{\text{opt}} = \tau_\eta/(\tau_\varepsilon + \tau_\eta)$, which is lower than the equilibrium weight $\kappa_y$ on $\tilde{y}$. Thus, the coordination role of public information is welfare reducing.

The implication is that greater disclosure might harm agents' welfare. Formally, using Equations 24 and 25, we can compute the expected welfare in equilibrium as

$$E[W(\tilde{v}, \mathbf{D})|\tilde{v}] = -\frac{\tau_\eta + \tau_\varepsilon(1 - b)^2}{[\tau_\eta + \tau_\varepsilon(1 - b)]^2}.$$

Direct computation shows that $E[W(\tilde{v}, \mathbf{D})|\tilde{v}]$ is U-shaped in the precision $\tau_\eta$ of public information. Intuitively, releasing public information has two effects on welfare. The positive effect stems from the informational role; that is, more public information helps agents to predict the state $\tilde{v}$ more accurately. The negative effect stems from the coordination role; that is, agents put too much weight on public information, and this is exacerbated when the public information is more precise. The overall result is that when the public information is sufficiently coarse, the negative effect dominates, whereas when the public information is sufficiently accurate, the positive effect dominates. Hence, increasing the precision of disclosure is desirable when disclosure is already quite precise.

We point out that the negative welfare effect of coordination is not general. It follows here because the beauty-contest element in individual utility is of zero-sum nature. Angeletos & Pavan (2007) show that, in other settings, coordination is socially valuable, so welfare necessarily increases with the precision of public information. One such example is investment complementarity, in which the production of one firm positively depends on the aggregate production of all firms in the same industry. Colombo, Femminis & Pavan (2014) extend the work of Angeletos & Pavan (2007) to allow for endogenous acquisition of private information.

Although Morris & Shin (2002) take the beauty-contest motive as given, it is important to ask where this motive might come from. After all, most traditional models of financial markets, built from first principles, do not necessarily predict that traders would like to do what other traders do. Allen, Morris & Shin (2006) and Cespa & Vives (2015) endogenize the beauty-contest motive using short horizons of financial traders. A short-horizon trader has to close his or her investment positions in an asset before its fundamental value is realized, so this trader's payoff depends on how much other traders would like to pay, rather than on how much he or she expects the fundamental value of the asset will be. As in the work of Morris & Shin (2002), public information again plays two roles in affecting trading: an informational role, because it conveys information about the unknown fundamental value, and a coordination role, because it is common to the information sets of all traders and helps a short-horizon trader to predict the future liquidation value when he or she closes positions.

Gao (2008) uses the setting of Allen, Morris & Shin (2006) to examine the implications of disclosure for market efficiency. He shows that greater disclosure always drives stock prices closer to the fundamental value and hence improves market efficiency. The reason lies in an endogenous link between the two roles of public information in affecting the trading of date-0 traders. The coordination role occurs because short-horizon traders correctly believe in the first place that future traders will use public information because of its information value. When the information value becomes less, traders at date 0 overuse it less because they (again, correctly) believe that others will be using it less. Thus, the coordination role is always secondary to the informational role in terms of market efficiency in the setting of Gao (2008).

Goldstein, Ozdenoren & Yuan (2011) endogenize the beauty-contest motive using a model in which the aggregate trading of currency speculators reveals new information to a central bank and affects its policy decision. The beauty-contest motive arises in their setting because speculators know that a large speculative currency attack has the potential to convince the central bank that the fundamentals are weak, so each speculator would like to second-guess other speculators' actions to better coordinate. As a result, speculators put excessive weight on signals that are correlated with other speculators' information. In this setting, the central bank may inadvertently strengthen the coordination motive by releasing more information that becomes common to speculators, which backfires by reducing the informational content that the central bank learns from the attack, leading the bank to make more policy mistakes.

---

## 6. Conclusion

The analysis provided in this article demonstrates key insights from the literature on how information disclosure in financial markets affects market quality, information production, real efficiency, and traders' welfare. As the analysis shows, there are many aspects to consider when evaluating the effects of disclosure and the optimal regulation of the level and form of disclosure. We have showed here how many of these effects can be manifested in a cohesive analytical framework that has proven useful in understanding trading and information in financial markets. As disclosure is being used more and more as a tool by regulators to increase market quality, it is important to consider its different implications. We hope that our review will be useful for researchers interested in advancing the theoretical and empirical work in the area and for policy analysis as regulations of market disclosure continue to evolve.

---

## Acknowledgments

We thank Patrick Bolton, Thierry Foucault, Pierre Jinghong Liang, Marco Pagano, Haresh Sapra, Joel Shapiro, and Zhuo Zhong for comments and suggestions. L.Y. thanks the Social Sciences and Humanities Research Council of Canada for financial support.

---

## Literature Cited

- Acharya VV, DeMarzo P, Kremer I. 2011. Endogenous information flows and the clustering of announcements. *Am. Econ. Rev.* 101:2955–79
- Admati A, Pfleiderer P. 1988. A theory of intraday patterns: volume and price variability. *Rev. Financ. Stud.* 1:3–40
- Allen F, Morris S, Shin HS. 2006. Beauty contests and iterated expectations in asset markets. *Rev. Financ. Stud.* 19:719–52
- Amador M, Weill PO. 2010. Learning from prices: public communication and welfare. *J. Polit. Econ.* 118:866–907
- Angeletos GM, Pavan A. 2007. Efficient use of information and social value of information. *Econometrica* 75:1103–42
- Bloomfield R, O'Hara M. 1999. Market transparency: Who wins and who loses? *Rev. Financ. Stud.* 12:5–35
- Bond P, Edmans A, Goldstein I. 2012. The real effects of financial markets. *Annu. Rev. Financ. Econ.* 4:339–60
- Bond P, Goldstein I. 2015. Government intervention and information aggregation by prices. *J. Finance* 70:2777–811
- Cespa G, Vives X. 2015. The beauty contest and short-term trading. *J. Finance* 70:2099–154
- Colombo L, Femminis G, Pavan A. 2014. Information acquisition and welfare. *Rev. Econ. Stud.* 81:1438–83
- Diamond DW. 1985. Optimal release of information by firms. *J. Finance* 40:1071–94
- Diamond DW, Verrecchia R. 1981. Information aggregation in a noisy rational expectations economy. *J. Financ. Econ.* 9:221–35
- Diamond DW, Verrecchia R. 1991. Disclosure, liquidity, and the cost of capital. *J. Finance* 46:1325–59
- Di Maggio M, Pagano M. 2017. Financial disclosure and market transparency with costly information processing. *Rev. Finance.* In press. doi: 10.1093/rof/rfx009
- Dugast J, Foucault T. 2017. Data abundance and asset price informativeness. Work. Pap., HEC Paris
- Dye RA. 1985. Disclosure of nonproprietary information. *J. Account. Res.* 23:123–45
- Dye RA. 2001. An evaluation of essays on disclosure and the disclosure literature in accounting. *J. Account. Econ.* 32:181–235
- Easley D, O'Hara M. 2004. Information and the cost of capital. *J. Finance* 59:1553–83
- Easley D, O'Hara M, Yang L. 2014. Opaque trading, disclosure, and asset prices: implications for hedge fund regulation. *Rev. Financ. Stud.* 27:1190–237
- Fama EF, Miller M. 1972. *The Theory of Finance.* New York: Holt, Rinehart & Winston
- Foster FD, Viswanathan S. 1990. A theory of the interday variations in volume, variance, and trading costs in securities markets. *Rev. Financ. Stud.* 3:593–624
- Foucault T, Gehrig T. 2008. Stock price informativeness, cross-listings, and investment decisions. *J. Financ. Econ.* 88:146–68
- Gao P. 2008. Keynesian beauty contest, accounting disclosure, and market efficiency. *J. Account. Res.* 46:785–807
- Gao P, Liang P. 2013. Informational feedback effect, adverse selection, and the optimal disclosure policy. *J. Account. Res.* 51:1133–58
- Goldstein I, Leitner Y. 2015. Stress tests and information disclosure. Work. Pap., Wharton Sch., Univ. Pa.
- Goldstein I, Ozdenoren E, Yuan K. 2011. Learning and complementarities in speculative attacks. *Rev. Econ. Stud.* 78:263–92
- Goldstein I, Sapra H. 2013. Should banks' stress test results be disclosed? An analysis of the costs and benefits. *Found. Trends Finance* 8:1–54
- Goldstein I, Yang L. 2014. *Market efficiency and real efficiency: the connect and disconnect via feedback effects.* Work. Pap., Wharton Sch., Univ. Pa.
- Goldstein I, Yang L. 2016. *Good disclosure, bad disclosure.* Work. Pap., Wharton Sch., Univ. Pa.
- Greenstone M, Oyer P, Vissing-Jorgensen A. 2006. Mandated disclosure, stock returns, and the 1964 Securities Acts Amendments. *Q. J. Econ.* 121:399–460
- Grossman S. 1981. The informational role of warranties and private disclosure about product quality. *J. Law Econ.* 24:461–83
- Grossman S, Stiglitz J. 1980. On the impossibility of informationally efficient markets. *Am. Econ. Rev.* 70:393–408
- Guttman I, Kremer I, Skrzypacz A. 2014. Not only what but also when: a theory of dynamic voluntary disclosure. *Am. Econ. Rev.* 104:2400–20
- Han B, Tang Y, Yang L. 2016. Public information and uninformed trading: implications for market liquidity and price efficiency. *J. Econ. Theory* 163:604–43
- Hayek FA. 1945. The use of knowledge in society. *Am. Econ. Rev.* 35:519–30
- Hellwig M. 1980. On the aggregation of information in competitive markets. *J. Econ. Theory* 22:477–98
- Hirshleifer J. 1971. The private and social value of information and the reward to inventive activity. *Am. Econ. Rev.* 61:561–74
- Huddart S, Hughes JS, Levine CB. 2001. Public disclosure and dissimulation of insider trades. *Econometrica* 69:665–81
- Hughes JS, Liu J, Liu J. 2007. Information asymmetry, diversification, and cost of capital. *Account. Rev.* 82:705–29
- Indjejikian R. 1991. The impact of costly information interpretation on firm disclosure decisions. *J. Account. Res.* 29:277–301
- Jung W-O, Kwon YK. 1988. Disclosure when the market is unsure of information endowment of managers. *J. Account. Res.* 26:146–53
- Kamenica E, Gentzkow M. 2011. Bayesian persuasion. *Am. Econ. Rev.* 101:2590–615
- Kanodia C. 2006. Accounting disclosure and real effects. *Found. Trends Account.* 1:167–258
- Kanodia C, Sapra H. 2017. A real effects perspective to accounting measurement and disclosure: implications and insights for future research. *J. Account. Res.*
- Kendall C. 2017. The time cost of information in financial markets. Work. Pap., Univ. South. Calif.
- Keynes JM. 1936. *The General Theory of Employment, Interest, and Money.* London: Macmillan
- Kim O, Verrecchia RE. 1994. Market liquidity and volume around earnings announcements. *J. Account. Econ.* 17:41–67
- Kurlat P, Veldkamp L. 2015. Should we regulate financial information? *J. Econ. Theory* 158:697–720
- Kyle A. 1985. Continuous auctions and insider trading. *Econometrica* 53:1315–35
- Lambert R, Leuz C, Verrecchia RE. 2007. Accounting information, disclosure, and the cost of capital. *J. Account. Res.* 45:385–420
- Langberg N, Sivaramakrishnan K. 2010. Voluntary disclosures and analyst feedback. *J. Account. Res.* 48:603–45
- Leuz C, Wysocki P. 2008. *Economic consequences of financial reporting and disclosure regulation: a review and suggestions for future research.* Work. Pap., Univ. Chic.
- Madhavan A. 1995. Consolidation, fragmentation, and the disclosure of trading information. *Rev. Financ. Stud.* 8:579–603
- Milgrom PR. 1981. Good news and bad news: representation theorems and applications. *Bell J. Econ.* 12:380–91
- Morris S, Shin HS. 2002. The social value of public information. *Am. Econ. Rev.* 92:1521–34
- Naik N, Neuberger A, Viswanathan S. 1999. Disclosure regulation in markets with negotiated trades. *Rev. Financ. Stud.* 12:873–900
- Ozsoylev H, Walden J. 2011. Asset pricing in large information networks. *J. Econ. Theory* 146:2252–80
- Pagano M, Röell A. 1996. Transparency and liquidity: a comparison of auction and dealer markets with informed trading. *J. Finance* 51:579–611
- Pagano M, Volpin P. 2012. Securitization, transparency, and liquidity. *Rev. Financ. Stud.* 25:2417–53
- Peress J. 2010. Product market competition, insider trading, and stock market efficiency. *J. Finance* 65:1–43
- Scharfstein D, Stein J. 1990. Herd behavior and investment. *Am. Econ. Rev.* 80:465–79
- SEC (Secur. Exch. Comm.). 2002. Final rule: ownership reports and trading by officers, directors, and principal security holders. Release Nos. 34-46421, 35-27563, IC-25720, File No. S7-32-01, SEC, Washington, DC. https://www.sec.gov/rules/final/34-46421.htm
- Subrahmanyam A, Titman S. 1999. The going-public decision and the development of financial markets. *J. Finance* 54:1045–82
- Tang Y. 2014. Information disclosure and price discovery. *J. Financ. Markets* 19:39–61
- Verrecchia RE. 1982a. Information acquisition in a noisy rational expectations economy. *Econometrica* 50:1415–30
- Verrecchia RE. 1982b. The use of mathematical models in financial accounting. *J. Account. Res.* 20:1–42
- Verrecchia RE. 2001. Essays on disclosure. *J. Account. Econ.* 32:97–180
- Vives X. 2008. *Information and Learning in Markets: The Impact of Market Microstructure.* Princeton, NJ: Princeton Univ. Press
- Wang J. 1994. A model of competitive stock trading volume. *J. Polit. Econ.* 102:127–68
