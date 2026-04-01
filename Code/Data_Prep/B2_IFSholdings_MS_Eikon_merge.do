
******************************************************************************************************************************
******************************************************************************************************************************
***
*** Number of project:		2016\0082				
*** Title of project:		Securities lending by mutual funds
*** Data source: 			Investment Fund Statistics (Original Data is December 2009 until December 2018; June 2014 until December 2018 is kept for analysis)
*** Name of programme code:	B2-b_IFSholdings_MS_Eikon_merge.do
***
*** Purpose of programme code: 
***			Part I: 	Merge IFS holdings data (on share class level) to Morningstar Fund IDs to collapse holdings to the fund level
***			Part II: 	Merge holdings data to Eikon security identifiers and static stock information; create a unique stock identifier
***			Part III: 	Expand holdings data to construct position entries and exits (important for turnover)
***			Part IV:	Merge Eikon time series information, Morningstar time series information, and Markit time series information to holdings data
***			Part V: 	Final Adjustments and Save Merged Data Set
***					
******************************************************************************************************************************
******************************************************************************************************************************

/* Paths : */

*Comment next two lines out when running code via the master file (information comes from there in this case)
*global datum 				= 	"20200416"				/* Date in the form yyyymmdd */
global proj_num			=	"2016_0082r"			/* Please spezify project number with underscore */

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
/* Part I: Collapse Holdings to Fund Level */
******************************************************************************************************************************
******************************************************************************************************************************

****************************************
/*Use raw dataset from IFS holdings */
****************************************
cd "${data_for_analysis}/01_IFS"
use "A2-a_IFS_ShareClass_Holdings_2009m9_2018m12_Apr20.dta", replace

****************************************
/*Keep relevant time period*/
****************************************
drop if datem < tm(2014m6)

****************************************
/* Securities quoted in percent */
****************************************
replace KURSPREIS = KURSPREIS/100 if NOTTYP == "P"


**********************************************************
**********************************************************
*MERGE 1: IFS Holdings to Morningstar Fund Identifier (for fund-level aggregation)
**********************************************************
**********************************************************
cd "${data_for_analysis}"
merge m:1 share_class_isin using "KEY_IFS_MS_ShareClassISIN_FundID_Jul20.dta"

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
collapse (first) NOTTYP GlobalBroadCategoryGroup (mean) KURSPREIS (sum) NOMSTUECK SUMME NOMSTUECK_WPLEI, by(FundId sec_isin datem)


****************************************
/*Label Variables*/
****************************************
label variable FundId "Fund: Morningstar ID"
label variable datem "Time Variable: Calendar Month"
label variable sec_isin "Stock: Security Identifier"
label variable NOTTYP "Stock: Notation Type (P = Percentage, S = Unit)"
label variable KURSPREIS "Stock: Average Price (arithmetic mean across share classes, by NOTTYP)"
label variable NOMSTUECK "Stock: Nominal Fund Holdings"
label variable SUMME "Stock: Absolute Fund Holdings (in EUR, by NOTTYP)"
label variable NOMSTUECK_WPLEI "Stock: Nominal in Lending Transaction"


****************************************
/*Market value of fund holdings*/
****************************************
gen sec_mv = (KURSPREIS*NOMSTUECK)/10^3

*Set to missing if market value is negative
replace sec_mv = . if sec_mv < 0

*Fund Value = Sum of Market Value of Holdings
bys FundId datem: egen fund_mv = sum(sec_mv)

label variable sec_mv "Fund-Stock: Market value of security holding (in thousand EUR)"
label variable fund_mv "Fund: Market value of all securities in fund (in thousand EUR)"





******************************************************************************************************************************
******************************************************************************************************************************
/* Part II: Merge holdings data to Eikon IDs and static stock-level information  */
******************************************************************************************************************************
******************************************************************************************************************************

