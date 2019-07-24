// Monthly Data Summary (putexcel table code template) 

* N and % for indicator/categorical variables
* mean and median for continuous variables

version 16.0

keep if inrange(date, start_date, end_date) //keep date range of interest

gen yearmonth = ym(year, month)  //easier to work with yearmonth var than year and month separately 
format yearmonth %tmMon-ccYY

putexcel set "filepath", replace sheet("Monthly Table")

local r = 3 //row counter
local c = 3 //column counter

tokenize A B C D E F G H I J K L M N O P Q R S T U V W X Y Z //A = 1, B = 2, C = 3 , etc.

local ivars   //local of indicator vars 
local cvars   //local of continuous vars
local catvars //local of categorical vars

local wc: word count `ivars' `cvars' 1

foreach ym of local yearmonth {
	
	//Indicator vars
	
	foreach x of local ivars {
		local lab_var: variable label `x'
		
		putexcel B`r' = ("`lab_var'")
		
		sum `x' if yearmonth==`ym'
		
		local num   = string(`r(sum)')
		local meann = string((`r(sum)'/`r(N)')*100, "%9.1f")
		local comb  = "`num' (`meann')"

		putexcel ``c''`r' = ("`comb'")	
		putexcel ``c''2 = ("`ym'")
		
		local r = `r'+1
	}
	
	//Continuous vars
	
	foreach cv of local cvars {
		local lab_var: variable label `cv'
		
		putexcel B`r' = ("`lab_var'")
		
		sum `cv' if yearmonth==`ym', detail
		
		local meann = string((`r(sum)'/`r(N)'), "%9.1f")
		local med	= string(`r(p50)')
		local comb  = "`meann' (`med')"

		putexcel ``c''`r' = ("`comb'")
					
		local r = `r'+1
	}
		
local c = `c'+1
local r = 3
}

di `r'
local r = `r' + `wc''
local c =3	

	//Categorical vars

foreach x of local catvars {
	local labvar: variable label `x'
	
	putexcel B`=`r'-1' = ("`labvar'"), underline
	
		foreach ym of local yearmonth {
			levelsof `x', local(levels)
			
			local lbe : value label `x'
			local wc  : word count `levels'	
				
				foreach l of local levels {
					local f`x'`l' : label `lbe' `l'
					
					tab `x' if yearmonth==`ym'
					
					local total=`r(N)'
					di "`total'"
					
					sum `x' if `x'==`l' & yearmonth==`ym'
	
					local num   = string(`r(N)')
					local meann = string(((`r(N)'/`total')*100), "%9.1f")
					local comb  =  "`num' (`meann')"
	
					putexcel B`r'=("`f`x'`l''")
					putexcel ``c''`r'=("`comb'")
					
					local r = `r'+1
				}			
		local r = `=`r'-`wc'' 
		local c = `c'+1		
		
		}
local r = `r' + 1
local c = 3

}