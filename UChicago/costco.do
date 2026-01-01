****************************************************
gl doc= "C:\Users\galve\Documents\UChicago\ECON11020\Lectures"
****************************************************
* One sample: Sales on store size and distance to highway exit
****************************************************
clear all
set seed 12345

local n = 200

* True parameters (pick units that look reasonable in class)
local b0 = 2000          // baseline sales in dollars
local b1 = 8              // $ per additional sq ft
local b2 = -90           // $ per additional mile from highway exit
local sigma = 1200       // noise level

set obs `n'

* Regressors
gen size = rnormal(2000, 400)
replace size = max(size, 600)

gen dist_exit = rnormal(3, 1.5)      // miles
replace dist_exit = max(dist_exit, 0.2)

* Error and outcome
gen u = rnormal(0, `sigma')
gen sales = `b0' + `b1'*size + `b2'*dist_exit + u

reg sales size dist_exit

*twoway scatter sales size
*twoway scatter sales dist_exit

****************************************************
* Monte Carlo: sampling distribution of OLS coefficients
****************************************************
clear all
set seed 12345

local reps = 1000
local n = 200

local b0 = 2000
local b1 = 8
local b2 = -90
local sigma = 1200

tempname posth
tempfile results
postfile `posth' b1hat b2hat se1 se2 using `results', replace

forvalues r = 1/`reps' {
    clear
    set obs `n'

    gen size = rnormal(2000, 400)
    replace size = max(size, 600)

    gen dist_exit = rnormal(3, 1.5)
    replace dist_exit = max(dist_exit, 0.2)

    gen u = rnormal(0, `sigma')
    gen sales = `b0' + `b1'*size + `b2'*dist_exit + u

    quietly reg sales size dist_exit

    post `posth' (_b[size]) (_b[dist_exit]) (_se[size]) (_se[dist_exit])
}

postclose `posth'
use `results', clear

* Summary
label var b1hat "b1_hat"
label var b2hat "b2_hat"
summ b1hat b2hat se1 se2

* Histograms with normal overlays
hist b1hat, frac color(gs9) graphregion(fcolor(white)) ///
normal ///
xtitle("Beta1_hat") ///
ytitle("Distribution") 
graph export "$doc\Beta1_hat.png", replace
	
hist b2hat, frac color(gs9) graphregion(fcolor(white)) ///
normal ///
xtitle("Beta2_hat") ///
ytitle("Distribution") 
graph export "$doc\Beta2_hat.png", replace

* Compare empirical SD of beta-hat to average reported SE
summ b1hat
local sd_b1 = r(sd)
summ se1
local mean_se1 = r(mean)
di "Size: SD(b1hat) = " %9.3f `sd_b1' "   Mean SE = " %9.3f `mean_se1'

summ b2hat
local sd_b2 = r(sd)
summ se2
local mean_se2 = r(mean)
di "Dist: SD(b2hat) = " %9.3f `sd_b2' "   Mean SE = " %9.3f `mean_se2'
