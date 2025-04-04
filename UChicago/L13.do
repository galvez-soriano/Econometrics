*============================================================*
/* ECON 11020 / Professor Oscar Galvez-Soriano */
*============================================================*
/* Lecture 14 */
*============================================================*
clear
set more off
*============================================================*
gl base="C:\Users\galve\Documents\UChicago\ECON11020"
gl data= "https://raw.githubusercontent.com/galvez-soriano/Econometrics/main/UChicago"
*============================================================*
/* Health insurance mandate */
*============================================================*
use "$data/cpsinsure.dta", clear

gen insured= hcovany==2
gen treatment=state==25
gen after=year>2007

gen after_treat=treatment*after
gen hstatus = health >= 4