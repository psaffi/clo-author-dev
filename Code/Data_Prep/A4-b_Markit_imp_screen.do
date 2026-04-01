
******************************************************************************************************************************
******************************************************************************************************************************
***
*** Number of project:		2016\0082				
*** Title of project:		Securities lending by mutual funds
*** Data source: 			Investment Fund Statistics (Original Data is December 2009 until December 2018; later on, June 2014 until December 2018 is kept for the analysis)
*** Name of programme code:	A4-b_Markit_imp_screen.do
***
*** Purpose of programme code: 
***			Part I: Import Markit Data for Different Regions		
***			Part II: Import Monthly Exchange Rates and Merge to Markit Data (for currency conversion)
***			Part III: Clean Markit Data, Filter out Stock-Day Duplicates
***			Part IV: Set Up End-of-Month File of Markit Data (IFS reports are also collected at end-of-month)
***		
******************************************************************************************************************************
******************************************************************************************************************************

/* Paths : */

*Comment next two lines out when running code via the master file (information comes from there in this case)
global datum 				= 	"20200416"				/* Date in the form yyyymmdd */
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

******************************************************************************************************************************
******************************************************************************************************************************
/* Part I: Import Markit Data for Different Regions */
******************************************************************************************************************************
******************************************************************************************************************************

****************************************
/*Import different regions and add currency*/
****************************************
cd "${ext_data}/20190514/Markit" 
clear

/*Import EU*/
****************************************
use "final_equity_eu.dta", clear
gen currency = ""
replace currency = "EUR" if currency == ""

/*Append USA*/
****************************************
append using "final_equity_us.dta"
replace currency = "USD" if currency == ""

/*Append OTHER*/
****************************************
append using "final_equity_other.dta"
replace currency = "USD" if currency == ""

/*Append Australia*/
****************************************
append using "final_equity_australia.dta"
replace currency = "AUD" if currency == ""

/*Append Asia excl Japan */
****************************************
append using "final_equity_asiaexjapauseqty.dta"
replace currency = "USD" if currency == ""

/*Append Japan*/
****************************************
cd "${ext_data}/20190520/"
append using "final_equity_japeqty.dta"
replace currency = "JPY" if currency == ""

/*Clean data */
****************************************
duplicates drop 

****************************************
/*Save raw Markit Data for All Countries */
****************************************
cd "${data_for_analysis}/04_Markit"
compress
save "DX_data_all_Apr20.dta", replace




******************************************************************************************************************************
******************************************************************************************************************************
/* Part II: Import Monthly Exchange Rates and Merge to Markit Data (for currency conversion) */
******************************************************************************************************************************
******************************************************************************************************************************


****************************************
/*Import: Exchange rates */
****************************************
preserve
cd "${data_for_analysis}/04_Markit/Exchange rates"
clear
import excel "DS_exchange_rates.xlsx", sheet("Tabelle1") cellrange(A2) firstrow

/*rename exchange rates*/
****************************************
rename JSPTEURER exchr_JPYtoEUR
rename EUROUSER exchr_USDtoEUR
rename EUAUSPER exchr_AUDtoEUR

/*formate date*/
****************************************
rename Code date
format date %td

/*save data*/
****************************************
save "DS_exchange_rates_Apr20.dta", replace
restore


****************************************
/* Merge Markit and Exchange Rates */
****************************************
cd "${data_for_analysis}/04_Markit/Exchange rates"
merge m:1 date using "DS_exchange_rates_Apr20.dta"

/*Drop using only, i.e. only exchange rate data, but no Markit data*/
****************************************
quietly drop if _merge == 2 
drop _merge 


****************************************
/*Exchange rate conversion of variables given in absolute terms */
****************************************
cd "${data_for_analysis}/04_Markit/"
foreach x of varlist *_value{

	/*Define EUR-counterpart for each value variable not given in EUR*/
	****************************************
	gen `x'_EUR = .
	replace `x'_EUR = `x'/exchr_JPYtoEUR if currency == "JPY"
	replace `x'_EUR = `x'/exchr_AUDtoEUR if currency == "AUD"
	replace `x'_EUR = `x'/exchr_USDtoEUR if currency == "USD"
	replace `x'_EUR = `x' if currency == "EUR"
	
}



******************************************************************************************************************************
******************************************************************************************************************************
/* Part III: Clean Markit Data (mostly to filter out duplicates) */
******************************************************************************************************************************
******************************************************************************************************************************

****************************************
/*Date Variable (monthly) */
****************************************
gen year = year(date)
gen month = month(date)

destring year, replace
destring month, replace

/*Date Variable - Calendar Month */
****************************************
gen datem = ym(year, month)
format datem %tm

drop year month
label variable datem "Date (monthly)"



****************************************
/*1. Duplicates in terms of Markit Identifier - ISIN - Date*/
****************************************
duplicates tag dxl_identifier isin date, gen(temp_dupl)
tab temp_dupl


/*A lot of these duplicates are misreports in the Australian data (entries for both AUD and USD) --> drop AUD entry*/
****************************************
tab currency if temp_dupl >0
quietly drop if temp_dupl >0 & currency  == "AUD"


/*Check how many duplicates in terms of ISIN - Date are left? */
****************************************
drop temp_dupl
duplicates tag isin date, gen(temp_dupl)
tab temp_dupl


**********************************************
/*2. Drop if number of lending agents is zero! */
**********************************************
quietly drop if temp_dupl >0 & active_agents == 0


