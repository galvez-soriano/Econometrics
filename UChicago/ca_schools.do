*============================================================*
/* CA Schools */
*============================================================*
gl data="C:\Users\ogalvez\Documents\Econ 11020"
ssc install grstyle, replace
*============================================================*
use "$data\CASchools_EE141_InSample.dta", clear
rename str_s str
rename ell_frac_s el
rename enrollment_s enroll
save "$data\CAschools.dta", replace

reg testscore str el
reg testscore str el enroll
