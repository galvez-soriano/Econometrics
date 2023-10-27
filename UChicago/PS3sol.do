*============================================================*
/* ECON 11020 / Professor Oscar Galvez-Soriano */
*============================================================*
/* PS3 */
*============================================================*
clear
set more off
*============================================================*
gl base="C:\Users\galve\Documents\UChicago\ECON11020"
gl data= "https://raw.githubusercontent.com/galvez-soriano/Econometrics/main/UChicago"
*============================================================*
use "$data/employment_06_07.dta", clear

gen learn=log(earnwke)
gen age2=age^2

/* Question 1 */
reg employed age married female educ_adv

/* Question 2(a) */
reg employed educ_hs educ_somecol educ_aa educ_bac educ_adv

/* Question 2(b) */
reg employed educ_lths educ_hs educ_somecol educ_aa educ_bac educ_adv, nocons

/* Question 3(a) */
reg learn age age2 educ_hs educ_somecol educ_aa educ_bac educ_adv private female white if employed==1

/* Question 3(c) */
vce 
* Variance
dis .00181834+.00036997-2*(.00004508)
* t-statistic
dis (.3462199-.3744367)/sqrt(.00209815)
* You could also use a Wald test
test educ_somecol=-female

/* Question 3(d) */

*This is the unrestricted model
reg learn age age2 educ_hs educ_somecol educ_aa educ_bac educ_adv private female white if employed==1
*This is the restricted model
reg learn age educ_hs educ_somecol educ_aa educ_bac educ_adv private female if employed==1

* F statistic
dis ((1636.54118-1527.85903)/2)/(1527.85903/4093)
* Critical value of F
dis invFtail(2, 4093, 0.05)
* You could also use an F test
reg learn age age2 educ_hs educ_somecol educ_aa educ_bac educ_adv private female white if employed==1
test age2 white

/* Question 4(a) */
reg learn age age2 educ_hs educ_somecol educ_aa educ_bac educ_adv private female white if employed==1

predict earn_hat
predict epsilon, resid
scatter epsilon earn_hat, yline(0)

/* Question 4(b) */
/* Breusch-Pagan test for heteroscedasticity */
estat hettest

/* White test for heteroscedasticity */
estat imtest, white

/* Question 4(c) */
reg learn age age2 educ_hs educ_somecol educ_aa educ_bac educ_adv private female white if employed==1, vce(robust)