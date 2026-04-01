******************************************************************************************************************************
******************************************************************************************************************************
***
*** Number of project:		2016\0082				
*** Title of project:		Securities lending by mutual funds
*** Data source: 			Investment Fund Statistics (Original Data is December 2009 until December 2018; June 2014 until December 2018 is kept for analysis)
*** Name of programme code:	B3_MergedFile_EquityFunds_FinalSample.do
***
*** Purpose of programme code: 
***			Part I: 	Filter Merged Data Set
***			Part II: 	Calculate Security Lending Dummies and Security Lending Variables
***			Part III: 	Calculate additional variables required for subsequent analysis and save final data set
***					
******************************************************************************************************************************
******************************************************************************************************************************


/* Paths : */

*Comment next two lines out when running code via the master file (information comes from there in this case)
*global datum 				= 	"20200416"				/* Date in the form yyyymmdd */
global proj_num				=	"2016_0082r"			/* Please spezify project number with underscore */

global path					= 	"\\in.bundesbank.de.\BBK\Daten\Zentrale\ZB-S\Daten_FDSZ_Gastforscher\1_gafo\\${proj_num}"

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



******************************************************************************************************************************
******************************************************************************************************************************
/* Part I: Filter Merged Data Set */
******************************************************************************************************************************
******************************************************************************************************************************

****************************************
/*Use merged data set */
****************************************
cd "${data_for_analysis}"
*use "B2_Panel_EquityFunds_FinalMerge_2014m6on_Jun20.dta", clear
use "B2_Panel_EquityFunds_FinalMerge_2014m6on_Dec22.dta", clear


/****************************************
/*FILTER: keep only ordinary and preferred shares with Stück-Quotierung*/
****************************************
qui keep if InstrumentTypeCode == "ORD" | InstrumentTypeCode == "PRF"  | InstrumentTypeCode == "FULLPAID"
qui keep if NOTTYP == "S"		//only 26 obs with NOTTYP == "P" anyhow
drop InstrumentTypeCode NOTTYP

****************************************
/*FILTER: keep only securities traded in developed markets (as defined by Fama/French)*/
****************************************
qui keep if dum_developedmkt_ff == 1
drop dum_developedmkt_ff
*/

****************************************
*FILTER: Sample Period (we keep one more month prior to the start of the sample period in order to calculate lagged values)
****************************************
qui drop if datem < tm(2014m11)

****************************************
/*Screens: negative values and lending exceeds holdings! */
****************************************
replace NOMSTUECK = . if NOMSTUECK <0
replace NOMSTUECK_adj = . if NOMSTUECK_adj < 0

replace NOMSTUECK_WPLEI = . if NOMSTUECK_WPLEI <0
replace NOMSTUECK_WPLEI = . if NOMSTUECK_WPLEI > NOMSTUECK

replace NOMSTUECK_WPLEI_adj = . if NOMSTUECK_WPLEI_adj <0
replace NOMSTUECK_WPLEI_adj = . if NOMSTUECK_WPLEI_adj > NOMSTUECK_adj

******************************************************************************************************************************
******************************************************************************************************************************
/* Part II: Lending Dummies and Securities Lending Variables */
******************************************************************************************************************************
******************************************************************************************************************************

************************************
/*Unique ids (ui) for stocks, funds, fund families and combinations*/
************************************
egen ui_fund = group(FundId)
egen ui_family = group(KAGNR)
egen ui_dscd = group(DSCD)
egen ui_fund_sec = group(ui_fund ui_dscd)
egen ui_family_sec = group(ui_family ui_dscd)
egen ui_sec_datem = group(DSCD datem) 
egen ui_fund_datem = group(FundId datem) 
egen ui_GlobalCategory = group(GlobalCategory)

order ui_fund ui_family ui_dscd ui_fund_sec ui_fund_datem ui_sec_datem ui_GlobalCategory FundId DSCD datem


************************************
/*Number of securities held by fund */
************************************
gen dum = 1
bys ui_fund datem: egen Numbr_Stocks = sum(dum)
label variable Numbr_Stocks "Monthly number of securities held by fund"
drop dum


************************************
/*Active vs. Passive Fund (redefined)*/
************************************
gen dum_fund_active = abs(dum_fund_index - 1)
tab dum_fund_active dum_fund_index
drop dum_fund_index 


