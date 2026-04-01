
******************************************************************************************************************************
******************************************************************************************************************************
***
*** Number of project:		2016\0082				
*** Title of project:		Securities lending by mutual funds
*** Data source: 			Investment Fund Statistics (Original Data is December 2009 until December 2018; later on, June 2014 until December 2018 is kept for the analysis)
*** Name of programme code:	A3-d_varcalc_DGTW_Portfolios.do
***
*** Purpose of programme code: 
***			Part I: 		Load IFS Holdings (ISIN List) and merge to stock-level Information to define the universe of stocks for the DGTW portfolios	
***			Part II: 		Construct DGTW portfolios (5x5x5-dependent sort on size, book-to-market, past return) and calculate portfolio returns
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
/* Part I: Load IFS Holdings ISIN-List and Merge to Datastream Stock Information 
		   --> defines universe of stocks for DGTW portfolios */
*********************************************
*********************************************
cd "${data_for_analysis}/01_IFS"
import excel using "A2-a_IFS_Holdings_ISINList_2009m9_2018m12_Apr20.xlsx", clear


****************************************
/*Merge with Security Identifier Key File*/
****************************************
cd "${data_for_analysis}/03_DS_EIKON/ID_KEYS"
rename A ISIN
merge 1:1 ISIN using "KEY_InstrumentID_DSCD_ISIN.dta", keepusing(ISIN InstrumentID DSCD)

/*
----------------------------------------------------------
_merge == 1: Data only in Holdings (Eikon information requested only for securities classified as equity, i.e. rest is non-equity securities)
_merge == 2: Data only in Eikon (stocks only held prior to December 2013)
----------------------------------------------------------
*/

*Keep Matched Stocks
****************************************
quietly keep if _merge == 3
drop _merge

****************************************
/*Merge with Eikon Security Information (merge on InstrumentID, for Industry Assignment)*/
****************************************
cd "${data_for_analysis}/03_DS_EIKON"
merge m:1 InstrumentID using "TR_static_selected.dta", keepusing(TRBCIndustryGroupCode)

*Keep Matched Stocks
****************************************
quietly keep if _merge == 3
drop _merge

****************************************
/*Merge with monthly time series information (merge on DSCD)*/
****************************************
keep DSCD TRBCIndustryGroupCode
duplicates drop
quietly drop if DSCD == ""

cd "${data_for_analysis}/03_DS_EIKON"
merge 1:m DSCD using "DS_ts_allvars_varcalc_Apr20.dta"

*Keep Matched Stocks
****************************************
quietly keep if _merge == 3
drop _merge


*********************************************
*********************************************
/* Part II: Construct DGTW Portfolios */
*********************************************
*********************************************
gen year = yofd(dofm(datem))
gen month = month(dofm(datem))

*********************************************
*Each year (from 2012 onwards), a new portfolio is formed in July and held until June next year (each portfolio is captured by a portfolio identifier)
*********************************************
gen portfolio = .
replace portfolio = 1 if (year == 2012 & month >= 7) | (year == 2013 & month <= 6)
replace portfolio = 2 if (year == 2013 & month >= 7) | (year == 2014 & month <= 6)
replace portfolio = 3 if (year == 2014 & month >= 7) | (year == 2015 & month <= 6)
replace portfolio = 4 if (year == 2015 & month >= 7) | (year == 2016 & month <= 6)
replace portfolio = 5 if (year == 2016 & month >= 7) | (year == 2017 & month <= 6)
replace portfolio = 6 if (year == 2017 & month >= 7) | (year == 2018 & month <= 6)
replace portfolio = 7 if (year == 2018 & month >= 7) | (year == 2019 & month <= 6)

*********************************************
*Build triple sorted portfolios (dependent sort): size, book-to-market, past return (with values as of the end of June)
*********************************************
egen ui_dscd = group(DSCD)

*Last year's cumulative return
*********************************************
tsset ui_dscd datem
gen ln_ret = ln(1 + ret_eur)
gen last_year_ret = l.ln_ret + l2.ln_ret + l3.ln_ret + l4.ln_ret + l5.ln_ret + l6.ln_ret + l7.ln_ret + l8.ln_ret + l9.ln_ret + l10.ln_ret + l11.ln_ret + l12.ln_ret
replace last_year_ret = exp(last_year_ret) - 1

*Industry-adjusted book-to-market ratio
*********************************************
bys TRBCIndustryGroupCode datem: egen BM_Industry = mean(BM)
gen BM_Industry_Adjusted = BM - BM_Industry

*Lagged values (end of June values for portfolio formation in July)
*********************************************
tsset ui_dscd datem
gen lMV_eur = l.MV_eur 
gen lBM_Industry_Adjusted = l.BM_Industry_Adjusted
gen llast_year_ret = l.last_year_ret


*********************************************
/*Sort Stocks into Size Quintiles*/
*********************************************

