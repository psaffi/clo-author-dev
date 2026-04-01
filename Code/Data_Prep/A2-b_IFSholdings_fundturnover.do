
******************************************************************************************************************************
******************************************************************************************************************************
***
*** Number of project:		2016\0082				
*** Title of project:		Securities lending by mutual funds
*** Data source: 			Investment Fund Statistics (Original Data is December 2009 until December 2018; later on, June 2014 until December 2018 is kept for the analysis)
*** Name of programme code:	A2-b_IFSholdings_fundturnover.do
***
*** Purpose of programme code: 
***			Part I: 	Merge IFS holdings data (on share class level) to Morningstar Fund IDs to collapse holdings to the fund level
***			Part II: 	Merge holdings data to Eikon security identifiers to create a unique stock identifier
***			Part III: 	Expand holdings data to construct position entries and exits (important for turnover)
***			Part IV: 	Calculate Monthly Fund Churn Rate
***			Part V: 	Calculate Monthly Fund Turnover
***			Part VI:	Merge Turnover and Churn Rate to Fund Information Data
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





******************************************************************************************************************************
******************************************************************************************************************************
/* Part I: Collapse Holdings to Fund Level */
******************************************************************************************************************************
******************************************************************************************************************************

****************************************
/*Use raw dataset from IFS holdings */
****************************************
cd "${data_for_analysis}/01_IFS"
use "A2-a_IFS_ShareClass_Holdings_2009m9_2018m12_Apr20.dta", replace

****************************************
/*Keep relevant time period (we need churn rate and turnover from December 2014 onwards, i.e. keep one year before that to calculate the necessary steps) */
****************************************
qui drop if datem < tm(2013m12)

****************************************
/* Securities quoted in percent */
****************************************
replace KURSPREIS = KURSPREIS/100 if NOTTYP == "P"


**********************************************************
**********************************************************
*MERGE 1: IFS Holdings to Morningstar Fund Identifier (for fund-level aggregation) */
**********************************************************
**********************************************************
cd "${data_for_analysis}"
merge m:1 share_class_isin using "KEY_IFS_MS_ShareClassISIN_FundID_Apr20.dta"

/*
----------------------------------------------------------
_merge == 1: Data only in Holdings (a lot of IFS funds are not covered in Morningstar (= Spezialfonds)) 
_merge == 2: Data only in Morningstar (funds with holdings prior to December 2013)
----------------------------------------------------------
*/


****************************************
*Drop Funds Not Covered by Morningstar or Funds w/o Holdings after December 2013
****************************************
qui drop if _merge != 3 
drop _merge

****************************************
*Drop Non-Equity Funds
****************************************
qui keep if GlobalBroadCategoryGroup == "Equity"

 
****************************************
/* Collapse portfolio holdings to fund-level (aggregate share classes to funds as given by FundId)  */
****************************************
collapse (first) NOTTYP (mean) KURSPREIS (sum) NOMSTUECK SUMME NOMSTUECK_WPLEI, by(FundId sec_isin datem)





******************************************************************************************************************************
******************************************************************************************************************************
/* Part II: Merge holdings data to Eikon IDs and create a unique stock identifier  */
******************************************************************************************************************************
******************************************************************************************************************************

****************************************
/*Market value of fund holdings*/
****************************************
gen sec_mv = (KURSPREIS*NOMSTUECK)/10^3

*Set to missing if market value is negative
replace sec_mv = . if sec_mv < 0

*Fund Value = Sum of Market Value of Holdings
bys FundId datem: egen fund_mv = sum(sec_mv)

label variable sec_mv "Market value of security (in thousand EUR)"
label variable fund_mv "Market value of all securities in fund (in thousand EUR)"


**********************************************************
**********************************************************
*MERGE 2: IFS Holdings to Eikon Stock Identifier (for matching security ISINs to unique InstrumentID or DSCD) */
**********************************************************
**********************************************************
cd "${data_for_analysis}/03_DS_EIKON/ID_KEYS"
rename sec_isin ISIN
merge m:1 ISIN using "KEY_InstrumentID_DSCD_ISIN.dta", keepusing(ISIN InstrumentID DSCD)