**********************************************************
**********************************************************
*MERGE 2: IFS Holdings to Eikon Stock Identifier (for matching security ISINs to unique InstrumentID or DSCD)
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
*Drop Stocks without any Holdings  
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
gduplicates tag InstrumentID FundId datem, gen(temp_dupl_Instrument)
gduplicates tag DSCD FundId datem, gen(temp_dupl_DSCD)
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
	drop if FundId == "FSUSA0A6ZE" & ISIN == "US0138175072" & datem == tm(2016m10)
}
drop temp_dupl*

****************************************
*Check if any remaining duplicates
****************************************
gduplicates tag InstrumentID FundId datem, gen(temp_dupl_Instrument)
gduplicates tag DSCD FundId datem, gen(temp_dupl_DSCD)
tab temp_dupl_Instrument temp_dupl_DSCD
drop temp_dupl*




**********************************************************
**********************************************************
*MERGE 3: IFS Holdings to Eikon Stock Static Information
**********************************************************
**********************************************************
cd "${data_for_analysis}/03_DS_EIKON"
merge m:1 InstrumentID using "TR_static_selected.dta"

/*
----------------------------------------------------------
_merge == 1: Data only in Holdings (No static information for the corresponding InstrumentID -> mostly the artificially created Instrument IDs)
_merge == 2: Data only in Eikon (InstrumentIDs of holdings prior to June 2014 or holdings of filtered out funds -> if matched to raw holdings data, all InstrumentIDs are matched)
----------------------------------------------------------
*/


****************************************
*Drop Stocks without any Holdings  
****************************************
quietly drop if _merge == 2
tab _merge


****************************************
*Generate dummy for stocks with no static information
****************************************
gen sec_static_info = .
replace sec_static_info = 0 if _merge == 1		//most of them should be non-equity, i.e. with an artificial Instrument ID
replace sec_static_info = 1 if _merge == 3
drop _merge

label variable sec_static_info "Dummy: Stock Static Information Available (1=yes, 0=no)"



******************************************************************************************************************************
******************************************************************************************************************************
/* Part III: Expand Holdings Data to include months before, inbetween, and after holding a position to define entry and exit */
******************************************************************************************************************************
******************************************************************************************************************************

****************************************
/* impose panel structure on Fund-Security level, sort data */
****************************************
gegen ui_fund = group(FundId)
gegen ui_instrument = group(InstrumentID)
gegen ui_dscd = group(DSCD)
gegen ui_fund_dscd = group(FundId DSCD)
gegen ui_fund_instrument = group(FundId InstrumentID)

tsset ui_fund_dscd datem 

****************************************
/* need to hardcode lagged variables for use in later calculations (otherwise issues with by-command) */
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
replace KURSPREIS = -1e15 if DSCD == "" & KURSPREIS == .

replace temp_cr_prev_NOMSTUECK = l.NOMSTUECK if DSCD == ""
replace temp_cr_prev_KURSPREIS = l.KURSPREIS if DSCD == ""

replace sec_mv = 0 if DSCD == ""

****************************************
/* only keep month of liquidation (when position in current month is 0 AND position
   in previous month is also 0, drop these observations */
****************************************
drop if NOMSTUECK == 0 & temp_cr_prev_NOMSTUECK == 0	


****************************************
/* fill in missing information after tsfill*/
****************************************

/* fill in missing (time-invariant) numeric information */
****************************************
replace ui_dscd = l.ui_dscd if DSCD == ""
replace ui_fund = l.ui_fund if DSCD == ""
replace sec_instrument_info = l.sec_instrument_info if DSCD == ""
replace sec_dscd_info = l.sec_dscd_info if DSCD == ""
replace sec_static_info = l.sec_static_info if DSCD == ""
replace dum_developedmkt_ff = l.dum_developedmkt_ff if DSCD == ""

/* fill in missing (time-invariant) fund string information */
****************************************
replace FundId = FundId[_n-1] if DSCD == "" & ui_fund == l.ui_fund

/* fill in missing (time-invariant) stock string information */
****************************************
foreach var of varlist InstrumentType* ExchangeName CountryofExchange UltimateParentId CountryofHeadquarters CountryISOCodeofHeadquarters StateorProvinceofHeadquarter PrimaryInstrumentFlag DateBecamePublic RetireDate ///
					   CountryISOCodeofIncorporatio Currency TRBC* ISIN* world_region_ff{
	replace `var' = `var'[_n-1] if DSCD == "" & ui_dscd == l.ui_dscd
}

