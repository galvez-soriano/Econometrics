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
/* Job training programs and wages */
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

*============================================================*
/* Health intervention and education */
*============================================================*
use "$data\worms.dta", clear

ttest prs991, by(t98) unequal
ttest prs991, by(t98)

/* Run a regression of the varible school participation (prs991) on the 
dummy for being treated (t98) */
label variable prs991 "Participation"
label variable t98 "Treatment"
label variable test98 "Scores98"
label variable test96_a "Scores96"

reg prs991 t98, vce(robust)
reg prs991 t98

/* You want to test whether the effect was different for girls than boys */
reg prs991 t98 if sex==1, vce(robust)
reg prs991 t98 if sex==0, vce(robust)

/* Run a regression of test score (test98) on the dummy for being treated (t98) */
reg test98 t98, vce(robust)
reg test98 t98 test96_a, vce(robust)

*============================================================*
/* Panel data and Fixed Effects */
*============================================================*
use "$data\fatality.dta", clear

replace mrall=mrall*10000

/* Regression analysis by year */
reg mrall beertax if year==1982
reg mrall beertax if year==1988

/* Pooled regression */
reg mrall beertax

/* Should we conclude that more beer taxes are associated to more traffic 
fatalities? No, most likely we have an omitted variables bias.
We have the concern that these estimates are biased because state "culture" 
is correlated with both tax and fatality */

/* Fixed Effects */
areg mrall beertax, absorb(state)

/* By differencing, we can sweep out the effect of state "culture". In FE 
estimation, we are subtracting out each state's mean over time, and 
identifying the effect of beer taxes using within state cross time variation 
in beer taxes */

/* We could also have done fixed effects this way in Stata by forming state 
dummies as follows: */
xi: reg mrall beertax i.state

/* You could also run the same regression without forming the state dummies */
reg mrall beertax i.state

/* You could also use the xtreg command */
xtset state year

xtreg mrall beertax, fe

/* Finally, using the demeaned equation rather than the dummy variable
regression */
egen statemeany=mean(mrall), by(state)
egen statemeanx=mean(beertax), by(state)
gen demeany=mrall-statemeany
gen demeanx=beertax-statemeanx

reg demeany demeanx, noc

/* Notice that the point estimate associated to the beer tax variable is 
the same among all methods. Differences in the constant term come from a 
different omitted category */

/* When we have data over time, we should also control for aggregate time
effects. This way, we can avoid that the correlation between within
differences in x (beertax) and within differences in y (fatalities) is due to
spurious aggregate trends (e.g., bad economic conditions increase beertax
(need more revenues) as well as decrease fatalities (less driving)) */

areg mrall beertax i.year, absorb(state)