/*
----------------------------------------------------------
_merge == 1: Data only in Holdings (Eikon information requested only for securities classified as equity, i.e. rest is non-equity securities)
_merge == 2: Data only in Eikon (stocks only held prior to December 2013)
----------------------------------------------------------
*/


****************************************
/* Drop Stocks without any Holdings */
****************************************
quietly drop if _merge == 2
tab _merge

****************************************
*Create dummy for stocks with no stock identifiers (both DSCD from Datastream and InstrumentID from Eikon)
****************************************
gen sec_dscd_info = .
replace sec_dscd_info = 0 if _merge == 1	| DSCD == ""	//most of them should be non-equity
replace sec_dscd_info = 1 if _merge == 3 & DSCD != ""

gen sec_instrument_info = .
replace sec_instrument_info = 0 if _merge == 1	| InstrumentID == ""	//most of them should be non-equity
replace sec_instrument_info = 1 if _merge == 3  & InstrumentID != ""

drop _merge

label variable InstrumentID "Stock: Eikon InstrumentID"
label variable DSCD "Stock: Datastream Code"
label variable sec_dscd_info "Dummy: Datastream Code Available (1=yes, 0=no)"
label variable sec_instrument_info "Dummy: InstrumentID Available (1=yes, 0=no)"

****************************************
*Generate Artificial InstrumentID/DSCD for stocks with no identifier (assuming no ISIN changes) -> just needed for computation, will be dropped later anyway
****************************************
egen id_temp = group(ISIN) if sec_dscd_info == 0
tostring id_temp, replace
replace DSCD = id_temp if sec_dscd_info == 0
drop id_temp

egen id_temp = group(ISIN) if sec_instrument_info == 0
tostring id_temp, replace
replace InstrumentID = id_temp if sec_instrument_info == 0
drop id_temp

****************************************
/* Adjustments for fund-months with multiple ISINs for one InstrumentID (same adjustments for DSCD):
   -------------------------------------
   some funds keep on reporting an old ISIN (e.g. after an ISIN change) with a stale position (NOMSTUECK 
   close to 0, no change in NOMSTUECK and KURSPREIS); we identify the old position and delete the stale position */
****************************************

*Any duplicates in terms of DSCD/InstrumentID for a fund in a month (these duplicates differ with respect to their ISIN which then needs to be adjusted)
duplicates tag InstrumentID FundId datem, gen(temp_dupl_Instrument)
duplicates tag DSCD FundId datem, gen(temp_dupl_DSCD)
tab temp_dupl_Instrument temp_dupl_DSCD

/*Adjustment is made by looking at the number of shares reported for duplicate entries (the number of shares for the old ISIN is typically very close to 0)*/
quietly{
	drop if FundId == "FS0000923J" & ISIN == "ES0113307021" & datem >= tm(2017m6)
	drop if FundId == "FS0000923J" & ISIN == "SE0000869646" & datem >= tm(2018m5)
	drop if FundId == "FS0000923J" & ISIN == "IE0030606259" & datem >= tm(2017m7)
	drop if FundId == "FS0000923J" & ISIN == "BE0003884047" & datem >= tm(2017m10)
	drop if FundId == "FS0000923J" & ISIN == "JE00BFNWV485" & datem >= tm(2018m6)
	drop if FundId == "FS0000923J" & ISIN == "LU0323134006" & datem >= tm(2017m5)
	drop if FundId == "FS0000923J" & ISIN == "GB00BLNN3L44" & datem >= tm(2017m6)
	drop if FundId == "FS0000923J" & ISIN == "GB00B08SNH34" & datem >= tm(2017m5)
	drop if FundId == "FS0000923J" & ISIN == "CH0000587979" & datem >= tm(2018m6)
	drop if FundId == "FS0000923J" & ISIN == "IT0000068525" & datem >= tm(2017m5)
	drop if FundId == "FS0000923J" & ISIN == "GB00BYXK6398" & datem >= tm(2017m5)
	drop if FundId == "FS0000923J" & ISIN == "SE0006886750" & datem >= tm(2018m5)
	drop if FundId == "FS0000923J" & ISIN == "SE0006886768" & datem >= tm(2018m5)
	drop if FundId == "FS0000923J" & ISIN == "GB00B77J0862" & datem >= tm(2018m6)
	drop if FundId == "FS0000923J" & ISIN == "FR0000124711" & datem >= tm(2018m6)
	drop if FundId == "FS0000923J" & ISIN == "GB0031809436" & datem >= tm(2017m9)
	drop if FundId == "FS0000923K" & ISIN == "CH0100383485" & datem >= tm(2014m11)
	drop if FundId == "FS0000923K" & ISIN == "US3931221069" & datem >= tm(2014m11)
	drop if FundId == "FS0000923K" & ISIN == "CH0038838394" & datem >= tm(2014m11)
	drop if FundId == "FS0000923K" & ISIN == "CH0193880173" & datem >= tm(2014m11)
	drop if FundId == "FSGBR06OKF" & ISIN == "TH0646010015" & datem >= tm(2018m4)
	drop if FundId == "FSGBR069CZ" & ISIN == "FR0013046646" & datem >= tm(2015m12)
	drop if FundId == "FSGBR05904" & ISIN == "US5806451093" & datem >= tm(2016m4)
	drop if FundId == "FSGBR06NY8" & ISIN == "US5850551061" & datem >= tm(2015m1)
	drop if FundId == "FS0000923K" & ISIN == "US3931221069" & datem >= tm(2014m3)
	drop if FundId == "FS0000CA8J" & ISIN == "GB0043620292" & datem >= tm(2018m6)
	drop if FundId == "FS0000923K" & ISIN == "CH0038838394" & datem >= tm(2014m6)
	drop if FundId == "FS0000923K" & ISIN == "CH0193880173" & datem >= tm(2014m6)
	drop if FundId == "FSGBR0581N" & ISIN == "GB00B16GWD56" & datem >= tm(2014m2)
	drop if FundId == "FSGBR05029" & ISIN == "NL0006033250" & datem >= tm(2014m3)
}
drop temp_dupl*

