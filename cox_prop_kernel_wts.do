// Cox Prop Hazard Models with and without kernel weights, clustering, bootstrapping 
version 16

use "Datasets\Derived\hcc_data06v3.dta" if encounter_type == "Inpatient", clear

*Generate readmission 
by mrn (admit_date disch_date visit_id), sort: gen readmission_date = admit_date[_n+1]
format readmission_date %td

gen readmission = readmission_date != .

*_______________________________________________________________________________
//Propensity Score Matching

*Covariates to include in Propensity Score calculation

local pscov female race age_first active_alcohol_use ald hcv  meldI smoker_status rifaximin ///
			charlsonW hbv embolization platelet  primaryinsurance

cap drop pc_pscore pc_block

pscore pc_hosp `pscov', pscore(pc_pscore) blockid(pc_block) detail comsup logit

psgraph, treated(pc_hosp) pscore(pc_pscore) support(comsup)

/*Check Range of common support - Extent to which distributions of ps in treatment
and comparison groups overlap. (psgraph w/ support option). */

// Assess balance with standardized differences (% Bias)
*- This accounts for means and variances
* -Not sensisitive to sample size  */

pstest `pscov', t(pc_hosp) mweight(pc_pscore) label both


//Kernel matching
psmatch2 pc_hosp, outcome(readmission) pscore(pc_pscore) kernel logit common

/*Treatment effects with kernel-weighted data are not part of the teffects packaged...
use bootstrapping to obtain correct standard errors */

*bs "psmatch2 pc_database, kernel outcome(readmit) common pscore(pc_pscore)" "r(att)" , reps(100) dots
*bs "psmatch2 pc_database, kernel outcome(icu)     common pscore(pc_pscore)" "r(att)" , reps(100) dots

//Evaluate standardized differences in matched sample. %bias <5 is ideal.
pstest `pscov', both graph

psgraph, treated(pc_hosp) pscore(pc_pscore) support(comsup)
rename _weight kernelweight
*_______________________________________________________________________________

gen surv_days = readmission_date - disch_date

replace surv_days = td(18Apr2016) - disch_date if missing(surv_days)
count if surv_days < 0
drop if surv_days < 0


// Cox Prop withOUT kernel-weights
stset surv_days, failure(readmission)
sts list
sts graph, title("Survivor function") //Kaplan meier curve
sts graph, title("Cumulative hazard function") na

local ivars female pc_hosp white_nonhisp 			 ///
			medicaid ald  hbv hcv nash  			///
			embolization liver_transplant sorafenib ///
			rifaximin charlsonW surgery

local cvars age_first_visit first_pain_score

local lab_results meld_na platelet

eststo clear
eststo: stcox `ivars' `cvars' `lab_results'



// Cox Prop with Kernel Weights
drop if missing(kernelweight)

stset, clear
stset surv_days [pw = kernelweight], failure(readmission)
sts list

*export to excel, send to CW 
preserve
sts list if pc_hosp==1, saving(Datasets\Derived\surv_data_pc, replace)
restore

preserve
sts list if pc_hosp==0, saving(Datasets\Derived\surv_data_nonpc, replace)
restore


///
*drop if _t>=500 // truncates graphs
///

label def pcc 0 "Non palliative care" 1 "Palliative care"
label val pc_hosp pcc
sts graph, by(pc_hosp)title("Time to hospital readmission by PCC Status")  ylabel(.25 (.25) 1) xscale(range(0 500)) xtitle(Time (Days)) 
sts graph, title("Cumulative hazard function") na

eststo: stcox `ivars' `cvars' `lab_results'



//Cox Prop with K-weights and Clustering by Patient
eststo: stcox `ivars' `cvars' `lab_results', cluster(mrn)

label var _t "Haz. Ratio"

esttab using "Tables\coxprop_matched.rtf", eform ci replace label onecell		  ///
		mtitle("Unweighted" "Kernel Weighted" "Weighted & Clustered MRN")		  ///
		title("Cox Proportional Hazards Regression Models Examining Readmission") 


exit

 
//Bootstrapped kernel weighted cox prop 

capture program drop cboot
program define cboot, rclass

stset, clear
stset surv_days [pw = kernelweight], failure(readmission) // declare data to be survival-time data

stcox     female pc_hosp white_nonhisp             ///
		  medicaid ald  hbv hcv nash               ///
		  embolization liver_transplant sorafenib  ///
		  rifaximin charlsonW surgery              ///
		  age_first_visit first_pain_score		   ///
		  meld_na platelet

return scalar btx = _b[pc_hosp]      // coefficient

return scalar hrx = exp(_b[pc_hosp]) // hazard ratio
end

set seed 1234
bootstrap r(btx) r(hrx), reps(1000) cluster(mrn): cboot
estat boot, all