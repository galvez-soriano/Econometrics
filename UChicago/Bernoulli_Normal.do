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
simulate mean = r(mean), reps(100) nodots: bernmean 10

histogram mean, frac ///
    normal ///
    width(0.02) ///
    xline(0.5, lpattern(dash)) ///
    xtitle("Sample mean of p_hat") ///
    ytitle("Distribution") ///
    name(g10, replace)

****************************************************
* 4. N = 50
****************************************************
simulate mean = r(mean), reps(10000) nodots: bernmean 50

histogram mean, ///
    normal ///
    width(0.01) ///
    xline(0.5, lpattern(dash)) ///
    title("Sampling distribution of \hat{p}, N = 50") ///
    xtitle("Sample mean \hat{p}") ///
    ytitle("Density") ///
    name(g50, replace)

****************************************************
* 5. N = 100
****************************************************
simulate mean = r(mean), reps(10000) nodots: bernmean 100

histogram mean, ///
    normal ///
    width(0.008) ///
    xline(0.5, lpattern(dash)) ///
    title("Sampling distribution of \hat{p}, N = 100") ///
    xtitle("Sample mean \hat{p}") ///
    ytitle("Density") ///
    name(g100, replace)

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