**********************************************************
**********************************************************
/*Variable Calculation for Securities' Lending*/
**********************************************************
**********************************************************

************************************
/*Share: fraction of stocks lend out */
************************************
gen sh_sec_lend = NOMSTUECK_WPLEI/NOMSTUECK
label variable sh_sec_lend "Share of Security lent out"

gen sh_sec_lend_adj = NOMSTUECK_WPLEI_adj/NOMSTUECK_adj
label variable sh_sec_lend_adj "Share of Security lent out (NOMSTUECK adjusted)"

*No Lending information prior to December 2014 reported
replace sh_sec_lend = . if datem < tm(2014m12)
replace sh_sec_lend_adj = . if datem < tm(2014m12)


************************************
/*Market value of stocks lend out */
************************************
gen sec_mv_lend = KURSPREIS*NOMSTUECK_WPLEI
replace sec_mv_lend = sec_mv_lend/10^3

gen sec_mv_lend_adj = KURSPREIS*NOMSTUECK_WPLEI_adj
replace sec_mv_lend_adj = sec_mv_lend_adj/10^3


*No Lending information prior to December 2014 reported
replace sec_mv_lend = . if datem < tm(2014m12)
replace sec_mv_lend_adj = . if datem < tm(2014m12)

gen sec_rel_lend_adj = sec_mv_lend_adj/(MV_eur*10^3)
replace sec_rel_lend_adj = sec_rel_lend_adj*100

bys ui_family ui_dscd datem: egen temp = sum(sec_mv_lend_adj)
gen sec_rel_lend_fam_adj = temp/(MV_eur*10^3)
replace sec_rel_lend_fam_adj = sec_rel_lend_fam_adj*100
drop temp


************************************
/*Share of fund holdings lend out (in terms of overall fund holdings' market value) */
************************************
bys ui_fund datem: egen fund_mv_lend = sum(sec_mv_lend_adj)
bys ui_fund datem: egen fund_mv_lend_adj = sum(sec_mv_lend_adj)
bys ui_fund datem: egen fund_mv_developed = sum(sec_mv)
bys ui_fund datem: egen fund_mv_developed_adj = sum(sec_mv_adj)

gen sh_fund_mv_lend = fund_mv_lend/fund_mv_developed
gen sh_fund_mv_lend_adj = fund_mv_lend_adj/fund_mv_developed_adj

label variable sec_mv_lend "Market value of lent security (in thousand EUR)"
label variable fund_mv_lend "Market value of lent securities in fund (per month, in thousand EUR)"
label variable sh_fund_mv_lend "Share of portfolio on loan (per month)"


label variable sec_mv_lend_adj "Market value of lent security (in thousand EUR, nom_adj)"
label variable fund_mv_lend_adj "Market value of lent securities in fund (per month, in thousand EUR, nom_adj)"
label variable sh_fund_mv_lend_adj "Share of portfolio on loan (per month, nom_adj)"


**********************************************************
**********************************************************
/*Security Lending Dummy
  -------------------------------------------------------------------------
  Here, we create a dummy variable indicating whether a fund has lend a PARTICULAR security in the current month or somewhen in the last 6 or 12 months 
  (i.e. lending at the fund-security-level)
  
  If this is the case, the respective dummy is set to one (calculated from Dez 2014 onwards when lending information becomes available) */
**********************************************************
**********************************************************

************************************
/*Dummy: Is a Security currently on loan */
************************************
gen dum_slend_now = .
replace dum_slend_now = 0 if sh_sec_lend_adj == 0 & sh_sec_lend_adj !=.
replace dum_slend_now = 1 if sh_sec_lend_adj >0 & sh_sec_lend_adj !=. // & NOMSTUECK_WPLEI_adj >= 1

*Set dummy to missing if exit month
************************************
replace dum_slend_now = . if dum_exit == 1

*Set dummy to missing if prior to December 2014 (we do not know anything about lending before)
************************************
replace dum_slend_now = . if datem < tm(2014m12)
label variable dum_slend_now "Dummy: Security lend out by a given fund in a given month"


************************************
/*Number and share of securities lent by fund */
************************************
bys ui_fund datem: egen Numbr_Stocks_Lend = sum(dum_slend_now)
gen sh_fund_numbr_lend = Numbr_Stocks_Lend/Numbr_Stocks

