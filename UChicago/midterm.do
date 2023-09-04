*============================================================*
/* ECON 11020 / Professor Oscar Galvez-Soriano */
*============================================================*
/* Midterm */
*============================================================*
clear
set more off
*============================================================*
gl base="C:\Users\galve\Documents\UChicago\ECON11020"
gl data= "https://raw.githubusercontent.com/galvez-soriano/Econometrics/main/UChicago"
*============================================================*
use "$data/birthweight_smoking.dta", clear

reg birthweight smoker nprevist alcohol

test nprevist=29
test nprevist=-alcohol

test nprevist alcohol

reg birthweight smoker

use "$data/acs2008.dta", clear
rename yrschool educ
gen educ_black=educ*black

reg lwage educ_black educ