*Fund Market Value is equal to sum of market value of other holdings (we already calculated this for the fund-month, so just take the non-missing value of fund_mv)
****************************************
bys FundId datem: egen temp_fund_mv = min(fund_mv)

*Fund-Month observations for which a fund exits all positions and ends reporting (probably fund is liquidated) means that market value of fund is equal to 0
replace temp_fund_mv = 0 if temp_fund_mv == .			

*Replace fund market value of filled in observations
replace fund_mv = temp_fund_mv if DSCD == ""
drop temp_fund_mv

/* fill in missing DSCD & InstrumentIDs */
****************************************
tsset ui_fund_dscd datem 
replace ui_fund_instrument = l.ui_fund_instrument if DSCD == "" & ui_fund == l.ui_fund & ui_instrument == l.ui_instrument
replace InstrumentID = InstrumentID[_n-1] if InstrumentID == "" & ui_fund_instrument == l.ui_fund_instrument
replace DSCD = DSCD[_n-1] if DSCD == "" & ui_fund_dscd == l.ui_fund_dscd


*Type of security (notation type) is identified based on what the majority of other funds holding the same security report (i.e. we use egen = mode())
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

*Expand observation if it is the last observation per fund-stock and NOT end of sample period
****************************************
gen temp_cr_flag_expand = 0
by ui_fund_dscd: replace temp_cr_flag_expand = 1 if _n == _N & datem < tm(2018m12) & NOMSTUECK != 0   

*Expand if flag is set, create new variable that observation is expanded
****************************************
expand 2 if temp_cr_flag_expand == 1, gen(temp_cr_asset_left)    

/* For expanded observation, fill up values (current holdings are 0, current price is 0, 
   previous holdings and price are equal to last reported holdings and price) */
****************************************            			  				 
sort ui_fund_dscd datem temp_cr_asset_left
replace datem = datem+1 if temp_cr_asset_left == 1                               // for the expanded observation: date of next month
replace temp_cr_prev_NOMSTUECK = NOMSTUECK if temp_cr_asset_left == 1            // for the expanded observation: previous quantity
replace temp_cr_prev_KURSPREIS = KURSPREIS if temp_cr_asset_left == 1       	 // for the expanded observation: previous price
replace NOMSTUECK = 0 if temp_cr_asset_left == 1                                 // for the expanded observation: current quantity is 0
replace NOMSTUECK_WPLEI = 0 if temp_cr_asset_left == 1                           // for the expanded observation: current quantity is 0
replace SUMME = 0 if temp_cr_asset_left == 1									 // for the expanded observation: current quantity is 0
replace sec_mv = 0 if temp_cr_asset_left == 1									 // for the expanded observation: current quantity is 0

*For expanded observation, take fund market value from other observations of same fund in a given month
****************************************
bys FundId datem: egen temp = mean(fund_mv) if temp_cr_asset_left == 0		// fund market value = mean across all observations not expanded (fund mv is constant for a fund within a month and position exited has mv of 0)
bys FundId datem: egen temp_fund_mv = min(temp)								// and transfer the result to the newly added (exit) positions (those have market value of 0) in a temporary market value variable
replace temp_fund_mv = 0 if temp_fund_mv == .								// Fund-month pairs for which a fund exits all positions and ends reporting (probably, fund is liquidated) -> fund market value equal to 0
replace fund_mv = temp_fund_mv if temp_cr_asset_left == 1					// finally, fund market value of expanded positions is replaced with temporary market value variable 
drop temp temp_fund_mv


****************************************
/*Tag Position Entry & Exit*/
****************************************

*entry = positive nominale in t, no observation in t-1, not first sample month
gen dum_entry = (NOMSTUECK != 0 & temp_cr_prev_NOMSTUECK == 0 & datem > tm(2014m6))		

*exit = positive nominale in t-1, no observation in t
gen dum_exit  = (temp_cr_prev_NOMSTUECK != 0 & NOMSTUECK == 0)