/*Check how many duplicates in terms of ISIN - Date are left? */
****************************************
drop temp_dupl
duplicates tag isin date, gen(temp_dupl)
tab temp_dupl


****************************************
/*Aggregate inventory and total demand value (EUR) for duplicates (i.e. stock-day pairs reported with different information on lending agent)*/
****************************************
bys isin date: egen bo_inventory_sum_EUR = sum(bo_inventory_value_EUR) if temp_dupl > 0
bys isin date: egen total_demand_sum_EUR = sum(total_demand_value_EUR) if temp_dupl > 0

*For non-duplicate observations, aggregate inventory and total demand value is just equal to the variable itself
replace bo_inventory_sum_EUR = bo_inventory_value_EUR if temp_dupl == 0
replace total_demand_sum_EUR = total_demand_value_EUR if temp_dupl == 0


**********************************************
/*3. Drop duplicate which is not associated with the maximum value of lending agents  */
**********************************************
bys isin date: egen temp_max_act_agents = max(active_agents)
quietly drop if temp_dupl >0  & temp_max_act_agents != active_agents 
drop temp_max_act_agents

/*Check how many duplicates in terms of ISIN - Date are left? */
****************************************
drop temp_dupl
duplicates tag isin date, gen(temp_dupl)
tab temp_dupl



**********************************************
/*4. Drop duplicate which is not associated with the maximum value of inventory (EUR)  */
**********************************************
bys isin date: egen temp_max_inventoryEUR = max(bo_inventory_value_EUR)
quietly drop if temp_dupl >0  & temp_max_inventoryEUR != bo_inventory_value_EUR 
drop temp_max_inventoryEUR

/*Check how many duplicates in terms of ISIN - Date are left? */
****************************************
drop temp_dupl
duplicates tag isin date, gen(temp_dupl)
tab temp_dupl


**********************************************
/*5. Manual drop   */
**********************************************
quietly drop if dxl_identifier == 258997 & temp_dupl >0


/*Check how many duplicates in terms of ISIN - Date are left? */
****************************************
drop temp_dupl
duplicates tag isin date, gen(temp_dupl)
tab temp_dupl
drop temp_dupl



**********************************************
/*Save Cleaned Markit Data */
**********************************************
cd "${data_for_analysis}/04_Markit/"
compress
save "DX_data_all_cleaned_Apr20.dta", replace




******************************************************************************************************************************
******************************************************************************************************************************
/* Part IV: Set Up Markit Data End-of-Month File */
******************************************************************************************************************************
******************************************************************************************************************************

/* Use Cleaned Markit Data */
**********************************************
cd "${data_for_analysis}/04_Markit/"
clear
use "DX_data_all_cleaned_Apr20.dta", replace


/*Add trading days and end-of-month dataset */
**********************************************
cd "${data_for_analysis}/04_Markit/Trading days"
merge m:1 date using  "trading_days_DE_Apr20.dta"
tab _merge

/*Only Keep if Day is Trading Day in Germany*/
**********************************************
quietly keep if _merge == 3
drop _merge


/*Calculate monthly average of utilisation and total demand value on loan*/
**********************************************
bys isin datem: egen utilisation_Mmean = mean(utilisation)
bys isin datem: egen total_demand_value_Mmean = mean(total_demand_value)
bys isin datem: egen total_demand_value_EUR_Mmean = mean(total_demand_value_EUR)
bys isin datem: egen total_demand_value_EUR_Mmax = max(total_demand_value_EUR)
bys isin datem: egen total_demand_sum_EUR_Mmean = mean(total_demand_sum_EUR)

bys isin datem: egen fee_risk = sd(vwaf_30_day)

bys isin datem: egen active_agents_Mmean = mean(active_agents)
bys isin datem: egen active_agents_Mmax = max(active_agents)


/*For each DCBS Score, calculate monthly distribution of "typical" lending fees (mean, median, 5th percentile, 95th percentile) 
  -> used for calculation of lending income as in Blocher and Whaley (2016)*/
**********************************************
bys dcbs datem: egen vwaf_all_day_mean = mean(vwaf_all_day)
bys dcbs datem: egen vwaf_all_day_median = pctile(vwaf_all_day), p(50)
bys dcbs datem: egen vwaf_all_day_p5 = pctile(vwaf_all_day), p(5)
bys dcbs datem: egen vwaf_all_day_p95 = pctile(vwaf_all_day), p(95)


**********************************************
/*Identify Day which Corresponds to End-of-Month Date (end-of-month == 0, -1 day, -2 days) */
**********************************************

/*1.) Determine for each ISIN and month the last calendar date (based on the ultimo dummy, so either 0, -1, or -2) */
**********************************************
bys isin datem: egen temp_max = max(dum_month_ultimo)

/*2.) Only keep the last calendar date + also just if last day in the month or 1/2 days before that */
**********************************************
keep if dum_month_ultimo == temp_max  
keep if (dum_month_ultimo == 0| dum_month_ultimo == -1| dum_month_ultimo == -2)
drop temp_max dum_month_ultimo

egen ui = group(isin)
tsset ui datem

gen fee_risk_plus1 = F.fee_risk
gen fee_risk_plus3 = F3.fee_risk_plus1

drop ui

**********************************************
/*Save Montly Markit Data */
**********************************************
cd "${data_for_analysis}/04_Markit/"
compress
describe

save "DX_data_all_cleaned_endofM_Apr20.dta", replace


**********************************************************************************************
***EOF
**********************************************************************************************



