
******************************************************************************************************************************
******************************************************************************************************************************
***
*** Number of project:		2016\0082				
*** Title of project:		Securities lending by mutual funds
*** Data source: 			Investment Fund Statistics (December 2009 until December 2018; December 2014-December 2018 is used for analysis
*** Name of programme code:	A5-a_PublicDisclosure_Prepare.do
***
*** Purpose of programme code: 
***			Part I: 		Import and Clean Public Disclosure Data
***			Part II: 		Define Short Selling Episodes (from 1st position to last disclosure, i.e. net_short_position < .5)
***			Part III:		Information on Public Short Selling Disclosures on Stock-Month Level 
***			Part IV:		Identify First Disclosures in a Stock (at all, after 6 months without any disclosure)
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
/* Part I: Import and Clean Public Disclosure Data */
******************************************************************************************
******************************************************************************************

****************************************
/*Load Data Set (merged dataset: IFS data, Eikon Data, Morningstar Data, Markit Data, Net Short Position Data)*/
****************************************

cd "${data_for_analysis}"
use "B3_Panel_EquityFunds_FinalMerge_AddVar_2014m12on_Dec22.dta", clear


*Keep DSCD codes (to be merged to short position disclosure)
****************************************
keep DSCD
duplicates drop


**********************************************************
**********************************************************
/*Merge Data Set of Public Short Selling Disclosure*/
**********************************************************
**********************************************************

cd "${ext_data}/20190917"
merge 1:m DSCD using "Disclosure_NetShortPositions_2012-2018_nonames.dta"

*Keep stocks for which IFS holdings data is available
****************************************
quietly keep if _merge == 3
drop _merge

*Drop Portugal, Belgium and Greece because the closing of the short position (i.e. net_short_position < .5) is not reported
****************************************
quietly drop if countrycode == "BE" | countrycode == "PT" | countrycode == "GR"
duplicates drop

****************************************
/*Position Duplicates: Two Reports, Same Day, Same Share, Same Investor*/
****************************************
duplicates tag DSCD ui_ph position_date, gen(temp_dupl)

*Duplicates with different country code -> keep country code corresponding to share country
****************************************
quietly drop if temp_dupl == 1 & DSCD == "8884YG" & countrycode == "DE"
quietly drop if temp_dupl == 1 & DSCD == "87497G" & countrycode == "DE"
quietly drop if temp_dupl == 1 & DSCD == "866096" & countrycode == "DE"
quietly drop if temp_dupl == 1 & DSCD == "69033U" & countrycode == "SE"
drop temp_dupl

*Duplicates left?
****************************************
duplicates tag DSCD ui_ph position_date, gen(temp_dupl)

*Remaining duplicates -> check episode history before and after report (if position increases, keep larger one and vice versa)
****************************************
quietly{
	drop if temp_dupl == 1 & DSCD == "504403" & position_date == td(03jul2018) & net_short_position == 0.61
	drop if temp_dupl == 1 & DSCD == "50820E" & position_date == td(22jun2018) & net_short_position == 0.77
	drop if temp_dupl == 1 & DSCD == "682797" & position_date == td(02jan2017) & net_short_position > 0
	drop if temp_dupl == 1 & DSCD == "682797" & position_date == td(02jan2017) & net_short_position == 1.08
	drop if temp_dupl == 1 & DSCD == "775672" & position_date == td(26jan2018) & net_short_position == 0.90
	drop if temp_dupl == 1 & DSCD == "87263W" & position_date == td(04nov2014) & net_short_position == 0.62
	drop if temp_dupl == 1 & DSCD == "907656" & position_date == td(28oct2014) & net_short_position > 0
	drop if temp_dupl == 1 & DSCD == "907656" & position_date == td(13oct2014) & net_short_position > 0
}
drop temp_dupl


******************************************************************************************
******************************************************************************************
/* Part II: Define Short Selling Episodes*/
******************************************************************************************
******************************************************************************************

****************************************
/*Identify Short Selling Episodes (from 1st position to last disclosure, i.e. net_short_position < .5)*/
****************************************
sort DSCD ui_ph position_date

/*Exit Time (when a net short position of below 0.5% is reported)*/
****************************************
gen dum_exit = (net_short_position < .49)


/*For each investor-stock pair, count number of completed short position:
  First time investor-stock pair appears -> temp == 1 (until exit of public short position)
  Second time investor-stock pair appears -> temp == 2 (until exit of public short position), and so on*/
****************************************
sort DSCD ui_ph position_date
bys DSCD ui_ph: gen temp = sum(dum_exit)

*Start with 1, not with 0
replace temp = temp + 1

*Exit date belongs to last short position (i.e. subtract 1)
replace temp = temp - 1 if dum_exit == 1


/*Assign unique identifier to each investor-stock pair short selling episode*/
****************************************
egen ui_dscd_ph_pos = group(DSCD ui_ph temp)
drop temp

****************************************
/*Drop whole Episode if position date is prior to Nov, 2012*/
****************************************

/*Define Start and End Date for each Episode*/
****************************************
bys ui_dscd_ph_pos: egen start_date = min(position_date)
bys ui_dscd_ph_pos: egen end_date = max(position_date)
format start_date %td
format end_date %td

/*Drop if Episode starts prior to start of disclosure rule (November 2012)*/
****************************************
quietly drop if start_date < td(01nov2012) 


/*Label first position of each episode (when reporting date == start date)*/
****************************************
gen dum_entry = (position_date == start_date)

/*How long does the short position last?*/
****************************************
gen episode_length = end_date - start_date

*Drop if episode lasts for one day only
****************************************
quietly drop if episode_length <= 1



******************************************************************************************
******************************************************************************************
/* Part III: Information on Public Short Selling Disclosures on Stock-Month Level*/
******************************************************************************************
******************************************************************************************

****************************************
/*How large is the aggregate public short position in a stock per day across all open positions*/
****************************************

/*Tag all days with a new report for a stock*/
****************************************
gen report = 1

*Span entire panel (full span, i.e. from November 2012 to End of 2018)
****************************************
tsset ui_dscd_ph_pos position_date
tsfill, full

*Calendar month variable
gen datem = mofd(position_date)
format datem %tm


*For each episode, keep obs from first report onwards (tsfill, full (!) -> drop obs before the first short position for a stock is reported)
****************************************

*First Date on which a short position is reported for a stock
bys ui_dscd_ph_pos: egen temp = min(position_date) if report == 1

*Add this information to all the positions of the same investor in the same stock (i.e. egen = min())
bys ui_dscd_ph_pos: egen first_report_date = min(temp)

*Drop if date is smaller than first position date
quietly drop if position_date < first_report_date
drop temp first_report_date


*For each episode, keep obs until last report (if this is an exit) 
****************************************

*Last Date on which a short position is reported for a stock (given the investor exits the stock)
bys ui_dscd_ph_pos: egen temp = max(position_date) if report == 1 & dum_exit == 1

*Add this information to all the positions of the same investor in the same stock (i.e. egen = min())
bys ui_dscd_ph_pos: egen exit_report_date = min(temp)

*Drop if date is larger than last position date
drop if position_date > exit_report_date
drop temp exit_report_date

*For any dates without a new report, set report == 0
replace report = 0 if report == .

*Drop Saturdays and Sundays
****************************************
gen day = dow(position_date)
drop if day == 0	/*Saturday*/
drop if day == 6	/*Sunday*/

/*Fill up stock identifier after tsfill*/
****************************************
bys ui_dscd_ph_pos: egen DSCD_temp = mode(DSCD)
drop DSCD
rename DSCD_temp DSCD

/*Generate time variable (from 1 to n) for each investor-stock position (start to exit)*/
****************************************
by ui_dscd_ph_pos: gen tid = _n

/*Replace net short position with lagged net short position if no new report is available*/
****************************************
tsset ui_dscd_ph_pos tid
replace net_short_position = l.net_short_position if net_short_position == .


/*Sum net short positions across all positions for a given stock on a given day*/
****************************************
bys DSCD position_date: egen net_short_sum = sum(net_short_position)

*How many different positions per stock per day/month (count number of different episode identifiers)
****************************************
bys DSCD position_date: egen nmbr_LSP_daily = nvals(ui_dscd_ph_pos)
bys DSCD datem: egen nmbr_LSP_monthly = nvals(ui_dscd_ph_pos)

*Any very large individual position (> 1.75%, equivalent to 90% percentile) in a stock? 
****************************************
gen dum_large = (net_short_position >= 1.75 & net_short_position < .)

*How many very large individual positions in a stock (on a given day/month)?
****************************************
bys DSCD position_date: egen temp_daily = nvals(ui_dscd_ph_pos) if dum_large == 1
bys DSCD datem: egen temp_monthly = nvals(ui_dscd_ph_pos) if dum_large == 1

bys DSCD datem: egen nmbr_large_LSP_daily = max(temp_daily)
bys DSCD datem: egen nmbr_large_LSP_monthly = max(temp_monthly)

replace nmbr_large_LSP_daily = 0 if nmbr_large_LSP_daily == .
replace nmbr_large_LSP_monthly = 0 if nmbr_large_LSP_monthly == .
drop temp*

****************************************
/*Short Selling Episodes Per Month*/
****************************************

*Collapse to monthly stock level
****************************************
collapse (mean) LSP_avg = net_short_sum nmbr_LSP_total = nmbr_LSP_monthly nmbr_LSP_avg = nmbr_LSP_daily nmbr_large_LSP_total = nmbr_large_LSP_monthly nmbr_large_LSP_avg = nmbr_large_LSP_daily ///
		 (last) LSP_eom = net_short_sum nmbr_LSP_eom = nmbr_LSP_daily nmbr_large_LSP_eom = nmbr_large_LSP_daily ///
		 (max)  LSP_max = net_short_sum nmbr_LSP_max = nmbr_LSP_daily nmbr_large_LSP_max = nmbr_large_LSP_daily ///
		 , by(DSCD datem)
		 
		 
/*Span to full panel (stock-month level)*/
****************************************
egen ui = group(DSCD)
tsset ui datem

tsfill, full

/*Fill up stock identifier after tsfill*/
****************************************
bys ui: egen DSCD_temp = mode(DSCD)
drop DSCD
rename DSCD_temp DSCD

order ui DSCD datem LSP* nmbr_LSP* nmbr_large_LSP*

/*If there is no position in a stock for a given month, replace with zeros*/
****************************************
foreach var of varlist LSP_* nmbr_*{
	replace `var' = 0 if `var' == .
}



/*Dummy: Any open short position in a given month*/
****************************************
gen any_LSP = (nmbr_LSP_total > 0)



******************************************************************************************
******************************************************************************************
/* Part IV: Identify First Disclosures in a Stock (at all, after 6 months without disclosure)*/
******************************************************************************************
******************************************************************************************

****************************************
****************************************
/*First net short position per stock (at all)*/
****************************************
****************************************

/*Minimum Date for which any net short position in a given stock is reported*/
****************************************
bys DSCD: egen temp = min(datem) if any_LSP == 1

/*Expand this information to all observations corresponding to the stock (i.e. egen = min())*/
****************************************
bys DSCD: egen first_short_month = min(temp)
format first_short_month %tm

/*Tag First Disclosure in a stock*/
****************************************
gen first_LSP = (datem == first_short_month)
drop temp

****************************************
****************************************
/*First net short position per stock (blackout period 6 months, i.e. minimum of 6 months between end of last short position and beginning of new one)*/
****************************************
****************************************
tsset ui datem

/*Tag new short positions, i.e. at least one short position in month t but no short position in month t-1*/
****************************************
gen new_LSP = (any_LSP == 1 & l.any_LSP == 0)

*In the first month of the disclosure rule (November 2012), all positions are new disclosures
replace new_LSP = 1 if any_LSP == 1 & datem == tm(2012m11)


/*Per stock, count how many short positions are tagged as new positions (running sum, starting at 1 for 1st time a new position is tagged, 
  then 2 for the 2nd time a new position is tagged in the stock, and so on)*/
****************************************
gen temp = 0
replace temp = 1 if first_LSP == 1

*Sum over all observations of a stock (adds 1 every time a new net short position is observed)
replace temp = l.temp + new_LSP if first_LSP == 0
replace temp = 0 if temp == .

*Unique identifier for each new short position episode (ui_dscd_pos replaces temp here)
egen ui_dscd_pos = group(ui temp)
drop temp

quietly drop if ui_dscd_pos == .

****************************************
*Time between short position disclosures for a stock (cout months between close of last position and opening of new position)
****************************************

*Tag months without any short position in the stock
gen temp = (any_LSP == 0)

*For each stock, count how many months with no short position until a new one is observed
bys ui_dscd_pos: egen no_short_position = sum(temp)
drop temp

****************************************
*Tag new positions for which the last position was closed at least 6 months before (= first disclosures we are interested in)
****************************************
tsset ui datem
gen first_LSP_6m = 0

*First disclosure in a stock at all is tagged
replace first_LSP_6m = 1 if first_LSP == 1

*First disclosure in a stock is tagged when no short position was reported in the last 6 months
replace first_LSP_6m = 1 if l.no_short_position > 6 & new_LSP == 1


****************************************
*Clean Data
****************************************
drop first_short_month no_short_position ui_dscd_pos
order ui DSCD datem any_LSP new_LSP first_* LSP* nmbr_LSP* nmbr_large_LSP* 
sort DSCD datem


****************************************
*Tag months t-3, t-2, t-1, t+1, t+2, t+3 where t is the month of a new disclosure (at all, at least 6 months in between)
****************************************
gen first_LSP_plus1 = 0
gen new_LSP_plus1 = 0

gen first_LSP_6m_plus3 = 0
gen first_LSP_6m_plus2 = 0
gen first_LSP_6m_plus1 = 0

gen first_LSP_minus1 = 0
gen new_LSP_minus1 = 0

gen first_LSP_6m_minus1 = 0
gen first_LSP_6m_minus2 = 0
gen first_LSP_6m_minus3 = 0


tsset ui datem
replace first_LSP_plus1 = 1 if F.first_LSP == 1
replace new_LSP_plus1 = 1 if F.new_LSP == 1

replace first_LSP_6m_plus3 = 1 if F3.first_LSP_6m == 1
replace first_LSP_6m_plus2 = 1 if F2.first_LSP_6m == 1
replace first_LSP_6m_plus1 = 1 if F.first_LSP_6m == 1


replace first_LSP_minus1 = 1 if l.first_LSP == 1
replace new_LSP_minus1 = 1 if l.new_LSP == 1

replace first_LSP_6m_minus1 = 1 if l.first_LSP_6m == 1
replace first_LSP_6m_minus2 = 1 if l2.first_LSP_6m == 1
replace first_LSP_6m_minus3 = 1 if l3.first_LSP_6m == 1


foreach var of varlist *LSP_*{
	gen l`var' = l.`var'
	gen F`var' = F.`var'
}

gen post_disclosure = (first_LSP_6m == 1 | first_LSP_6m_minus1 == 1 | first_LSP_6m_minus2 == 1 | first_LSP_6m_minus3 == 1)

gen post_disclosure_tplus1 = F.post_disclosure
gen post_disclosure_tplus2 = F2.post_disclosure
gen post_disclosure_tplus3 = F3.post_disclosure

gen post_disclosure_tminus1 = l.post_disclosure


*Large Position (>5% which is roughly equal to the 90% percentile across all disclosures)
gen dum_large_LSP = (LSP_avg > 5)
gen ldum_large_LSP = l.dum_large_LSP
gen Fdum_large_LSP = F.dum_large_LSP

gen dum_large_LSP_eom = (LSP_eom > 5)
gen ldum_large_LSP_eom = l.dum_large_LSP_eom
gen Fdum_large_LSP_eom = F.dum_large_LSP_eom

*Change in Position 
gen diff_LSP = LSP_avg - l.LSP_avg
gen diff_LSP_eom = LSP_eom - l.LSP_eom

gen ldiff_LSP = l.diff_LSP
gen Fdiff_LSP = F.diff_LSP
gen ldiff_LSP_eom = l.diff_LSP_eom
gen Fdiff_LSP_eom = F.diff_LSP_eom

gen diff_nmbr_LSP = nmbr_LSP_total  - l.nmbr_LSP_total 
gen diff_nmbr_LSP_eom = nmbr_LSP_eom  - l.nmbr_LSP_eom

gen ldiff_nmbr_LSP = l.diff_nmbr_LSP
gen Fdiff_nmbr_LSP = F.diff_nmbr_LSP
gen ldiff_nmbr_LSP_eom = l.diff_nmbr_LSP_eom
gen Fdiff_nmbr_LSP_eom = F.diff_nmbr_LSP_eom

gen lany_LSP = l.any_LSP
gen Fany_LSP = F.any_LSP

****************************************
*Save Data Set
****************************************
drop ui
sort DSCD datem

cd "${data_for_analysis}/06_NSP"
compress
save "Public_NetShortPositions_FirstDisclosureEvent_2012-2018_Jul25.dta", replace



**************************************************************************************************************
*EOF
**************************************************************************************************************


