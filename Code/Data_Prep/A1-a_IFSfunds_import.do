
******************************************************************************************************************************
******************************************************************************************************************************
***
*** Number of project:		2016\0082				
*** Title of project:		Securities lending by mutual funds
*** Data source: 			Investment Fund Statistics (Original Data is December 2009 until December 2018; later on, June 2014 until December 2018 is kept for the analysis)
*** Name of programme code:	A1-a_IFSfunds_import.do
***
*** Purpose of programme code: 
***			Part I: 	Import Investment Fund Statistics - Fund Information (month-by-month)
***			Part II: 	Append Investment Fund Statistics - Fund Information monthly files
***			Part III: 	Calculate additional variables for subsequent analysis
***			Part IV: 	Export Fund Share Class ISIN List for Morningstar request
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
set excelxlsxlargefile on

******************************************************************************************************************************
******************************************************************************************************************************


*********************************************
*********************************************
/* Part I: Import Files */
*********************************************
*********************************************

****************************************
/* Define macros to access files for each month (2017 is split into two separate macros because October to December 2017 are 
   part of the second data delivery and therefore in a different folder) */
****************************************

global y2009 "200909 200910 200911 200912"
global y2010 "201001 201002 201003 201004 201005 201006 201007 201008 201009 201010 201011 201012"
global y2011 "201101 201102 201103 201104 201105 201106 201107 201108 201109 201110 201111 201112"
global y2012 "201201 201202 201203 201204 201205 201206 201207 201208 201209 201210 201211 201212"
global y2013 "201301 201302 201303 201304 201305 201306 201307 201308 201309 201310 201311 201312"
global y2014 "201401 201402 201403 201404 201405 201406 201407 201408 201409 201410 201411 201412"
global y2015 "201501 201502 201503 201504 201505 201506 201507 201508 201509 201510 201511 201512"
global y2016 "201601 201602 201603 201604 201605 201606 201607 201608 201609 201610 201611 201612"
global y2017a "201701 201702 201703 201704 201705 201706 201707 201708 201709"
global y2017b "201710 201711 201712"
global y2018 "201801 201802 201803 201804 201805 201806 201807 201808 201809 201810 201811 201812"


****************************************
/* Import years 2009-2015 */
****************************************
global imp_months "$y2009 $y2010 $y2011 $y2012 $y2013 $y2014 $y2015"
foreach x of global imp_months{

	display "Import `x'"
	clear
	
	*Import original file
	cd "${orig_data}/20160929"
	*import excel "`x'_Einzeldatensatz IFS_Allg Angaben & Hauptpositionen.xlsx", firstrow
	
	*Save .dta file
	cd "${data_for_analysis}/01_IFS/AllgA_Hauptpos"
	*save "`x'_Einzeldatensatz IFS_Allg Angaben & Hauptpositionen.dta", replace
	
}


****************************************
/* Import years 2016 - 2017 (different file name) */ 
****************************************
global imp_months "$y2016 $y2017a"
foreach x of global imp_months{

	display "Import `x'"
	clear
	
	*Import original file
	cd "${orig_data}/20160929"
	*import excel "`x'_Einzeldatensatz IFS_Hauptpositionen mit allg Angaben.xlsx", firstrow

	*Save .dta file	
	cd "${data_for_analysis}/01_IFS/AllgA_Hauptpos"
	*save "`x'_Einzeldatensatz IFS_Hauptpositionen mit allg Angaben.dta", replace
	
}
/**/

****************************************
/*Import years 2017 - 2018 (different folder)*/ 
****************************************
global imp_months "$y2017b $y2018"
foreach x of global imp_months{

	display "Import `x'"
	clear

	*Import original file
	cd "${orig_data}/20190301"
	*import excel "`x'_Einzeldatensatz IFS_Hauptpositionen mit allg Angaben.xlsx", firstrow

	*Save .dta file	
	cd "${data_for_analysis}/01_IFS/AllgA_Hauptpos"
	*save "`x'_Einzeldatensatz IFS_Hauptpositionen mit allg Angaben.dta", replace
	
}
/**/

******************************************************************************************************************************
******************************************************************************************************************************


*********************************************
*********************************************
/* Part II: Append Files */
*********************************************
*********************************************
 

****************************************
/*Append data */  
****************************************
cd "${data_for_analysis}/01_IFS/AllgA_Hauptpos"
local imp_files: dir "${data_for_analysis}/01_IFS/AllgA_Hauptpos" files "*.dta"
clear 

foreach f in `imp_files' {
	display "Appending ... `f'"
	append using "`f'", force
}
/**/

duplicates drop 

******************************************************************************************************************************
******************************************************************************************************************************

*********************************************
*********************************************
/* Part III: Calculate Variables */
*********************************************
*********************************************

****************************************
/*Date Variable*/
****************************************
tostring DATUM, replace 
gen year = substr(DATUM,1,4)
gen month = substr(DATUM,5,6)

destring year, replace
destring month, replace