*turn KURSPREIS into missing values when a fund exits a position
replace KURSPREIS = . if dum_exit == 1		


****************************************
/*Fund-month pairs for which a fund exits all positions and ends reporting (probably, fund is liquidated)*/
****************************************

*What is the last month in which a fund reports anything (including the exits we created)?
****************************************
bys FundId: gegen last_report = max(datem)

*How many of the fund holdings are exited?
****************************************
bys FundId datem: gegen exit_all = mean(dum_exit)
format last_report %tm

*If fund-month is the last reporting month of this fund AND all reports are exits AND it is not the end of the sample period, we drop this fund-month
****************************************
gen byte dum_drop = (datem == last_report & exit_all == 1 & datem < tm(2018m12))

quietly drop if dum_drop == 1
drop last_report dum_drop


****************************************
*For each exit, calculate the time the position was held
****************************************
tsset ui_fund_dscd datem

*Count how many times a fund exits a particular stock
****************************************
bys ui_fund_dscd: gen portfolio_position = sum(dum_exit)

/*Count how often the fund enters a position within a fund-stock pair (position = time between entry and exit; 
  portfolio_position > 1 means that a fund holds the same stock several times over the sample period but with breaks inbetween*/
****************************************
gen lportfolio_position = l.portfolio_position
replace lportfolio_position = portfolio_position if lportfolio_position == .
replace lportfolio_position = lportfolio_position + 1 

*Assign unique identifier for each fund-stock position
****************************************
gegen ui_fund_dscd_position = group(ui_fund_dscd lportfolio_position)
drop portfolio_position lportfolio_position

label variable ui_fund_dscd_position "Unique identifier fund-stock position (from entry to exit)"

*How long does the fund hold the stock (before exiting it)?
****************************************
bys ui_fund_dscd_position: gen holding_time = _N
label variable holding_time "Time Position is Held (counting from July 2014 onwards)"


****************************************
*Positions held in or after stock's retire month -> drop (holdings are end-of-month, i.e. there should be no holdings at the end of the stock's retire month)
****************************************
gen EndDatem = mofd(date(RetireDate, "MDY"))
format EndDatem %tm

gen dum_pos_when_retire = (datem >= EndDatem)
drop if dum_pos_when_retire == 1
drop dum_pos_when_retire 




******************************************************************************************************************************
******************************************************************************************************************************
/* Part IV: Merge Eikon (stocks), Morningstar (funds), and Markit (stock short selling) data to holdings data */
******************************************************************************************************************************
******************************************************************************************************************************

**********************************************************
**********************************************************
*MERGE 3: IFS Holdings to Morningstar Fund Data
**********************************************************
**********************************************************
cd "${data_for_analysis}"
merge m:1 FundId datem using "B1_Panel_IFS_MS_EquityFundID_allVars_2014m6on_Jul20.dta"

/*
----------------------------------------------------------
_merge == 1: Data only in Holdings  -> should be 0
_merge == 2: Data only in Morningstar -> these are fund-month pairs in Morningstar with no reported holdings)
----------------------------------------------------------
*/


****************************************
*Drop Funds without holdings in a month (a minor part of the funds is dropped) -> OK
****************************************
quietly drop if _merge == 2
quietly drop if WP == 0 & nav == 0 & exit_all == 1
drop exit_all _merge

****************************************
*Drop Sector Funds & Emerging Markets Funds (for these funds, we did not define an investment region, i.e. drop if InvestmentRegion == "")
****************************************
quietly drop if InvestmentRegion == ""
*quietly drop if GlobalCategory == "Global Emerging Markets Equity"
*quietly drop if regexm(GlobalCategory , "Sector") == 1
*quietly drop if GlobalCategory == "Equity Miscellaneous"
*quietly drop if GlobalCategory == "Greater China Equity"



****************************************
*Drop AIF Funds (we are only interested in Publikumsfonds)
****************************************

*Is a fund ever labeled as AIF fund during the sample period? If so, drop the entire fund history
****************************************
bys FundId: gegen ever_aif = sum(dum_fund_aif)
gen dum_fund_aif_overall = (ever_aif > 0 & ever_aif != .)
quietly drop if dum_fund_aif_overall == 1
drop ever_aif dum_fund_aif* 




