*============================================================*
/* CA Schools */
*============================================================*
clear
set more off
ssc install grstyle, replace
*============================================================*
gl base="C:\Users\ogalvez\Documents\Econ 11020"
gl data= "https://raw.githubusercontent.com/galvez-soriano/Econometrics/main/UChicago"
*============================================================*
/* use "$base\CASchools_EE141_InSample.dta", clear
rename str_s str
rename ell_frac_s el
rename enrollment_s enroll
save "$base\CAschools.dta", replace */
*============================================================*
use "$data/CAschools.dta", clear
reg testscore str el
reg testscore str el enroll
*============================================================*
use "$data/cps2022.dta", clear

reg lwage educ exper
vce
* SE of coefficient for educ
dis sqrt(0.00002856)
* SE of coefficient for exper
dis sqrt(6.785e-07)
