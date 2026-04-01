
******************************************************************************************************************************
******************************************************************************************************************************
***
*** Number of project:		2016\0082				
*** Title of project:		Securities lending by mutual funds
*** Data source: 			Investment Fund Statistics (Original Data is December 2009 until December 2018; later on, June 2014 until December 2018 is kept for the analysis)
*** Name of programme code:	A2-a_IFSholdings_import.do
***
*** Purpose of programme code: 
***			Part I: 	Import Investment Fund Statistics - Holding Information (month-by-month)
***			Part II: 	Append Investment Fund Statistics - Holding Information monthly files
***			Part III: 	Calculate additional variables for subsequent analysis
***			Part IV: 	Export ISIN list of holdings for Eikon request
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
/* Part I: Import Files */
*********************************************
*********************************************


****************************************
/* Define macros to access files for each month 
  (2014 is split into two separate macros because from December 2014 onwards, the list of variables in the IFS data was extended and some variables renamed)
  (2017 is split into two separate macros because October to December 2017 are part of the 2nd data delivery and therefore in a different folder) */
****************************************

global y2009 "200909 200910 200911 200912"
global y2010 "201001 201002 201003 201004 201005 201006 201007 201008 201009 201010 201011 201012"
global y2011 "201101 201102 201103 201104 201105 201106 201107 201108 201109 201110 201111 201112"
global y2012 "201201 201202 201203 201204 201205 201206 201207 201208 201209 201210 201211 201212"
global y2013 "201304 201305 201306 201307 201308 201309 201310 201311 201312 201301 201302 201303"
global y2014a "201401 201402 201403 201404 201405 201406 201407 201408 201409 201410 201411"

global y2014b "201412"
global y2015 "201501 201502 201503 201504 201506 201507 201508 201505 201509 201510 201511 201512"
global y2016 "201601 201602 201603 201604 201605 201606 201607 201608 201609 201610 201611 201612"
global y2017a "201701 201702 201703 201704 201705 201706 201707 201708 201709"

global y2017b "201710 201711 201712"
global y2018 "201801 201802 201803 201804 201805 201806 201807 201808 201809 201810 201811 201812"



****************************************
/*Import years 2009 - 2014 (until November 2014) */
****************************************
global imp_months "$y2009 $y2010 $y2011 $y2012 $y2013 $y2014a"
foreach x of global imp_months{

	display "Import `x'"
	clear
	
	*Import original file
	cd "${orig_data}/20160929"
	*import excel "`x'_Einzeldatensatz IFS_WP mit ISIN.xlsx", firstrow
	
	*Save .dta file
	cd "${data_for_analysis}/01_IFS/WP mit ISIN"
	*save "`x'_WP mit ISIN.dta", replace
}
/**/


****************************************
/*Import years 2014b - 2017a (from December 2014, different variables and varnames)*/ 
****************************************
global imp_months " $y2014b $y2015 $y2016 $y2017a"
foreach x of global imp_months{

	display "Import `x'"
	clear
	
	*Import original file
	cd "${orig_data}/20160929"
	*import excel "`x'_Einzeldatensatz IFS_Monatliche WP mit ISIN.xlsx", firstrow

	*Save .dta file
	cd "${data_for_analysis}/01_IFS/WP mit ISIN"
	*save "`x'_WP mit ISIN.dta", replace
}
/**/


****************************************
/*Import years 2017b - 2018 (different folder)*/ 
****************************************
global imp_months "$y2017b $y2018"
foreach x of global imp_months{

	display "Import `x'"
	clear
	
	*Import original file
	cd "${orig_data}/20190301"
	*import excel "`x'_Einzeldatensatz IFS_Monatliche WP mit ISIN.xlsx", firstrow

	*Save .dta file
	cd "${data_for_analysis}/01_IFS/WP mit ISIN"
	*save "`x'_WP mit ISIN.dta", replace
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
cd "${data_for_analysis}/01_IFS/WP mit ISIN"
local imp_files: dir "${data_for_analysis}/01_IFS/WP mit ISIN"  files "*.dta"
clear

foreach f in `imp_files' {
	display "Appending ... `f'"
	append using "`f'", force
}
/**/

****************************************
/* Drop unnecessary variables */
****************************************
drop SPERRKZ FONDSNAME RECHTLAND LEI
drop ORGANISATIONSFORM TYP_INVV ARTINHABER_OFFEN ARTERTRAG ARTLAUFZEIT ARTRUECK AUSSETZUNG AUSSETZUNG_SEIT NOTART BOERSENGEHANDELT INDEX_ABB INDEX_ABB_ISIN INDEX_ABB_TEXT
drop WERTGESICHERT MASTER_FEEDER HIERST UEBERFONDS BEREINIGUNG SPERRKZ_ALLG KENN
drop KAGNR INDEXFONDS ARTANLEGER ARTMITTEL ARTDACHFONDS	STUECKZINS NOMSTUECK_PENSION

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

*Calendar Month
gen datem = ym(year, month)
format datem %tm

drop year month
drop DATUM


****************************************
/*Fund Share Class ISIN, Security ISIN*/
****************************************
rename ISIN share_class_isin
rename WPKENN sec_isin
order share_class_isin sec_isin datem


****************************************
/* Label variables */
****************************************
label variable share_class_isin "Fund Share Class: ISIN"
label variable sec_isin "Stock: Security Identifier (as reported by fund)"
label variable NOTTYP "Stock: Notation Type (P = Percentage, S = Unit)"
label variable NOMSTUECK "Security: Nominal value in euro (percentage quoted) or number of shares (unit quoted)"
label variable KURSPREIS "Security: Rate (percentage quoted) or price of security in euro (number quoted)"
label variable SUMME "Security: Value of the position (in euro)"
label variable NOMSTUECK_WPLEI "Security: Number of shares in lending transactions"
label variable datem "Time Variable: Calendar Month"

 
 
****************************************
/* Save full data set*/
****************************************
cd "${data_for_analysis}/01_IFS/"
compress
describe

save "A2-a_IFS_ShareClass_Holdings_2009m9_2018m12_Apr20.dta", replace


*********************************************
*********************************************
/* Part IV: Holdings ISIN List */
*********************************************
*********************************************

****************************************
/*ISIN List of Holdings for Eikon Request*/
****************************************
preserve
keep sec_isin 
duplicates drop 
sort sec_isin 
rename sec_isin ISIN

export excel ISIN using "A2-a_IFS_Holdings_ISINList_2009m9_2018m12_Apr20.xlsx", replace
restore 



**********************************************************************************************
***EOF
**********************************************************************************************