**********************************************************
**********************************************************
*MERGE 4: IFS Holdings to Eikon Stock Time Series Data
**********************************************************
**********************************************************

/*Merge holdings with Datastream Stock TS variables calculated based on monthly data */
*----------------------------------------------------------
cd "${data_for_analysis}/03_DS_EIKON"
merge m:1 DSCD datem using "DS_ts_allvars_varcalc_Jul20.dta"

/*
----------------------------------------------------------
_merge == 1: Data only in Holdings  -> No time series information for the corresponding DSCD
_merge == 2: Data only in Morningstar -> No holdings for the DSCD in the corresponding month (mainly months prior to 2014m6)
----------------------------------------------------------
*/

****************************************
*Drop Stock-Months without any holdings in a given month 
****************************************
quietly drop if _merge == 2
drop _merge



/*Merge holdings with Datastream Stock TS variables (amihud, std.dev) calculated based on daily data */
*----------------------------------------------------------
cd "${data_for_analysis}/03_DS_EIKON"
merge m:1 DSCD datem using "DS_tsD_allvars_varcalc_Aug22.dta"
*--> _merge == 1: Data only in Holdings 	 (No time series information for the corresponding DSCD)
*--> _merge == 2: Data only in Datastream    (No holdings for the DSCD in the corresponding month -> months prior to 2014m12)

****************************************
*Drop Stock-Months without any holdings in a given month 
****************************************
quietly drop if _merge == 2
drop _merge


/*Merge holdings with Eikon Stock TS data (on InstrumentID) */
*----------------------------------------------------------
cd "${data_for_analysis}/03_DS_EIKON"
merge m:1 InstrumentID datem using "TS_allvars.dta" 

****************************************
/*Drop Stock-Months without any holdings in a given month */
****************************************
quietly drop if _merge == 2
drop _merge



**********************************************************
**********************************************************
*Adjust NOMSTUECK for stock splits and reverse splits 
**********************************************************
**********************************************************

****************************************
/* Assign adjustment factor (AF) for stock splits to right fund-month:
   --------------------------------------------------------------------
   Sometimes, funds apply the wrong AF when reporting NOMSTUECK (i.e. they apply a new AF  after a stock split too late). 
   This would artificially lead to large position changes although there is no such position change. 
   
   We create a fund-stock specific AF by looking at the deviation of KURSPREIS (reported by the fund) to the unadjusted price 
   (reported by Datastream) -> if the fund applies the right AF, the deviation should be minimal; if the fund does not apply 
   the right AF, the deviation is large (for the month in which the fund applies the wrong AF) and we adjust NOMSTUECK accordingly */
****************************************

*Does the adjustment factor for a particular stock change? 
****************************************
tsset ui_fund_dscd datem
gen dAF = AF/l.AF

*Check deviation of KURSPREIS to unadjusted price (should be minimal if fund reporting is based on prevailing adjustment factor)
****************************************
gen dPrice =KURSPREIS/UP_eur
replace dPrice = abs(1-dPrice)

*1) If Adjustment factor doesn't change or change is missing (because UP is missing or position entry), take the original AF for deflating NOMSTUECK
gen AF_Fund = AF if dAF == 1 | dAF == .

*2) If fund exits position, set AF to small negative value (effectively 0, but we need to divide by AF later) for deflating NOMSTUECK (we deflate 0 anyhow)
replace AF_Fund = -1e15 if AF_Fund == . & dum_exit == 1

*3) If Adjustment factor changes from t-1 to t and price deviation is less than 10% (i.e. fund correctly adjusts), take the original AF for deflating NOMSTUECK
replace AF_Fund = AF if AF_Fund == . & dAF != 1 & dPrice < .1