****************************************
*Check if any remaining duplicates
****************************************
duplicates tag InstrumentID FundId datem, gen(temp_dupl_Instrument)
duplicates tag DSCD FundId datem, gen(temp_dupl_DSCD)
tab temp_dupl_Instrument temp_dupl_DSCD
drop temp_dupl*





******************************************************************************************************************************
******************************************************************************************************************************
/* Part III: Expand Holdings Data to include months before, inbetween, and after holding a position  */
******************************************************************************************************************************
******************************************************************************************************************************

****************************************
/* impose panel structure on fund-security level, sort data */
****************************************
egen ui_fund_dscd = group(FundId DSCD)
tsset ui_fund_dscd datem 

****************************************
/* need to hardcode lagged variables for use in later calculations (otherwise issues with by, ...) */
****************************************
gen double temp_cr_prev_KURSPREIS = l.KURSPREIS
gen double temp_cr_prev_NOMSTUECK = l.NOMSTUECK


********************************************************************************
********************************************************************************
*a) New Positions, i.e. Position Entries
********************************************************************************
********************************************************************************

****************************************
/* if an asset enters a portfolio then its previous holdings were 0  */
****************************************

replace temp_cr_prev_KURSPREIS = -1e15 if missing(temp_cr_prev_KURSPREIS)   // should be missing but setting to large negative value so that the product of 0 and "missing" is well-defined
replace temp_cr_prev_NOMSTUECK = 0 if missing(temp_cr_prev_NOMSTUECK)


********************************************************************************
********************************************************************************
*b) Temporary Position Exits, i.e. Position Exit with later Re-Entry
********************************************************************************
********************************************************************************

****************************************
/* if an asset leaves a portfolio and is added back later on -> tsfill */
****************************************
tsfill 
tsset ui_fund_dscd datem 

****************************************
/* observations created by tsfill = months for which the fund does not hold the 
   stock before entering the position again -> holdings are 0, price is 0 (for calculation purpose, large negative value for price) */
****************************************
replace NOMSTUECK = 0 if DSCD == ""
replace NOMSTUECK_WPLEI = 0 if DSCD == ""
replace SUMME = 0 if DSCD == ""
replace temp_cr_prev_NOMSTUECK = l.NOMSTUECK if DSCD == ""
replace temp_cr_prev_KURSPREIS = l.KURSPREIS if DSCD == ""
replace KURSPREIS = temp_cr_prev_KURSPREIS if DSCD == "" & missing(KURSPREIS)
replace temp_cr_prev_KURSPREIS = -1e15 if DSCD == "" & missing(temp_cr_prev_KURSPREIS)
replace KURSPREIS = -1e15 if DSCD == "" & missing(KURSPREIS)