label variable Numbr_Stocks_Lend "Monthly number of securities lend by fund"
label variable sh_fund_numbr_lend "Monthly share of securities lend by fund"


************************************
*Fund lend PARTICULAR Security at least once in the last 6, or 12 months (including current month)
************************************

foreach i of numlist 3 4 5 6 12{
	preserve
	keep ui_fund_sec datem dum_slend_now sec_rel_lend_adj
	
	*Fill up panel to have a time series without gaps
	************************************
	tsset ui_fund_sec datem
	tsfill
	
	*For filled up observations, security was not lend (in a given month, by a given fund...else, it would not have been missing because added through tsfill)
	************************************
	replace sec_rel_lend_adj = 0 if dum_slend_now == .
	replace dum_slend_now = 0 if dum_slend_now == .
	
	bys ui_fund_sec: gen ti = _n
	
	
	*For each fund-stock pair, loop through month 1 to i (i={6,12}) and count how often a security was lend
	************************************
	tsset ui_fund_sec datem
	gen temp = dum_slend_now if ti == 1
	gen temp2 = sec_rel_lend_adj if ti ==1
	forvalues j = 2(1)`i'{
		replace temp = l.temp + dum_slend_now if ti == `j' & ui_fund_sec == l.ui_fund_sec
		replace temp2 = l.temp2 + sec_rel_lend_adj if ti == `j' & ui_fund_sec == l.ui_fund_sec
	}
	
	*After 6 or 12 months (respectively), we add the value of the security lending dummy of the current month and subtract the value of the security 
	*lending dummy 6 or 12 months ago (so that we always have a constant time window)
	************************************
	replace temp = l.temp + dum_slend_now - l`i'.dum_slend_now if ui_fund_sec == l.ui_fund_sec & ti > `i'	
	replace temp2 = l.temp2 + sec_rel_lend_adj - l`i'.sec_rel_lend_adj if ui_fund_sec == l.ui_fund_sec & ti > `i'	

	*Dummy: Security was lend at least once in the last 6 or 12 months is equal to one if the running sum calculated above is non-negative
	************************************
	gen dum_slend_`i'm = (temp > 0 & temp != .)
	replace dum_slend_`i'm = . if datem < tm(2014m12)
	
	gen on_loan_fund_`i'm = temp2/`i'
	replace on_loan_fund_`i'm = . if datem < tm(2014m12)
	
	*Save temporary file containing the security lending dummy
	************************************
	keep ui_fund_sec datem dum_slend_`i'm on_loan_fund_`i'm
	save "temp_`i'm.dta", replace
	restore
	
	*Merge temporary file to final data sample
	************************************
	merge 1:1 ui_fund_sec datem using "temp_`i'm.dta"
	keep if _merge == 3
	drop _merge
	erase "temp_`i'm.dta"
}

label variable dum_slend_3m "Dummy: Security lend out by a given fund at least once in last 3 months"
label variable dum_slend_6m "Dummy: Security lend out by a given fund at least once in last 6 months"
label variable dum_slend_12m "Dummy: Security lend out by a given fund at least once in last 12 months"

label variable on_loan_fund_3m "Average amount on loan of a given stock by a given fund in last 3 months"
label variable on_loan_fund_6m "Average amount on loan of a given stock by a given fund in last 6 months"
label variable on_loan_fund_12m "Average amount on loan of a given stock by a given fund in last 12 months"




**********************************************************
**********************************************************
/*Fund Lending Dummies
  -------------------------------------------------------------------------
  Here, we create a dummy variable indicating whether a fund has lend ANY security at all, in the current month or somewhen in the last 6 or 12 months 
  (i.e. lending at the fund-level)
  
  If this is the case, the dummy is set to one (calculated from Dez 2014 onwards when lending information becomes available) */
**********************************************************
**********************************************************

************************************
/*Does a fund participate in lending at all (once in sample period)?*/
************************************
capture drop temp

bys ui_fund: egen temp = sum(dum_slend_now)
gen dum_flend_overall = 0
replace dum_flend_overall = 1 if temp>0 & temp != .
drop temp
label variable dum_flend_overall "Dummy: Fund is lender (once in sample)"


************************************
*In a given month (at least one Security)
************************************
bys ui_fund datem: egen temp = sum(dum_slend_now)
gen dum_flend_now = 0
replace dum_flend_now = 1 if temp >0 & temp != .
replace dum_flend_now = . if datem < tm(2014m12)
drop temp
label variable dum_flend_now "Dummy: Fund is lender (in current month)"


