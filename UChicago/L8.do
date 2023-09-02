*============================================================*
/* ECON 11020 / Professor Oscar Galvez-Soriano */
*============================================================*
/* Lecture 8 */
*============================================================*
clear
set more off
ssc install grstyle, replace
graph set window fontface "Times New Roman"
grstyle init
grstyle set plain, horizontal
*============================================================*
gl base="C:\Users\galve\Documents\UChicago\ECON11020"
gl data= "https://raw.githubusercontent.com/galvez-soriano/Econometrics/main/UChicago"
*============================================================*
/* Identifying heteroscedasticity */
*============================================================*
use "$data/cps2022.dta", clear

reg lwage educ exper

/* Visual insecption */
predict wage_hat
predict epsilon, resid
scatter epsilon wage_hat if lwage>0, yline(0)
graph export "$base\resid.png", replace

/* Breusch-Pagan test for heteroscedasticity */
estat hettest

/* White test for heteroscedasticity */
estat imtest, white
