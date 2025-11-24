************************************************************
* Simulate annual data for Ford profitability model
* Units:
*   Profits π_t = thousands of dollars
*   Q_t = production quantity in thousands of cars
*   P_t = average price per car in thousands of dollars
************************************************************

clear all
set more off
set seed 2026

* Number of years 
set obs 40
gen year = 1985 + _n - 1
tsset year

****************************************************
* 1. Generate quantity (Q_t) in thousands
*    Target for 2024: approx 4,500 (i.e., 4.5 million cars)
****************************************************
gen Q = 2500 + 80*(year-1985) + rnormal(0,120)

****************************************************
* 2. Generate price (P_t) in thousands of dollars
****************************************************
gen P = 22 + 0.25*(year-1985) + rnormal(0,1)

****************************************************
* 3. True parameters for simulation
* Profits π_t = β0 + β1*P_t + β2*Q_t + β3*Q_t^2 + ε_t
****************************************************
scalar b0 = -300000   // fixed cost or legacy liabilities
scalar b1 = 18000     // price effect on profits
scalar b2 = 900       // linear production effect
scalar b3 = -0.12     // decreasing returns (congestion, costs)

* Error variance
scalar sigma = 200000  // profit shocks

****************************************************
* 4. Generate profits π_t in thousands of dollars
****************************************************
gen profits = b0 ///
    + b1*P ///
    + b2*Q ///
    + b3*(Q^2) ///
    + rnormal(0, sigma)

label var profits "Profits (thousand USD)"
label var P "Average price per car (thousand USD)"
label var Q "Quantity produced (thousands of cars)"

****************************************************
* 5. Check 2024 values
list year profits Q if year==2024, noobs sep(0)

****************************************************
* 6. Regression model (for students to estimate)
reg profits P Q c.Q#c.Q
************************************************************
gen Q2=Q^2

reg profits P Q Q2

binscatter profits Q, line(qfit) xtitle(Quantity) ytitle(Profits)

*graph export "$base\wexper3.png", replace