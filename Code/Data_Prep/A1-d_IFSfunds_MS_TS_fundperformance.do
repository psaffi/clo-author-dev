
******************************************************************************************************************************
******************************************************************************************************************************
***
*** Number of project:		2016\0082				
*** Title of project:		Securities lending by mutual funds
*** Data source: 			Investment Fund Statistics (Original Data is December 2009 until December 2018; June 2014 until December 2018 is kept for analysis)
*** Name of programme code:	A1-d_IFSfunds_MS_TS_fundperformance_2019-11-06_sg.do
***
*** Purpose of programme code: 
***			Part I: 	Combine Static & Time Series Fund Information
***			Part II: 	Calculate Fund Alpha (Abnormal Performance) based on the Carhart 4-Factor model
***			Part III:	Final adjustments to data & save data
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

******************************************************************************************************************************
******************************************************************************************************************************

*********************************************
*********************************************
/* Part I: Combine Static & Time Series Fund Information*/
*********************************************
*********************************************


****************************************
/* Use Morningstar static fund information (matched to IFS funds) */
****************************************
cd "${data_for_analysis}/01_IFS"
use "A1-b_Panel_IFS_MS_FundID_Char_2009m9_2018m12_Apr20.dta", clear
keep FundId GlobalBroadCategoryGroup GlobalCategory
duplicates drop


****************************************
/* Merge to Morningstar TS fund information */
****************************************
cd "${data_for_analysis}/01_IFS"
merge 1:m FundId using "A1-c_Panel_IFS_MS_FundID_TS_2009m9_2018m12_Apr20.dta", keepusing(datem GrossReturn TotalReturn)
qui drop if _merge == 1
drop _merge


****************************************
/* Keep only German-Based Equity Funds according to Morningstar Category */
****************************************
qui keep if GlobalBroadCategoryGroup == "Equity"
drop GlobalBroadCategoryGroup

****************************************
/* Create Fund Identifier (for tsset) */
****************************************
egen ui_fund = group(FundId)

****************************************
/*FILTER: Alphas Needed from June 2014 onwards;
  3-year estimation period, i.e. drop anything prior to June 2011*/
****************************************
qui drop if datem <tm(2011m6)


****************************************
/*Create Variable for Fund Investment Region;
  Alphas are calculated with region-specific factors for each investment region*/
****************************************
tab GlobalCategory

gen InvestmentRegion = ""
replace InvestmentRegion = "Europe" if regexm(GlobalCategory, "Europe") == 1 | regexm(GlobalCategory, "UK Equity") == 1
replace InvestmentRegion = "Japan" if regexm(GlobalCategory, "Japan") == 1 & regexm(GlobalCategory, "-ex-Japan") == 0
replace InvestmentRegion = "Global" if regexm(GlobalCategory, "Global") == 1
replace InvestmentRegion = "North_America" if regexm(GlobalCategory, "US Equity") == 1

replace InvestmentRegion = "AsiaPac_exJP" if regexm(GlobalCategory, "Asia") == 1
replace InvestmentRegion = "AsiaPac_exJP" if regexm(GlobalCategory, "Australia") == 1
replace InvestmentRegion = "AsiaPac_exJP" if regexm(GlobalCategory, "New Zealand") == 1

tab GlobalCategory, miss
tab GlobalCategory if InvestmentRegion == "", miss		//we do not define an Investment Region for Sector Funds or Emerging Market Funds because those are dropped later on

label variable InvestmentRegion "Fund: Investment Region"

****************************************
/*Fill Up Observations to Have Balanced Time Series (only for the regressions)*/
****************************************
tsset ui_fund datem
tsfill, full

*Label observations which are filled in after tsfill --> so that we know which observations we drop again later on
****************************************
gen filled_obs = (FundId == "")

