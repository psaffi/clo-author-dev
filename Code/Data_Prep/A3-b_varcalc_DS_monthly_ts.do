
******************************************************************************************************************************
******************************************************************************************************************************
***
*** Number of project:		2016\0082				
*** Title of project:		Securities lending by mutual funds
*** Data source: 			Investment Fund Statistics (Original Data is December 2009 until December 2018; later on, June 2014 until December 2018 is kept for the analysis)
*** Name of programme code:	A3-b_varcalc_DS_monthly_ts.do
***
*** Purpose of programme code: 
***			Part I: 	Load Monthly Eikon Stock Data and Merge with other Data
***			Part II: 	Clean Stock Data
***			Part III: 	Calculate Abnormal Returns
***			Part IV: 	Calculate Other Variables
***					
******************************************************************************************************************************
******************************************************************************************************************************

/* Paths : */

*Comment next two lines out when running code via the master file (information comes from there in this case)
*global datum 				= 	"20200416"				/* Date in the form yyyymmdd */
global proj_num			=	"2016_0082r"			/* Please spezify project number with underscore */

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
/* Part I: Load Monthly Eikon Stock Data and Merge with Other Data Sets */
*********************************************
*********************************************
cd "${data_for_analysis}/03_DS_EIKON"
use "DS_ts_allvars.dta", replace
quietly drop if datem == .

****************************************
/*Merge with monthly FF factors */
****************************************
cd "${data_for_analysis}/05_FF"
merge m:1 datem using "Fama_French_factors_EUR.dta" 

/*Drop if month is before 2008 (we only need some years prior to the sample period to calculate variables)*/
****************************************
quietly drop if datem < tm(2008m1)
tab _merge 
drop _merge

****************************************
/*Merge with stock identifier key file (matching InstrumentIDs to DSCD codes)*/
****************************************
cd "${data_for_analysis}/03_DS_EIKON/ID_KEYS"
merge m:1 DSCD using "KEY_InstrumentID_DSCD.dta"

*Keep matched stocks
****************************************
quietly keep if _merge == 3
drop _merge

****************************************
/*Merge with static Eikon information (to get information on stock's world region for calculation of abnormal returns)*/
****************************************
cd "${data_for_analysis}/03_DS_EIKON"
merge m:1 InstrumentID using "TR_static_selected.dta", keepusing(world_region_ff)
drop _merge

*Instruments without information on world region are fitted to a global factor model
****************************************
replace world_region_ff = "Global" if world_region_ff == ""


*********************************************
*********************************************
/* Part II: Clean Stock-Level Data */
*********************************************
*********************************************

****************************************
/*Return Filter*/
****************************************
egen ui = group(DSCD)
tsset ui datem

gen ret_eur = RI_eur/l.RI_eur - 1


****************************************
/*
Ince & Porter (2006) 
"We screen for this type of error by setting to missing return above 300% that is reversed within one month."
"If Rt or Rt−1 is greater than 300% and (1 + Rt)(1 + Rt−1) −1 is less than 50%, we set Rt and Rt−1 to missing."
*/
****************************************
gen byte filter_flag = ((ret_eur>3 | l.ret_eur>3) & ((1+l.ret_eur)*(1+ret_eur)-1<0.50) & (ret_eur!=.) & (l.ret_eur!=.))
replace ret_eur = . if filter_flag ==1
drop filter_flag


****************************************
/*
G. Andrew Karolyi et al./Journal of Financial Economics 105(2012)82–112, p.87
we set daily returns to missing if the value of  the total return index for either
the previous or the current day is below 0.01.

--> adapted to monthly frequency
*/
****************************************
replace ret_eur = . if RI_eur <0.01 | l.RI_eur <0.01




*********************************************
*********************************************
/* Part III: Calculate abnormal stock return */
*********************************************
*********************************************

*Excess Returns and World Region of Stock (we fit a regional factor model)
****************************************
gen xret = ret_eur - rf_EUR_MM_Buba
encode world_region_ff, gen(world_region_num)


