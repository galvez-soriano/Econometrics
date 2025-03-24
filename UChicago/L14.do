*============================================================*
/* ECON 11020 / Professor Oscar Galvez-Soriano */
*============================================================*
/* Lecture 15 */
*============================================================*
clear
set more off
ssc install grstyle, replace
ssc install coefplot, replace
graph set window fontface "Times New Roman"
grstyle init
grstyle set plain, horizontal
*============================================================*
gl base="C:\Users\Oscar Galvez Soriano\Documents\Teaching\ECON11020\Lectures"
gl data= "https://raw.githubusercontent.com/galvez-soriano/Econometrics/main/UChicago"
*============================================================*
/* Bilingual programs and test scores */
*============================================================*
use "$data/rdbilinged.dta", clear