*Calculate size quintile in July of each year (based on market capitalzation of the previous month)
egen size_temp = xtile(lMV_eur) if month == 7, by(year) nq(5)

*For each portfolio (from July of year t to June of year t+1), keep size quinitle constant -> take each stock's July size quintile --> use egen = min())
bys DSCD portfolio: egen size_5 = min(size_temp)

*If no portfolio is defined, replace size quintile with missing
replace size_5 = . if portfolio == .
drop size_temp



*********************************************
/*Sort Stocks into BM Quintiles (within each size quintile)*/
*********************************************

*Calculate BM quintile in July of each year per size portfolio (based on industry-adjusted book-to-market ratio of the previous month)
egen bm_temp = xtile(lBM_Industry_Adjusted) if month == 7, by(year size_5) nq(5)

*For each portfolio (from July of year t to June of year t+1), keep BM quintile constant -> take each stock's July BM quintile --> use egen = min())
bys DSCD portfolio size_5: egen bm_5 = min(bm_temp)

*If no portfolio is defined, replace BM quintile with missing
replace bm_5 = . if portfolio == .
drop bm_temp


*********************************************
/*Sort Stocks into Momentum Quintiles (within each size-bm quintile)*/
*********************************************
*Calculate momentum quintile in July of each year per size-bm portfolio (based on last year's cumulative return from July in year t-1 to June in year t)
egen mom_temp = xtile(llast_year_ret) if month == 7, by(year size_5 bm_5) nq(5)

*For each portfolio (from July of year t to June of year t+1), keep momentum quintile constant -> take each stock's July momentum quintile --> use egen = min())
bys DSCD portfolio size_5 bm_5: egen mom_5 = min(mom_temp)

*If no portfolio is defined, replace momentum quintile with missing
replace mom_5 = . if portfolio == .
drop mom_temp


*********************************************
/*5x5x5 Portfolios*/
*********************************************
tostring size_5, gen(size_5_string)
tostring bm_5, gen(bm_5_string)
tostring mom_5, gen(mom_5_string)

/*Name Portfolio (e.g. 1-1-1 means lowest size, lowest BM, lowest return quintile)*/
*********************************************
gen DGTW_Portfolio = size_5_string + "-" + bm_5_string + "-" + mom_5_string

*If stock is not assigned, replace portfolio name with missing value (empty string)
replace DGTW_Portfolio = "" if strpos(DGTW_Portfolio, ".") > 0 
drop *_string

/*Calculate Portfolio Return (value-weighted, by last month market capitalzation)*/
*********************************************
bys DGTW_Portfolio datem: egen ret_DGTW = wtmean(ret_eur), weight(lMV_eur)

*If stock is not assigned, replace benchmark return with missing value
replace ret_DGTW = . if DGTW_Portfolio == ""

*Lag DGTW Portfolio Assignment by 13 months for exit event study
*********************************************
tsset ui_dscd datem
bys DSCD: gen l13DGTW_Portfolio = DGTW_Portfolio[_n-13]

*********************************************
*Save Stock Assignments to DGTW Portfolios
*********************************************
preserve
keep DSCD datem DGTW_Portfolio l13DGTW_Portfolio
duplicates drop

*Drop if portfolio is not defined
qui drop if DGTW_Portfolio == ""

/*Restrict Time Period (maximum of 12 months prior to sample period start needed for analysis)*/
*********************************************
quietly drop if datem < tm(2013m12)
quietly drop if datem > tm(2018m12)

/*Label Variables*/
*********************************************
label variable DSCD	"Stock: Datastream Security Identifier"
label variable datem "Time Variable: Calendar Month"
label variable DGTW_Portfolio "Stock: DGTW-Portfolio Assignment"
label variable l13DGTW_Portfolio "Stock: 13-months Lagged DGTW-Portfolio Assignment"

cd "${data_for_analysis}/03_DS_EIKON/DGTW"
compress
describe

save "DGTW_Stock_Portfolio_Assignments_Apr20.dta", replace
restore

*********************************************
*Save DGTW Portfolio Returns
*********************************************
preserve
keep DGTW_Portfolio datem ret_DGTW
duplicates drop

*Drop if portfolio is not defined
quietly drop if DGTW_Portfolio == ""

/*Restrict Time Period (maximum of 12 months prior to sample period start needed for analysis)*/
*********************************************
quietly drop if datem < tm(2013m12)
quietly drop if datem > tm(2018m12)

/*Label Variables*/
*********************************************
label variable datem "Time Variable: Calendar Month"
label variable DGTW_Portfolio "Stock: DGTW-Portfolio Assignment"
label variable ret_DGTW "Stock: Assigned DGTW-Portfolio Benchmark Return"

cd "${data_for_analysis}/03_DS_EIKON/DGTW"
compress
describe

save "DGTW_Portfolio_Returns_Apr20.dta", replace
restore

**********************************************************************************************
***EOF
**********************************************************************************************



