******************************************************************************************************************************
******************************************************************************************************************************
***
*** Number of project:		2016\0082				
*** Title of project:		Securities lending by mutual funds
*** Data source: 			Investment Fund Statistics (December 2009 until December 2018; December 2014-December 2018 is used for analysis
*** Name of programme code:	C1_Descriptive_Statistics.do
***
*** Purpose of programme code: Calculation of descriptive statistics for lenders and non-lenders
***			Part I: 	Create additional variables and rescale variables for descriptive statistics
***			Part II: 	Descriptives for Number of Funds and Assets under Management in the sample
***			Part III:	Descriptives for Securities Lending Activity
***			Part IV: 	Descriptives for Main Variables (Fund-Security Level)
***
******************************************************************************************************************************
******************************************************************************************************************************

/* Paths : */

*Comment next two lines out when running code via the master file (information comes from there in this case)
global datum 				= 	"20260311"				/* Date in the form yyyymmdd */
global proj_num				=	"2016_0082r"			/* Please spezify project number with underscore */

global path					= 	"\\in.bundesbank.de.\BBK\Daten\Zentrale\ZB-S\Daten_FDSZ_Gastforscher\1_gafo\\${proj_num}"

global orig_data			=	"${path}/data/orig"							/* Path for original data */
global data_for_analysis	= 	"${path}/data/data_for_analysis"			/* Path to data used for analysis */
global temp_data			=	"${path}/data/temp"							/* Path for temporary files */
global ext_data				=	"${path}/data/ext"							/* Path for external data */

global ado					=	"${path}/ado"								/* ado-path */
global code					=	"${path}/code/${datum}"						/* Path for program codes */
global results				=	"${path}/results/${datum}"					/* Path for results */


sysdir set STBPLUS "${ado}"

clear all 
set more off
capture reghdfe, compile
capture ftools, compile


******************************************************************************************************************************
******************************************************************************************************************************

*********************************************
*********************************************
/* Part I: Prepare data for analysis */
*********************************************
*********************************************


******************************************************************************************************************************
******************************************************************************************************************************
/* Part I: Prepare data for analysis */
******************************************************************************************************************************
******************************************************************************************************************************

****************************************
/*Load Data Set (merged dataset: IFS data, Eikon Data, Morningstar Data, Markit Data)*/
****************************************
cd "${data_for_analysis}"
use "B3_Panel_EquityFunds_FinalMerge_AddVar_2014m12on_Dec22.dta", clear


****************************************
/*Add Net Short Position Data*/
****************************************
cd "${data_for_analysis}/06_NSP"
merge m:1 DSCD datem using "Public_NetShortPositions_FirstDisclosureEvent_2012-2018_Jul25.dta"


/*
----------------------------------------------------------
_merge == 1: Data only in Holdings (no public short selling disclosure for these stock-months) -> OK
_merge == 2: Data only in Short Selling Disclosure (No holdings for the ISIN in the corresponding month) -> drop
----------------------------------------------------------
*/

****************************************
*Drop Stock-Months without any holdings in a given month 
****************************************
qui drop if _merge == 2		
drop _merge

*Stocks without any net short position disclosure -> fill up with 0's
****************************************
foreach var of varlist *LSP*{
	replace `var' = 0 if `var' == .
}


cd "${data_for_analysis}"
merge m:1 DSCD datem using "Index_Exclusions_v2.dta"
drop if _merge == 2

gen dum_index_exclusion = (_merge == 3)
drop _merge

drop if dum_index_exclusion == 1
drop dum_index_exclusion

*Lagged Index Exclusion Months
replace datem = datem + 1
merge m:1 DSCD datem using "Index_Exclusions_v2.dta"
drop if _merge == 2

gen dum_index_exclusion = (_merge == 3)
drop _merge

drop if dum_index_exclusion == 1
drop dum_index_exclusion 
replace datem = datem - 1

*Define Public Disclosure Sample
gcollapse (min) first_date = datem if first_LSP_6m == 1, by(DSCD) merge replace
gcollapse (min) first_date, by(DSCD) merge replace

gcollapse (max) ever_LSP = any_LSP, by(DSCD) merge replace

gen public_disclosure = (any_LSP == 1)
gen public_disclosure2 = (ever_LSP == 1)

*Define Private Disclosure Sample(s)
gen private_disclosure = (any_LSP == 0 & on_loan_mv > 0.2 & on_loan_mv <= 0.5)
gen private_disclosure2 = (any_LSP == 0 & on_loan_mv > 0.3 & on_loan_mv <= 0.5)
gen private_disclosure3 = (any_LSP == 0 & on_loan_mv > 0.4 & on_loan_mv <= 0.5)

rename (first*plus*) (first*pre*)
rename (first*minus*) (first*post*)

*Define time window for disclosure sample
gen disclosure_sample = (first_LSP_6m_post1 == 1 | first_LSP_6m_post2 == 1 | first_LSP_6m_post3 == 1 | first_LSP_6m == 1 | first_LSP_6m_pre1 == 1 | first_LSP_6m_pre2 == 1 | first_LSP_6m_pre3 == 1)



*********************************************
/*Additional Variables*/
*********************************************

*Does any fund in the family currently lend the stock (2nd version: not the fund itself)
bys ui_family ui_dscd datem: egen dum_slend_family_now = max(dum_slend_now)
gen dum_slend_family_now_noown = dum_slend_family_now
replace dum_slend_family_now_noown = 0 if dum_slend_now == 1

bys ui_family ui_dscd datem: egen dum_slend_family_12m = max(dum_slend_12m)
gen dum_slend_family_12m_noown = dum_slend_family_12m
replace dum_slend_family_12m_noown = 0 if dum_slend_12m == 1
	
tsset ui_fund_sec datem


/*Lagged Lending Dummies */
****************************************
gen ldum_slend_12m = l.dum_slend_12
*gen ldum_slend_now = l.dum_slend_now

gen ldum_slend_now = (lsec_mv_lend_adj != 0)
replace ldum_slend_now = . if lsec_mv_lend_adj == .

gen ldum_flend_12m = l.dum_flend_12m
gen ldum_fflend_12m = l.dum_fflend_12m

gen fon_loan_mv = F.on_loan_mv

*gen lsec_mv_lend = l.sec_mv_lend
gen lon_loan_fund = lsec_mv_lend_adj/(lMV_eur*10^3)	
replace lon_loan_fund = lon_loan_fund*100

winsor2 lon_loan_fund, cut(0 99) replace

*Family Level Lending
****************************************
bys ui_family ui_dscd datem: egen lsec_mv_lend_fam = sum(lsec_mv_lend_adj)
gen lon_loan_fam = lsec_mv_lend_fam/(lMV_eur*10^3)
replace lon_loan_fam = lon_loan_fam*100


****************************************
****************************************
*Lending Power
****************************************
****************************************

gcollapse (sum) lsec_mv_lend_all = lsec_mv_lend_adj, by(ui_dscd datem) merge replace

gen lon_loan_mv_all = lsec_mv_lend_all/(lMV_eur*10^3)
replace lon_loan_mv_all = lon_loan_mv_all*100

egen lon_loan_mv_comb = rowmax(lon_loan_mv_max lon_loan_mv_all)

*Fund j's or family f's share of total lending (lsec_mv_lend_adj/lMV_eur divided by ltotal_demand_value_EUR_Mmean/lMV_eur) -> should be smaller than 1!
****************************************
gen frac_active_lend = lon_loan_fund/lon_loan_mv_max
replace frac_active_lend = 0 if frac_active_lend == . & lon_loan_fund != .

gen ffrac_active_lend_max = lon_loan_fam/lon_loan_mv_max
replace ffrac_active_lend_max = 0 if ffrac_active_lend_max == . & lon_loan_fam != .

gen ffrac_active_lend_comb = lon_loan_fam/lon_loan_mv_comb
replace ffrac_active_lend_comb = 0 if ffrac_active_lend_comb == . & lon_loan_fam != .

/*
gen ffrac_active_lend_trim = ffrac_active_lend
replace ffrac_active_lend_trim = 1 if ffrac_active_lend > 1 & ffrac_active_lend < .

gen ffrac_active_lend_ifs = lsec_mv_lend_fam/lsec_mv_lend_all
replace ffrac_active_lend_ifs = 0 if ffrac_active_lend_ifs == . & lsec_mv_lend_all != .
*/

foreach var of varlist ffrac*{
	replace `var' = `var'*100
}

capture drop ffrac_active_lend_high
gen ffrac_active_lend_high = ffrac_active_lend_max >= 5
replace ffrac_active_lend_high = . if ffrac_active_lend_max == .


winsor2 lon_loan_fund, cut(0 99) replace
winsor2 lon_loan_fam, cut(0 99) replace

*Take 1/active agents for concentration measure that aligns with other measures
replace lactive_agents_Mmean = 1/lactive_agents_Mmean 


*winsor2 ffrac_active_lend ffrac_active_lend_trim ffrac_active_lend_ifs, cut(0 99) replace


******************************************
/*Stock level HHI (based on families lending shares) */
bys ui_family ui_dscd datem: gen id_fam_sec = _n if ffrac_active_lend_comb > 0 & ffrac_active_lend_comb < .

gen temp_sh1_sq = ffrac_active_lend_comb^2 if id_fam_sec == 1
bys ui_dscd datem: gegen hhi_lend = sum(temp_sh1_sq)
drop temp*

rename hhi hhi_holding


******************************************
/*Fund lending portfolio concentration */
bys ui_fund datem: egen lsec_mv_lend_adj_sum = total(lsec_mv_lend_adj)
gen frac_lend_ptf = lsec_mv_lend_adj/lsec_mv_lend_adj_sum
replace frac_lend_ptf = 0 if frac_lend_ptf == . & lon_loan_fund != .

******************************************
/*Family lending portfolio concentration */
bys ui_family datem: egen lsec_mv_fam_lend_adj_sum = total(lsec_mv_lend_adj)
bys ui_family ui_dscd datem: egen lsec_mv_fam_lend_adj = total(lsec_mv_lend_adj)

gen ffrac_lend_ptf = lsec_mv_fam_lend_adj/lsec_mv_fam_lend_adj_sum
replace ffrac_lend_ptf = 0 if ffrac_lend_ptf == . & lon_loan_fam != .

foreach var of varlist *frac*ptf*{
	replace `var' = `var'*100
}

******************************************
/*HHI at family level */
gen temp_sh2_sq = ffrac_lend_ptf^2 if id_fam_sec == 1
bys ui_family datem: gegen hhi_family = sum(temp_sh2_sq)
drop temp*


******************************************
/*Stocks held by family */
bys ui_family datem: egen stocks_held = nvals(ui_dscd) if lsec_mv_adj != 0 & lsec_mv_adj != .
replace stocks_held = 1/stocks_held
replace stocks_held = stocks_held*10^4

gcollapse (max) stocks_held, by(ui_family datem) merge replace

******************************************
/*Stocks held by family */
bys ui_family datem: egen stocks_lend = nvals(ui_dscd) if lsec_mv_lend_adj != 0 & lsec_mv_lend_adj  != .
replace stocks_lend = 1/stocks_lend

gcollapse (max) stocks_lend, by(ui_family datem) merge replace
replace stocks_lend = 0 if stocks_lend == .
replace stocks_lend = stocks_lend*10^4

******************************************
/*We do not consider entries for the analysis*/
****************************************
qui drop if dum_entry == 1

******************************************
/*We only consider active funds for the analysis*/
****************************************
qui keep if dum_fund_active == 1


/*Episodes which include an immediate position reversal (we will not consider these)*/
**********************************************************
tsset ui_fund_sec datem
gen dum1 = (dpos_prc_nom_adj_99_5 == -50 & l.dpos_prc_nom_adj_99_5 == 100 & l.dpos_prc_nom_adj_99_5 != .)
gen dum2 = (dpos_prc_nom_adj_99_5 == 100 & F.dpos_prc_nom_adj_99_5 == -50 & dpos_prc_nom_adj_99_5 != .)

/*ESMA Sample*/
****************************************
gen esma_sample = (CountryofExchange == "Austria" | CountryofExchange == "Finland" | CountryofExchange == "France" ///
				 | CountryofExchange == "Germany" | CountryofExchange == "Ireland; Republic of" | CountryofExchange == "Italy" ///
				 | CountryofExchange == "Netherlands" | CountryofExchange == "Norway" | CountryofExchange == "Spain" ///
				 | CountryofExchange == "Sweden" | CountryofExchange == "United Kingdom" | CountryofExchange == "Sweden" | CountryofExchange == "Denmark")


****************************************
/*Label Variables*/
****************************************

/*Label Shorting Demand Variables*/
****************************************
label variable on_loan_mv "Market Value on Loan (as % of Market Cap)"
label variable lon_loan_mv "Lagged Market Value on Loan (as % of Market Cap)"
label variable lutilisation "Lagged Utilization Rate (Short Demand/Short Supply)"
label variable lln_vwaf_30_day "Lagged Log of Value-Weighted Lending Fee"
label variable first_LSP_6m "Dummy: Public Position Disclosure in current month"
label variable first_LSP_6m_post1 "Dummy: Public Position Disclosure in last month"
label variable first_LSP_6m_pre1 "Dummy: Public Position Disclosure in next month"

/*Label Lending Dummies*/
****************************************
label variable dum_fflend_12m "Dummy: Fund Family is lender (in last 12 month)"
label variable dum_flend_12m "Dummy: Fund is lender (in last 12 month)"
label variable dum_slend_12m "Dummy: Security lend out by fund once in last 12 months"
label variable dum_fund_active "Dummy: Active Fund"


/*Label control variables */
****************************************
label variable lpct_amihud_rank "Lagged Amihud Illiquidty Percentile Rank"
label variable ldpos_prc_nom_adj_99_5 "Lagged Position Change (in %)"
label variable lpos_w_developed "Lagged Portfolio Position Weight (in %)"



tsset ui_fund_sec datem

****************************************
/* De-Mean Short Interest (by active/passive funds) */
****************************************
gen lon_loan_mv_d = lon_loan_mv

qui sum lon_loan_mv 
replace lon_loan_mv_d = (lon_loan_mv_d - r(mean))/r(sd) 

label variable lon_loan_mv_d "Lagged Market Value on Loan (as % of Market Cap) in t-1"

***

gen on_loan_mv_d = on_loan_mv

qui sum on_loan_mv 
replace on_loan_mv_d = (on_loan_mv_d - r(mean))/r(sd) 

label variable on_loan_mv_d "Lagged Market Value on Loan (as % of Market Cap) in t"

***

gen lon_loan_fund_d = lon_loan_fund

qui sum lon_loan_fund
replace lon_loan_fund_d = (lon_loan_fund_d - r(mean))/r(sd) 

label variable lon_loan_fund_d "Amount on Loan of a given stock by a given fund"



***

qui sum frac_active_lend
gen frac_active_lend_d = (frac_active_lend - r(mean))/r(sd)

label variable frac_active_lend_d "Lending Share of Fund"

***

qui sum ffrac_active_lend_max
gen ffrac_active_lend_max_d = (ffrac_active_lend_max - r(mean))/r(sd)

label variable ffrac_active_lend_max_d "Lending Share of Family (max 100%)"

***

qui sum ffrac_active_lend_comb
gen ffrac_active_lend_comb_d = (ffrac_active_lend_comb - r(mean))/r(sd)

label variable ffrac_active_lend_comb_d "Lending Share of Family (comb 100%)"


***

qui sum frac_lend_ptf 
gen frac_lend_ptf_d = (frac_lend_ptf - r(mean))/r(sd)

label variable frac_lend_ptf_d "Share of Fund Lending Portfolio"

***

qui sum ffrac_lend_ptf 
gen ffrac_lend_ptf_d = (ffrac_lend_ptf - r(mean))/r(sd)

label variable ffrac_lend_ptf_d "Share of Family Lending Portfolio"


***

gen lon_loan_fam_d = lon_loan_fam

qui sum lon_loan_fam
replace lon_loan_fam_d = (lon_loan_fam_d - r(mean))/r(sd) 

label variable lon_loan_fam_d "Amount on Loan of a given stock by a given family"


***

gen hhi_lend_d = hhi_lend

qui sum hhi_lend_d
replace hhi_lend_d = (hhi_lend_d - r(mean))/r(sd) 

label variable hhi_lend_d "HHI Lending Index"

***

gen hhi_family_d = hhi_family

qui sum hhi_family_d
replace hhi_family_d = (hhi_family_d - r(mean))/r(sd) 

label variable hhi_family_d "HHI Family Index"

***

gen stocks_held_d = stocks_held

qui sum stocks_held_d
replace stocks_held_d = (stocks_held_d - r(mean))/r(sd) 

label variable stocks_held_d "1/Stocks Held by Family f"

***

gen stocks_lend_d = stocks_lend

qui sum stocks_lend_d
replace stocks_lend_d = (stocks_lend_d - r(mean))/r(sd) 

label variable stocks_lend_d "1/Stocks Lend by Family f"

***

gen lactive_agents_Mmean_d = lactive_agents_Mmean

qui sum lactive_agents_Mmean_d
replace lactive_agents_Mmean_d = (lactive_agents_Mmean_d - r(mean))/r(sd) 

label variable lactive_agents_Mmean_d "Active Lending Agents"


******************************************************************************************************************************
******************************************************************************************************************************

*********************************************
*********************************************
/* Part II: Regression Analysis of Fund Holdings */
*********************************************
*********************************************
capture mkdir "${results}"
cd "${results}"

tsset ui_fund_sec datem

****************************************
/* Define macros which contain lists of:
	- Position Changes, Exit Dummy, Position Changes w/o exits (LHS dependent variable)
	- lending market demand variables (main RHS variable of interest)
	- fund-security level controls (other RHS variables) */
****************************************
global dependent "dpos_prc_nom_adj_99_5" // dum_exit" //"dpos_prc_nom_adj_99_5 dpos_prc_nom_adj_99_5 dum_exit stock_alpha_c4_pred_l1u99"
global SD "lon_loan_fund_d" // choose: lon_loan_mv lutilisation lln_vwaf ldcbs
global fund_sec_controls "c.lpct_amihud_rank c.lpos_w_developed_adj"
global fixed_effects "ui_sec_datem ui_fund_datem ui_fund_sec"
global clustvar "ui_fund datem"


****************************************
/*Run regressions for each dependent variable (Position Changes, Exit Dummy, Position Changes w/o exits)
  and each lending market demand variable (Market Capitalzation on Loan)*/
****************************************
foreach s of global SD{
	local counting = 0
	
	foreach d of global dependent{
		
		*Clear estimates, scalars and placeholders
		****************************************
		est clear
		scalar drop _all
		
	
		****************************************
		*1.Regression: Baseline Regression (no FE)
		****************************************
		reghdfe `d' c.lon_loan_fam_d##c.first_LSP_6m_pre1 ${fund_sec_controls} if dum_exit == 0 & disclosure_sample == 1 & ever_LSP == 1 & first_LSP_6m_pre1 != . & lon_loan_fund != ., absorb(${fixed_effects}) cluster(${clustvar})
		est store reg_dpos_pool_1
	
		****************************************
		*2.Regression: IA with Stock HHI
		****************************************
		reghdfe `d' c.lon_loan_fam_d##c.hhi_lend_d ${fund_sec_controls} if dum_exit == 0 & disclosure_sample == 1 & ever_LSP == 1 & first_LSP_6m_pre1 != . & lon_loan_fund != ., absorb(${fixed_effects}) cluster(${clustvar})
		est store reg_dpos_pool_2

		****************************************
		*3.Regression: Include Post Disclosure
		****************************************
		reghdfe `d' c.lon_loan_fam_d##c.hhi_lend_d##c.first_LSP_6m_pre1 ${fund_sec_controls} if dum_exit == 0 & disclosure_sample == 1 & ever_LSP == 1 & first_LSP_6m_pre1 != . & lon_loan_fund != ., absorb(${fixed_effects}) cluster(${clustvar})
		est store reg_dpos_pool_3
		
		****************************************
		*4.Regression: IA with Active Agents
		****************************************
		reghdfe `d' c.lon_loan_fam_d##c.lactive_agents_Mmean_d ${fund_sec_controls} if dum_exit == 0 & disclosure_sample == 1 & ever_LSP == 1 & first_LSP_6m_pre1 != . & lon_loan_fund != ., absorb(${fixed_effects}) cluster(${clustvar})
		est store reg_dpos_pool_4

		****************************************
		*5.Regression: Include Post Disclosure
		****************************************
		reghdfe `d' c.lon_loan_fam_d##c.lactive_agents_Mmean_d##c.first_LSP_6m_pre1 ${fund_sec_controls} if dum_exit == 0 & disclosure_sample == 1 & ever_LSP == 1 & first_LSP_6m_pre1 != . & lon_loan_fund != ., absorb(${fixed_effects}) cluster(${clustvar})
		est store reg_dpos_pool_5
		
			
		****************************************
		*6.Regression: IA with Family HHI
		****************************************
		reghdfe `d' c.lon_loan_fam_d##c.hhi_family_d ${fund_sec_controls} if dum_exit == 0 & disclosure_sample == 1 & ever_LSP == 1 & first_LSP_6m_pre1 != . & lon_loan_fund != ., absorb(${fixed_effects}) cluster(${clustvar})
		est store reg_dpos_pool_6

		****************************************
		*7.Regression: Include Post Disclosure
		****************************************
		reghdfe `d' c.lon_loan_fam_d##c.hhi_family_d##c.first_LSP_6m_pre1 ${fund_sec_controls} if dum_exit == 0 & disclosure_sample == 1 & ever_LSP == 1 & first_LSP_6m_pre1 != . & lon_loan_fund != ., absorb(${fixed_effects}) cluster(${clustvar})
		est store reg_dpos_pool_7
		
		****************************************
		*6.Regression: IA with Stocks Held
		****************************************
		reghdfe `d' c.lon_loan_fam_d##c.stocks_held_d ${fund_sec_controls} if dum_exit == 0 & disclosure_sample == 1 & ever_LSP == 1 & first_LSP_6m_pre1 != . & lon_loan_fund != ., absorb(${fixed_effects}) cluster(${clustvar})
		est store reg_dpos_pool_8

		****************************************
		*7.Regression: Include Post Disclosure
		****************************************
		reghdfe `d' c.lon_loan_fam_d##c.stocks_held_d##c.first_LSP_6m_pre1 ${fund_sec_controls} if dum_exit == 0 & disclosure_sample == 1 & ever_LSP == 1 & first_LSP_6m_pre1 != . & lon_loan_fund != ., absorb(${fixed_effects}) cluster(${clustvar})
		est store reg_dpos_pool_9
		
		****************************************
		*6.Regression: IA with Stocks Lend
		****************************************
		reghdfe `d' c.lon_loan_fam_d##c.stocks_lend_d ${fund_sec_controls} if dum_exit == 0 & disclosure_sample == 1 & ever_LSP == 1 & first_LSP_6m_pre1 != . & lon_loan_fund != ., absorb(${fixed_effects}) cluster(${clustvar})
		est store reg_dpos_pool_10

		****************************************
		*7.Regression: Include Post Disclosure
		****************************************
		reghdfe `d' c.lon_loan_fam_d##c.stocks_lend_d##c.first_LSP_6m_pre1 ${fund_sec_controls} if dum_exit == 0 & disclosure_sample == 1 & ever_LSP == 1 & first_LSP_6m_pre1 != . & lon_loan_fund != ., absorb(${fixed_effects}) cluster(${clustvar})
		est store reg_dpos_pool_11
		
		****************************************
		*Output Control (only for the most extensive specification)
		****************************************
		if "${output_check}" == "Yes"{
			nobsreg ui_family
		}

		
		****************************************
		/*Export Change in Position (Active Sample - Disclosure)*/
		****************************************
		esttab reg_dpos_pool* using "temp.csv", b(4) t(2) star(* 0.10 ** 0.05 *** 0.01) /// 
		stats(r2 r2_a r2_within r2_a_within N absvars clustvar, /// 
		fmt(%9.4g %9.4g %9.4g %9.4g %16.0g %16.0g %9.4g %9.4g) ///
		)  nodepvars nocons noomitted nobase label replace ///

		preserve
		clear
		insheet using temp.csv
		
		export excel using "${datum}_Holdings_FamMarketPower_T9.xlsx", sheet("NEW Table 9 - F,T") sheetmodify   cell(B5)
		restore
		erase temp.csv
	}
}

	

	
******************************************************************************************************************************
*** EOF
******************************************************************************************************************************

		
