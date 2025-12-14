*=====================================================================*
clear
gl doc="C:\Users\galve\Documents\UChicago\ECON11020\Lectures"
*=====================================================================*
set seed 12345
set obs 100
*=====================================================================*
* Age: children and adolescents
gen age = runiform(6, 18)

* Shoe size (EU scale, increasing with age)
gen shoe_size = 25 + 1.2*age + rnormal(0, 1.5)

* IQ (age-related cognitive development)
gen iq = 70 + 2.5*age + rnormal(0, 10)

* Raw correlation
corr shoe_size iq

* Scatter plot
twoway scatter iq shoe_size, ///
    xtitle("Shoe Size") ///
    ytitle("IQ") ///
	graphregion(color(white)) legend(off)
graph export "$doc\Shoe_IQ.png", replace

*    title("Raw Correlation: Shoe Size and IQ")

* Naive regression
reg iq shoe_size

* Control for age
reg iq shoe_size age