************************************
*At all (first time in sample period until now)
************************************
sort ui_fund datem
by ui_fund: gen temp = sum(dum_slend_now)
gen dum_fund_temp = 0
replace dum_fund_temp = 1 if temp>0 & temp != .
bys ui_fund datem: egen dum_flend_once_now = max(dum_fund_temp)
replace dum_flend_once_now = . if datem < tm(2014m12)
drop temp dum_fund_temp
label variable dum_flend_once_now "Dummy: Fund is lender (once in past)"


************************************
*Fund lends ANY Security at least once in the last 6 or 12 months (including current month)
************************************
foreach i of numlist 3 6 12{
	preserve
	keep ui_fund datem dum_flend_now
	duplicates drop
	
	*Fill up panel to have a time series without gaps
	************************************
	tsset ui_fund datem
	tsfill
	
	*For filled up observations, fund was not lending (in a given month...else, it would not have been missing because added through tsfill)
	************************************
	replace dum_flend_now = 0 if dum_flend_now == .
	bys ui_fund: gen ti = _n

	*For each fund, loop through month 1 to i (i={6,12}) and count how often a fund has lend at least one security (in a given month)
	************************************
	tsset ui_fund datem
	gen temp = dum_flend_now if ti == 1
	forvalues j = 2(1)`i'{
		replace temp = l.temp + dum_flend_now if ti == `j' & ui_fund == l.ui_fund
	}
	
	*After 6 or 12 months (respectively), we add the value of the fund lending dummy of the current month and subtract the value of the fund lending dummy 6 or 12 months ago (so that we always have a constant time window)
	************************************
	replace temp = l.temp + dum_flend_now - l`i'.dum_flend_now if ui_fund == l.ui_fund & ti > `i'
	
	*Dummy: Fund was lending at least once in the last 6 or 12 months is equal to one if the running sum calculated above is non-negative
	************************************
	gen dum_flend_`i'm = (temp > 0 & temp != .)
	replace dum_flend_`i'm = . if datem < tm(2014m12)

	*Save temporary file containing the fund lending dummy
	************************************
	keep ui_fund datem dum_flend_`i'm
	duplicates drop
	save "temp_`i'm.dta", replace
	restore

	*Merge temporary file to final data sample
	************************************
	merge m:1 ui_fund datem using "temp_`i'm.dta"
	keep if _merge == 3
	drop _merge
	erase "temp_`i'm.dta"
}

label variable dum_flend_3m "Dummy: Fund is lender (in last 3 months)"
label variable dum_flend_6m "Dummy: Fund is lender (in last 6 months)"
label variable dum_flend_12m "Dummy: Fund is lender (in last 12 months)"




**********************************************************
**********************************************************
/*Fund Family Lending Dummies
  -------------------------------------------------------------------------
  Here, we create a dummy variable indicating whether a fund family has lend ANY security at all, in the current month or somewhen in the last 6 or 12 
  months (i.e. lending at the fund family-level)
  
  If this is the case, the dummy is set to one (calculated from Dez 2014 onwards when lending information becomes available) */
**********************************************************
**********************************************************

************************************
/*Does a fund family participate in lending at all (once in sample period)? */
************************************
capture drop temp

bys ui_family: egen temp = sum(dum_slend_now)
gen dum_fflend_overall = 0
replace dum_fflend_overall = 1 if temp>0 & temp != .
drop temp
label variable dum_fflend_overall "Dummy: Fund Family is lender (once in sample)"

************************************
*In a given month (at least one Security)
************************************
bys ui_family datem: egen temp = sum(dum_slend_now)
gen dum_fflend_now = 0
replace dum_fflend_now = 1 if temp >0 & temp != .
replace dum_fflend_now = . if datem < tm(2014m12)
drop temp
label variable dum_fflend_now "Dummy: Fund Family is lender (in current month)"


************************************
*At all (first time in sample period until now)
************************************
sort ui_family datem
by ui_family: gen temp = sum(dum_slend_now)
gen dum_family_temp = 0
replace dum_family_temp = 1 if temp>0 & temp != .
bys ui_family datem: egen dum_fflend_once_now = max(dum_family_temp)
replace dum_fflend_once_now = . if datem < tm(2014m12)
drop temp dum_family_temp
label variable dum_fflend_once_now "Dummy: Fund Family is lender (once in past)"