*Calendar Month Variable
gen datem = ym(year, month)
format datem %tm

drop year month
drop DATUM



****************************************
/*ISIN Fund Share Class*/
****************************************
rename ISIN share_class_isin
encode share_class_isin, gen(ui_share_class)
order share_class_isin ui_share_class datem


****************************************
/*Type of investors (UCITS vs. AIF) -> we will drop AIF funds later on*/
****************************************

*Classify fund into UCITS and AIF based on ARTANLEGER information
tostring ARTANLEGER, replace
gen fund_type_UCITS_AIF = ""
replace fund_type_UCITS_AIF = "ucits" if ARTANLEGER == "110"
replace fund_type_UCITS_AIF = "aif" if substr(ARTANLEGER,1,2) == "12"

*Dummy Variable: 1 is AIF, 0 is UCITS
gen dum_fund_aif = .
replace dum_fund_aif = 0 if fund_type_UCITS_AIF == "ucits"
replace dum_fund_aif = 1 if fund_type_UCITS_AIF == "aif"
drop fund_type_UCITS_AIF

label define ucits_aif 0 "UCITS" 1 "AIF"
label values dum_fund_aif ucits_aif


****************************************
/* Index funds  */
****************************************

*Classify funds into index and non-index funds based on INDEXFONDS information
gen index_temp = 0 if INDEXFONDS != ""
replace index_temp = 1 if INDEXFONDS == "1"
replace index_temp = 0 if INDEXFONDS == "U"
replace index_temp = 0 if INDEXFONDS == "0"

*For each fund ISIN, label a fund as index fund if IFS classification is "index fund" in the majority of months (-> egen = mode())
bys share_class_isin: egen dum_fund_index = mode(index_temp)
tab dum_fund_index index_temp
drop index_temp

*Manual Adjustments (after look-up in fund's prospectus)
replace dum_fund_index = 1 if FONDSNAME == "NORD/LB AM Global Challenges Index-Fonds"
replace dum_fund_index = 1 if FONDSNAME == "Multi-Index Equity Fund"

label define index_fund 0 "Non-Index Fund" 1 "Index Fund"
label values dum_fund_index index_fund 


****************************************
/* NAV: net asset value (share class) */
****************************************
tsset ui_share_class datem
rename FONDSVERM nav_share_class


****************************************
/*Size of Fund family (BEFORE FILTERS!!!!!!)  */
****************************************
bys KAGNR datem: egen fund_family_nav = sum(nav_share_class)

****************************************
/*Inflows/outflows/netflows (share class) */
****************************************
rename (MITTELZUFL MITTELABFL) (inflow_share_class outflow_share_class)
gen netflow_share_class = inflow_share_class - outflow_share_class


****************************************
/* Keep & Order Necessary Variables */
****************************************
keep share_class_isin datem KAGNR dum_fund_aif dum_fund_index nav_share_class fund_family_nav inflow_share_class outflow_share_class netflow_share_class FONDSNAME WP
order share_class_isin datem FONDSNAME KAGNR dum_fund_aif dum_fund_index nav_share_class fund_family_nav inflow_share_class outflow_share_class netflow_share_class WP

****************************************
/* Label Variables */
****************************************
label variable KAGNR "Fund: KAG-Nummer (IFS Fund Family Number)"
label variable FONDSNAME "Fund: IFS Fund Name"
label variable WP "Fund Share Class: IFS Wertpapierbestände"
label variable dum_fund_aif "Dummy: IFS UCITS or AIF fund (1 = AIF, 0 = UCITS)"
label variable dum_fund_index "Dummy: IFS Index fund (1= Index, 0 = Non-Index)"
label variable share_class_isin "Fund Share Class: ISIN"
label variable datem "Time Variable: Calendar Month"
label variable nav_share_class "Fund Share Class: IFS Net asset value (NAV) (thousand euro)"
label variable fund_family_nav "Fund Family (KAGNR): IFS Net asset value (NAV) (thousand euro)"
label variable inflow_share_class "Fund Share Class: IFS Inflow (thousand euro)"
label variable outflow_share_class "Fund Share Class: IFS Outflow (thousand euro)"
label variable netflow_share_class "Fund Share Class: IFS Netflow (thousand euro)"


****************************************
/*Save full data set*/
****************************************
cd "${data_for_analysis}/01_IFS"
compress
describe

save "A1-a_IFS_ShareClass_Char_2009m9_2018m12_Apr20.dta", replace

*********************************************
*********************************************
/* Part IV: Fund Share Class ISIN List */
*********************************************
*********************************************

****************************************
/*Fund Share Class ISIN List (all share classes, for Morningstar Request)*/
****************************************
preserve
keep share_class_isin 
duplicates drop 
sort share_class_isin

export excel using "A1-a_IFS_ShareClass_ISINList_2009m9_2018m12_Apr20.xlsx", replace
restore 


**********************************************************************************************
***EOF
**********************************************************************************************
