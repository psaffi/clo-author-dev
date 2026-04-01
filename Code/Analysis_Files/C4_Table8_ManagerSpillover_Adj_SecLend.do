******************************************************************************************************************************
******************************************************************************************************************************
***
*** Number of project:		2016\0082				
*** Title of project:		Securities lending by mutual funds
*** Data source: 			Investment Fund Statistics (December 2009 until December 2018; December 2014-December 2018 is used for analysis
*** Name of programme code:	C1_Descriptive_Statistics.do
***
*** Purpose of programme code: Calculation of descriptive statistics for lenders and non-lenders
***			Part I: 	Create additional variables and rescale variables for descriptive statistics
***			Part II: 	Descriptives for Number of Funds and Assets under Management in the sample
***			Part III:	Descriptives for Securities Lending Activity
***			Part IV: 	Descriptives for Main Variables (Fund-Security Level)
***
******************************************************************************************************************************
******************************************************************************************************************************

/* Paths : */

*Comment next two lines out when running code via the master file (information comes from there in this case)
global datum 				= 	"20260311"				/* Date in the form yyyymmdd */
global proj_num				=	"2016_0082r"			/* Please spezify project number with underscore */

global path					= 	"R:/Zentrale/ZB-S/Daten_FDSZ_Gastforscher/1_gafo/${proj_num}"

global orig_data			=	"${path}/data/orig"							/* Path for original data */
global data_for_analysis	= 	"${path}/data/data_for_analysis"			/* Path to data used for analysis */
global temp_data			=	"${path}/data/temp"							/* Path for temporary files */
global ext_data				=	"${path}/data/ext"							/* Path for external data */

global ado					=	"${path}/ado"								/* ado-path */
global code					=	"${path}/code/${datum}"						/* Path for program codes */
global results				=	"${path}/results/${datum}"					/* Path for results */

*Select Sample: Active vs. Passive Funds (do file is run for both cases in a loop)
*********************************************
global active ""dum_fund_active == 1""	/* For active funds */
global passive ""dum_fund_active == 0""	/* For passive funds */
global fund_type "${active}"

sysdir set STBPLUS "${ado}"

clear all 
set more off
capture reghdfe, compile
capture ftools, compile

capture mkdir "${results}"


******************************************************************************************************************************
******************************************************************************************************************************



*********************************************
*********************************************
/* Part I: Prepare data for analysis */
*********************************************
*********************************************

****************************************
/*Load Data Set (merged dataset: IFS data, Eikon Data, Morningstar Data, Markit Data, Net Short Position Data)*/
****************************************
cd "${data_for_analysis}"
use "B3_Panel_EquityFunds_FinalMerge_AddVar_2014m12on_Dec22.dta", clear

/*
gen FundFamily = ""
replace FundFamily = "DWS" if KAGNR == 6
replace FundFamily = "DEKA" if KAGNR == 7
replace FundFamily = "ALLIANZ" if KAGNR == 8
replace FundFamily = "AMPEGA" if KAGNR == 12
replace FundFamily = "UNION INVEST" if KAGNR == 13
replace FundFamily = "UNIVERSAL INVEST" if KAGNR == 14
replace FundFamily = "HSBC" if KAGNR == 15
replace FundFamily = "HANSAINVEST" if KAGNR == 18
replace FundFamily = "ODDO" if KAGNR == 20 | KAGNR == 21
*/


****************************************
/*Add Net Short Position Data*/
****************************************
cd "${data_for_analysis}/06_NSP"
merge m:1 DSCD datem using "Public_NetShortPositions_FirstDisclosureEvent_2012-2018_Jul25.dta"


/*
----------------------------------------------------------
_merge == 1: Data only in Holdings (no public short selling disclosure for these stock-months) -> OK
_merge == 2: Data only in Short Selling Disclosure (No holdings for the ISIN in the corresponding month) -> drop
----------------------------------------------------------
*/

****************************************
*Drop Stock-Months without any holdings in a given month 
****************************************
qui drop if _merge == 2		
drop _merge

*Stocks without any net short position disclosure -> fill up with 0's
****************************************
foreach var of varlist *LSP* *disclosure{
	replace `var' = 0 if `var' == .
}

*Index Exclusion Months
cd "${data_for_analysis}"
merge m:1 DSCD datem using "Index_Exclusions_v2.dta"
drop if _merge == 2

gen dum_index_exclusion = (_merge == 3)
drop _merge

drop if dum_index_exclusion == 1
drop dum_index_exclusion


*Lagged Index Exclusion Months
replace datem = datem + 1
merge m:1 DSCD datem using "Index_Exclusions_v2.dta"
drop if _merge == 2

gen dum_index_exclusion = (_merge == 3)
drop _merge

drop if dum_index_exclusion == 1
drop dum_index_exclusion 
replace datem = datem - 1


*Define Public Disclosure Sample
gcollapse (min) first_date = datem if first_LSP_6m == 1, by(DSCD) merge replace
gcollapse (min) first_date, by(DSCD) merge replace

gcollapse (max) ever_LSP = any_LSP, by(DSCD) merge replace

gen public_disclosure = (any_LSP == 1)
gen public_disclosure2 = (ever_LSP == 1)

*Define Private Disclosure Sample(s)
gen private_disclosure = (any_LSP == 0 & on_loan_mv > 0.2 & on_loan_mv <= 0.5)
gen private_disclosure2 = (any_LSP == 0 & on_loan_mv > 0.3 & on_loan_mv <= 0.5)
gen private_disclosure3 = (any_LSP == 0 & on_loan_mv > 0.4 & on_loan_mv <= 0.5)

rename (first*plus*) (first*pre*)
rename (first*minus*) (first*post*)

*Define time window for disclosure sample
gen disclosure_sample = (first_LSP_6m_post1 == 1 | first_LSP_6m_post2 == 1 | first_LSP_6m_post3 == 1 | first_LSP_6m == 1 | first_LSP_6m_pre1 == 1 | first_LSP_6m_pre2 == 1 | first_LSP_6m_pre3 == 1)

****************************************
/*Add Manager Information*/
****************************************
cd "${data_for_analysis}\02_MS"
joinby FundId datem using "Manager_history_nonames_cc.dta", unmatched(master)


*Fill in or drop missings?
****************************************
*sum manager_id
*replace manager_id = `r(max)' + ui_family if manager_id == .

drop if manager_id == .


****************************************
/*Regression Preparation*/
****************************************
egen ui_fund_man_sec = group(ui_fund_sec manager_id)
egen ui_man_datem = group(manager_id datem)
egen ui_man_sec = group(manager_id ui_dscd)

tsset ui_fund_man_sec datem

/*Lagged Lending Dummies */
****************************************
gen ldum_slend_12m = l.dum_slend_12m 
gen ldum_flend_12m = l.dum_flend_12m
gen ldum_fflend_12m = l.dum_fflend_12m

gen lon_loan_fund = lsec_mv_lend_adj/(lMV_eur*10^3)	
replace lon_loan_fund = lon_loan_fund*100

gen lon_loan_fund_12m = l.on_loan_fund_12m
gen lon_loan_fund_6m = l.on_loan_fund_6m
gen lon_loan_fund_3m = l.on_loan_fund_3m


*Family Level Lending
****************************************
bys ui_family ui_dscd datem: egen temp = sum(lsec_mv_lend_adj)
gen lon_loan_fam = temp/(lMV_eur*10^3)
replace lon_loan_fam = lon_loan_fam*100

gen lon_loan_fam_other_fund = lon_loan_fam - lon_loan_fund  //amount lend by family - amount lend by specific fund 

gen lon_loan_fam_other_fund_adj = lon_loan_fam_other_fund
replace lon_loan_fam_other_fund_adj = 0 if lon_loan_fund != 0


	
*Manager Level Lending (and split between funds managed by m and not by m)
****************************************
bys manager_id ui_family ui_dscd datem: egen lon_loan_man = sum(lon_loan_fund) 	

gen lon_loan_man_other_fund = lon_loan_man - lon_loan_fund //amount lend by manager - amount lend by manager in a specific fund (i.e. for lending fund, amount lend in other funds is 0; for non-lending funds, amount lend in other funds is > 0)

gen lon_loan_man_other_fund_adj = lon_loan_man_other_fund
replace lon_loan_man_other_fund_adj = 0 if lon_loan_fund != 0
	
gen lon_loan_fam_other_man = lon_loan_fam - lon_loan_man //amount lend by family funds not managed by manager m

gen lon_loan_fam_other_man_adj = lon_loan_fam_other_man
replace lon_loan_fam_other_man_adj = 0 if lon_loan_man != 0

winsor2 lon_loan_fund, cut(0 99) replace

winsor2 lon_loan_man, cut(0 99) replace	
winsor2 lon_loan_man_other_fund if lon_loan_man_other_fund != 0, cut(0 99) replace	
winsor2 lon_loan_man_other_fund_adj if lon_loan_man_other_fund_adj != 0, cut(0 99) replace	

winsor2 lon_loan_fam, cut(0 99) replace
winsor2 lon_loan_fam_other_fund if lon_loan_fam_other_fund != 0, cut(0 99) replace
winsor2 lon_loan_fam_other_fund_adj if lon_loan_fam_other_fund_adj != 0, cut(0 99) replace

winsor2 lon_loan_fam, cut(0 99) replace
winsor2 lon_loan_fam_other_man if lon_loan_fam_other_man != 0, cut(0 99) replace
winsor2 lon_loan_fam_other_man_adj if lon_loan_fam_other_man_adj != 0, cut(0 99) replace


/*We do not consider entries for the analysis*/
****************************************
qui drop if dum_entry == 1


/*We only consider active funds for the analysis*/
****************************************
qui keep if dum_fund_active == 1



****************************************
/*Label Variables*/
****************************************


/*Label Shorting Demand Variables*/
****************************************
label variable on_loan_mv "Market Value on Loan (as % of Market Cap)"
label variable lon_loan_mv "Lagged Market Value on Loan (as % of Market Cap)"


/*Label Lending Dummies*/
****************************************
label variable ldum_fflend_12m "Dummy: Fund Family is lender (in last 12 month)"
label variable ldum_flend_12m "Dummy: Fund is lender (in last 12 month)"
label variable ldum_slend_12m "Dummy: Security lend out by fund once in last 12 months"
label variable dum_fund_active "Dummy: Active Fund"


/*Label control variables */
****************************************
label variable lpct_amihud_rank "Lagged Amihud Illiquidty Percentile Rank"
label variable ldpos_prc_nom_adj_99_5 "Lagged Position Change (in %)"
label variable lpos_w_developed "Lagged Portfolio Position Weight (in %)"



******************************************************************************************************************************
******************************************************************************************************************************

*********************************************
*********************************************
/* Part II: Regression Analysis of Fund Holdings */
*********************************************
*********************************************
tsset ui_fund_man_sec datem

****************************************
/* De-Mean Short Interest */
****************************************
bys ui_dscd datem: gen ct_stock = _n
gen lon_loan_mv_d = lon_loan_mv

qui sum lon_loan_mv 
replace lon_loan_mv_d = (lon_loan_mv_d - r(mean))/r(sd) 

label variable lon_loan_mv_d "Lagged Market Value on Loan (as % of Market Cap)"

***

gen lon_loan_fund_d = lon_loan_fund

qui sum lon_loan_fund
replace lon_loan_fund_d = (lon_loan_fund_d - r(mean))/r(sd) 

label variable lon_loan_fund_d "Amount on Loan of a given stock by a given fund"

***

gen lon_loan_man_d = lon_loan_man

qui sum lon_loan_man
replace lon_loan_man_d = (lon_loan_man_d - r(mean))/r(sd) 

label variable lon_loan_man_d "Amount on Loan of a given stock by a given manager"

gen lon_loan_man_other_fund_d = lon_loan_man_other_fund

qui sum lon_loan_man_other_fund
replace lon_loan_man_other_fund_d = (lon_loan_man_other_fund_d - r(mean))/r(sd) 

label variable lon_loan_man_other_fund_d "Amount on Loan of a given stock by a given manager - other funds"

gen lon_loan_man_other_fund_adj_d = lon_loan_man_other_fund_adj

qui sum lon_loan_man_other_fund_adj
replace lon_loan_man_other_fund_adj_d = (lon_loan_man_other_fund_adj_d - r(mean))/r(sd) 

label variable lon_loan_man_other_fund_adj_d "Amount on Loan of a given stock by a given manager - other funds"

***

gen lon_loan_fam_other_fund_d = lon_loan_fam_other_fund

qui sum lon_loan_fam_other_fund
replace lon_loan_fam_other_fund_d = (lon_loan_fam_other_fund_d - r(mean))/r(sd) 

label variable lon_loan_fam_other_fund_d "Amount on Loan of a given stock by a given family - other funds"

gen lon_loan_fam_other_fund_adj_d = lon_loan_fam_other_fund_adj

qui sum lon_loan_fam_other_fund_adj
replace lon_loan_fam_other_fund_adj_d = (lon_loan_fam_other_fund_adj_d - r(mean))/r(sd) 

label variable lon_loan_fam_other_fund_adj_d "Amount on Loan of a given stock by a given family - other funds"


***


gen lon_loan_fam_other_man_d = lon_loan_fam_other_man

qui sum lon_loan_fam_other_man
replace lon_loan_fam_other_man_d = (lon_loan_fam_other_man_d - r(mean))/r(sd) 

label variable lon_loan_fam_other_man_d "Amount on Loan of a given stock by a given family - other managers"

gen lon_loan_fam_other_man_adj_d = lon_loan_fam_other_man_adj

qui sum lon_loan_fam_other_man_adj
replace lon_loan_fam_other_man_adj_d = (lon_loan_fam_other_man_adj_d - r(mean))/r(sd) 

label variable lon_loan_fam_other_man_adj_d "Amount on Loan of a given stock by a given family - other managers"


****************************************
/* Define macros which contain lists of:
	- Position Changes, Exit Dummy, Position Changes w/o exits (LHS dependent variable)
	- lending market demand variables (main RHS variable of interest)
	- fund-security level controls (other RHS variables) */
****************************************

global dependent "dpos_prc_nom_adj_99_5"
global SD "lon_loan_mv" // choose: lon_loan_mv lutilisation lln_vwaf ldcbs
global fund_sec_controls "c.lpct_amihud_rank c.lpos_w_developed"
global clustvar "ui_family datem"

****************************************
/*Run regressions for each dependent variable (Position Changes, Exit Dummy, Position Changes w/o exits)
  and each lending market demand variable (Market Capitalzation on Loan)*/
****************************************
	foreach s of global SD{
		local counting = 0
	
		foreach d of global dependent{
			cd "${results}"
			
			*Clear estimates, scalars and placeholders
			****************************************
			est clear
			scalar drop _all

			
			****************************************
			*1.Regression: Manager has lent
			****************************************
			reghdfe `d' c.lon_loan_man_d##c.first_LSP_6m_pre1 ${fund_sec_controls} if dum_exit == 0 & disclosure_sample == 1 & ever_LSP == 1 & first_LSP_6m_pre1 != . & lon_loan_fund != ., absorb(ui_fund_datem ui_sec_datem ui_fund_sec) cluster(${clustvar})
			est store reg_dpos_pool_1
		
			****************************************
			*2.Regression: Manager has lent (funds managed by him w/o active lending)
			****************************************
			reghdfe `d' c.lon_loan_fund_d##c.first_LSP_6m_pre1 c.lon_loan_man_other_fund_adj_d##c.first_LSP_6m_pre1 ${fund_sec_controls}   if dum_exit == 0 & disclosure_sample == 1 & ever_LSP == 1 & first_LSP_6m_pre1 != . & lon_loan_fund != ., absorb(ui_fund_datem ui_sec_datem ui_fund_sec) cluster(${clustvar})
			est store reg_dpos_pool_2
			
			****************************************
			*3.Regression: Manager has lent (funds not managed by him w/o active lending)
			****************************************
			reghdfe `d' c.lon_loan_man_d##c.first_LSP_6m_pre1 c.lon_loan_fam_other_man_adj_d##c.first_LSP_6m_pre1 ${fund_sec_controls}   if dum_exit == 0 & disclosure_sample == 1 & ever_LSP == 1 & first_LSP_6m_pre1 != . & lon_loan_fund != ., absorb(ui_fund_datem ui_sec_datem ui_fund_sec) cluster(${clustvar})
			est store reg_dpos_pool_3
			
			****************************************
			*4.Regression: All Combined
			****************************************
			reghdfe `d' c.lon_loan_fund_d##c.first_LSP_6m_pre1 c.lon_loan_man_other_fund_adj_d##c.first_LSP_6m_pre1 c.lon_loan_fam_other_man_adj_d##c.first_LSP_6m_pre1 ${fund_sec_controls}   if dum_exit == 0 & disclosure_sample == 1 & ever_LSP == 1 & first_LSP_6m_pre1 != . & lon_loan_fund != ., absorb(ui_fund_datem ui_sec_datem ui_fund_sec) cluster(${clustvar})
			est store reg_dpos_pool_4
			
			*** Add Stock FE ***
			
			****************************************
			*5.Regression: Saturated Spec
			****************************************
			*reghdfe `d' c.lon_loan_fund_d##c.first_LSP_6m_pre1 c.lon_loan_man_other_fund_adj_d##c.first_LSP_6m_pre1 c.lon_loan_fam_other_man_adj_d##c.first_LSP_6m_pre1 ${fund_sec_controls}   if dum_exit == 0 & disclosure_sample == 1 & ever_LSP == 1 & first_LSP_6m_pre1 != . & lon_loan_fund != ., absorb(ui_fund_datem ui_sec_datem ui_fund_sec) cluster(${clustvar})
			*est store reg_dpos_pool_5
				
			****************************************
			*Output Control (only for the most extensive specification)
			****************************************
			if "${output_check}" == "Yes"{
				nobsreg ui_family
			}
			
			****************************************
			/*Export Change in Position (Pooled Sample - Triple Interaction)*/
			****************************************
			esttab reg_dpos_pool* using "temp.csv", b(4) t(2) star(* 0.10 ** 0.05 *** 0.01) /// 
													stats(r2 r2_a r2_within r2_a_within N absvars clustvar, /// 
													fmt(%9.4g %9.4g %9.4g %9.4g %16.0g %16.0g %9.4g %9.4g)) ///
													nodepvars label replace noomit nobase ///
		
			*Import Output file for cleaning
			****************************************
			preserve
			clear
			insheet using temp.csv
		
			
	
			*Export Excel File 
			****************************************
			export excel using "${datum}_Disclosure_Manager_NEW_T8.xlsx", sheet("Modi T8 - FF,T") sheetmodify   cell(B5)	
					
			restore
			erase temp.csv
		}
}


******************************************************************************************************************************
*** EOF
******************************************************************************************************************************






		
