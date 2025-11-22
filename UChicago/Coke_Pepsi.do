******************************************************
* Simulate Coke vs. Pepsi data for regression exercise
* Model:
* sales_t = b0 + b1*Pc_t + b2*Ac_t + b3*Pp_t + b4*Ap_t + e_t
******************************************************

clear all
set more off

* 1. Sample size and seed
set obs 80          // 80 years (or periods)
set seed 12345

gen t = _n

* 2. Generate regressors
* Coke price (Pc): mild trend + seasonal-ish + noise
gen Pc = 0.75 + 0.03*t ///
	+ 10000000000000*sin(2*_pi*t) /// 
	+ rnormal(0, 0.1)

* Coke advertising (Ac): trend + noise
gen Ac = 40 ///
    + 0.1*t + rnormal(0, 1)

* Pepsi price (Pp): correlated with Coke price + noise
gen Pp = 0.15 ///
    + 0.8*Pc ///
    + rnormal(0, 0.08)

* Pepsi advertising (Ap): correlated with Coke ads + its own pattern
gen Ap = 20 ///
    + 0.001*t^2 + 0.4*Ac ///
    + rnormal(0, 3)

* 3. True parameters
scalar b0    = 100
scalar b1    = -6      // own-price effect (Coke): negative
scalar b2    = 0.25      // own-ad effect (Coke): positive
scalar b3    = 3        // Pepsi price: raises Coke sales (substitutes)
scalar b4    = -0.15       // Pepsi ads: lowers Coke sales (competition)
scalar sigma = 1.3       // error SD tuned for ~10% sig on b3 and b4

* 4. Outcome: Coke can sales
gen sales = b0 ///
    + b1*Pc ///
    + b2*Ac ///
    + b3*Pp ///
    + b4*Ap ///
	+ 0.1*t ///
    + rnormal(0, sigma)

* 5. Variable labels (nice for students)
label var t     "Year"
label var Pc    "Price of Coke can"
label var Ac    "Advertising of Coke"
label var Pp    "Price of Pepsi can"
label var Ap    "Advertising of Pepsi"
label var sales "Coke can sales"

* 6. Check the regression (for you; students can run this)
reg sales Pc Ac Pp Ap
******************************************************