*Fill in missing obs after tsfill
****************************************
foreach var of varlist GlobalCategory FundId InvestmentRegion{
	
	*For each fund, identify the respective value for each variable (all variables are static so value does not change, i.e. use egen = mode())
	bys ui_fund: egen temp = mode(`var')
	
	*Fill in missing observation for tsfilled-values with value of original observations (identified through egen = mode())
	replace `var' = temp if `var' == ""
	drop temp
}

****************************************
/* Merge with Fama-French factors */
****************************************
cd "${data_for_analysis}/05_FF"
merge m:1 datem using "Fama_French_factors_EUR.dta"
tab _merge 

qui drop if _merge == 2 /*using only, i.e. months with only FF factors, but no fund returns (before 2009m9!)*/
drop _merge


******************************************************************************************************************************
******************************************************************************************************************************

*********************************************
*********************************************
/* Part II: Calculate fund Alphas (based on Gross and Net Returns) */
*********************************************
*********************************************
tsset ui_fund datem

*********************************************
/*Carhart model (c4) */
*********************************************
foreach var of varlist GrossReturn TotalReturn{

	/*Calculate Excess return*/
	****************************************
	gen xret = `var' - rf_EUR_MM_Buba

	foreach region in "Europe" "Japan" "Global" "North_America" "AsiaPac_exJP" {

		/*Create empty vars for N, error code, R^2 */
		****************************************
		capture drop xret_*
		capture gen xret_n = .
		capture gen xret_err = .
		capture gen xret_r2 = .

		/*Fast rolling regression (36 month window, fund-by-fund)*/
		****************************************
		fastrollreg xret mktrf_`region'_EUR smb3_`region'_EUR hml3_`region'_EUR wml_`region'_EUR , /// 
		window(36) increment(1) panelvar(ui_fund) coeff(auto) rsq(auto) err(auto) obs(auto)

		/*Correct intercept, coefficients, and R^2 to missing if not enough observations (less than 24 out of 36 return observations) */ 
		****************************************
		foreach x of varlist *_b *_r2{
			display "====================================================="
			display "Correct variable: `x'"
			replace `x' = . if xret_n <24
			replace `x' = . if xret_err == 999
		}
		/**/
	 
		/*Rename variables */
		****************************************
		rename c_b c_b_`region'
		rename xret_n xret_c4_n_`region'
		rename xret_err xret_err_`region' 
		
		if "`var'" == "GrossReturn"{
			rename xret_r2 gr2_c4_`region'
		}
		
		else if "`var'" == "TotalReturn"{
			rename xret_r2 nr2_c4_`region'
		}

		
		/* Calculate historical alpha (given by the intercept -> average alpha of past 36 months) */
		****************************************
		display "====================================================="
		display "Compute alpha (past 36 months) "
		
		if "`var'" == "GrossReturn"{
			gen galpha_past_c4_`region' = c_b_`region'
		}
		
		else if "`var'" == "TotalReturn"{
			gen nalpha_past_c4_`region' = c_b_`region'
		}
		
		/* Calculate alpha (one-month ahead prediction based on coefficients estimated up to month t-1 and factor returns in month t) */
		****************************************
		display "Compute alpha (one-month ahead prediction) "
		
		if "`var'" == "GrossReturn"{
			gen galpha_pred_c4_`region' = xret - ///
							(l.mktrf_`region'_EUR_b*mktrf_`region'_EUR + l.smb3_`region'_EUR_b*smb3_`region'_EUR + ///
							 l.hml3_`region'_EUR_b*hml3_`region'_EUR + l.wml_`region'_EUR_b*wml_`region'_EUR )
		}
		
		else if "`var'" == "TotalReturn"{
			gen nalpha_pred_c4_`region' = xret - ///
							(l.mktrf_`region'_EUR_b*mktrf_`region'_EUR + l.smb3_`region'_EUR_b*smb3_`region'_EUR + ///
							 l.hml3_`region'_EUR_b*hml3_`region'_EUR + l.wml_`region'_EUR_b*wml_`region'_EUR )
		}
		
		/*Drop Coefficients*/
		****************************************
		capture drop *_b
		capture drop c_b_*
	}
	drop xret
}
/**/



*********************************************
/*Assign Alpha and R-Squared by Investment Region*/
*********************************************
gen fund_gross_alpha_c4_past = .
gen fund_net_alpha_c4_past = .
gen fund_gross_alpha_c4_pred = .
gen fund_net_alpha_c4_pred = .
gen fund_gross_r2_c4 = .
gen fund_net_r2_c4 = .

foreach x in "Europe" "Global" "North_America" "AsiaPac_exJP" "Japan"{
	replace fund_gross_alpha_c4_past = galpha_past_c4_`x' if InvestmentRegion == "`x'"
	replace fund_net_alpha_c4_past = nalpha_past_c4_`x' if InvestmentRegion == "`x'"
	replace fund_gross_alpha_c4_pred = galpha_pred_c4_`x' if InvestmentRegion == "`x'"
	replace fund_net_alpha_c4_pred = nalpha_pred_c4_`x' if InvestmentRegion == "`x'"
	replace fund_gross_r2_c4 = gr2_c4_`x' if InvestmentRegion == "`x'"
	replace fund_net_r2_c4 = nr2_c4_`x' if InvestmentRegion == "`x'"
}
/**/


*********************************************
*********************************************
/* Part III: Final Adjustments and Save Data*/
*********************************************
*********************************************


*********************************************
/*FILTER: Sample for analysis starts in June 2014 (also drop observations previously filled in with tsfill)*/
*********************************************	
qui drop if datem <tm(2014m6)
qui drop if filled_obs == 1


*********************************************
/*Keep Alphas and R2 for Funds*/
*********************************************	   
keep datem FundId fund_gross* fund_net* InvestmentRegion
order FundId datem InvestmentRegion *alpha_c4_past *alpha_c4_pred *r2_*
compress


****************************************
/*Calculate 6-months cumulative fund alphas*/
****************************************
egen ui = group(FundId)
tsset ui datem
gen fund_6m_net_alpha_c4_pred = fund_net_alpha_c4_pred + F.fund_net_alpha_c4_pred + F2.fund_net_alpha_c4_pred  + F3.fund_net_alpha_c4_pred  + F4.fund_net_alpha_c4_pred  + F5.fund_net_alpha_c4_pred 
drop ui

*********************************************
/*Label Variables*/
*********************************************	
label variable fund_gross_alpha_c4_past "Fund: Gross Alpha (4-factor, horizon 36m, by region)"
label variable fund_net_alpha_c4_past "Fund: Net Alpha (4-factor, horizon 36m, by region)"

label variable fund_gross_alpha_c4_pred "Fund: Gross Alpha (4-factor, one-month ahead prediction, by region)"
label variable fund_net_alpha_c4_pred "Fund: Net Alpha (4-factor, one-month ahead prediction, by region)"

label variable fund_gross_r2_c4 "Fund: Gross R^2 (4-factor, by region)"
label variable fund_net_r2_c4 "Fund: Net R^2 (4-factor, by region)"

label variable fund_6m_net_alpha_c4_pred "Fund: 6-Month Cumulative Net Alpha (4-factor, by region)"

*********************************************
/* Save Data */
*********************************************	
cd "${data_for_analysis}/01_IFS"
compress
describe

save "A1-d_Panel_IFS_MS_EquityFundID_Perf_2014m6_2018m12_Apr20.dta", replace


**********************************************************************************************
***EOF
**********************************************************************************************