*4) If Adjustment factor changes from t-1 to t and price deviation is more than 10%, manually adjust cases for which fund applies the new adjustment factor too late
quietly{
	replace AF_Fund = l.AF if DSCD == "360538" & datem == tm(2014m12) & (FundId == "FSGBR05056" | FundId == "FSGBR050XV" | FundId == "FSGBR050Y8" | FundId == "FSGBR050ZO" | FundId == "FSGBR05104" | FundId == "FSGBR058YM" | FundId == "FSGBR058YN" | FundId == "FSGBR0661B" | FundId == "FSGBR06FKW")
	replace AF_Fund = l.AF if DSCD == "902232" & datem == tm(2015m11) & (FundId == "FSGBR0508C" | FundId == "FSGBR0574F")
	replace AF_Fund = l.AF if DSCD == "953830" & datem == tm(2018m5) & FundId == "FSGBR0574H"
	replace AF_Fund = l.AF if DSCD == "288512" & datem == tm(2018m8) & FundId == "FS0000CA8J"
	replace AF_Fund = l.AF if DSCD == "921855" & datem == tm(2018m11) & FundId == "FS0000D16N"
	replace AF_Fund = l.AF if DSCD == "933185" & datem == tm(2018m3) & FundId == "FS0000D16N"
	replace AF_Fund = l.AF if DSCD == "8745RP" & datem == tm(2015m7) & FundId == "FSGBR0557R"
}


**********************************************************
**********************************************************
/* Generate adjusted NOMSTUECK (deflated by adjustment factor) & 
   Position Changes (based on adjusted NOMSTUECK) */
**********************************************************
**********************************************************

*Deflate NOMSTUECK by adjustment factor
****************************************
gen NOMSTUECK_adj = NOMSTUECK/AF_Fund
gen NOMSTUECK_WPLEI_adj = NOMSTUECK_WPLEI/AF_Fund

*Log of NOMSTUECK and change in Log-NOMSTUECK
****************************************
gen pos_ln_nom_adj = ln(NOMSTUECK_adj+1)
gen dpos_ln_nom_adj = pos_ln_nom_adj - l.pos_ln_nom_adj 
label variable dpos_ln_nom_adj "Fund: Change in Log of Nominal Fund Holdings (deflated with Fund AF)"

*Percentage change in NOMSTUECK
****************************************
gen dpos_prc_nom_adj = (NOMSTUECK_adj - l.NOMSTUECK_adj)/l.NOMSTUECK_adj if NOMSTUECK_adj >= 0 & l.NOMSTUECK_adj >= 0
label variable dpos_prc_nom_adj "Fund: Percentage Change in Position (deflated with Fund AF)"

*Security Market Values (with adjusted NOMSTUECK)
****************************************
gen sec_mv_adj = (KURSPREIS*NOMSTUECK_adj)/10^3

*Set to missing if market value is negative
replace sec_mv_adj = . if sec_mv_adj < 0

*Fund Value = Sum of Market Value of Holdings
bys FundId datem: egen fund_mv_adj = sum(sec_mv_adj)

label variable sec_mv_adj "Fund-Stock: Market value of security holding (in thousand EUR, nom_adj)"
label variable fund_mv_adj "Fund: Market value of all securities in fund (in thousand EUR, nom_adj)"





**********************************************************
**********************************************************
*MERGE 5: IFS Holdings to ISIN change data
**********************************************************
**********************************************************
cd "${data_for_analysis}/03_DS_EIKON/ID_KEYS"
merge m:1 InstrumentID datem using "KEY_InstrumentID_ISINchange_2014m6on_spanned_Apr20.dta"

/*
----------------------------------------------------------
_merge == 1: Data only in Holdings (No capital actions for the corresponding InstrumentID) -> OK
_merge == 2: Data only in Eikon    (No holdings for the ISIN in the corresponding month)
----------------------------------------------------------
*/

****************************************
*Drop ISINs without any holdings in a given month 
****************************************
quietly drop if _merge == 2
drop _merge


****************************************
/*Create unique historical ISINs for each InstrumentID 
 (we need this for the merge to the Markit data because securities are identified with ISINs) */
****************************************
gen ISIN_historic = ""

*If there is no ISIN change in a given month (i.e. no new ISIN), historic ISIN is equal to "old" (reported) ISIN
****************************************
replace ISIN_historic = ISIN if ISIN_with_change  == ""

