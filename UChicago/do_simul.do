*============================================================*
/* Creating simulation data */
*============================================================*
gl data="C:\Users\galve\Documents\UChicago\ECON11020"
*============================================================*
clear
set obs 1000000
set seed 6

gen id=_n
gen edu=rnormal(11,3)
replace edu=round(edu,1)
replace edu=0 if edu<0 | edu>21
gen exper=rnormal(15,3.5)
replace exper=round(exper,1)
replace exper=0 if exper<0

gen sum_ee=edu+exper
sum sum_ee
replace exper=exper+18-r(min)
drop sum_ee
gen age=edu+exper
sum exper
replace exper=exper-r(min)
gen exper2=exper^2
gen female=rbinomial(1,0.5)
gen epsilon=rnormal(0,10000)

gen wages=-30000+9000*edu+1600*exper-60*exper2-13000*female+epsilon
replace wages=wages+30000 if edu<8
replace wages=wages+exper*1000 if wages<150000 & edu>=8
replace wages=wages+exper*4000 if wages<0 & edu<8
replace wages=wages-30000 if exper<=2 & edu>=9
replace wages=wages-50000 if exper<=5 & edu>=16 & female==1
replace wages=0 if wages<0

save "$data\inc_simul.dta", replace
*============================================================*
use "$data\inc_simul.dta", clear

label var wages "Annual wages in dollars"
label var edu "Years of education"
graph set window fontface "Times New Roman"
grstyle init
grstyle set plain, horizontal

scatter wages edu, graphregion(fcolor(white))
graph export "$data\w_edu.png", replace

graph twoway (scatter wages edu) (lfit wages edu), graphregion(fcolor(white)) 
graph export "$data\w_edu_lfit.png", replace

reg wages edu

reg wages edu exper exper2 female

predict resid, residuals

binscatter wages edu, nquantiles(60)

*============================================================*
use "$data\inc_simul.dta", clear

label var wages "Annual wages in dollars"
label var edu "Years of education"
graph set window fontface "Times New Roman"
grstyle init
grstyle set plain, horizontal

histogram edu, frac graphregion(fcolor(white)) fcolor(gs13) lcolor(black) ///
width(1) ytitle(Probability)
graph export "$data\pmf_edu.png", replace

histogram wages, frac graphregion(fcolor(white)) fcolor(none) lcolor(white) ///
ytitle(Probability) kden
graph export "$data\pdf_w.png", replace

cdfplot edu, graphregion(fcolor(white))
graph export "$data\cdf_edu.png", replace

cdfplot wages, graphregion(fcolor(white))
graph export "$data\cdf_w.png", replace

*============================================================*
cd "C:\Users\galve\Documents\UChicago\ECON11020"
foreach x in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 ///
25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 ///
50 51 52 53 54 55 56 57 58 59 60 {
	set seed `x'
	use inc_simul, clear
	sample 10
    save simul`x'.dta, replace
}
