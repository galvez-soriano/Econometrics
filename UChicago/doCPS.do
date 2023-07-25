/* Working with March CPS 2022 */
cd "C:\Users\galve\Documents\UChicago\ECON11020"
use cps_mar22, clear
label drop _all
tostring cpsidp, replace format(%014.0f) force
keep year cpsidp statecensus asecwt age sex race empstat labforce uhrsworkt ///
educ inctot incwage
replace sex=. if sex==9
gen female=sex==2 & sex!=.
replace race=. if race==999
gen white=race==100
replace empstat=. if empstat==0
replace labforce=. if labforce==0
gen work=empstat==10 | empstat==12 & empstat!=.
replace uhrsworkt=. if uhrsworkt==997 | uhrsworkt==999
replace edu=0 if edu<=2
replace edu=4 if edu==10
replace edu=6 if edu==20
replace edu=8 if edu==30
replace edu=9 if edu==40
replace edu=10 if edu==50
replace edu=11 if edu==60
replace edu=12 if edu==71
replace edu=12 if edu==73
replace edu=13 if edu==81
replace edu=14 if edu==91
replace edu=15 if edu==92
replace edu=16 if edu==111
replace edu=17 if edu==123
replace edu=17 if edu==124
replace edu=21 if edu==125
replace inctot=. if inctot==999999999
replace inctot=. if inctot<0
replace incwage=. if incwage==99999999
replace incwage=. if incwage<0
keep year cpsidp statecensus asecwt age female white empstat work labforce ///
uhrsworkt educ inctot incwage

graph twoway (lfit incwage edu) (scatter incwage edu) if incwage>0 & incwage<1000000 & work==1 & edu>=5

binscatter incwage uhrsworkt if work==1 & incwage>0, nquantiles(60)

scatter incwage edu if work==1 & edu>=5
scatter incwage edu if work==1 & incwage>0
binscatter incwage edu if work==1 & incwage>0 & edu>=5, nquantiles(60)

binscatter take_up altitude if loc_size==1, xtitle(Altitude) ///
xlabel(0(1000)3000) ylabel(.80(.05)1) ytitle(Take-up) absorb(mun) ///
controls(lond latd) nquantiles(20) subtitle(A. Rural areas)
graph save "$doc\rural_65",replace
graph export "$doc\rural_65.png", replace

reg incwage edu [aw=asecwt] if work==1 & age>=18 & age<=65, nocons
reg incwage edu age age2 female white [aw=asecwt] if work==1, absorb(statecensus)