*If there is an ISIN change in a given month (i.e. new ISIN valid from there on), historic ISIN is equal to new ISIN
****************************************
replace ISIN_historic = ISIN_with_change  if ISIN_with_change  != ""
drop ISIN_with_change ISIN_start_date 


****************************************
*Manual correction for unique ISINs  
****************************************

*Any Instruments with more than one ISIN?
****************************************
bys InstrumentID datem: egen nvals_ISIN_historic = nvals(ISIN_historic) if InstrumentID != ""
tab nvals_ISIN_historic

*Manually replace ISINs for which there is more than one ISIN (check which ISIN the other funds holding the same stock report...)
****************************************
quietly{
	replace ISIN_historic = "GB00BYQ0JC66" if InstrumentID == "8589966105" & nvals_ISIN_historic == 2
	replace ISIN_historic = "US19122T1097" if InstrumentID == "8590921339" & nvals_ISIN_historic == 2
	replace ISIN_historic = "CA87262K1057" if InstrumentID == "8590937282" & nvals_ISIN_historic == 2
	replace ISIN_historic = "IT0004053440" if InstrumentID == "8590938847" & nvals_ISIN_historic == 2
	replace ISIN_historic = "VGG607541015" if InstrumentID == "21480475802" & nvals_ISIN_historic == 2
}
drop nvals_ISIN_historic


**********************************************************
**********************************************************
*MERGE 6: IFS Holdings to DGTW Portfolios
**********************************************************
**********************************************************

/*Merge holdings with DGTW Portfolio Assignment (i.e. each stock is sorted into one of the 5x5x5 portfolios) */
*----------------------------------------------------------
cd "${data_for_analysis}/03_DS_EIKON/DGTW"
merge m:1 DSCD datem using "DGTW_Stock_Portfolio_Assignments_Apr20.dta"

/*
----------------------------------------------------------
_merge == 1: Data only in Holdings (stock not yet assigned to a DGTW portfolio, i.e. either too young or assignment information missing) -> OK
_merge == 2: Data only in DGTW File (No holdings for the ISIN in the corresponding month)
----------------------------------------------------------
*/


****************************************
*Drop Stock-Months without any holdings in a given month 
****************************************
quietly drop if _merge == 2
drop _merge


/*Merge holdings with DGTW Portfolio Returns (based on the portfolio assignments) */
*----------------------------------------------------------
cd "${data_for_analysis}/03_DS_EIKON/DGTW"
merge m:1 DGTW_Portfolio datem using "DGTW_Portfolio_Returns_Apr20.dta"

/*
----------------------------------------------------------
_merge == 1: Data only in Holdings (stock not yet assigned to a DGTW portfolio, i.e. either too young or assignment information missing) -> OK
_merge == 2: Data only in DGTW File (returns prior to June 2014 or after December 2018) -> drop
----------------------------------------------------------
*/


****************************************
*Drop DGTW returns prior to June 2014 or after December 2018
****************************************
quietly drop if _merge == 2
drop _merge




**********************************************************
**********************************************************
*MERGE 7: IFS Holdings to Markit Stock Level Data
**********************************************************
**********************************************************
cd "${data_for_analysis}/04_Markit/"
rename ISIN_historic isin
merge m:1 isin datem using "DX_data_all_cleaned_endofM_Apr20.dta"

/*
----------------------------------------------------------
_merge == 1: Data only in Holdings (no Markit information for these stocks or stock-months) -> OK
_merge == 2: Data only in Markit (No holdings for the ISIN in the corresponding month) -> drop
----------------------------------------------------------
*/


****************************************
*Drop Stock-Months without any holdings in a given month 
****************************************
quietly drop if _merge == 2
drop _merge

rename isin sec_isin_historic
rename ISIN sec_isin_reported