****************************************
/*Carhart 4-Factor Model*/
****************************************

*Create variables for Alpha, Betas, and R2 (Fama French 3-Factor Model)
****************************************
gen stock_alpha_c4_past = .
gen stock_alpha_c4_pred = .
gen stock_r2_c4 = .
gen stock_beta_c4_mktrf = .
gen stock_beta_c4_smb = .
gen stock_beta_c4_hml = .
gen stock_beta_c4_wml = .


*Take numerical version of world regions (world_region_num) and iterate through the 5 regions
****************************************
forvalues r = 1(1)5{ 

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

	/*Create temporary variables for N, error code, R^2 */
	****************************************
	capture drop xret_*
	capture gen xret_n = .
	capture gen xret_err = .
	capture gen xret_r2 = .

	/*Fast rolling regression*/
	****************************************
	fastrollreg xret mktrf_`region'_EUR smb3_`region'_EUR hml3_`region'_EUR wml_`region'_EUR if world_region_num == `r', /// 
	 window(36) increment(1) panelvar(ui) coeff(auto) rsq(auto) err(auto) obs(auto)


	/*Correct intercept, coefficients, and R^2 to missing if not enough observations (less than 24 out of 36 return observations) */ 
	**************************************** 
	foreach x of varlist *_b *_r2{
	display "====================================================="
	display "Correct variable: `x'"
	replace `x' = . if xret_n <36
	replace `x' = . if xret_err == 999
	}
 
	/*Rename variables */
	****************************************
	rename c_b c_b_c4_`region'
	rename xret_n xret_c4_n_`region'
	rename xret_err xret_err_`region' 
	rename xret_r2 r2_c4_`region'
	

	/* Calculate historical alpha (given by the intercept -> average alpha of past 36 months) */
	****************************************
	display "====================================================="
	display "Compute alpha (past 36 months) "
	
	gen alpha_temp = c_b_c4_`region'
	replace stock_alpha_c4_past = alpha_temp if world_region_ff == "`region'"

	/* Calculate alpha (one-month ahead prediction based on coefficients estimated up to month t-1 and factor returns in month t) */
	****************************************
	display "Compute alpha (one-month ahead prediction) "
	
	gen alpha_pred = xret - (l.mktrf_`region'_EUR_b*mktrf_`region'_EUR + l.smb3_`region'_EUR_b*smb3_`region'_EUR + ///
					 l.hml3_`region'_EUR_b*hml3_`region'_EUR + l.wml_`region'_EUR_b*wml_`region'_EUR)
					 
	/* Collect alpha and R-squared in one variable (region-by-region)*/
	****************************************				 
	replace stock_alpha_c4_pred = alpha_pred if world_region_ff == "`region'"
	replace stock_r2_c4 = r2_c4_`region' if world_region_ff == "`region'"
	
	/* Collect coefficients in one variable (region-by-region)*/
	****************************************
	replace stock_beta_c4_mktrf = mktrf_`region'_EUR_b if world_region_ff == "`region'"
	replace stock_beta_c4_smb = smb3_`region'_EUR_b if world_region_ff == "`region'"
	replace stock_beta_c4_hml = hml3_`region'_EUR_b if world_region_ff == "`region'"
	replace stock_beta_c4_wml = wml_`region'_EUR_b if world_region_ff == "`region'"
	
	/*Drop Coefficients (for next loop)*/
	****************************************				 
	capture drop c_b_* alpha_temp alpha_pred mktrf_*_EUR_b smb3_*_EUR_b hml3_*_EUR_b wml_*_EUR_b
}

/*Drop temporary variables used for the loop*/
****************************************
drop r2_c4* xret_c4_n* xret_err* 
capture drop temp
rename xret xret_stock


*********************************************
*********************************************
/* Part IV: Calculate other variables */
*********************************************
*********************************************

*********************************************
/*Book-to-Market Ratio*/
*********************************************
gen BM = PTBV^(-1)
quietly replace BM = . if BM <=0

label variable BM "Book-to-market (missing if <=0)"
duplicates drop

/*Log & Lagged Values*/
*********************************************
gen ln_MV = ln(MV_eur)
gen ln_BM = ln(BM)

tsset ui datem
foreach var of varlist ln_MV ln_BM UP_eur{
	gen l`var' = l.`var'
}

*********************************************
*Lag betas by 13 months for the exit event study
*********************************************
foreach var of varlist stock_beta*{
	gen l13`var' = l13.`var'
}

*********************************************
*Calculate 6-month cumulative future returns as of month t (i.e. return from t+1 to t+7)
*********************************************
forvalue i = 1(1)12{
	gen ret_plus_`i'm = F`i'.ret_eur
	gen ret_minus_`i'm = l`i'.ret_eur
}


gen cum_ret_minus_1_12 = ret_minus_1m + ret_minus_2m + ret_minus_3m + ret_minus_4m + ret_minus_5m + ret_minus_6m ///
					   + ret_minus_7m + ret_minus_8m + ret_minus_9m + ret_minus_10m + ret_minus_11m + ret_minus_12m
					   
gen cum_ret_plus_1_3 = ret_plus_1m + ret_plus_2m + ret_plus_3m
gen cum_ret_plus_1_6 = ret_plus_1m + ret_plus_2m + ret_plus_3m + ret_plus_4m + ret_plus_5m + ret_plus_6m
gen cum_ret_plus_1_12 = ret_plus_1m + ret_plus_2m + ret_plus_3m + ret_plus_4m + ret_plus_5m + ret_plus_6m ///
					  + ret_plus_7m + ret_plus_8m + ret_plus_9m + ret_plus_10m + ret_plus_11m + ret_plus_12m
					   
					   
drop ret_minus_1m ret_*_2m ret_*_3m ret_*_4m ret_*_5m ret_*_6m ret_*_7m ret_*_8m ret_*_9m ret_*_10m ret_*_11m ret_*_12m

label variable ret_plus_1m "Stock: Monthly Raw Return in t+1"
label variable cum_ret_minus_1_12 "Stock: Cumulative Raw Return from t-12 to t-1"
label variable cum_ret_plus_1_3 "Stock: Cumulative Raw Return from t+1 to t+3"
label variable cum_ret_plus_1_6 "Stock: Cumulative Raw Return from t+1 to t+6"
label variable cum_ret_plus_1_12 "Stock: Cumulative Raw Return from t+1 to t+12"

*********************************************
*Calculate next month alphas (e.g. after exits)
*********************************************
forvalue i = 1(1)12{
	gen alpha_plus_`i'm = F`i'.stock_alpha_c4_pred
	gen alpha_minus_`i'm = l`i'.stock_alpha_c4_pred
}

*********************************************
*Calculate 6-month cumulative future alpha as of month t (i.e. return from t+1 to t+7)
*********************************************
gen cum_alpha_plus_1_12 = alpha_plus_1m + alpha_plus_2m + alpha_plus_3m +  alpha_plus_4m + alpha_plus_5m + alpha_plus_6m ///
						+ alpha_plus_7m + alpha_plus_8m + alpha_plus_9m + alpha_plus_10m + alpha_plus_11m + alpha_plus_12m
gen cum_alpha_plus_1_6 = alpha_plus_1m + alpha_plus_2m + alpha_plus_3m +  alpha_plus_4m + alpha_plus_5m + alpha_plus_6m
gen cum_alpha_plus_1_3 = alpha_plus_1m + alpha_plus_2m + alpha_plus_3m
gen cum_alpha_plus_0_1 = stock_alpha_c4_pred + alpha_plus_1m

gen cum_alpha_minus_1_6 = alpha_minus_6m + alpha_minus_5m + alpha_minus_4m + alpha_minus_3m + alpha_minus_2m + alpha_minus_1m
gen cum_alpha_minus_1_3 = alpha_minus_3m + alpha_minus_2m + alpha_minus_1m


drop alpha_minus_1m alpha_*_2m alpha_*_3m alpha_*_4m alpha_*_5m  alpha_*_6m alpha_*_7m alpha_*_8m alpha_*_9m alpha_*_10m alpha_*_11m alpha_*_12m 

label variable alpha_plus_1m "Stock: 4-Factor Alpha in t+1"
label variable cum_alpha_plus_1_12 "Stock: Cumulative 4-Factor Alpha from t+1 to t+12"
label variable cum_alpha_plus_1_6 "Stock: Cumulative 4-Factor Alpha from t+1 to t+6"
label variable cum_alpha_plus_1_3 "Stock: Cumulative 4-Factor Alpha from t+1 to t+3"
label variable cum_alpha_plus_0_1 "Stock: Cumulative 4-Factor Alpha from t to t+1 (including t)"

label variable cum_alpha_minus_1_6 "Stock: Cumulative 4-Factor Alpha from t-6 to t-1"
label variable cum_alpha_minus_1_3 "Stock: Cumulative 4-Factor Alpha from t-3 to t-1"


*********************************************
/*Label Variables*/
*********************************************
label variable DSCD	"Stock: Datastream Security Identifier"
label variable datem "Time Variable: Calendar Month"
label variable ret_eur "Stock: Monthly Raw Return (Unscaled)"
label variable stock_alpha_c4_past "Stock: Carhart 4-Factor Alpha (past 36 months up to month t, by region)"
label variable stock_alpha_c4_pred "Stock: Carhart 4-Factor Alpha (one-month ahead prediction, by region)"
label variable stock_r2_c4 "Stock: Carhart 4-Factor R^2 (past 36 months up to month t, by region)"
label variable stock_beta_c4_mktrf "Stock: Carhart 4-Factor Market Beta, by region"
label variable stock_beta_c4_smb "Stock: Carhart 4-Factor Size Beta, by region"
label variable stock_beta_c4_hml "Stock: Carhart 4-Factor Value Beta, by region"
label variable stock_beta_c4_wml "Stock: Carhart 4-Factor Momentum Beta, by region"
label variable BM "Stock: Book-to-Market Ratio"
label variable ln_BM "Stock: Log of Book-to-Market Ratio"
label variable lln_BM "Stock: Lagged Log of Book-to-Market Ratio"
label variable ln_MV "Stock: Log of Market Value"
label variable lln_MV "Stock: Lagged Log of Market Value"
label variable l13stock_beta_c4_mktrf "Stock: Carhart 4-Factor Market Beta in t-13"
label variable l13stock_beta_c4_smb "Stock: Carhart 4-Factor Size Beta in t-13"
label variable l13stock_beta_c4_hml "Stock: Carhart 4-Factor Value Beta in t-13"
label variable l13stock_beta_c4_wml "Stock: Carhart 4-Factor Momentum Beta in t-13"
label variable MV_eur "Stock: Market Value (in million EUR)
label variable AF "Stock: Adjustment Factor (accumulated)"
label variable UP_eur "Stock: Unadjusted Price (in EUR)"
label variable lUP_eur "Stock: Lagged Unadjusted Price (in EUR)"
label variable world_region_num "World region developed markets (Fama-French) - numeric values"

*********************************************
/*Save Stock Data*/
*********************************************
quietly drop if ui == .
drop date_eom_DS MTBV NOSH PT_eur PTBV RI_eur rf_* mkt_* mktrf_* smb* hml* wml* rmw* cma* ui xret_stock InstrumentID

order DSCD datem ret_eur* cum_ret* *MV* *BM* UP_eur AF stock_beta* l13stock_beta* stock_alpha* cum_alpha* stock_r2

compress
describe

cd "${data_for_analysis}/03_DS_EIKON"
save "DS_ts_allvars_varcalc_Jul20.dta", replace


**********************************************************************************************
***EOF
**********************************************************************************************
