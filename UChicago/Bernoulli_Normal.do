****************************************************
gl doc= "C:\Users\Oscar Galvez Soriano\Documents\Teaching\ECON11020\Lectures\Fall25\Codes for lectures"
****************************************************
* 1. Program: draw N Bernoulli(0.5), return sample mean
****************************************************
clear
capture program drop bernmean
program define bernmean, rclass
    // bernmean N
    // N = sample size

    args N

    // Start fresh inside the program
    quietly {
        clear
        set obs `N'
        gen x = (runiform() < 0.5)   // Bernoulli(0.5)
        summarize x
        return scalar mean = r(mean) // sample mean
    }
end
****************************************************
* 2. Set seed for reproducibility
****************************************************
set seed 12345
****************************************************
* 3. N = 10
****************************************************
simulate mean = r(mean), reps(10) nodots: bernmean 1000

histogram mean, frac color(gray) graphregion(fcolor(white)) ///
    normal ///
    width(0.02) ///
    xline(0.5, lpattern(dash) lcolor(red)) ///
    xtitle("Sample mean of p_hat") ///
    ytitle("Distribution") ///
    name(g10, replace)
graph export "$doc\histo10.png", replace

****************************************************
* 4. N = 50
****************************************************
simulate mean = r(mean), reps(50) nodots: bernmean 1000

histogram mean, frac color(gray) graphregion(fcolor(white)) ///
    normal ///
    width(0.01) ///
    xline(0.5, lpattern(dash) lcolor(red)) ///
    xtitle("Sample mean p_hat") ///
    ytitle("Density") ///
    name(g50, replace)
graph export "$doc\histo50.png", replace

****************************************************
* 5. N = 100
****************************************************
simulate mean = r(mean), reps(100000) nodots: bernmean 1000

histogram mean, frac color(gray) graphregion(fcolor(white)) ///
    normal ///
    width(0.008) ///
    xline(0.5, lpattern(dash) lcolor(red)) ///
    xtitle("Sample mean p_hat") ///
    ytitle("Density") ///
    name(g100, replace)
graph export "$doc\histo100.png", replace

****************************************************
* 6. Combine graphs into one figure (optional)
****************************************************
graph combine g10 g50 g100, ///
    cols(1) ///
    title("CLT: Sampling distribution of \hat{p} for Bernoulli(0.5)")

* Example export:
graph export clt_bern_means.png, width(2000) replace
****************************************************
* End

****************************************************
