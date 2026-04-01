
******************************************************************************************************************************
******************************************************************************************************************************
***
*** Number of project:		2016\0082				
*** Title of project:		Securities lending by mutual funds
*** Data source: 			Investment Fund Statistics (Original Data is December 2009 until December 2018; later on, June 2014 until December 2018 is kept for the analysis)
*** Name of programme code:	A4-a_Markit_month_ultimo.do
***
*** Purpose of programme code: 
***			Part I: 	Generate Dataset with Daily and Monthly Date Variables
***			Part II: 	Eliminate Non-Trading Days in the Sample Period
***			Part III: 	Identify End-of-Month Dates and Save Trading Day File
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
/* Part I: Generate Dataset with End-of-Month Dates for Sample Period */
*********************************************
*********************************************
cd "${data_for_analysis}/04_Markit/Trading days"

/*Start with empty data set */
****************************************
clear
set obs 100000 

/*Date Variable (Numeric Values from 1 to _N -> format as date)*/
****************************************
gen date = _n
format date %td

/*Cut to the right time period: */
****************************************
drop if date <td(01jan2009)

/*Cut to the left time period: */
****************************************
drop if date >td(31dec2018)

/*Save Dataset */
****************************************
save "all_days.dta", replace

/*Calendar Month Variable */
****************************************
gen datem=  ym(year(date),month(date))
format datem %tm 


/*Drop Sat & Sun */
****************************************
gen dow = dow(date)
drop if dow == 6 /*Saturday*/
drop if dow == 0 /*Sunday */






*********************************************
*********************************************
/* Part II: Manual correction of non-trading days */
*********************************************
*********************************************


*************
/*2009*/
/*
An der FWB® Frankfurter Wertpapierbörse wird im Jahr 2009 von montags bis freitags außer am 1. Januar,
10. April, 13. April, 1. Mai, 24. Dezember, 25. Dezember und am 31. Dezember gehandelt. Der 24. und
31. Dezember sind Erfüllungstage.
*/

quietly{
	drop if date == td(01jan2009)
	drop if date == td(10apr2009)
	drop if date == td(13apr2009)
	drop if date == td(01may2009)
	drop if date == td(24dec2009)
	drop if date == td(25dec2009)
	drop if date == td(31dec2009)
}



*************
/*2010*/
/*
An der FWB® Frankfurter Wertpapierbörse wird im Jahr 2010 von montags bis freitags außer am 1. Januar,
2. April, 5. April, 24. Dezember und am 31. Dezember gehandelt. Der 24. und 31. Dezember sind Erfüllungstage.
*/

quietly{
	drop if date == td(01jan2010)
	drop if date == td(02apr2010)
	drop if date == td(05apr2010)
	drop if date == td(24dec2010)
	drop if date == td(31dec2010)
}


*************
/*2011*/
/*
An der FWB® Frankfurter Wertpapierbörse wird im Jahr 2011 von montags bis freitags außer am 22. April, 25. April
und am 26. Dezember gehandelt.
*/

quietly{
	drop if date == td(22apr2011)
	drop if date == td(25apr2011)
	drop if date == td(26dec2011)
}

*************
/*2012*/
/*
An der FWB® Frankfurter Wertpapierbörse wird im Jahr 2012 von montags bis freitags außer am 6. April, 9. April,
1. Mai, 24. Dezember, 25. Dezember, 26. Dezember und am 31. Dezember gehandelt. Der 24. und 31. Dezember
sind Erfüllungstage.
*/

quietly{
	drop if date == td(06apr2012)
	drop if date == td(09apr2012)
	drop if date == td(01may2012)
	drop if date == td(24dec2012)
	drop if date == td(25dec2012)
	drop if date == td(26dec2012)
	drop if date == td(31dec2012)
}


*************
/*2013*/
/*
An der FWB® Frankfurter Wertpapierbörse wird im Jahr 2013 von montags bis freitags außer am 1. Januar, 29. März,
1. April, 1. Mai, 24. Dezember, 25. Dezember, 26. Dezember und am 31. Dezember gehandelt. Der 24. und 31.
Dezember sind Erfüllungstage.
*/

quietly{
	drop if date == td(01jan2013)
	drop if date == td(29mar2013)
	drop if date == td(01apr2013)
	drop if date == td(01may2013)
	drop if date == td(24dec2013)
	drop if date == td(25dec2013)
	drop if date == td(26dec2013)
	drop if date == td(31dec2013)
}


*************
/*2014*/
/*
An der Frankfurter Wertpapierbörse (FWB®) wird im Jahr 2014 von montags bis freitags außer 
am 1. Januar, 18. April, 21. April, 1. Mai, 3. Oktober, 24. Dezember, 25. Dezember,
26. Dezember und am 31. Dezember gehandelt. Der 3. Oktober sowie der 24. und 31. Dezember sind Erfüllungstage.
*/

