******************************************************************************************************************************
******************************************************************************************************************************
***
*** Number of project:		2016\0082				
*** Title of project:		Securities lending by mutual funds
*** Data source: 			Investment Fund Statistics (December 2009 until December 2018; December 2014-December 2018 is used for analysis
*** Name of programme code:	C3b_Holdings_SecLend_SPILLOVER.do
***
*** Purpose of programme code: Panel Regressions with lending dummies defined on the security-, fund-, and fund family-level (to capture spillovers)
***			Part I: 	
***			Part II: 	
***			Part III:	
***			Part IV: 	
***
******************************************************************************************************************************
******************************************************************************************************************************

/* Paths : */

*Comment next two lines out when running code via the master file (information comes from there in this case)
*global datum 				= 	"20200416"				/* Date in the form yyyymmdd */
*global proj_num			=	"2016_0082r"			/* Please spezify project number with underscore */

global path					= 	"R:/Zentrale/ZB-S/Daten_FDSZ_Gastforscher/1_gafo/${proj_num}"

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

global event_window = "6"


******************************************************************************************************************************
******************************************************************************************************************************

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


*Index Exclusion Months
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

****************************************
*Stocks without any net short position disclosure -> fill up with 0's
****************************************
replace dum_large_LSP  = 0 if _merge == 1
drop _merge


*********************************************
/*Additional Variables*/
*********************************************
tsset ui_fund_sec datem

*Lagged Lending Dummies
*********************************************
foreach var of varlist dum_flend* dum_slend*{
	gen l`var' = l.`var'
	}
	
	
******************************************************************************************************************************
******************************************************************************************************************************
/* Part II: Define Disclosure Events */
******************************************************************************************************************************
******************************************************************************************************************************

*********************************************
/*Keep Necessary Variables*/
*********************************************
keep ui_fund_sec FundId DSCD sec_isin_historic ui_fund ui_dscd ui_family lon_loan_mv datem lMV_eur ldum_flend* ldum_slend* lsec_mv lNOMSTUECK* ///
	 lUP_eur holding_time dum_fund_active lln_* *relflow lCost* lturnover l*r2* l*alpha* first_LSP* 
	 
*********************************************
*Only active funds
*********************************************
qui keep if dum_fund_active == 1

*********************************************
*Keep Big Short Disclosures
*********************************************
qui keep if first_LSP_6m  == 1

*********************************************
*Keep if disclosure is before July 2018 (to have the full 6 months after the disclosure)
*********************************************
qui drop if datem > tm(2018m6)

*********************************************
*Rename (all variables are measured one month prior to the disclosure, i.e. rename to varname_pre_disc
*********************************************
rename lon_loan_mv SIR_pre_disc
rename lsec_mv pos_mv_pre_disc
rename lNOMSTUECK_adj pos_nom_pre_disc
rename lNOMSTUECK_WPLEI pos_nom_lend_pre_disc
rename lUP_eur lUP_pre_disc
rename lln_MV ln_mv_pre_disc
rename lMV_eur mv_pre_disc
rename lln_BM ln_bm_pre_disc
rename lln_amihud ln_amihud_pre_disc
rename lln_spread ln_spread_pre_disc
rename lln_sd_idio ln_sd_idio_pre_disc
rename lln_nav ln_nav_pre_disc
rename lln_fund_family_nav ln_fund_family_nav_pre_disc
rename lturnover turnover_pre_disc
rename lfund_net_r2_c4 r2_fund_pre_disc
rename lfund_net_alpha_c4_past fund_net_alpha_c4_pre_disc
rename lCostsExTrFees FundCosts_pre_disc
rename lln_age fund_age_pre_disc
rename lrelflow relflow_pre_disc
rename sec_isin_historic isin



*********************************************
*Disclosure Event Identifier
*********************************************
sort ui_fund_sec datem
gen event_id = _n


******************************************************************************************************************************
******************************************************************************************************************************
/* Part III: Span Exit Events to Panel */
******************************************************************************************************************************
******************************************************************************************************************************

*********************************************
/*For each event, define event time start and end date (+/- 12 months around the event)*/
*********************************************

/*Expand all observations*/
*********************************************
expand 2, gen(temp_expand)

/*What is the exit month?*/
*********************************************
gen disclosure_month = datem
format disclosure_month %tm

/*Non-expanded observation is start date (i.e. 6 months prior to disclosure month + 1 more month to get base category for event-time regressions)*/
*********************************************
replace datem = datem - ${event_window} - 1 if temp_expand == 0

/*Expanded observation is end date (i.e. 12 months after to exit month)*/
*********************************************
replace datem = datem + ${event_window} if temp_expand == 1

*********************************************
/*Span a panel of +/- 6 months around the disclosure*/
*********************************************
tsset event_id datem
tsfill

*Fill in missing numeric values*
**********************************************************
foreach var of varlist ui_fund_sec ui_fund ui_dscd ui_family disclosure_month ldum_flend* ldum_slend* holding_time dum_fund_active *_pre_disc{
	bys event_id: replace `var' = l.`var' if `var' == .
}

*Fill in missing string values*
**********************************************************
foreach var of varlist DSCD FundId isin{
	bys event_id: replace `var' = `var'[_n-1] if `var' == ""
}

*All months which are not the disclosure month (for a given event) have disclosure dummy equal to 0
**********************************************************
replace first_LSP_6m = 0 if datem != disclosure_month
replace first_LSP_6m = 1 if datem == disclosure_month
drop temp_expand

**********************************************************
/*Define disclosure event time (from -6 to +6)*/
**********************************************************
sort event_id datem
bys event_id: gen disclosure_event_time = _n
replace disclosure_event_time = disclosure_event_time - 8

******************************************************************************************************************************
******************************************************************************************************************************
/* Part III: Add stock holdings information to disclosure events panel*/
******************************************************************************************************************************
******************************************************************************************************************************

**********************************************************
*Add Holding Position (from original Holdings Data Set)
**********************************************************
cd "${data_for_analysis}"
merge m:1 ui_fund_sec datem using "B3_Panel_EquityFunds_FinalMerge_AddVar_2014m12on_Dec22.dta", ///
		  keepusing(NOMSTUECK_adj NOMSTUECK_WPLEI KURSPREIS dpos_prc_nom_adj_99_5 /// 
		  dum_flend_now sec_mv dum_exit dum_entry lln_fund_family_nav lln_nav lln_age ///
		  lrelflow lCostsExTrFees lfund_net_alpha_c4_pred lfund_net_r2_c4 lturnover)

/*Drop all fund-stock months which do not fall within an exit event period*/
**********************************************************
qui drop if _merge == 2		
drop _merge


**********************************************************
*Figure 3 Filters
**********************************************************

/*Did Fund hold position in t-6 prior to the disclosure? (he can exit at some point but we require him to have the position in t-6)*/
**********************************************************
tsset event_id disclosure_event_time

*Tag if fund has position in t-6
gen dum_holding_6m = .
replace dum_holding_6m = 1 if NOMSTUECK_adj != . & disclosure_event_time == -6
replace dum_holding_6m = 0 if NOMSTUECK_adj == . & disclosure_event_time == -6

*Expand tag to all observations for a given event
bys event_id: egen dum_eligible = min(dum_holding_6m)


/*Episodes which include an entry (we will not consider these)*/
**********************************************************
bys event_id: egen any_entry = max(dum_entry)

*Overlap between last two tags?
tab dum_eligible any_entry


/*Episodes which include an immediate position reversal (we will not consider these)*/
**********************************************************
tsset event_id disclosure_event_time
gen dum1 = (dpos_prc_nom_adj_99_5 == -50 & l.dpos_prc_nom_adj_99_5 == 100 & l.dpos_prc_nom_adj_99_5 != .)
gen dum2 = (dpos_prc_nom_adj_99_5 == 100 & F.dpos_prc_nom_adj_99_5 == -50 & dpos_prc_nom_adj_99_5 != .)

*Any reversal of either kind? -> tag
egen sum_dum = rowtotal(dum1-dum2)
bys event_id: egen dum_drop = total(sum_dum)

**********************************************************
*Position Changes (cumulative & normalized)
**********************************************************
sort event_id disclosure_event_time
bys event_id: gen cpos_change = sum(dpos_prc_nom_adj_99_5)

gen dpos_normalized = dpos_prc_nom_adj_99_5
replace dpos_normalized = 0 if disclosure_event_time == -7



**********************************************************
*Add Eikon Information
**********************************************************
cd "${data_for_analysis}/03_DS_Eikon"
merge m:1 datem DSCD using "DS_ts_allvars_varcalc_Jul20.dta"

qui drop if _merge == 2
*drop stock_alpha* cum_alpha_6m

*Only keep exit events with complete Eikon return information
**********************************************************

*Are all observations of an event matched?
bys event_id: egen mean_merge = mean(_merge)

*If this is the case, _merge is on average 3 -> dummy equal to one
gen complete_information = (mean_merge == 3)
tab complete_information

*If this is not the case, dummy equal to zero -> drop whole event
qui drop if complete_information == 0
drop _merge mean_merge complete_information


**********************************************************
*Fama-French Factors
**********************************************************
cd "${data_for_analysis}/05_FF"
merge m:1 datem using "Fama_French_factors_EUR.dta"

quietly drop if _merge == 2
drop _merge


**********************************************************
*Stock Alpha with betas estimated 13 months prior to the disclosure (i.e. no interference with the event period)
**********************************************************
foreach var of varlist l13stock*{
	*In the exit month, what is the factor loading 12 months before?
	**********************************************************
	gen temp = `var' if disclosure_event_time == 0
	*local varname = substr("`var'", 1, length("`var'") - 5)
	
	*Assign this factor loading to all observations of an event id
	**********************************************************
	bys event_id: egen `var'_event = min(temp)
	drop temp
}

tsset event_id datem

*We calculate alphas based on regional factors
**********************************************************
gen xret = ret_eur - rf_EUR_MM_Buba
gen ret_mkt_adj = .
gen alpha_stock_c4 = .

forvalues r = 1(1)5{ 
	
	*Which region?
	**********************************************************
	if `r' == 1{
		local region = "AsiaPac_exJP"
		}
	else if `r' == 2{
		local region = "Europe"
		}
	else if `r' == 3{
		local region = "Global"
		}
	else if `r' == 4{
		local region = "Japan"
		}
	else if `r' == 5{
		local region = "North_America"
		}

	di "`region'"
	
	*Market Adjusted Return: Stock return minus regional market factor
	**********************************************************
	replace ret_mkt_adj = ret_eur - mkt_`region'_EUR
	
	*Carhart 4-Factor Alpha with regional factors
	**********************************************************
	replace alpha_stock_c4 = xret - (l13stock_beta_c4_mktrf_event*mktrf_`region'_EUR + l13stock_beta_c4_smb_event*smb3_`region'_EUR + ///
					 l13stock_beta_c4_hml_event*hml3_`region'_EUR + l13stock_beta_c4_wml_event*wml_`region'_EUR )

}


