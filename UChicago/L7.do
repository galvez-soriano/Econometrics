*============================================================*
/* ECON 11020 / Professor Oscar Galvez-Soriano */
*============================================================*
/* Lecture 7 */
*============================================================*
clear
set more off
ssc install grstyle, replace
graph set window fontface "Times New Roman"
grstyle init
grstyle set plain, horizontal
*============================================================*
gl base="C:\Users\ogalvez\Documents\Econ 11020"
gl data= "https://raw.githubusercontent.com/galvez-soriano/Econometrics/main/UChicago"
*============================================================*
/* Interpretation */
*============================================================*
use "$data/cps2022.dta", clear

reg incwage educ exper
reg lwage educ exper
gen leduc=log(educ+1)
reg lwage leduc exper

*============================================================*
/* Specification: wages are not linear in experience */
*============================================================*
binscatter lwage exper, controls(educ) nquantiles(60) xtitle(Experience) ytitle(ln(wages))
graph export "$base\wexper.png", replace
binscatter lwage exper, controls(educ) nquantiles(60) line(qfit) xtitle(Experience) ytitle(ln(wages))
graph export "$base\wexper2.png", replace
binscatter lwage exper, controls(educ exper2) nquantiles(60) xtitle(Experience) ytitle(ln(wages))
graph export "$base\wexper3.png", replace

reg lwage educ exper exper2

*============================================================*
/* Specification: using dummies to capture non-linearities */
*============================================================*

binscatter lwage educ, controls(exper exper2) nquantiles(60)
graph export "$base\wedu.png", replace
binscatter lwage educ, controls(exper exper2) nquantiles(60) line(qfit)
graph export "$base\wedu2.png", replace

gen educa8=educ<=8 & educ!=0
gen educa11=educ<=11 & educ>=9
gen educa12=educ==12
gen educa15=educ<=15 & educ>=13
gen educa16=educ==16
gen educa21=educ>=17

reg lwage educa* exper exper2

*============================================================*
/* Specification: using weights */
*============================================================*
reg lwage educa* exper exper2 [aw=asecwt]

*============================================================*
/* Specification: more details on dummy variables */
*============================================================*
