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
*global datum 				= 	"20200507"				/* Date in the form yyyymmdd */
global proj_num				=	"2016_0082r"			/* Please spezify project number with underscore */

global path					= 	"\\in.bundesbank.de.\BBK\Daten\Zentrale\ZB-S\Daten_FDSZ_Gastforscher\1_gafo\\${proj_num}"

global orig_data			=	"${path}/data/orig"							/* Path for original data */
global data_for_analysis	= 	"${path}/data/data_for_analysis"			/* Path to data used for analysis */
global temp_data			=	"${path}/data/temp"							/* Path for temporary files */
global ext_data				=	"${path}/data/ext"							/* Path for external data */

global ado					=	"${path}/ado"								/* ado-path */
global code					=	"${path}/code/${datum}"						/* Path for program codes */
global results				=	"${path}/results/${datum}"					/* Path for results */

capture mkdir "${results}"

*Comment next line out when running code via the master file (information comes from there in this case)
global event_window 		=	"12"
global panel				=	"Unbalanced"

sysdir set STBPLUS "${ado}"

clear all 
set more off

capture reghdfe, compile
capture ftools, compile


******************************************************************************************************************************
******************************************************************************************************************************

******************************************************************************************************************************
******************************************************************************************************************************
/* Part I: Prepare data for analysis */
******************************************************************************************************************************
******************************************************************************************************************************

****************************************
/*Load Data Set (merged dataset: IFS data, Eikon Data, Morningstar Data, Markit Data, Net Short Position Data)*/
****************************************
cd "${data_for_analysis}"
use "B3_Panel_EquityFunds_FinalMerge_AddVar_2014m12on_Dec22.dta", clear

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

*Does any fund in the family currently lend the stock (2nd version: not the fund itself)
bys ui_family ui_dscd datem: egen dum_slend_family_now = max(dum_slend_now)
gen dum_slend_family_now_noown = dum_slend_family_now
replace dum_slend_family_now_noown = 0 if dum_slend_now == 1

	
*********************************************
/*Additional Variables*/
*********************************************
tsset ui_fund_sec datem

*Lagged Lending Dummies
*********************************************
foreach var of varlist dum_flend* dum_slend*{
	gen l`var' = l.`var'
	}

gen lKURSPREIS = l.KURSPREIS

*Family-Level Lending (Market Values)
gen mv_stock_lent = NOMSTUECK_WPLEI_adj*KURSPREIS
bys ui_family ui_dscd datem: egen family_stock_lent = sum(mv_stock_lent)
replace family_stock_lent = family_stock_lent*10^(-6)

egen ui_fam_sec = group(ui_family ui_dscd)


*Only active funds
*********************************************
qui keep if dum_fund_active == 1


*Share Lent (relative to total supply)
*********************************************
rangestat (mean) sec_mv_lend_adj (max) sec_mv_lend_adj, interval(datem -12 0) by(ui_fund_sec)
gen sh_lender_lent = sec_mv_lend_adj_mean*10^(-3)/bo_inventory_value_EUR
replace sh_lender_lent =  1 if sh_lender_lent > 1 & sh_lender_lent < .

tsset ui_fund_sec datem
gen lsh_lender_lent = l.sh_lender_lent


*Family Level
preserve
bys ui_family ui_dscd datem: gen id_temp = _n
keep if id_temp == 1

rangestat(mean) family_stock_lent (max) family_stock_lent, interval(datem -12 0) by(ui_fam_sec)
gen sh_fam_lent = family_stock_lent_mean/bo_inventory_value_EUR
replace sh_fam_lent = 1 if sh_fam_lent > 1 & sh_fam_lent < .

keep ui_family ui_dscd datem sh_fam_lent
save "temp.dta", replace
restore

merge m:1 ui_family ui_dscd datem using "temp.dta"
drop _merge
erase "temp.dta"


tsset ui_fund_sec datem
gen lsh_fam_lent = l.sh_fam_lent