**********************************************************
*Cumulative Returns
**********************************************************
foreach var of varlist ret_eur ret_mkt_adj alpha_stock*{

	*Cumulative Return from t-6 to t+6
	**********************************************************
	sort event_id disclosure_event_time
	bys event_id: gen c`var' = sum(`var') if disclosure_event_time >= -${event_window} & disclosure_event_time < . & `var' != .
	
	*Cumulative Return from t-6 to t+6 (normalized to have cumulative return equal to zero at t=0 as the base category for the regressions)
	**********************************************************
	sort event_id disclosure_event_time
	bys event_id: gen c`var'_sum = sum(`var') if disclosure_event_time >= -${event_window} & disclosure_event_time <= 0 & `var' != .
	bys event_id: gen c`var'_temp = c`var'_sum if disclosure_event_time == 0 
	bys event_id: egen c`var'_at_disclosure = min(c`var'_temp)
	bys event_id: gen c`var'_normalized = c`var' - c`var'_at_disclosure
	drop c`var'_sum c`var'_temp c`var'_at_disclosure

}


******************************************************************************************************************************
******************************************************************************************************************************
/* Part IV: Save Disclosure Event Sample */
******************************************************************************************************************************
******************************************************************************************************************************

*Only keep observations within the sample period (December 2014 - December 2018)
**********************************************************
qui drop if datem > tm(2018m12)
qui drop if datem < tm(2014m12)

