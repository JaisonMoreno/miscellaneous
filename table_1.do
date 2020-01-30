/*
table_1
version 3.0
william.parker@uchospitals.edu

creates a publication quality Table 1 (summary statistics) for categorical and continuous covariates across groups.

********
syntax
varname [if] [in], cont_vars(varlist of continuous variables) cat_vars(varlist of categorical variables) [options]

where varname is a categorical group variable

options include:
creg_op(string of regression options to be applied to testing for differences between groups)
title(string of document title)
median - add median and IQR for continuous variables
any putdocx begin options
*******



examples:
sysuse auto.dta, clear
table_1 foreign, cont_vars(price mpg headroom trunk weight length turn displacement gear_ratio) cat_vars(rep78) title(auto_table_1.docx)


*/
cap program drop table_1
program define table_1
version 15
syntax varname [if] [in], cont_vars(varlist) cat_vars(varlist) [creg_op(string) title(string) median *]
preserve
marksample touse
keep if `touse'

putdocx begin, `options' 

putdocx paragraph
putdocx text ("Table 1"), bold

*create header
putdocx paragraph
distinct `varlist'
local n_cats = r(ndistinct)
local col = 3+2*`n_cats'
putdocx table tbl1 = (2,`col'), border(all, nil) memtable layout(fixed)
putdocx table tbl1(1,1) = (" "), halign(left) border(top) colspan(2)
putdocx table tbl1(2,1) = ("variable"), halign(left) border(bottom) colspan(2)

levelsof `varlist', local(`varlist'_g)
local c_col = 2
foreach l of local `varlist'_g{
local var_lab : label `varlist' `l' 
putdocx table tbl1(1,`c_col') = ("`var_lab'"), halign(center) border(top) colspan(2) valign(center) 
quietly: sum if `varlist' == `l'
local obs_`l' = r(N)
putdocx table tbl1(2,`c_col') = ("(N =`obs_`l'')"), halign(center) border(bottom) colspan(2) valign(center) 
local ++c_col
}

putdocx table tbl1(1,`c_col') = (" "), halign(right) border(top) 
putdocx table tbl1(2,`c_col') = ("p-value"), halign(right)border(bottom)

*continuous variables
local row 1
local col= `n_cats'*2+3
putdocx table tbl2 = (1,`col'), memtable cellmargin(left, 0.015) cellmargin(right, 0.015) layout(fixed) border(all,nil)
putdocx table tbl2(`row',.), addrows(1)

local sub_head = `col'-1
forvalues c = 3/`sub_head'{
if mod(`c',2) ==1 {
putdocx table tbl2(`row',`c') = ("Mean"), halign(right) border(bottom) valign(bottom)
}
if mod(`c',2) ==0{
putdocx table tbl2(`row',`c') = ("±SD"), halign(left) border(bottom) valign(bottom)
}
}