*gen lsec_mv_lend_adj = l.sec_mv_lend
gen lon_loan_fund = lsec_mv_lend_adj/(lMV_eur*10^3)	
replace lon_loan_fund = lon_loan_fund*100

gen lon_loan_fund_12m = l.on_loan_fund_12m
gen lon_loan_fund_6m = l.on_loan_fund_6m
gen lon_loan_fund_3m = l.on_loan_fund_3m

winsor2 lon_loan_fund_12m, cut(0 99) replace
winsor2 lon_loan_fund_6m, cut(0 99) replace
winsor2 lon_loan_fund_3m, cut(0 99) replace
winsor2 lon_loan_fund, cut(0 99) replace






******************************************************************************************************************************
******************************************************************************************************************************
/* Part II: Define Exit Events */
******************************************************************************************************************************
******************************************************************************************************************************

*********************************************
/*Keep Necessary Variables*/
*********************************************
keep ui_fund_sec FundId DSCD sec_isin_historic ui_fund ui_dscd ui_family lon_loan_mv datem dum_exit* ///
	 lMV_eur ldum_flend* ldum_slend* lsec_mv_adj lNOMSTUECK* lKURSPREIS lUP_eur holding_time ///
	 lln_* *relflow lCost* lturnover l*r2* l*alpha* lsh_lender_lent lsh_fam_lent lon_loan_fund*

*********************************************
*Keep Exits (everything from December 2014 onwards)
*********************************************
qui keep if dum_exit == 1
qui keep if datem >= tm(2014m12)
qui keep if ldum_flend_once_now == 1

*********************************************
*Rename (all variables are measured one month prior to the exit, i.e. rename varname to varname_pre_exit)
*********************************************
rename lon_loan_mv SIR_pre_exit
rename lsec_mv pos_mv_pre_exit
rename lNOMSTUECK_adj pos_nom_pre_exit
rename lNOMSTUECK_WPLEI pos_nom_lend_pre_exit
rename lUP_eur lUP_pre_exit
rename lln_MV ln_mv_pre_exit
rename lMV_eur mv_pre_exit
rename lln_BM ln_bm_pre_exit
rename lln_amihud_w ln_amihud_pre_exit
rename lln_spread ln_spread_pre_exit
rename lln_sd_idio ln_sd_idio_pre_exit
rename lln_nav ln_nav_pre_exit
rename lln_fund_family_nav ln_fund_family_nav_pre_exit
rename lturnover turnover_pre_exit
rename lfund_net_r2_c4 fund_r2_pre_exit
rename lfund_net_alpha_c4_past fund_net_alpha_c4_pre_exit
rename lCostsExTrFees fund_cost_pre_exit
rename lln_age fund_age_pre_exit
rename lrelflow relflow_pre_exit
rename sec_isin_historic isin
rename lKURSPREIS KURSPREIS_pre_exit
rename lsh_lender_lent lsh_lender_lent_pre_exit
rename lsh_fam_lent lsh_fam_lent_pre_exit

*********************************************
*Short Interest Percentiles (over all exit events)
*********************************************
egen SI_pre_exit_5 = xtile(SIR_pre_exit), nq(5)

bys SI_pre_exit_5: egen sh_lender_2 = xtile(lsh_lender_lent_pre_exit) if lsh_lender_lent_pre_exit > 0, nq(2)
replace sh_lender_2 = 0 if sh_lender_2 == .

bys SI_pre_exit_5: egen sh_famlend_2 = xtile(lsh_fam_lent_pre_exit) if lsh_fam_lent_pre_exit > 0, nq(2)
replace sh_famlend_2 = 0 if sh_famlend_2 == .



*********************************************
*Exit Event Identifier
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
gen exit_month = datem
format exit_month %tm

/*Non-expanded observation is start date (i.e. 12 or 24 months prior to exit month)*/
*********************************************
replace datem = datem - ${event_window} if temp_expand == 0

/*Expanded observation is end date (i.e. 12 months after to exit month)*/
*********************************************
replace datem = datem + 12 if temp_expand == 1

