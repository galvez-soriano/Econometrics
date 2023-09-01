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
gl base="C:\Users\galve\Documents\UChicago\ECON11020"
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

binscatter lwage educ, nquantiles(60) ytitle("ln(wages)") ///
xtitle("Education (years)")
graph export "$base\wedu.png", replace
binscatter lwage educ, nquantiles(60) line(qfit) ytitle("ln(wages)") ///
xtitle("Education (years)")
graph export "$base\wedu2.png", replace

gen educa=educ<=11
replace educa=2 if educ<=13 & educ>=12
replace educa=3 if educ>=14

gen educa0=educa==1
gen educa1=educa==2
gen educa2=educa==3

reg lwage educa1 educa2
reg lwage educa0 educa1 educa2, noconst

binscatter lwage educ, nquantiles(60) line(none) yline(4.1 5.9 7.8) ///
xline(11 14 , lstyle(grid) lpattern(dash) lcolor(gray)) ///
ytitle("ln(wages)") xtitle("Education (years)")
graph export "$base\wedu3.png", replace

*============================================================*
/* Specification: using weights */
*============================================================*
reg lwage educa1 educa2 [aw=asecwt]

*============================================================*
/* Specification: more details on dummy variables */
*============================================================*
drop educa
reg lwage educa* [aw=asecwt], noconst
*============================================================*
/* Hypothesis Testing */
*============================================================*
reg lwage white educ 

gen black=white==0
gen wedu=white*educ
gen bedu=black*educ

reg lwage white wedu bedu

dis _b[wedu]-_b[bedu]

mat A=e(V)
dis (_b[wedu]-_b[bedu])/sqrt(A[2,2]+A[3,3]-2*A[3,2])

test wedu=bedu

reg lwage white wedu educ

/* F-test */

reg lwage white wedu bedu

reg lwage white

dis invFtail(2, 111620, 0.05)

dis ((3013218.84-2866697.16)/(2))/(2866697.16/(111620))

reg lwage white wedu bedu

test wedu bedu