foreach cv of local cont_vars{
putdocx table tbl2(`row',.), addrows(1)
local ++row

local var_lab : variable label `cv'
if "`var_lab'" == ""{
local var_lab `cv'
}

putdocx table tbl2(`row',1) = ("`var_lab'"), halign(left) colspan(2)

levelsof `varlist', local(over_group)
local cur_col 2
foreach i of local over_group{
tabstat `cv' if `varlist'==`i', stat(mean sd) format(%5.1f) save
matrix m = r(StatTotal)
local mn: di %5.2f m[1,1]
local mn = strltrim("`mn'")
local p_m "±"
local sd: di %5.2f m[2,1]
local sd = strltrim("`sd'")
local sd `p_m'`sd'
putdocx table tbl2(`row',`cur_col') = (`mn'), halign(right)
local ++cur_col
putdocx table tbl2(`row',`cur_col') = ("`sd'"), halign(left)
local ++cur_col

regress `cv' i.`varlist' , `creg_op' 
testparm i.`varlist'
local p : di %5.3f r(p)
if `p' < 0.001 {
local p "<0.001"
}
putdocx table tbl2(`row',`cur_col') = ("`p'"), halign(center)
}

}


*median and IQR for continuous variables
if "`median'" == "median"{
local row 1
local col= `n_cats'*2+3
putdocx table tbl4 = (1,`col'), memtable cellmargin(left, 0.015) cellmargin(right, 0.015) layout(fixed) border(all,nil)
putdocx table tbl4(`row',.), addrows(1)

local sub_head = `col'-1
forvalues c = 3/`sub_head'{
if mod(`c',2) ==1 {
putdocx table tbl4(`row',`c') = ("Median"), halign(right) border(bottom) valign(bottom)
}
if mod(`c',2) ==0{
putdocx table tbl4(`row',`c') = ("[IQR]"), halign(left) border(bottom) valign(bottom)
}
}



foreach cv of local cont_vars{
putdocx table tbl4(`row',.), addrows(1)
local ++row

local var_lab : variable label `cv'
if "`var_lab'" == ""{
local var_lab `cv'
}

putdocx table tbl4(`row',1) = ("`var_lab'"), halign(left) colspan(2)

levelsof `varlist', local(over_group)
local cur_col 2
foreach i of local over_group{
tabstat `cv' if `varlist'==`i', stat(median p25 p75) format(%5.1f) save
matrix m = r(StatTotal)
local mn: di %5.0f m[1,1]
local mn = strltrim("`mn'")
local p25: di %5.0f m[2,1]
local p25 = strltrim("`p25'")
local p75: di %5.0f m[3,1]
local p75 = strltrim("`p75'")
local iqr "[`p25'–`p75']"
putdocx table tbl4(`row',`cur_col') = (`mn'), halign(right)
local ++cur_col
putdocx table tbl4(`row',`cur_col') = ("`iqr'"), halign(left)
local ++cur_col

qreg `cv' i.`varlist' 
testparm i.`varlist'
local p : di %5.3f r(p)
if `p' < 0.001 {
local p "<0.001"
}
putdocx table tbl4(`row',`cur_col') = ("`p'"), halign(center)
}

}
}


*Categorical Variables
local row 1
distinct `varlist'

local col = 3+2*r(ndistinct)

putdocx table tbl3 = (1,`col'), border(all,nil) memtable cellmargin(left, 0.015) cellmargin(right, 0.015) layout(fixed)
putdocx table tbl3(`row',.), addrows(1)
local sub_head = `col'-1
forvalues c = 3/`sub_head'{
if mod(`c',2) ==1 {
putdocx table tbl3(`row',`c') = ("N"), halign(right) border(bottom) valign(bottom)
}
if mod(`c',2) ==0{
putdocx table tbl3(`row',`c') = ("(%)"), halign(left) border(bottom) valign(bottom)
}
}



foreach cv of local cat_vars{
distinct `cv'
local categories = r(ndistinct)+2
putdocx table tbl3(`row',.), addrows(`categories')
local ++row
*label categorical variable
local var_lab : variable label `cv'
if "`var_lab'" == ""{
local var_lab `cv'
}
mlogit `cv' i.`varlist', `creg_op' 
testparm i.`varlist'
local p : di %5.3f r(p)
if `p' < 0.001 {
local p "<0.001"
}
putdocx table tbl3(`row',`col') = ("`p'"), halign(center)

putdocx table tbl3(`row',1) = ("`var_lab'"), halign(left) underline colspan(2)


local ++row


levelsof `varlist', local(over_group)
local cur_col 1

foreach i of local over_group{
local r = `row'

levelsof `cv', local(c_l)
local k = 1

foreach c of local c_l{
local j = `cur_col'
local ct: label `cv' `c'
if "`ct'" == ""{
local ct `c'
}
tab `cv' if `varlist'==`i', matcell(M)
local freq_1 = M[`k',1]
local freq_1 = strltrim("`freq_1'")
local pt_1 =100*`freq_1'/`obs_`i''
local pt_1: di %5.1f `pt_1'
local pt_1 "`pt_1'"
local pt_1 = strltrim("`pt_1'")


if `cur_col'==1{
putdocx table tbl3(`r',`j') = ("`ct'"), halign(left) colspan(2)
local ++j
}

putdocx table tbl3(`r',`j') = (`freq_1'), halign(right)
local ++j

putdocx table tbl3(`r',`j') = ("(`pt_1')"), halign(left)
local ++j
local ++r
local ++k
} 
if `cur_col'==1 {
local cur_col = 4
}

else if `cur_col' !=1 {
local cur_col = `cur_col'+2
}

}

local row = `r'

}

if "`title'" == ""{

local title "table1.docx"
}

*create final table and put in document
if "`median'" == ""{
putdocx table tbl12 = (3,1), border(all, nil) headerrow(1) layout(fixed) cellspacing(0.01)
putdocx table tbl12(1,1) = table(tbl1) 
putdocx table tbl12(2,1) = table(tbl2) 
putdocx table tbl12(3,1) = table(tbl3), border(bottom) 
}

if "`median'" == "median"{
putdocx table tbl12 = (4,1), border(all, nil) headerrow(1) layout(fixed) cellspacing(0.01)
putdocx table tbl12(1,1) = table(tbl1) 
putdocx table tbl12(2,1) = table(tbl2) 
putdocx table tbl12(3,1) = table(tbl4)
putdocx table tbl12(4,1) = table(tbl3), border(bottom) 
}
putdocx save `title', replace

end