************************************
*Fund Family lends ANY Security at least once in the last 6 or 12 months (including current month)
************************************
foreach i of numlist 3 6 12{
	preserve
	keep ui_family datem dum_fflend_now 
	duplicates drop
	
	*Fill up panel to have a time series without gaps
	************************************
	tsset ui_family datem
	tsfill
	
	*For filled up observations, fund family was not lending (in a given month...else, it would not have been missing because added through tsfill)
	************************************
	replace dum_fflend_now = 0 if dum_fflend_now == .
	bys ui_family: gen ti = _n

	*For each fund family, loop through month 1 to i (i={6,12}) and count how often a fund family has lend at least one security (in a given month)
	************************************
	tsset ui_family datem
	gen temp = dum_fflend_now if ti == 1
	forvalues j = 2(1)`i'{
		replace temp = l.temp + dum_fflend_now if ti == `j' & ui_family == l.ui_family
	}
	
	*After 6 or 12 months (respectively), we add the value of the fund family lending dummy of the current month and subtract the value of the fund family 
	*lending dummy 6 or 12 months ago (so that we always have a constant time window)
	************************************
	replace temp = l.temp + dum_fflend_now - l`i'.dum_fflend_now if ui_family == l.ui_family & ti > `i'
	
	*Dummy: Fund Family was lending at least once in the last 6 or 12 months is equal to one if the running sum calculated above is non-negative
	************************************
	gen dum_fflend_`i'm = (temp > 0 & temp != .)
	replace dum_fflend_`i'm = . if datem < tm(2014m12)
	
	*Save temporary file containing the fund lending dummy
	************************************
	keep ui_family datem dum_fflend_`i'm
	duplicates drop
	save "temp_`i'm.dta", replace
	restore

	*Merge temporary file to final data sample
	************************************
	merge m:1 ui_family datem using "temp_`i'm.dta"
	keep if _merge == 3
	drop _merge
	erase "temp_`i'm.dta"
}

label variable dum_fflend_3m "Dummy: Fund Family is lender (in last 3 months)"
label variable dum_fflend_6m "Dummy: Fund Family is lender (in last 6 months)"
label variable dum_fflend_12m "Dummy: Fund Family is lender (in last 12 months)"




**********************************************************
**********************************************************
/*Fund Family Securities Lending Dummies
  -------------------------------------------------------------------------
  Here, we create a dummy variable indicating whether a fund family has lend a PARTICULAR security in the current month or somewhen in the last 6 or 12 
  months (i.e. lending at the fund family-security-level)
  
  If this is the case, the respective dummy is set to one (calculated from Dez 2014 onwards when lending information becomes available) */
**********************************************************
**********************************************************

************************************
*In a given month (at least one Security)
************************************
bys ui_family ui_dscd datem: egen temp = sum(dum_slend_now)
gen dum_ff_slend_now = 0
replace dum_ff_slend_now = 1 if temp >0 & temp != .
replace dum_ff_slend_now = . if datem < tm(2014m12)
drop temp
label variable dum_ff_slend_now "Dummy: Security lend out by a given fund family in a given month"


************************************
*Fund Family lend PARTICULAR Security at least once in the last 6, or 12 months (including current month)
************************************

