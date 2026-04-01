
******************************************************************************************************************************
******************************************************************************************************************************
***
*** Number of project:		2016\0082				
*** Title of project:		Securities lending by mutual funds
*** Data source: 			Investment Fund Statistics (Original Data is December 2009 until December 2018; later on, June 2014 until December 2018 is kept for the analysis)
*** Name of programme code:	A3-c_varcalc_DS_daily_ts.do
***
*** Purpose of programme code: 
***			Part I: 	Load Daily Eikon Stock Data and Merge with other Data
***			Part II: 	Clean Stock Data (Return Filters)
***			Part III: 	Calculate Variables based on Daily Data
***			Part IV: 	Collapse to Monthly Level and Save Data
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
/* Part I: Load Daily Eikon Stock Data and Merge with Other Data Sets */
*********************************************
*********************************************
cd "${data_for_analysis}/03_DS_EIKON"
use "DS_tsD_allvars.dta", replace

**********************************************************************
/* Cal-weeks  + monthly dates */
**********************************************************************
capture drop calweek_* dow 
gen calweek_mo=.
format calweek_mo %td


gen dow = dow(date)
local N = _N
forvalues i = 1/`N' { 
if dow[`i'] == 1 {
qui replace calweek_mo = date in `i'
}
else if dow[`i'] == 0 {
qui replace calweek_mo = date - 6 in `i'
}
else {
qui replace calweek_mo = date - dow +1 in `i'
}
}
/**/

label variable calweek_mo "Cal week (starting Monday)"


gen calweek_fr= calweek_mo + 4
format calweek_fr %td
label variable calweek_fr "Cal week (end of trading week Friday)"



****************************************
/*Merge with daily FF factors */
****************************************
cd "${data_for_analysis}/05_FF"
merge m:1 date using "Fama_French_factors_EUR_Daily.dta" 

/*Drop if date is before end of January 2013 (we only need some years prior to the sample period to calculate variables)*/
****************************************
quietly drop if date <td(31jan2013)
tab _merge 
drop _merge

****************************************
/*Merge with stock identifier key file (matching InstrumentIDs to DSCD codes)*/
****************************************
cd "${data_for_analysis}/03_DS_EIKON/ID_KEYS"
merge m:1 DSCD using "KEY_InstrumentID_DSCD.dta"

*Keep matched stocks
****************************************
quietly keep if _merge == 3
drop _merge


****************************************
/*Merge with static Eikon information (to get information on stock's world region for calculation of idiosyncratic volatility)*/
****************************************
cd "${data_for_analysis}/03_DS_EIKON"
merge m:1 InstrumentID using "TR_static_selected.dta", keepusing(world_region_ff)
drop _merge


*Instruments without information on world region are fitted to a global factor model
****************************************
replace world_region_ff = "Global" if world_region_ff == ""


*********************************************
*********************************************
/* Part II: Clean Stock-Level Data */
*********************************************
*********************************************

****************************************
/*Add Trading Day Key to Data*/
****************************************
cd "${data_for_analysis}/03_DS_EIKON/ID_KEYS"
merge m:1 date using "KEY_date_date_trd.dta"
drop _merge

****************************************
/*Return Filter*/
****************************************
egen ui = group(DSCD)
tsset ui date_trd

gen ret_eur = RI_eur/l.RI_eur - 1

****************************************
/*
Griffin et al. 2010, RFS: "Do Market Efficiency Measures Yield Correct Inferences? A Comparison of Developed and
Emerging Markets"

Due to concern over data errors, we ran the following return filters. For daily returns, if rt or
rt-1 > 100% and (1 + rt-1)(1 + rt ) - 1 < 20%, then both rt and rt-1 are set equal to a missing
value. Additionally, any daily return greater than 200% is set to missing.
*/
****************************************
gen byte filter_flag = ((ret_eur>1 | l.ret_eur>1) & ((1+l.ret_eur)*(1+ret_eur)-1<0.2) & (ret_eur!=.) & (l.ret_eur!=.))
replace filter_flag = 1 if ret_eur>2 & ret_eur!=.
label variable filter_flag "TS filter: Return filter as in Griffin et al. (2010)"


****************************************
/*
G. Andrew Karolyi et al./Journal of Financial Economics 105(2012)82–112, p.87
we set daily returns to missing if the value of  the total return index for either
the previous or the current day is below 0.01.
*/
****************************************
gen byte filter_flag2 = (RI_eur <0.01 | l.RI_eur <0.01)
replace  filter_flag2 = (RI <0.01 | l.RI <0.01) if filter_flag2==0
label variable filter_flag2 "TS filter: Return filter as in Karolyi et al. (2012)"