*********************************************
/*Span a panel of +/- 6 or 12 months around the exit*/
*********************************************
tsset event_id datem
tsfill

*Fill in missing numeric values
**********************************************************
foreach var of varlist ui_fund_sec ui_fund ui_dscd ui_family exit_month holding_time *_5 *_2 *_pre_exit dum_exit* ldum_flend* ldum_slend* lon_loan_fund*{
	bys event_id: replace `var' = l.`var' if `var' == .
}

*Fill in missing string values
**********************************************************
foreach var of varlist DSCD FundId isin{
	bys event_id: replace `var' = `var'[_n-1] if `var' == ""
}

*All months which are not the exit month (for a given event) have exit dummy equal to 0
**********************************************************
replace dum_exit = 0 if datem != exit_month
drop temp_expand


**********************************************************
/*Define exit event time (from -12 to +12)*/
**********************************************************
sort event_id datem
bys event_id: gen exit_event_time = _n

if "${event_window}" == "6"{
	replace exit_event_time = exit_event_time - 7
}
else if "${event_window}" == "12"{
	replace exit_event_time = exit_event_time - 13
}

else if "${event_window}" == "24"{
	replace exit_event_time = exit_event_time - 25
}



******************************************************************************************************************************
******************************************************************************************************************************
/* Part III: Add stock TS information, FF Factors, DGTW Returns and holdings information to exit events panel*/
******************************************************************************************************************************
******************************************************************************************************************************

**********************************************************
*Add Holding Position (from original Holdings Data Set)
**********************************************************
cd "${data_for_analysis}"
merge m:1 ui_fund_sec datem using "B3_Panel_EquityFunds_FinalMerge_AddVar_2014m12on_Dec22.dta", keepusing(NOMSTUECK_adj dum_entry sec_mv_adj dpos_prc_nom_adj_99_5)

/*Drop all fund-stock months which do not fall within an exit event period*/
**********************************************************
qui drop if _merge == 2		
drop _merge


/*After the exit: Drop if fund re-enters position (i.e. if NOMSTUECK_adj non-missing in any month t+1 to t+6  */
**********************************************************
qui drop if NOMSTUECK_adj != . & exit_event_time > 0 

*Position Change when a fund enters a position = 100%
**********************************************************
replace dpos_prc_nom_adj_99_5 = 100 if dum_entry == 1


**********************************************************
*Add Eikon Information
**********************************************************
cd "${data_for_analysis}/03_DS_Eikon"
merge m:1 datem DSCD using "DS_ts_allvars_varcalc_Jul20.dta"
qui drop if _merge == 2

*Drop stock alphas  -> calculate new ones in event time
**********************************************************
drop stock_alpha* 

*Only keep exit events with complete Eikon return information
**********************************************************

*Are all observations of an event matched?
bys event_id: egen mean_merge = mean(_merge)

*If this is the case, _merge is on average 3 -> dummy equal to one
gen complete_information = (mean_merge == 3)

*If this is not the case, dummy equal to zero -> drop whole event
*drop if complete_information == 0
drop _merge mean_merge


**********************************************************
*Add Markit Information
**********************************************************
cd "${data_for_analysis}/04_Markit"
merge m:1 isin datem using "DX_data_all_cleaned_endofM_Apr20.dta", keepusing(total_demand_value_EUR_Mmean utilisation_Mmean)

qui drop if _merge == 2
drop _merge

*Calculate Short Interest Ratio for events
**********************************************************
gen SIR =  100*((total_demand_value_EUR_Mmean)/MV_eur)

**********************************************************
*Fama-French Factors
**********************************************************
cd "${data_for_analysis}/05_FF"
merge m:1 datem using "Fama_French_factors_EUR.dta"

drop if _merge == 2
drop _merge

**********************************************************
*DGTW Portfolio Assignments
**********************************************************
cd "${data_for_analysis}/03_DS_Eikon/DGTW"
merge m:1 DSCD datem using "DGTW_Stock_Portfolio_Assignments_Apr20.dta", keepusing(l13DGTW_Portfolio)