*Fund Identifier is equal to lagged value (panel is set by fund/security-month)
****************************************
replace ui_fund = l.ui_fund if DSCD == ""
replace FundId = FundId[_n-1] if DSCD == "" & ui_fund == l.ui_fund

*Fund Market Value is equal to sum of market value of other holdings (we already calculated this for the fund-month, so just take the non-missing value of fund_mv)
****************************************
bys FundId datem: egen temp_fund_mv = min(fund_mv)

*Fund-Month observations for which a fund exits all positions and ends reporting (probably fund is liquidated) means that market value of fund is equal to 0
replace temp_fund_mv = 0 if temp_fund_mv == .			

*Replace fund market value of filled in observations
replace fund_mv = temp_fund_mv if DSCD == ""
drop temp_fund_mv

*Security Identifier is equal to lagged value (panel is set by fund/security-month)
****************************************
tsset ui_fund_dscd datem 
replace DSCD = DSCD[_n-1] if DSCD == "" & ui_fund_dscd == l.ui_fund_dscd
replace ISIN = ISIN[_n-1] if DSCD == "" & ui_fund_dscd == l.ui_fund_dscd

*Type of security is identified based on what the majority of other funds holding the same security report (i.e. we use egen = mode())
****************************************
bys DSCD: egen NOTTYP_temp = mode(NOTTYP)
replace NOTTYP = NOTTYP_temp if NOTTYP == ""
drop NOTTYP_temp



********************************************************************************
********************************************************************************
*C) Position Exits, i.e. Position Exit no Re-Entry
********************************************************************************
********************************************************************************

****************************************
/* if an asset leaves a portfolio for the last time then we need to span it one more time */
****************************************
sort ui_fund_dscd datem 

*Expand if last observation per fund-stock and NOT end of sample period
****************************************
gen temp_cr_flag_expand = 0
by ui_fund_dscd: replace temp_cr_flag_expand = 1 if _n == _N & datem < tm(2018m12)       

*Expand if flag is set, create new variable that observation is expanded
****************************************
expand 2 if temp_cr_flag_expand == 1, gen(temp_cr_asset_left)                    

/* For expanded observation, fill up values (current holdings are 0, current price is 0, 
   previous holdings and price are equal to last reported holdings and price) */
**************************************** 
replace datem = datem+1 if temp_cr_asset_left == 1                               // for the expanded observation: date of next month
replace temp_cr_prev_KURSPREIS = KURSPREIS if temp_cr_asset_left == 1       	 // for the expanded observation: previous price
replace temp_cr_prev_NOMSTUECK = NOMSTUECK if temp_cr_asset_left == 1            // for the expanded observation: previous quantity
replace NOMSTUECK = 0 if temp_cr_asset_left == 1                                 // for the expanded observation: current quantity is 0
replace NOMSTUECK_WPLEI = 0 if temp_cr_asset_left == 1                           // for the expanded observation: current quantity is 0
replace SUMME = 0 if temp_cr_asset_left == 1									 // for the expanded observation: current quantity is 0

*For expanded observation, take fund market value from other observations of same fund in a given month
****************************************
bys FundId datem: egen temp = mean(fund_mv) if temp_cr_asset_left == 0		// fund market value = mean across all observations not expanded (fund mv is constant for a fund within a month and position exited has mv of 0)
bys FundId datem: egen temp_fund_mv = min(temp)								// and transfer the result to the newly added (exit) positions (those have market value of 0) in a temporary market value variable
replace temp_fund_mv = 0 if temp_fund_mv == .								// Fund-month pairs for which a fund exits all positions and ends reporting (probably, fund is liquidated) -> fund market value equal to 0
replace fund_mv = temp_fund_mv if temp_cr_asset_left == 1					// finally, fund market value of expanded positions is replaced with temporary market value variable 
drop temp temp_fund_mv



******************************************************************************************************************************
******************************************************************************************************************************
/* Part IV: Churn Rate Calculation */
******************************************************************************************************************************
******************************************************************************************************************************

****************************************
/* Churn rate as defined in Gaspar et al. JFE 2005 p. 143 eq (1) */
****************************************