/*
**********************************************************
**********************************************************
*MERGE 8: IFS Holdings to Public Short Position Disclosure Data (moved to a later point!!!)
**********************************************************
**********************************************************
cd "${path}${data}\data_for_analysis\06_NSP"
merge m:1 DSCD datem using "Public_NetShortPositions_FirstDisclosureEvent_2012-2018_new.dta"

/*
----------------------------------------------------------
_merge == 1: Data only in Holdings (no public short selling disclosure for these stock-months) -> OK
_merge == 2: Data only in Short Selling Disclosure (No holdings for the ISIN in the corresponding month) -> drop
----------------------------------------------------------
*/

****************************************
*Drop Stock-Months without any holdings in a given month 
****************************************
drop if _merge == 2		

****************************************
*Stocks without any net short position disclosure -> fill up with 0's
****************************************
replace any_net_short_position = 0 if _merge == 1
drop _merge
*/




******************************************************************************************************************************
******************************************************************************************************************************
/* Part V: Final Adjustments and Save Data Set */
******************************************************************************************************************************
******************************************************************************************************************************

****************************************
/*drop unnecessary variables*/
****************************************
drop temp_cr_prev* ui_fund ui_fund_instrument ui_instrument ui_dscd currency temp_cr* EndDatem dAF ///
	 InstrumentType InstrumentIsActiveFlag QuoteID PrimaryQuoteFlag OrganizationPermID ExchangeName TickerSymbol TradingSymbol ///
	 UltimateParentId CountryISOCodeofHeadquarters StateorProvinceofHeadquarter ContactCountryName CountryISOCodeofIncorporatio ///
	 TRBC* Currency inflow outflow netflow inception_datem exchr* ///
	 PrimaryInstrumentFlag DateBecamePublic AskPriceAdjLoc BidPriceAdjLoc  DateofIncorporation ///
	 IssueSharesOutstanding PriceCloseEUR PriceToBVPerShare TotalReturnLocal TotalReturnEUR IssueMarketCapOUT dPrice AF AF_Fund ///
	 dxl_identifier date sl_tenure open_loan_transactions sl_return_to_lendable total_return_to_lendable sl_fee_high sl_fee_low ///
	 number_of_transation* active_agents inactive_agents active_brokers balance_value* sec_isin_reported SUMME *_info FONDSNAME ///
	 ui_fund_dscd numbr_share_classes ManagementFee ln_turnover pos_ln_nom InstrumentID 
	 
****************************************
/*label remaining variables*/
****************************************
label variable dum_entry "Dummy: New Position (no holdings in previous month, but in current month) "
label variable dum_exit "Dummy: Exit Position (no holdings in current month, but in previous month)"
label variable rel_bid_ask "Stock: Eikon Relative Bid-Ask Spread"
label variable NumberOfAnalysts "Stock: Eikon Number of Analysts"
label variable InvestmentRegion "Fund: Morningstar Category Investment Region"
label variable NOMSTUECK_adj "Stock: Nominal Fund Holdings (deflated with Fund AF)"
label variable sec_isin_historic "Stock: Security Identifier (accounting for ISIN changes)"
label variable CountryofExchange "Stock: Country of Exchange"
label variable InstrumentTypeCode "Stock: Instrument Type Code"
label variable CountryofHeadquarters "Stock: Country of Headquarters"
label variable RetireDate "Stock: Retire Date"
label variable dum_developedmkt_ff "Dummy: Security Location (0 = Emerging, 1 = Developed, as in Fama & French 2012)"
label variable world_region_ff "Stock: Security Region (as in Fama & French 2012)"
label variable ui_fund_dscd_position "Fund-Stock: Identifier for fund-stock position (from entry to exit)"
label variable holding_time "Fund-Stock: Number of Months a Position is Held"

capture label define developed 0 "Emerging" 1 "Developed"
label values dum_developedmkt_ff developed

capture label define entry 0 "No Entry" 1 "Entry"
label values dum_entry entry

capture label define exit 0 "No Exit" 1 "Exit"
label values dum_exit exit


****************************************
 /*Save data */
****************************************
cd "${data_for_analysis}"
compress



****************************************
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


save "B2_Panel_EquityFunds_FinalMerge_2014m6on_Dec22.dta", replace


**********************************************************************************************
***EOF
**********************************************************************************************