*Save disclosure events (unbalanced sample)
**********************************************************
cd "${data_for_analysis}"
compress

describe
sum _all

tab datem
tab disclosure_event_time

save "C5_Disclosure_Events_Sample_Dec22.dta", replace


******************************************************************************************************************************
*** EOF
******************************************************************************************************************************




/******************************************************************************************************************************
******************************************************************************************************************************
/* Part V: Analyze Abnormal Returns & Position Changes surrounding a disclosure */
******************************************************************************************************************************
******************************************************************************************************************************

capture mkdir "${path}${results}\\${datum}"
cd "${path}${results}\\${datum}"

replace disclosure_event_time = disclosure_event_time + 7

  
/*Keep if event is within sample period*/
**********************************************************
drop if datem < tm(2014m12)
drop if datem > tm(2018m12)


*Reversal Filter
*************************************
global reversal "if dum1 == 0 & dum2 == 0"		//leave empty "" if no reversal filter is applied
*global reversal ""


*Penny Stock Filter
*************************************
*global penny_stock "& penny_stock >= 5 & penny_stock < ."		//leave empty "" if no penny stock filter is applied
global penny_stock ""

est clear

**********************************************************
**********************************************************
/*Pre- and Post-Disclsoure Position Changes*/
**********************************************************
**********************************************************

