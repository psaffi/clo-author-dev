
******************************************************************************************************************************
******************************************************************************************************************************
***
*** Number of project:		2016\0082				
*** Title of project:		Securities lending by mutual funds
*** Data source: 			Investment Fund Statistics (Original Data is December 2009 until December 2018; June 2014 until December 2018 is kept for analysis)
*** Name of programme code:	A1-c_IFSfunds_MS_TS_merge_fundlevel.do
***
*** Purpose of programme code: 
***			Part I: 	Import Morningstar fund time series information and merge it to IFS Fund Information
***			Part II: 	Combine fund share classes to fund level (collapse time series information from share class level to fund level)	
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
/* Part I: Import Morningstar Fund Info and Merge to IFS*/
*********************************************
*********************************************

****************************************
/* Load Morningstar Static Data (for Fund and Share Class Identifiers) */
****************************************
cd "${data_for_analysis}/02_MS"
use "MS_static_info_selected.dta", clear

*Keep Identifier (share class-level & fund-level)
keep FundId SecId GlobalBroadCategory
duplicates drop

****************************************
/* Load Morningstar TS data (merge on share class level) */
****************************************
cd "${data_for_analysis}/02_MS"
merge 1:m SecId using "MS_TSvars_all.dta"
quietly keep if _merge == 3
drop _merge


****************************************
/* Any Share Class duplicates (per month)? */
****************************************
duplicates tag SecId datem, gen(temp_dupl)
tab temp_dupl
drop temp_dupl


******************************************************************************************************************************
******************************************************************************************************************************

*********************************************
*********************************************
/* Part II: Collapse multiple fund share classes to fund level */
*********************************************
*********************************************


****************************************
/*For Funds with Multiple Share Classes, Calculate Asset-Weighted Gross and Net Return and Fund Costs (including & excluding transaction costs)*/
****************************************

/* Calculate lagged share class NAV (as weight) */
egen ui_temp = group(SecId)
tsset ui_temp datem
gen lTNA = l.TNA

/* Calculate asset-weighted fund variables */
bys FundId datem: egen GrossReturn_AW = wtmean(GrossReturn), weight(lTNA)
bys FundId datem: egen TotalReturn_AW = wtmean(TotalReturn), weight(lTNA)
bys FundId datem: egen CostsExTrFees_AW = wtmean(ReprCostsExTrFees), weight(lTNA)
bys FundId datem: egen CostsIncTrFees_AW = wtmean(ReprCostsIncTrFees), weight(lTNA)

****************************************
/* Collapse to Fund Level (for funds with more than one share class)*/
****************************************
collapse (mean) GrossReturn=GrossReturn_AW TotalReturn=TotalReturn_AW ///
				CostsExTrFees=CostsExTrFees_AW CostsIncTrFees=CostsIncTrFees_AW ///
		 (sum)	FundSize=TNA FundFlow=NetFlows ///
		 (first) GlobalBroadCategory ///
				,by(FundId datem)

order FundId datem  FundSize FundFlow GrossReturn TotalReturn CostsExTrFees CostsIncTrFees
sort FundId datem


****************************************
/* Rescale and label variables*/
****************************************
replace GrossReturn = GrossReturn/100
replace TotalReturn = TotalReturn/100
replace FundSize = FundSize/1000
replace FundFlow = FundFlow/1000
replace CostsExTrFees = CostsExTrFees/100
replace CostsIncTrFees = CostsIncTrFees/100

label variable datem "Time Variable: Calendar Month"
label variable FundId "Fund: Morningstar ID"
label variable GrossReturn "Fund: Morningstar Fund Gross Return (asset-weighted, unscaled)"
label variable TotalReturn "Fund: Morningstar Fund Net Return (asset-weighted, unscaled)"
label variable FundSize "Fund: Morningstar NAV (thousand euro)"
label variable FundFlow "Fund: Morningstar Netflow (thousand euro)"
label variable CostsExTrFees "Fund: Morningstar Fund Costs excl. Transaction Fees (asset-weighted, unscaled)"
label variable CostsIncTrFees "Fund: Morningstar Fund Costs incl. Transaction Fees (asset-weighted, unscaled)"
label variable GlobalBroadCategoryGroup "Fund: Morningstar Classification (Level 1)"

****************************************
/* Save Matched Fund-Level Time Series Data */
****************************************
cd "${data_for_analysis}/01_IFS"
compress
describe

save "A1-c_Panel_IFS_MS_FundID_TS_2009m9_2018m12_Apr20.dta", replace


**********************************************************************************************
***EOF
**********************************************************************************************