/*Apply time series filters*/
****************************************
replace ret_eur = . if filter_flag == 1
replace ret_eur = . if filter_flag2 == 1


/*Excess Returns*/
*********************************************
gen xret = ret_eur - rf_EUR_MM_Buba


/*Weekly Returns*/
*********************************************
tsset ui date_trd
gen ln_ret = ln(RI_eur/l.RI_eur)

bys ui calweek_mo: egen ret_sum = sum(ln_ret)
gen ret_eur_week = exp(ret_sum) - 1

tsset ui date_trd
foreach var of varlist mkt_*{
	forvalues i = 1(1)5{
		gen l`i'`var' = l`i'.`var'
	}
}

drop l*weekly

*********************************************
/*Save screened daily stock level data (only temporary)*/
*********************************************

/*Keep Necessary Variables (data set is quite big)*/
*********************************************
keep date date_trd DSCD P_eur world_region_ff VO ret_eur xret mktrf* smb3* hml3* wml* mkt* ret*week calweek_mo* l*mkt*

gen datem = mofd(date)
format datem %tm





/*Save data*/
*********************************************
cd "${data_for_analysis}/03_DS_EIKON"
save "DS_tsD_allvars_screened.dta", replace



*********************************************
*********************************************
/* Part III: Calculate variables based on daily data */
*********************************************
*********************************************

*********************************************
/*Standard deviation of returns and abnormal returns*/
*********************************************

/*Start with monthly security-level data (we need the stock alpha and betas)*/
*********************************************

cd "${data_for_analysis}/03_DS_EIKON"
use "DS_ts_allvars_varcalc_Apr20.dta", clear


********************************
*!!!!!        NEW 		  !!!!!*
********************************
*Add one month to calendar month variable (we want coefficients of month t-1 to be merged to month t's daily stock information)
tab datem
replace datem = datem + 1
qui drop if datem > tm(2019m6)
********************************
*!!!!!        NEW 		  !!!!!*
********************************


keep DSCD datem stock_alpha_c4_* stock_beta*
duplicates drop

/*Merge Monthly Alphas and Betas to screened daily stock data*/
*********************************************
merge 1:m DSCD datem using "DS_tsD_allvars_screened.dta"

/*Drop if observation only in master data (monthly stock alpha and betas are calculated for a longer time period, starting before the daily stock data file*/
*********************************************
quietly drop if _merge == 1
drop _merge


/* Calculate daily residuals of stock returns (with past month coefficients and intercepts of the Carhart 4-Factor Model and daily factor returns) */
*********************************************
gen res_stock_c4 = .
local world_region "AsiaPac_exJP Europe Global Japan North_America"
foreach region of local world_region{
	replace res_stock_c4 = xret - (stock_alpha_c4_past + stock_beta_c4_mktrf*mktrf_`region'_EUR + stock_beta_c4_smb*smb3_`region'_EUR + ///
								   stock_beta_c4_hml*hml3_`region'_EUR + stock_beta_c4_wml*wml_`region'_EUR) if world_region_ff == "`region'"
}

*********************************************
/*Calculate Amihud illiquidity ratio*/
*********************************************
replace VO = 0 if VO == .
gen amihud_illiq = (abs(ret_eur)/(VO*1000*P_eur))*10^6

*Winsorize Amihud Illiquidity Ratio at 1% level
*********************************************
winsor2 amihud_illiq , cut(1 99) suffix("_w")


*********************************************
*********************************************
*Price Delay (Hou and Moskowitz, 2005; monthly version, see Boehmer and Wu, RFS 2013)
*********************************************
*********************************************

frame copy default tmp_calc
frame change tmp_calc

keep world_region_ff datem mkt_* l*mkt_* ret_eur* DSCD date_trd
drop if datem < tm(2014m11)


encode world_region_ff, gen(world_region_num)


gen r2_delay_restricted = .
gen r2_delay_unrestricted = .

egen ui_dscd = group(DSCD)

*Take numerical version of world regions (world_region_num) and iterate through the 5 regions
****************************************
forvalues r = 1(1)5{ 
	
	capture drop reg_nobs reg_r2 reg_adj_r2 b_* se_*

	if `r' == 1{
		local region = "AsiaPac_exJP"
		}
	else if `r' == 2{
		local region = "Europe"
		}
	else if `r' == 3{
		local region = "Global"
		}
	else if `r' == 4{
		local region = "Japan"
		}
	else if `r' == 5{
		local region = "North_America"
		}

	di "`region'"


	/*Estimate Restricted Model*/
	****************************************
	rangestat (reg) ret_eur mkt_`region'_EUR if world_region_num == `r', interval(datem . .) by(ui_dscd datem)
	replace r2_delay_restricted = reg_r2 if world_region_num == `r'
	replace r2_delay_restricted = . if reg_nobs < 15 & world_region_num == `r'
	
	capture drop reg_nobs reg_r2 reg_adj_r2 b_* se_*
	
	
	/*Estimate Restricted Model*/
	****************************************
	rangestat (reg) ret_eur mkt_`region'_EUR l1mkt_`region'_EUR l2mkt_`region'_EUR l3mkt_`region'_EUR  l4mkt_`region'_EUR l5mkt_`region'_EUR if world_region_num == `r', interval(datem . .) by(ui_dscd datem)
	replace r2_delay_unrestricted = reg_r2 if world_region_num == `r'
	replace r2_delay_unrestricted = . if reg_nobs < 15 & world_region_num == `r'
	
	capture drop reg_nobs reg_r2 reg_adj_r2 b_* se_*
}

collapse (mean) r2_*, by(DSCD datem)
save "temp.dta", replace

frame change default
frame drop tmp_calc


*********************************************
*********************************************
/* Part IV: Collapse to monthly data (by stock) */
*********************************************
*********************************************
collapse (mean) amihud_illiq* (sd) ret_eur res_stock_c4*, by(DSCD datem) 

merge 1:1 DSCD datem using  "temp.dta"
*erase "temp.dta"
drop _merge

/*Rename Variables*/
*********************************************
rename ret_eur sd_ret
rename res_stock_c4 sd_idio
order DSCD datem amihud_illiq* sd_*

/*Rescale Variables*/
*********************************************
replace amihud_illiq = amihud_illiq*10^2
replace amihud_illiq_w = amihud_illiq_w*10^2

gen price_delay = 1 - (r2_delay_restricted/r2_delay_unrestricted)


/*Label Variables*/
*********************************************
label variable DSCD	"Stock: Datastream Security Identifier"
label variable datem "Time Variable: Calendar Month"
label variable amihud_illiq "Stock: Amihud illiquidity (x10^6)"
label variable amihud_illiq_w "Stock: Amihud illiquidity (x10^6, winsorized)"
label variable sd_ret "Stock: Standard deviation of raw returns (unscaled)"
label variable sd_idio "Stock: Standard deviation of idiosyncratic returns (Carhart 4-Factor, unscaled)"
label variable price_delay "Stock: Price Delay Measure - Monthly Version (Boehmer and Wu, 2013)"

/*Log and Lag Variables*/
*********************************************
egen ui = group(DSCD)
quietly drop if ui == .

gen ln_amihud = ln(amihud_illiq)
gen ln_amihud_w = ln(amihud_illiq_w)
gen ln_sd_idio = ln(sd_idio)
gen ln_sd_ret = ln(sd_ret)

label variable ln_amihud "Stock: Log of Amihud illiquidity"
label variable ln_amihud_w "Stock: Log of winsorized Amihud illiquidity"
label variable ln_sd_idio "Stock: Log of standard deviation of idiosyncratic returns"
label variable ln_sd_ret "Stock: Log of standard deviation of raw returns"

tsset ui datem

foreach var of varlist ln_amihud* ln_sd_*{
	gen l`var' = l.`var'
}

gen price_delay_plus1 = F.price_delay
gen price_delay_plus3 = F3.price_delay

label variable lln_amihud "Stock: Lagged Log of Amihud illiquidity"
label variable lln_amihud_w "Stock: Lagged Log of winsorized Amihud illiquidity"
label variable lln_sd_idio "Stock: Lagged Log of standard deviation of idiosyncratic returns"
label variable lln_sd_ret "Stock: Lagged Log of standard deviation of raw returns"

*********************************************
/*Save Data*/
*********************************************
cd "${data_for_analysis}/03_DS_EIKON"

drop ui
compress
describe

save "DS_tsD_allvars_varcalc_Aug22.dta", replace
*erase "DS_tsD_allvars_screened.dta"

**********************************************************************************************
***EOF
**********************************************************************************************




