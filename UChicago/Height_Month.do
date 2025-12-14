*=====================================================================*
clear
gl doc="C:\Users\galve\Documents\UChicago\ECON11020\Lectures"
*=====================================================================*
set seed 12345
set obs 100
*=====================================================================*
* Birth month: 1 = January, ..., 12 = December
gen birth_month = ceil(12*runiform())

* Adult height (cm)
gen height = rnormal(170, 8)

* Check correlation
corr height birth_month

* Scatter plot
twoway scatter height birth_month, ///
    xtitle("Birth Month (1 = Jan, ..., 12 = Dec)") ///
    ytitle("Adult Height (cm)") ///
	graphregion(color(white)) legend(off) ///
	xlabel(1(1)12)
graph export "$doc\Height_Month.png", replace

* Scatter plot with fitted values
twoway (scatter height birth_month) (lfit height birth_month), ///
    xtitle("Birth Month (1 = Jan, ..., 12 = Dec)") ///
    ytitle("Adult Height (cm)") ///
	graphregion(color(white)) legend(off) ///
	xlabel(1(1)12)
graph export "$doc\Height_Month.png", replace
    
	*title("Adult Height and Birth Month")

* Regression
reg height birth_month
