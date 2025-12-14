*=====================================================================*
clear
gl doc="C:\Users\galve\Documents\UChicago\ECON11020\Lectures"
*=====================================================================*
set seed 12345
set obs 100
*=====================================================================*
* Parental heights (cm)
gen father_height = rnormal(175, 7)
gen mother_height = rnormal(162, 6)

* Mid-parent height
gen mid_parent = (father_height + mother_height)/2

* Child height: regression to the mean
gen child_height = 40 + 0.75*mid_parent + rnormal(0, 5)

* Check correlations
corr child_height mid_parent

* Scatter plot
twoway scatter child_height mid_parent, ///
    xtitle("Mid-Parent Height (cm)") ///
    ytitle("Child Height (cm)") ///
	graphregion(color(white))
graph export "$doc\Height.png", replace

* Scatter plot with fitted line
twoway (scatter child_height mid_parent) (lfit child_height mid_parent), ///
    xtitle("Mid-Parent Height (cm)") ///
    ytitle("Child Height (cm)") ///
	graphregion(color(white)) legend(off)
graph export "$doc\Height_Fit.png", replace
	
    *title("Child Height vs Mid-Parent Height")

* Regression
reg child_height mid_parent
