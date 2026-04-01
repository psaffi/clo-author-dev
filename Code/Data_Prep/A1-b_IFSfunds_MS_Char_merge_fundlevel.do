
******************************************************************************************************************************
******************************************************************************************************************************
***
*** Number of project:		2016\0082				
*** Title of project:		Securities lending by mutual funds
*** Data source: 			Investment Fund Statistics (Original Data is December 2009 until December 2018; later on, June 2014 until December 2018 is kept for the analysis)
*** Name of programme code:	A1-b_IFfunds_MS_Char_merge_fundlevel.do
***
*** Purpose of programme code: 
***			Part I: 	Import Morningstar fund characteristics and merge it to IFS Investment Fund Statistic - Fund Information
***			Part II: 	Combine fund share classes to fund level(collapse information from share class level to fund level)	
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
/* Part I: Import Morningstar Fund Info and Merge to IFS*/
*********************************************
*********************************************

****************************************
/* Load Morningstar fund data */
****************************************
cd "${data_for_analysis}/02_MS"
use "MS_static_info_selected", clear

*Drop if no ISIN is available
rename ISIN share_class_isin
quietly drop if share_class_isin == ""

duplicates drop


****************************************
/* Share Class ISIN duplicates */
****************************************
duplicates tag share_class_isin, gen(temp_dupl)
tab temp_dupl

*Tag Oldest Share Class
gen dum_oldest = (OldestShareClass == "Yes")

*For duplicate ISINs, check if the ISIN is labelled as the oldest share class
bys share_class_isin: egen oldest_available = total(dum_oldest) if temp_dupl > 0

*Keep oldest share class if only one fund is oldest share class
quietly drop if temp_dupl > 0 & oldest_available == 1 & dum_oldest != 1
drop temp_dupl

*Keep oldest share class with non-missing FundID if multiple funds are oldest share classes
duplicates tag share_class_isin, gen(temp_dupl)
tab temp_dupl
quietly drop if temp_dupl > 0 & oldest_available == 2 & FundId == ""

*Keep share class with Base Currency == "Euro" if no funds are oldest share class
quietly drop if temp_dupl > 0 & oldest_available == 0 & BaseCurrency != "Euro"
drop temp_dupl oldest_available dum_oldest



****************************************
/* Merge to IFS (characteristics) fund data */
****************************************
cd "${data_for_analysis}\01_IFS"
merge 1:m share_class_isin using "A1-a_IFS_ShareClass_Char_2009m9_2018m12_Apr20.dta"

*Keep only those IFS funds for which Morningstar fund info is present, i.e. only for _merge == 3*/
quietly keep if _merge == 3 
drop _merge

*Drop Fund if no Fund Identifier is available
quietly drop if FundId == ""


******************************************************************************************************************************
******************************************************************************************************************************


*********************************************
*********************************************
/* Part II: Collapse multiple fund share classes to fund level */
*********************************************
*********************************************

****************************************
/*Number of share classes per fund */
****************************************
gen temp = 1
bys FundId datem: egen numbr_share_classes = sum(temp)
label variable numbr_share_classes "Number of share classes"
drop temp

****************************************
/* Fund Share Class Inception Date */
****************************************
gen inception_date = date(InceptionDate, "MDY")
gen inception_datem = mofd(inception_date)
format inception_date %td
format inception_datem %tm
drop InceptionDate

label variable inception_date "Fund Share Class Inception Date"
label variable inception_datem "Fund Share Class Inception Month"

****************************************
/* Funds with multiple AIF or Index Classifications */
****************************************
bys FundId: egen ever_aif = sum(dum_fund_aif)
gen dum_fund_aif_overall = (ever_aif > 0 & ever_aif != .)
drop dum_fund_aif
rename dum_fund_aif_overall dum_fund_aif 

bys FundId: egen ever_index = sum(dum_fund_index)
gen dum_fund_index_overall = (ever_index > 0 & ever_index != .)
drop dum_fund_index
rename dum_fund_index_overall dum_fund_index 



****************************************
/* Save Fund ISIN-FundID key */
****************************************
preserve
keep share_class_isin FundId SecId GlobalBroadCategoryGroup
duplicates drop

*Fund ISIN is unique, FundID can be assigned to multiple ISINs (i.e. a fund with multiple share classes)
cd "${data_for_analysis}"
save "KEY_IFS_MS_ShareClassISIN_FundID_Jul20.dta", replace
restore


****************************************
/* Collapse to Fund Level (for funds with more than one share class) */
****************************************
collapse (first) FONDSNAME GlobalCategory GlobalBroadCategoryGroup Domicile /// 
		 (firstnm) PrimaryProspectusBenchmark ///
		 (mean) dum_fund_aif dum_fund_index  ///
		 (mean) KAGNR numbr_share_classes fund_family_nav ManagementFee /// 
		 (sum) nav=nav_share_class WP inflow=inflow_share_class outflow=outflow_share_class netflow=netflow_share_class /// 
		 (min) inception_date*, /// 
		  by(FundId datem)


****************************************
/*Label Variables after collapse*/
****************************************
label variable FundId "Fund: Morningstar ID"
label variable FONDSNAME "Fund: IFS Fund Name"
label variable GlobalBroadCategoryGroup "Fund: Morningstar Classification (Level 1)"
label variable GlobalCategory "Fund: Morningstar Classification (Level 2)"
label variable Domicile "Fund: Morningstar Domicile"
label variable ManagementFee "Fund: Management Fee (in %)"
label variable dum_fund_index "Dummy: IFS Index fund (1 = Index, 0 = Non-Index)"
label variable dum_fund_aif "Dummy: IFS AIF fund (1 = AIF, 0 = UCITS)"
label variable KAGNR "Fund: KAG-Nummer (IFS Fund Family Number)"
label variable WP "Fund: IFS Wertpapierbestände"
label variable numbr_share_classes "Fund: Number of Share Classes"

label variable nav "Fund: IFS Net asset value (NAV) (thousand euro)"
label variable fund_family_nav "Fund Family (KAGNR): IFS Net asset value (NAV) (thousand euro)"
label variable inflow "Fund: IFS Inflow (thousand euro)"
label variable outflow "Fund: IFS Outflow (thousand euro)"
label variable netflow "Fund: IFS Netflow (thousand euro)"

label variable inception_date "Fund: Inception Date Oldest Share Class"
label variable inception_datem "Fund: Inception Month Oldest Share Class"

capture label define ucits_aif 0 "UCITS" 1 "AIF"
label values dum_fund_aif ucits_aif

capture label define index_fund 0 "Non-Index Fund" 1 "Index Fund"
label values dum_fund_index index_fund 

****************************************
/*Age since inception (add one month to avoid zero age); 
  Assumption: fund's inception is at the beginning of month */
****************************************
gen age = datem - inception_datem + 1 
replace age = 0 if age <0
replace age = age/12

label variable age "Fund: Age in years"


****************************************
/*Fund flow relative to past month NAV*/
****************************************
egen ui_temp = group(FundId)
tsset ui_temp datem

gen relflow = netflow/l.nav
drop ui_temp

label variable relflow "Fund: IFS Netflow (relative to IFS Lagged Fund NAV, in %)"

egen ui_benchmark = group(PrimaryProspectusBenchmark)

****************************************
/* Save Data */
****************************************
cd "${data_for_analysis}/01_IFS"
compress
describe


save "A1-b_Panel_IFS_MS_FundID_Char_2009m9_2018m12_Jul20.dta", replace


**********************************************************************************************
***EOF
**********************************************************************************************
