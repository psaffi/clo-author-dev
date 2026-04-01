
******************************************************************************************************************************
******************************************************************************************************************************
***
*** Number of project:		2016\0082				
*** Title of project:		Securities lending by mutual funds
*** Data source: 			Investment Fund Statistics (Original Data is December 2009 until December 2018; later on, June 2014 until December 2018 is kept for the analysis)
*** Name of programme code:	A3-a_ISINchanges_DS.do
***
*** Purpose of programme code: 
***			Part I: 	Import ISIN changes
***			Part II: 	Clean ISIN changes
***			Part III: 	Span ISIN changes to panel
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
/* Part I: Import ISIN changes (matched to respective InstrumentID) */
*********************************************
*********************************************


/*Load Key File Matching ISINs to Eikon Instrument IDs (comes from Eikon Download based on IFS-ISIN list)*/
****************************************
cd "${data_for_analysis}/03_DS_EIKON/ID_KEYS"
use "KEY_InstrumentID_ISIN.dta", replace


*********************************************
*********************************************
/* Part II: Clean ISIN changes  */
*********************************************
*********************************************

****************************************
/*Keep ISIN changes after June 2014 */
****************************************

/*Create Monthly Time Variable from Calendar Date (start_datem gives time since when the ISIN is valid)*/
****************************************
gen start_datem = mofd(start_date)
format start_datem %tm

/*Drop ISIN changes before June 2014*/
****************************************
qui keep if start_datem >= tm(2014m6)

****************************************
/*More than one ISIN change for an instrument in a given month -> keep last change*/
****************************************

/*Tag duplicates by InstrumentID in the same month (i.e. > 2 ISIN changes in one month)*/
****************************************
duplicates tag InstrumentID start_datem, gen(temp)
tab temp

/*For each duplicate by InstrumentID, what was the latest calendar date in this month?*/
****************************************
bys InstrumentID: egen max_date = max(start_date) if temp > 0

/*Drop if duplicate (i.e. temp > 0) and calendar date not equal to latest calendar date in this month*/
****************************************
qui drop if temp > 0 & max_date != start_date
drop temp max_date

****************************************
/*Manual adjustments*/
****************************************
quietly drop if InstrumentID == "21502536795" & ISIN == "US89621C1053" & start_date == td(08sep2016)
quietly drop if InstrumentID == "8590938613" & ISIN == "GBG4804L2051" & start_date == td(30jun2014)

quietly replace ISIN = "CA20653P1027" if ISIN == "US20653P1021" & InstrumentID == "21474958821"
quietly replace start_date = td(29jun2016) if ISIN == "CA20653P1027" & InstrumentID == "21474958821"


*********************************************
*********************************************
/* Part III: Span ISIN changes to panel  */
*********************************************
*********************************************

/*Drop if ISIN change occurs after end of sample perido*/
****************************************
egen ui = group(InstrumentID)
drop if start_datem > tm(2018m12)

/*Fill in missing months for each InstrumentID to get full panel*/
****************************************
tsset ui start_datem
tsfill, full

/*In each month, ISIN is now the valid ISIN of this month accounting for changes*/
****************************************
replace ISIN = ISIN[_n-1] if ISIN == "" & ui == l.ui
quietly drop if ISIN == ""

/*Fill up remaining variables after tsfill with lagged values of the variable*/
****************************************
replace InstrumentID = InstrumentID[_n-1] if InstrumentID == "" & ui == l.ui
replace start_date = l.start_date if start_date == . & ui == l.ui
drop ui

/*Rename*/
****************************************
rename ISIN ISIN_with_change
rename start_date ISIN_start_date
rename start_datem datem

/*Label variables*/
****************************************
label variable InstrumentID "Stock: Eikon Security Identifier"
label variable datem "Time Variable: Calendar Month"
label variable ISIN_start_date "Stock: Calendar Date of Security ISIN change"
label variable ISIN_with_change "Stock: Security Identifier accounting for ISIN changes"

/*Save data*/
****************************************
cd "${data_for_analysis}/03_DS_EIKON/ID_KEYS"
compress
describe

save "KEY_InstrumentID_ISINchange_2014m6on_spanned_Apr20.dta", replace


**********************************************************************************************
***EOF
**********************************************************************************************

