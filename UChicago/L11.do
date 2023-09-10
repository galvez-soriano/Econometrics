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
