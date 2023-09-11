*============================================================*
/* ECON 11020 / Professor Oscar Galvez-Soriano */
*============================================================*
/* Lecture 11 */
*============================================================*
clear
set more off
*============================================================*
gl base="C:\Users\galve\Documents\UChicago\ECON11020"
gl data= "https://raw.githubusercontent.com/galvez-soriano/Econometrics/main/UChicago"
*============================================================*
/* Identifying heteroscedasticity */
*============================================================*
use "$data/nswmaledata.dta", clear

tabulate treated
sum treated re78

/* Summary statitics by condition (using "if") */
sum treated re78 if treated==1
sum treated re78 if treated==0

/* Summary statitics by group (using "by") */
by treated: sum re78

/* Instead of the mean of the variable and sd of the variable, calculate 
the mean of the variable and standard error of the mean of the variable */
ci means re78 if treated==1
* From SD to SE
display sqrt(6923.796^2/297)

ci means re78 if treated==0
* From SD to SE
display sqrt(5718.089^2/425)

/* Difference in means assuming equal variances */
ttest re78, by(treated)

/* Difference in means with unequal variances */
ttest re78, by(treated) uneq
reg re78 treated

*========================================================================*
* Is the mean attendance rate different between the control and treatment?
*========================================================================*
use "$data\worms.dta", clear
ttest prs991, by(t98) unequal
ttest prs991, by(t98)
*========================================================================*
* Run a regression of the varible school participation (prs991) on the 
* dummy for being treated (t98).
*========================================================================*
label variable prs991 "Participation"
label variable t98 "Treatment"
label variable test98 "Scores98"
label variable test96_a "Scores96"

reg prs991 t98, vce(robust)
reg prs991 t98
*========================================================================*
* You want to test whether the effect was different for girls than boys.
*========================================================================*
reg prs991 t98 if sex==1, vce(robust)
reg prs991 t98 if sex==0, vce(robust)
*========================================================================*
* Run a regression of test score (test98) on the dummy for being treated (t98).
*========================================================================*
reg test98 t98, vce(robust)
reg test98 t98 test96_a, vce(robust)