*Nominator
****************************************
gen temp_cr_comp_numerator = abs(KURSPREIS*NOMSTUECK - temp_cr_prev_KURSPREIS*temp_cr_prev_NOMSTUECK - temp_cr_prev_NOMSTUECK*(KURSPREIS - temp_cr_prev_KURSPREIS))
sort FundId datem
bys FundId datem: egen temp_cr_numerator = sum(temp_cr_comp_numerator)

*Denominator
****************************************
gen temp_cr_comp_denominator = (KURSPREIS*NOMSTUECK + temp_cr_prev_KURSPREIS*temp_cr_prev_NOMSTUECK) / 2 
sort FundId datem
bys FundId datem: egen temp_cr_denominator = sum(temp_cr_comp_denominator)

*Churn Rate
****************************************
gen churn_rate = temp_cr_numerator / temp_cr_denominator
label variable churn_rate "Fund Churn Rate (Gaspar et al., JFE 2005)"

drop temp_cr_comp* temp_cr_numerator temp_cr_denominator


/*Save Churn Rate (Temp File)*/
****************************************
preserve
keep FundId datem churn_rate 

*Keep information from June 2014 onwards (=start of sample period)
qui drop if datem < tm(2014m6)
duplicates drop

cd "${data_for_analysis}/01_IFS"
compress
describe

save "A2-b_Panel_IFS_MS_FundID_ChurnRate_2014m6on_Apr20.dta", replace
restore


******************************************************************************************************************************
******************************************************************************************************************************
/* Part V: Turnover Calculation */
******************************************************************************************************************************
******************************************************************************************************************************

/*Identify Buys and sells*/
****************************************
tsset ui_fund_dscd datem 
gen delta_ownership = (NOMSTUECK - temp_cr_prev_NOMSTUECK)*KURSPREIS		

/*Aggregate Buys*/
****************************************
bys FundId datem: egen tpos_delta_ownership = sum(delta_ownership) if delta_ownership>0 /*use EGEN!*/
bys FundId datem: egen pos_delta_ownership = mean(tpos_delta_ownership) /*Take mean over entire fund-time obs*/
drop tpos*

/*Aggregate Sells*/
****************************************
bys FundId datem: egen tneg_delta_ownership = sum(delta_ownership) if delta_ownership<0 /*use EGEN!*/
bys FundId datem: egen neg_delta_ownership = mean(tneg_delta_ownership)  /*Take mean over entire fund-time obs*/
drop tneg*

/*Take Absolute value of buys and sells */
****************************************
replace neg_delta_ownership=-neg_delta_ownership

/*Missing: No buys/sells --> Zero!*/
****************************************
replace neg_delta_ownership = 0 if neg_delta_ownership ==.
replace pos_delta_ownership = 0 if pos_delta_ownership ==.

****************************************
/* Collapse data to monthly fund level*/
****************************************
preserve
collapse (mean) fund_mv pos_delta_ownership neg_delta_ownership, by(FundId datem)

****************************************
/* Monthly Turnover */
****************************************
egen ui_temp = group(FundId)
tsset ui_temp datem

*Take Minimum of aggregate buys and sells
****************************************
gen min_delta_ownership = min(neg_delta_ownership, pos_delta_ownership)

*Take average fund value of last and current month
****************************************
gen fund_mv_avg_2m = (fund_mv + l.fund_mv)/2
replace fund_mv_avg_2m = fund_mv_avg_2m*10^3

*Turnover (and log Turnover)
****************************************
gen turnover = min_delta_ownership/fund_mv_avg_2m
replace turnover = turnover*100
gen ln_turnover = ln(1+turnover)

label variable turnover "Fund Turnover (in%)"
label variable ln_turnover "Log of Fund Turnover"

****************************************
/*Save (Temp File)*/
****************************************
keep FundId datem turnover* ln_turnover*

*Keep information from June 2014 onwards (=start of sample period)
qui drop if datem < tm(2014m6)
duplicates drop

cd "${data_for_analysis}/01_IFS"
compress
describe

save "A2-b_Panel_IFS_MS_FundID_Turnover_2014m6on_Apr20.dta", replace
restore



**********************************************************************************************
***EOF
**********************************************************************************************