foreach i of numlist 3 6 12{
	preserve
	keep ui_family_sec ui_dscd datem dum_ff_slend_now sec_rel_lend_fam_adj
	duplicates drop

	
	*Fill up panel to have a time series without gaps
	************************************
	tsset ui_family_sec datem
	tsfill
	
	*For filled up observations, security was not lend (in a given month, by a given fund...else, it would not be missing because added through tsfill)
	************************************
	replace dum_ff_slend_now = 0 if dum_ff_slend_now == .
	replace sec_rel_lend_fam_adj = 0 if dum_ff_slend_now == .
	bys ui_family_sec: gen ti = _n
	

	*For each fund-stock pair, loop through month 1 to i (i={6,12}) and count how often a security was lend
	************************************
	tsset ui_family_sec datem
	gen temp = dum_ff_slend_now if ti == 1
	gen temp2 = sec_rel_lend_fam_adj if ti ==1
	
	forvalues j = 2(1)`i'{
		replace temp = l.temp + dum_ff_slend_now if ti == `j' & ui_family_sec == l.ui_family_sec
		replace temp2 = l.temp2 + sec_rel_lend_fam_adj if ti == `j' & ui_family_sec == l.ui_family_sec
	}
	
	*After 6 or 12 months (respectively), we add the value of the security lending dummy of the current month and subtract the value of the security 
	*lending dummy 6 or 12 months ago (so that we always have a constant time window)
	************************************
	replace temp = l.temp + dum_ff_slend_now - l`i'.dum_ff_slend_now if ui_family_sec == l.ui_family_sec & ti > `i'	
	replace temp2 = l.temp2 + sec_rel_lend_fam_adj - l`i'.sec_rel_lend_fam_adj if ui_family_sec == l.ui_family_sec & ti > `i'	

	
	*Dummy: Security was lend at least once in the last 6 or 12 months is equal to one if the running sum calculated above is non-negative
	************************************
	gen dum_ff_slend_`i'm = (temp > 0 & temp != .)
	replace dum_ff_slend_`i'm = . if datem < tm(2014m12)
	
	gen on_loan_fam_`i'm = temp2/`i'
	replace on_loan_fam_`i'm = . if datem < tm(2014m12)
	
	*Save temporary file containing the security lending dummy
	************************************
	keep ui_family_sec datem dum_ff_slend_`i'm on_loan_fam_`i'm
	save "temp_`i'm.dta", replace
	restore
	
	*Merge temporary file to final data sample
	************************************
	merge m:1 ui_family_sec datem using "temp_`i'm.dta"
	keep if _merge == 3
	drop _merge
	erase "temp_`i'm.dta"
}

label variable dum_ff_slend_3m "Dummy: Security lend out by a given fund family at least once in last 3 months"
label variable dum_ff_slend_6m "Dummy: Security lend out by a given fund family at least once in last 6 months"
label variable dum_ff_slend_12m "Dummy: Security lend out by a given fund family at least once in last 12 months"

label variable on_loan_fam_3m "Average amount on loan of a given stock by a given family in last 3 months"
label variable on_loan_fam_6m "Average amount on loan of a given stock by a given family in last 6 months"
label variable on_loan_fam_12m "Average amount on loan of a given stock by a given family in last 12 months"




******************************************************************************************************************************
******************************************************************************************************************************
/* Part III: Additional Variables */
******************************************************************************************************************************
******************************************************************************************************************************

**********************************************************
/*Position Weights - Ordinary Shares, Developed Markets Portfolio*/
**********************************************************
gen pos_w_developed = sec_mv/fund_mv_developed
replace pos_w_developed = pos_w_developed*100
label variable pos_w_developed "Fund Portfolio Position Weight (Ordinary Shares, Developed Markets Portfolio)"

gen pos_w_developed_adj = sec_mv/fund_mv_developed_adj
replace pos_w_developed_adj = pos_w_developed_adj*100
label variable pos_w_developed_adj "Fund Portfolio Position Weight (Ordinary Shares, Developed Markets Portfolio, nom_adj)"

**********************************************************
/*Calculate number of countries and regions a fund is invested in for a given month*/
**********************************************************

/*one observation per fund-country-month */
************************************
bys ui_fund datem CountryofHeadquarters : gen fund_holding_countries = _n
replace fund_holding_countries = . if fund_holding_countries != 1
replace fund_holding_countries = . if  CountryofHeadquarters == ""

/*Number of countries per fund*/
************************************
bys ui_fund datem: egen Numbr_Countries = sum(fund_holding_countries)
label variable Numbr_Countries "Fund: Number of Invested Countries"

/*one observation per fund-region-month */
************************************
bys ui_fund datem world_region_ff : gen fund_holding_regions = _n
replace fund_holding_regions = . if fund_holding_regions != 1
replace fund_holding_regions = . if  world_region_ff == ""

/*Number of regions per fund*/
************************************
bys ui_fund datem: egen Numbr_Regions = sum(fund_holding_regions)
label variable Numbr_Countries "Fund: Number of Invested Regions (out of 4)"

**********************************************************
/*Herfindahl Index*/
**********************************************************

/*Cumulative portfolio position weight per fund-country-month*/
************************************
bys ui_fund CountryofHeadquarters datem: egen pos_w_country = sum(pos_w_developed)
replace pos_w_country = . if fund_holding_countries != 1

