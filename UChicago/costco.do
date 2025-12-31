****************************************************
* One sample: Sales on store size and distance to highway exit
****************************************************
clear all
set seed 12345

local n = 200

* True parameters (pick units that look reasonable in class)
local b0 = 2000          // baseline sales in dollars
local b1 = 8              // $ per additional sq ft
local b2 = -90           // $ per additional mile from highway exit
local sigma = 1200       // noise level

set obs `n'

* Regressors
gen size = rnormal(2000, 400)
replace size = max(size, 600)

gen dist_exit = rnormal(3, 1.5)      // miles
replace dist_exit = max(dist_exit, 0.2)

* Error and outcome
gen u = rnormal(0, `sigma')
gen sales = `b0' + `b1'*size + `b2'*dist_exit + u

reg sales size dist_exit