reghdfe dpos_normalized ib0.disclosure_event_time##i.ldum_slend_12m ${reversal} ${penny_stock} & dum_entry == 0, cluster(DSCD) abs(ui_fund ui_dscd datem ldum_slend_12m) nocons
est store reg_disc_pos
nobsreg ui_family

*Output Control (only for the most extensive specification)
****************************************
if "$output_check" == "Yes"{
	nobsreg ui_family
}

*Compute sum of coefficients (=marginal effects) based on regression results conditional on stock lend
****************************************
margins, at(ldum_slend_12m == 1) over(disclosure_event_time) post
est store margin_disc_pos_lend


****************************************
/*Export Results for Stocks Exited */
****************************************
esttab reg_disc_pos margin_disc_pos_lend  using "temp.csv", b(4) t(2) star(* 0.10 ** 0.05 *** 0.01) /// 
										  stats(absvars clustvar, /// 
										  fmt(%9.4g %9.4g %9.4g %9.4g %16.0g %16.0g %9.4g %9.4g)) ///
										  nodepvars noomitted unstack label replace 


*Import Output file for cleaning
****************************************
preserve
clear
insheet using temp.csv

*Clean Output (omitted variables due to collinearity)
****************************************
drop if v2 == "" & v3 == ""
									
*Export Excel File
****************************************	
export excel using "${datum}_Disclosure_PosChange_Graph.xlsx", sheet("PosChanges_Disclosure_noPenny") sheetmodify cell(B5)
erase "temp.csv"
restore	



**********************************************************
**********************************************************
/*Pre- and Post-Disclsoure Abnormal Returns*/
**********************************************************
**********************************************************

reghdfe calpha_stock_c4_normalized ib7.disclosure_event_time##i.ldum_slend_12m if SI_all_5 == 5, cluster(DSCD) abs(ui_fund ui_dscd ldum_slend_12m) nocons
est store reg_disc_ret
nobsreg ui_family

*Output Control (only for the most extensive specification)
****************************************
if "$output_check" == "Yes"{
	nobsreg ui_family
}

*Compute sum of coefficients (=marginal effects) based on regression results conditional on stock lend
****************************************
margins, at(ldum_slend_12m == 1) over(disclosure_event_time) post
est store margin_disc_ret_lend

****************************************
/*Export Results for Stocks Exited */
****************************************
esttab reg_disc_ret margin_disc_ret_lend  using "temp.csv", b(4) t(2) star(* 0.10 ** 0.05 *** 0.01) /// 
										  stats(absvars clustvar, /// 
										  fmt(%9.4g %9.4g %9.4g %9.4g %16.0g %16.0g %9.4g %9.4g)) ///
										  nodepvars noomitted unstack label replace 
										  
*Import Output file for cleaning
****************************************
preserve
clear
insheet using temp.csv

*Clean Output (omitted variables due to collinearity)
****************************************
drop if v2 == "" & v3 == ""
									
*Export Excel File
****************************************	
export excel using "${datum}_Disclosure_Return_Graph.xlsx", sheet("All_HighSI") sheetmodify cell(B5)
erase "temp.csv"
restore	