/*Herfindahl Index: sum of squared country portfolio position weights*/
************************************
gen pos_w_country_squared = pos_w_country^2
bys ui_fund datem: egen hhi = sum(pos_w_country_squared)
replace hhi = hhi/100

label variable hhi "Herfindahl Index of Fund Holdings from 0 (not diversified) to 100 (max diversified)"
drop pos_w_country* fund_holding_countries fund_holding_regions


**********************************************************
/*Share of German Stocks (in % and as an indicator equal to one if most positions are German Stocks)*/
**********************************************************

/*Dummy Variable if stock has headquarter in Germany*/
************************************
gen dum_german = (CountryofHeadquarters == "Germany")

/*Dummy Variable if the majority of stock holdings of a given fund are German stocks*/
************************************
bys ui_fund: egen fund_focus_german = mode(dum_german)

/*Continuous Variable: Sum of position weights of German stocks for a given fund in a given month*/
************************************
bys ui_fund datem: egen share_temp = sum(pos_w_developed) if CountryofHeadquarters == "Germany"
bys ui_fund_datem: egen share_german_stocks = min(share_temp)
replace share_german_stocks = 0 if share_german_stocks == .
drop share_temp

/*Label Variables*/
************************************
label variable share_german_stocks "Fund Portfolio Position Weight Invested In German Stocks (weighted by market cap)"
label variable fund_focus_german "Dummy: Majority of Fund Portfolio Positions are German Stocks (1=yes, 0=no)"
drop dum_german


**********************************************************
/*Split up funds into Global, Europe and German Investment Focus*/
**********************************************************
gen Investment_Focus = ""
replace Investment_Focus = "Global" if InvestmentRegion == "Global"
replace Investment_Focus = "Europe" if InvestmentRegion == "Europe"
replace Investment_Focus = "Germany" if fund_focus_german == 1
replace Investment_Focus = "Other" if Investment_Focus == ""

label variable Investment_Focus "Fund Investment Focus: Global, Europe, Germany, Other"


**********************************************************
/* Stock Liquidity Percentile Ranks (within a portfolio, 
   sort stocks based on BAS or Amihud Ratio and assing a 
   rank ranging from 0 (most liquid) to 1 (least liquid) */
**********************************************************
bys ui_fund datem: egen temp_n = count(DSCD)
bys ui_fund datem: egen temp_i = rank(amihud_illiq)
gen pct_amihud_rank = 100*((temp_i - 0.5) / temp_n)
drop temp_n temp_i

bys ui_fund datem: egen temp_n = count(DSCD)
bys ui_fund datem: egen temp_i = rank(rel_bid_ask)
gen pct_bas_rank = 100*((temp_i - 0.5) / temp_n)
drop temp_n temp_i

label variable pct_amihud_rank "Stock Percentile Rank - Amihud Illiquidity Ratio (from most to least liquid)"
label variable pct_bas_rank "Stock Percentile Rank - Bid-Ask Spread (from most to least liquid)"

**********************************************************
/*Shorting Demand (scaled by Market Cap)*/
**********************************************************
gen on_loan_mv =  (total_demand_value_EUR_Mmean)/MV_eur
gen on_loan_mv_max =  (total_demand_value_EUR_Mmax)/MV_eur
gen on_loan_sum_mv =  (total_demand_sum_EUR_Mmean)/MV_eur

replace on_loan_mv = . if on_loan_mv >1
replace on_loan_mv = on_loan_mv*100
replace on_loan_mv_max = . if on_loan_mv_max >1
replace on_loan_mv_max = on_loan_mv_max*100
replace on_loan_sum_mv = . if on_loan_sum_mv >1
replace on_loan_sum_mv = on_loan_sum_mv*100

**********************************************************
/*Shorting Supply (scaled by Market Cap)*/
**********************************************************
gen short_supply = (bo_inventory_value_EUR)/MV_eur
replace short_supply = . if short_supply > 1
replace short_supply = short_supply*100

**********************************************************
/*DGTW-Adjusted Return*/
**********************************************************
gen stock_alpha_DGTW = ret_eur - ret_DGTW

