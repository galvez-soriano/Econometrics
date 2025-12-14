*=====================================================================*
clear
gl doc="C:\Users\galve\Documents\UChicago\ECON11020\Lectures"
*=====================================================================*
set seed 12345
set obs 100
*=====================================================================*
* Distance to CBD in mi
gen distance = runiform(0, 30)

* Neighborhood unobserved quality
gen neighborhood_fe = rnormal(0, 0.2)

* Housing prices (log)
gen ln_price = 12 - 0.05*distance + neighborhood_fe + rnormal(0, 0.25)

* Price in levels
gen price = exp(ln_price)

* Quick check
corr distance ln_price

* Scatter plot
twoway scatter ln_price distance, ///
    xtitle("Distance to CBD (mi)") ///
    ytitle("Log Housing Price") ///
	graphregion(color(white))
graph export "$doc\House_Dist.png", replace
	
* Scatter plot with fitted line
twoway (scatter ln_price distance) (lfit ln_price distance), ///
    xtitle("Distance to CBD (mi)") ///
    ytitle("Log Housing Price") ///
	graphregion(color(white)) legend(off)
graph export "$doc\House_Dist_Fit.png", replace
	
    *title("Housing Prices and Distance to CBD")