drop if _merge == 2
drop _merge

*Fix Portfolio Assignment for each stock 13 months prior to exit
**********************************************************

*What portfolio was the stock assigned to 13 months prior to exit?
gen temp = l13DGTW_Portfolio if exit_event_time == 0

*Expand this information to all observations of an event
bys event_id: egen DGTW_Portfolio = mode(temp)
drop temp

**********************************************************
*DGTW Portfolio Returns
**********************************************************
cd "${data_for_analysis}/03_DS_Eikon/DGTW"
merge m:1 DGTW_Portfolio datem using "DGTW_Portfolio_Returns_Apr20.dta"

drop if _merge == 2
drop _merge





******************************************************************************************************************************
******************************************************************************************************************************
/* Part IV: Calculate abnormal stock returns*/
******************************************************************************************************************************
******************************************************************************************************************************

**********************************************************
*Stock Alpha with betas estimated 13 months prior to the exit (i.e. no interference with the event period of -12 to +12)
**********************************************************
foreach var of varlist l13stock*{
	
	*In the exit month, what is the factor loading 12 months before?
	**********************************************************
	gen temp = `var' if exit_event_time == 0
	winsor2 temp, cut(5 95) replace
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
*DGTW abnormal return (= Stock return - DGTW Benchmark Portfolio return)
**********************************************************
gen alpha_stock_DGTW = ret_eur - ret_DGTW
sum alpha_stock_*



**********************************************************
*Cumulative Returns
**********************************************************
foreach var of varlist ret_eur ret_mkt_adj alpha_stock*{

	*Cumulative Return from t-12 to t+12
	**********************************************************
	sort event_id exit_event_time
	bys event_id: gen c`var' = sum(`var') if exit_event_time >= -${event_window} & exit_event_time < . & `var' != .
	
	*Cumulative Return from t-12 to t+12 (normalized to have cumulative return equal to zero at t=0 as the base category for the regressions)
	**********************************************************
	sort event_id exit_event_time
	bys event_id: gen c`var'_sum = sum(`var') if exit_event_time >= -${event_window} & exit_event_time <= 0 & `var' != .
	bys event_id: gen c`var'_temp = c`var'_sum if exit_event_time == 0 
	bys event_id: egen c`var'_at_exit = min(c`var'_temp)
	bys event_id: gen c`var'_normalized = c`var' - c`var'_at_exit
	drop c`var'_sum c`var'_temp c`var'_at_exit

}


******************************************************************************************************************************
******************************************************************************************************************************
/* Part V: Save Exit Event Sample */
******************************************************************************************************************************
******************************************************************************************************************************

*Only keep observations within the sample period (December 2014 - December 2018)
**********************************************************
qui drop if datem > tm(2018m12)
qui drop if datem < tm(2014m12)


*Since when do I observe holdings for each event prior to the exit?
**********************************************************
bys event_id: egen temp_event_time = min(exit_event_time) if NOMSTUECK_adj != .
bys event_id: egen min_event_time = min(temp_event_time)


*Drop unnecessary variables
**********************************************************
drop l13* world_region_* xret temp_event_time rf* mkt* smb* hml* cma* rmw* wml* world_region_ff  stock_*c4*

*Save exit events (unbalanced sample)
**********************************************************
cd "${data_for_analysis}"

save "C4-a_Exit_Events_Sample_Unbalanced_${event_window}m_Dec22.dta", replace


*Only keep events if fund holds the position for at least 6/12 months (prior to exit)
**********************************************************
qui drop if min_event_time > -${event_window}

*Save exit events (balanced sample, i.e. only positions held for at least 6 months prior to exit)
**********************************************************
cd "${data_for_analysis}"
compress

save "C4-a_Exit_Events_Sample_Balanced_${event_window}m_Dec22.dta", replace


******************************************************************************************************************************
*** EOF
******************************************************************************************************************************