quietly{
	drop if date == td(01jan2014)
	drop if date == td(18apr2014)
	drop if date == td(21apr2014)
	drop if date == td(01may2014)
	drop if date == td(03oct2014)
	drop if date == td(24dec2014)
	drop if date == td(25dec2014)
	drop if date == td(26dec2014)
	drop if date == td(31dec2014)
}


*************
/*2015*/
/*
An der Frankfurter Wertpapierbörse (FWB®) wird im Jahr 2015 von montags bis freitags außer 
am 1. Januar, 3. April, 6. April, 1. Mai, 25. Mai, 24. Dezember, 25. Dezember und am
31. Dezember gehandelt. Der 25. Mai sowie der 24. und 31. Dezember sind Erfüllungstage
*/

quietly{
	drop if date == td(01jan2015)
	drop if date == td(03apr2015)
	drop if date == td(06apr2015)
	drop if date == td(01may2015)
	drop if date == td(25may2015)
	drop if date == td(24dec2015)
	drop if date == td(25dec2015)
	drop if date == td(31dec2015)
}


*************
/*2016*/
/*
An der Frankfurter Wertpapierbörse (FWB®) wird im Jahr 2016 von montags bis freitags außer 
am 1. Januar, 25. März, 28. März, 16. Mai, 3. Oktober und am 26. Dezember gehandelt.
Der 16. Mai sowie der 3. Oktober sind Erfüllungstage.
*/

quietly{
	drop if date == td(01jan2016)
	drop if date == td(25mar2016)
	drop if date == td(28mar2016)
	drop if date == td(16may2016)
	drop if date == td(03oct2016)
	drop if date == td(26dec2016)
}


*************
/*2017*/
/*
An der Frankfurter Wertpapierbörse (FWB®) wird im Jahr 2017 von montags bis freitags außer am
14. April, 17. April, 1. Mai, 5. Juni, 3. Oktober, 31. Oktober, 25. Dezember und am 26. Dezember gehandelt. 
Der 5. Juni, 3. Oktober und 31. Oktober sind Erfüllungstage
*/

quietly{
	drop if date == td(14apr2017)
	drop if date == td(17apr2017)
	drop if date == td(01may2017)
	drop if date == td(05jun2017)
	drop if date == td(03oct2017)
	drop if date == td(31oct2017)
	drop if date == td(25dec2017)
	drop if date == td(26dec2017)
}

*************
/*2018*/
/*
An der Frankfurter Wertpapierbörse (FWB®) wird im Jahr 2018 von montags bis freitags außer am 
1. Januar, 30. März, 2. April, 1. Mai, 21. Mai, 3. Oktober, 24. Dezember, 25. Dezember, 26. Dezember und am 31. Dezember gehandelt. 
Der 21. Mai, 3. Oktober, 24. Dezember und 31. Dezember sind Erfüllungstage.
*/
quietly{
	drop if date == td(01jan2018)
	drop if date == td(30mar2018)
	drop if date == td(02apr2018)
	drop if date == td(01may2018)
	drop if date == td(21may2018)
	drop if date == td(03oct2018)
	drop if date == td(24dec2018)
	drop if date == td(25dec2018)
	drop if date == td(26dec2018)
	drop if date == td(31dec2018)
}



*********************************************
*********************************************
/* Part III: Keep the last day of each month (Monat-Ultimo) */
*********************************************
*********************************************

/*
"Die Meldung bezieht sich – sofern nicht anders angegeben – auf den Stand zum
Ende des Berichtsmonats (Ultimo)."

Source: Statistik über Investmentvermögen, Richtlinien, Stand: 1. Juli 2015
File: statistik_ueber_investmentvermoegen.pdf
(see folder)

*/


/*How Many Days Per Month?*/
*********************************************
sort datem date
bys datem: gen temp = _n

/*Number of Days in Month t (use egen = max() to get a variable which is constant within month)*/
*********************************************
bys datem: egen temp_max = max(temp)

/*Identify Last Day in Month t (tagged with 0)*/
*********************************************
gen dum_month_ultimo = .
replace dum_month_ultimo = 0  if temp == temp_max

/*Identify the two Days Before Month End in Month t (tagged with -1 and -2)*/
*********************************************
tsset date
replace dum_month_ultimo = f.dum_month_ultimo - 1 if dum_month_ultimo == .
replace dum_month_ultimo = f.dum_month_ultimo - 1 if dum_month_ultimo == .

/*All other Days in Month t (tagged with -999)*/
*********************************************
replace dum_month_ultimo = -999 if dum_month_ultimo == .

*********************************************
/*Save File with Trading Days for Sample Period*/
*********************************************
keep datem date dum_month_ultimo

compress
describe

cd "${data_for_analysis}/04_Markit/Trading days"
save "trading_days_DE_Apr20.dta", replace

cd "${data_for_analysis}/04_Markit/Trading days"
erase "all_days.dta"

**********************************************************************************************
***EOF
**********************************************************************************************