**********************************************************
/*Fund Utilization (see Evans et al., 2017)*/
**********************************************************
bys ui_fund datem: egen fund_short_demand = wtmean(on_loan_mv), weight(sec_mv_adj)
bys ui_fund datem: egen fund_short_supply = wtmean(short_supply), weight(sec_mv_adj)
gen fund_utilization = fund_short_demand/fund_short_supply
winsor2 fund_utilization, cut(0 99) suffix("_l0u99")
drop fund_short_demand fund_short_supply
replace fund_utilization_l0u99 = fund_utilization_l0u99*100

**********************************************************
/*Winsorize and re-scale percentage position changes */
**********************************************************
winsor2 dpos_prc_nom_adj, cut(0 99.5) suffix("_99_5") 
replace dpos_prc_nom_adj_99_5 = dpos_prc_nom_adj_99_5*100


**********************************************************
/*Log Values*/
**********************************************************
gen ln_fund_family_nav = ln(fund_family_nav)
gen ln_nav = ln(nav)
gen ln_spread = ln(rel_bid_ask)
gen ln_age = ln(age)
gen ln_vwaf_7_day = ln(1+ vwaf_7_day)
gen ln_vwaf_30_day = ln(1+ vwaf_30_day)
gen ln_vwaf_all_day = ln(1+ vwaf_all_day)
gen ln_utilisation = ln(.0999 +utilisation_Mmean)


**********************************************************
/*Lagged Variables*/
**********************************************************
tsset ui_fund_sec datem
foreach var of varlist utilisation on_loan_mv* ln_vwaf_* vwaf_score* dcbs dpos_ln_nom_adj dpos_prc_nom_adj_* pct_*_rank MV_eur BM ln_spread pos_w_developed* ln_fund_family_nav ln_nav ln_age CostsExTrFees turnover fund_gross* fund_net* sec_mv* NOMSTUECK_adj NOMSTUECK_WPLEI* relflow active_agents*{
	gen l`var' = l.`var'
}


preserve
keep sec_isin_historic datem on_loan_mv lon_loan_mv
gduplicates drop

gduplicates tag sec_isin_historic datem, gen(temp)
bys sec_isin_historic datem: egen temp2 = mean(lon_loan_mv)
drop if temp != 0 & lon_loan_mv == . & temp2 != .
drop temp temp2
duplicates drop datem sec_isin_historic , force
egen ui = group(sec_isin_historic )


tsset ui datem
tssmooth ma lon_loan_mv_3m=lon_loan_mv, window(3)
tssmooth ma lon_loan_mv_6m=lon_loan_mv, window(6)
tssmooth ma lon_loan_mv_12m=lon_loan_mv, window(12)

keep sec_isin_historic datem *3m *6m *12m
gduplicates drop
save "temp.dta", replace
restore

merge m:1 sec_isin_historic datem using "temp.dta"
drop _merge

replace lon_loan_mv_3m = lon_loan_mv if lon_loan_mv_3m == .
replace lon_loan_mv_6m = lon_loan_mv if lon_loan_mv_6m == .
replace lon_loan_mv_12m = lon_loan_mv if lon_loan_mv_12m == .


**********************************************************
**********************************************************
/*More Filter*/
**********************************************************
**********************************************************

**********************************************************
*FILTER: Fund Age (incubation bias, see Evans, 2010)
**********************************************************
qui drop if age <= 3

**********************************************************
*FILTER: Fund Size (drop months before fund nav exceeds 10mio for the first time)
**********************************************************

/*Calculate first time (=minimum date within a fund) the fund surpasses a NAV of 10.000.000€*/
************************************
bys ui_fund: egen min_date_temp = min(datem) if nav >= 10000

/*Fill up first time for all observations for a given fund*/
************************************
bys ui_fund: egen min_date = min(min_date_temp)

/*Drop all months before the fund exceeds the size threshold for the first time (everything before the minimum date)*/
************************************
qui drop if datem < min_date
qui drop if min_date == .
drop min_date*


**********************************************************
/*FILTER: Sample Period (Drop November 2014;
		  just needed to calculate lagged values)*/
**********************************************************
qui drop if datem == tm(2014m11)

**********************************************************
*Label Variables
**********************************************************


**********************************************************
**********************************************************
/* Save data */
**********************************************************
**********************************************************
cd "${data_for_analysis}"
compress

save "B3_Panel_EquityFunds_FinalMerge_AddVar_2014m12on_Dec22.dta", replace



**********************************************************************************************
***EOF
**********************************************************************************************