******************************************************************************************************************************
******************************************************************************************************************************
/* Part V: Analyze Abnormal Returns & Position Changes surrounding a disclosure */
******************************************************************************************************************************
******************************************************************************************************************************

/*Rescale variables to %*/
**********************************************************
replace calpha_stock_c4_normalized = calpha_stock_c4_normalized*100
replace relflow_pre_disc = relflow_pre_disc*100
replace FundCosts_pre_disc = FundCosts_pre_disc*100
replace fund_net_alpha_c4_pre_disc = fund_net_alpha_c4_pre_disc*100
replace r2_fund_pre_disc = r2_fund_pre_disc*100

sum SIR_pre_disc
gen SIR_d = SIR_pre_disc - `r(mean)'


/*Label Variables*/
**********************************************************
label variable ldum_slend_12 "Security lend out by fund once in last 12 months (prior to discexit)"
label variable SIR_d "Short Interest Ratio (prior to disc)"
label variable ln_fund_family_nav_pre_disc "Log of Fund Family TNA (prior to disc)"
label variable ln_nav_pre_disc "Log of Fund TNA (prior to disc)"
label variable fund_age_pre_disc "Log of Fund Age (prior to disc)"
label variable relflow_pre_disc "Relative net flow (prior to disc)"
label variable FundCosts_pre_disc "Fund Costs (prior to disc)"
label variable turnover_pre_disc "Fund Turnover (prior to disc)"
label variable r2_fund_pre_disc "R^2 Fama-French 3 Factors + Momentum (prior to disc)"
label variable fund_net_alpha_c4_pre_disc "Fund Net Alpha Fama-French 3 Factors + Momentum (prior to disc)"


/*Define Control Variables*/
********************************************************** 
global fund_controls "ln_fund_family_nav_pre_disc ln_nav_pre_disc fund_age_pre_disc relflow_pre_disc FundCosts_pre_disc fund_net_alpha_c4_pre_disc r2_fund_pre_disc turnover_pre_disc"

capture mkdir "${path}${results}\\${datum}"
cd "${path}${results}\\${datum}"

**********************************************************
/*Regression - Sample All Active Lenders, Dep.Var Cumulative 6-month Alpha*/
**********************************************************
eststo reg_disc_tfe_6_lender: reghdfe calpha_stock_c4_normalized  i.ldum_slend_12m##c.SIR_d  ${fund_controls} if disclosure_event_time == 13 , absorb(disclosure_month) cluster(ui_dscd)
eststo reg_disc_ffe_6_lender: reghdfe calpha_stock_c4_normalized  i.ldum_slend_12m##c.SIR_d  ${fund_controls} if disclosure_event_time == 13 , absorb(ui_fund disclosure_month) cluster(ui_dscd)
eststo reg_disc_ftfe_6_lender: reghdfe calpha_stock_c4_normalized  i.ldum_slend_12m##c.SIR_d  ${fund_controls} if disclosure_event_time == 13, absorb(ui_fund##disclosure_month) cluster(ui_dscd)

*Output Control (only for the most extensive specification)
****************************************
if "$output_check" == "Yes"{
	nobsreg ui_family
}

**********************************************************
/*Export Regression Results for all lenders*/
**********************************************************
esttab reg_disc_*_6_lender  using "temp.csv",  order(1.ldum_slend_12m#SIR_d  1.ldum_slend_12m SIR_d) /// 
											   b(4) t(2) star(* 0.10 ** 0.05 *** 0.01) /// 
											   stats(r2 r2_a r2_within r2_a_within N absvars clustvar, /// 
											   fmt(%9.4g %9.4g %9.4g %9.4g %16.0g %16.0g %9.4g %9.4g)) ///
											   nodepvars nocons noomitted label replace

preserve
clear
insheet using temp.csv
drop if v2 == "" & v3 == "" & v4 == "" 
drop if regexm(v1, "=0") == 1 | regexm(v1[_n-1], "=0") == 1
export excel using "${datum}_Disclosure_Event_Reg.xlsx", sheet("Regression_C4") sheetmodify   cell(B5)
erase temp.csv
restore




******************************************************************************************************************************
*** EOF
******************************************************************************************************************************

