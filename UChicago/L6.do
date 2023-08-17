*============================================================*
/* ECON 11020 / Professor Oscar Galvez-Soriano */
*============================================================*
/* Lecture 6 */
*============================================================*
clear
set more off
*============================================================*
gl base="C:\Users\galve\Documents\UChicago\ECON11020"
gl data= "https://raw.githubusercontent.com/galvez-soriano/Econometrics/main/UChicago"
*============================================================*
/* Hypothesis Testing */
*============================================================*
use "$data/cps2022.dta", clear
reg lwage educ exper, vce(robust)
/* t critical value */
dis -invnorm(0.025)
dis -invt(111624, 0.025)
/* p-value */
dis 2*normal(-59.22)
dis 2*t(111624, -59.22)
/* Confidence interval */
dis 0.3281549-1.96*0.0055415
dis 0.3281549+1.96*0.0055415
*============================================================*
/*Example with R2 and adjusted R2 */
*============================================================*
use "$data/CAschools.dta", clear
reg testscore str el enroll
