*============================================================*
/* ECON 11020 / Professor Oscar Galvez-Soriano */
*============================================================*
/* Lecture 6 */
*============================================================*
clear
set more off
*============================================================*
gl base="C:\Users\galve\Documents\UChicago\ECON11020"
gl data= "https://raw.githubusercontent.com/galvez-soriano/Econometrics/main/UChicago"
*============================================================*
/* Simple Linear Regression */
*============================================================*
use "$data/simul6.dta", clear

reg wages edu
