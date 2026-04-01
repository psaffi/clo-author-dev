
******************************************************************************************************************************
******************************************************************************************************************************
***
*** Number of project:		2016\0082				
*** Title of project:		Securities lending by mutual funds
*** Data source: 			Investment Fund Statistics (December 2009 until December 2018; later on, December 2014-December 2018 is used for analysis
*** Name of programme code:	B1_IFSfund_MS_merge.do
***
*** Purpose of programme code:
***			Part I: 	Merge Fund Characteristics with Fund Time Series, Fund Performance, Fund Turnover
***			Part II: 	Calculate additional variables for subsequent analysis
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


******************************************************************************************
******************************************************************************************
/* Part I: Merge Fund Information */
******************************************************************************************
******************************************************************************************

****************************************
/*Load Fund Characteristics Dataset */
****************************************
cd "${data_for_analysis}/01_IFS"
use "A1-b_Panel_IFS_MS_FundID_Char_2009m9_2018m12_Jul20.dta", clear

****************************************
/*Drop Observations prior to June 2014*/
****************************************
quietly drop if datem < tm(2014m6)

****************************************
*Drop Non-Equity Funds
****************************************
quietly keep if GlobalBroadCategoryGroup == "Equity"


**********************************************************
**********************************************************
*MERGE 1: Fund Statics with Morningstar Fund Time Series
**********************************************************
**********************************************************
merge 1:1 FundId datem using "A1-c_Panel_IFS_MS_FundID_TS_2009m9_2018m12_Apr20.dta"

/*
----------------------------------------------------------
_merge == 2: Observations prior to June 2014 or Non-Equity Fund
----------------------------------------------------------
*/

****************************************
*Drop Observations prior to June 2014 or Non-Equity Fund
****************************************
quietly drop if _merge == 2
drop _merge

**********************************************************
**********************************************************
*MERGE 2: Fund Data with calculated Fund Performance 
**********************************************************
**********************************************************
merge 1:1 FundId datem using "A1-d_Panel_IFS_MS_EquityFundID_Perf_2014m6_2018m12_Apr20.dta"


****************************************
*Drop Observations only in using
****************************************
quietly drop if _merge == 2
drop _merge


**********************************************************
**********************************************************
*MERGE 3: Fund Data with calculated Fund Turnover
**********************************************************
**********************************************************
merge 1:1 FundId datem using "A2-b_Panel_IFS_MS_FundID_Turnover_2014m6on_Apr20.dta"

****************************************
*Drop Observations only in using
****************************************
quietly drop if _merge == 2
drop _merge

**********************************************************
**********************************************************
*MERGE 3: Fund Data with calculated Fund Churn Rate
**********************************************************
**********************************************************
merge 1:1 FundId datem using "A2-b_Panel_IFS_MS_FundID_ChurnRate_2014m6on_Apr20.dta"

****************************************
*Drop Observations only in using
****************************************
quietly drop if _merge == 2
drop _merge


******************************************************************************************
******************************************************************************************
/* Part II: Additional Adjustments */
******************************************************************************************
******************************************************************************************

****************************************
/*Fill up Investment Regions*/
****************************************

*For each fund, what is the Investment Region we have for the majority of observations (i.e. egen = mode())
bys FundId: egen region_temp = mode(InvestmentRegion)

*Manually replace investment region if no investment region could be determined
replace region_temp = "Europe" if region_temp == "" & GlobalCategory == "Europe Equity Large Cap"
replace region_temp = "Europe" if region_temp == "" & GlobalCategory == "Europe Equity Mid/Small Cap"
replace region_temp = "Europe" if region_temp == "" & GlobalCategory == "UK Equity Mid/Small Cap"
replace region_temp = "Global" if region_temp == "" & GlobalCategory == "Global Equity Large Cap"
replace region_temp = "Global" if region_temp == "" & GlobalCategory == "Global Equity Mid/Small Cap"
replace region_temp = "Global" if region_temp == "" & GlobalCategory == "Other Equity"
replace region_temp = "North_America" if region_temp == "" & GlobalCategory == "US Equity Large Cap Blend"
replace region_temp = "Japan" if region_temp == "" & GlobalCategory == "Japan Equity"

drop InvestmentRegion
rename region_temp InvestmentRegion

label variable InvestmentRegion "Fund: Investment Region (based on Morningstar Fund Category)"
label variable turnover "Fund: Turnover (in %)"
label variable ln_turnover "Fund: Log of Turnover"
label variable churn_rate "Fund: Churn Rate (Gaspar et al., JFE 2005)"

****************************************
/*Save Merged Fund Data*/
****************************************
cd "${data_for_analysis}"
compress

describe
sum _all
tab datem

save "B1_Panel_IFS_MS_EquityFundID_allVars_2014m6on_Jul20.dta", replace




**********************************************************************************************
***EOF
**********************************************************************************************
