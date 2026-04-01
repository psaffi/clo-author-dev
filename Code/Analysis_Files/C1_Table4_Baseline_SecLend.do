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
capture reghdfe, compile
capture ftools, compile

capture mkdir "${path}/results/${datum}"


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
foreach var of varlist *LSP*{
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



*********************************************
/*Additional Variables*/
*********************************************

*Does any fund in the family currently lend the stock (2nd version: not the fund itself)
bys ui_family ui_dscd datem: egen dum_slend_family_now = max(dum_slend_now)
gen dum_slend_family_now_noown = dum_slend_family_now
replace dum_slend_family_now_noown = 0 if dum_slend_now == 1

bys ui_family ui_dscd datem: egen dum_slend_family_12m = max(dum_slend_12m)
gen dum_slend_family_12m_noown = dum_slend_family_12m
replace dum_slend_family_12m_noown = 0 if dum_slend_12m == 1
	
tsset ui_fund_sec datem


/*Lagged Lending Dummies */
****************************************
gen ldum_slend_12m = l.dum_slend_12
*gen ldum_slend_now = l.dum_slend_now

gen ldum_slend_now = (lsec_mv_lend_adj != 0)
replace ldum_slend_now = . if lsec_mv_lend_adj == .

gen ldum_flend_12m = l.dum_flend_12m
gen ldum_fflend_12m = l.dum_fflend_12m

gen fon_loan_mv = F.on_loan_mv

*gen lsec_mv_lend = l.sec_mv_lend
gen lon_loan_fund = lsec_mv_lend_adj/(lMV_eur*10^3)	
replace lon_loan_fund = lon_loan_fund*100

winsor2 lon_loan_fund, cut(0 99) replace

	
gen lon_loan_fund_12m = l.on_loan_fund_12m
winsor2 lon_loan_fund_12m, cut(0 99) replace

*Family Level Lending
****************************************
bys ui_family ui_dscd datem: egen temp = sum(lsec_mv_lend_adj)
gen lon_loan_fam = temp/(lMV_eur*10^3)
replace lon_loan_fam = lon_loan_fam*100

gen lon_loan_fam_other = lon_loan_fam - lon_loan_fund  //amount lend by family - amount lend by specific fund 

*If fund itself is lending, set fam_other to 0 (i.e. fam_other only captures cases in which fund itself is NOT lending)
gen lon_loan_fam_other_adj = lon_loan_fam_other
replace lon_loan_fam_other_adj = 0 if lon_loan_fund != 0

winsor2 lon_loan_fam, cut(0 99) replace
winsor2 lon_loan_fam_other, cut(0 99) replace
winsor2 lon_loan_fam_other_adj, cut(0 99) replace



/*We do not consider entries for the analysis*/
****************************************
qui drop if dum_entry == 1




/*Episodes which include an immediate position reversal*/
**********************************************************
tsset ui_fund_sec datem
gen dum1 = (dpos_prc_nom_adj_99_5 == -50 & l.dpos_prc_nom_adj_99_5 == 100 & l.dpos_prc_nom_adj_99_5 != . & l.dum_entry == 0)
gen dum2 = (dpos_prc_nom_adj_99_5 == 100 & F.dpos_prc_nom_adj_99_5 == -50 & dpos_prc_nom_adj_99_5 != . & dum_entry == 0)

****************************************
/*Label Variables*/
****************************************


/*Label Shorting Demand Variables*/
****************************************
label variable on_loan_mv "Market Value on Loan (as % of Market Cap)"
label variable lon_loan_mv "Lagged Market Value on Loan (as % of Market Cap)"
label variable lutilisation "Lagged Utilization Rate (Short Demand/Short Supply)"
label variable lln_vwaf_30_day "Lagged Log of Value-Weighted Lending Fee"

/*Label Lending Dummies*/
****************************************
label variable ldum_fflend_12m "Dummy: Fund Family is lender (in last three month)"
label variable ldum_flend_12m "Dummy: Fund is lender (in last three month)"
label variable ldum_slend_12m "Dummy: Security lend out by fund once in last three months"
label variable dum_fund_active "Dummy: Active Fund"


/*Label control variables */
****************************************
label variable lpct_amihud_rank "Lagged Amihud Illiquidty Percentile Rank"
label variable ldpos_prc_nom_adj_99_5 "Lagged Position Change (in %)"
label variable lpos_w_developed "Lagged Portfolio Position Weight (in %)"

******************************************************************************************************************************
******************************************************************************************************************************

*keep if dum_fund_active == 1


*********************************************
*********************************************
/* Part II: Regression Analysis of Fund Holdings */
*********************************************
*********************************************
tsset ui_fund_sec datem

****************************************
/* De-Mean Short Interest (by active/passive funds) */
****************************************
bys ui_dscd datem: gen ct_stock = _n
gen lon_loan_mv_d = lon_loan_mv

qui sum lon_loan_mv 
replace lon_loan_mv_d = (lon_loan_mv_d - r(mean))/r(sd) 

label variable lon_loan_mv_d "Lagged Market Value on Loan (as % of Market Cap) in t-1"


gen lon_loan_fund_d = lon_loan_fund

qui sum lon_loan_fund
replace lon_loan_fund_d = (lon_loan_fund_d - r(mean))/r(sd) 

label variable lon_loan_fund_d "Amount on Loan of a given stock by a given fund"




****************************************
/* Define macros which contain lists of:
	- Position Changes, Exit Dummy, Position Changes w/o exits (LHS dependent variable)
	- lending market demand variables (main RHS variable of interest)
	- fund-security level controls (other RHS variables) */
****************************************

global dependent "dpos_prc_nom_adj_99_5" // dum_exit" // choose: dpos_prc_nom_adj_99_5 dum_exit
global SD "lon_loan_fund" // choose: lon_loan_mv lutilisation lln_vwaf ldcbs
global fund_sec_controls "c.lpct_amihud_rank c.lpos_w_developed_adj"
global clustvar "ui_fund"


****************************************
/*Run regressions for each dependent variable (Position Changes, Exit Dummy, Position Changes w/o exits)
  and each lending market demand variable (Market Capitalzation on Loan)*/
****************************************
foreach s of global SD{
	foreach d of global dependent{
		cd "${results}"
		
		*Clear estimates, scalars and placeholders
		****************************************
		est clear
		scalar drop _all
		
				
		****************************************
		*1.Regression: Baseline (no FE)
		****************************************
		reghdfe `d' c.lon_loan_fund_d ${fund_sec_controls} if dum_exit == 0 , absorb(ui_sec_datem ui_fund_datem ui_fund_sec) cluster(${clustvar})
		est store reg_dpos_pool_1
		
		capture drop include
		gen include = (e(sample) == 1)
		
		****************************************
		*2.Regression: Include interaction with OnLoan of Stock
		****************************************
		reghdfe `d' c.lon_loan_fund_d##c.dum_fund_active ${fund_sec_controls} if dum_exit == 0 & include == 1 , absorb(ui_sec_datem ui_fund_datem ui_fund_sec)  cluster(${clustvar})
		est store reg_dpos_pool_2
		
		
		****************************************
		*3.Regression: Include interaction with OnLoan of Stock
		****************************************
		reghdfe `d' c.lon_loan_fund_d ${fund_sec_controls} if dum_exit == 0 & dum_fund_active == 1 , absorb(ui_sec_datem ui_fund_datem ui_fund_sec)  cluster(${clustvar})
		est store reg_dpos_pool_3
		
		capture drop include
		gen include = (e(sample) == 1)
		
		****************************************
		*4.Regression: Include interaction with OnLoan of Stock
		****************************************
		reghdfe `d' c.ldum_slend_now ${fund_sec_controls} if dum_exit == 0 & dum_fund_active == 1 & include == 1, absorb(ui_sec_datem ui_fund_datem ui_fund_sec) cluster(${clustvar})
		est store reg_dpos_pool_4
		
		****************************************
		*5.Regression: Include interaction with OnLoan of Stock
		****************************************
		reghdfe `d' c.lon_loan_fund_d c.ldum_slend_now ${fund_sec_controls} if dum_exit == 0 & dum_fund_active == 1 & include == 1, absorb(ui_sec_datem ui_fund_datem ui_fund_sec)  cluster(${clustvar})
		est store reg_dpos_pool_5
		
		****************************************
		*5.Regression: Include interaction with OnLoan of Stock
		****************************************
		reghdfe `d' c.lon_loan_fund_d ${fund_sec_controls} if dum_exit == 0 & dum_fund_active == 1 & disclosure_sample == 1 & ever_LSP == 1 & first_LSP_6m_pre1 != . & lon_loan_fund_d != ., absorb(ui_sec_datem ui_fund_datem ui_fund_sec)  cluster(${clustvar})
		est store reg_dpos_pool_6
		
		****************************************
		*5.Regression: Include interaction with OnLoan of Stock
		****************************************
		reghdfe `d'  c.ldum_slend_now ${fund_sec_controls} if dum_exit == 0 & dum_fund_active == 1 & disclosure_sample == 1 & ever_LSP == 1 & first_LSP_6m_pre1 != . & lon_loan_fund_d != ., absorb(ui_sec_datem ui_fund_datem ui_fund_sec)  cluster(${clustvar})
		est store reg_dpos_pool_7
		
		****************************************
		*5.Regression: Include interaction with OnLoan of Stock
		****************************************
		reghdfe `d' c.lon_loan_fund_d c.ldum_slend_now ${fund_sec_controls} if dum_exit == 0 & dum_fund_active == 1 & disclosure_sample == 1 & ever_LSP == 1 & first_LSP_6m_pre1 != . & lon_loan_fund_d != ., absorb(ui_sec_datem ui_fund_datem ui_fund_sec)  cluster(${clustvar})
		est store reg_dpos_pool_8
		
		
			
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
	
		export excel using "${datum}_Holdings_SecLend_NEW_T4.xlsx", sheet("NEW Table 4 (C3)") sheetmodify   cell(B5)
				
		restore
		erase temp.csv
	}
}


******************************************************************************************************************************
*** EOF
******************************************************************************************************************************


