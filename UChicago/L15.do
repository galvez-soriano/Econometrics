*============================================================*
/* ECON 11020 / Professor Oscar Galvez-Soriano */
*============================================================*
/* Lecture 16 */
*============================================================*
gl data= "https://raw.githubusercontent.com/galvez-soriano/Econometrics/main/UChicago"
*============================================================*
/* Estimation: First create the leads and lags that will be
used in the TWFE and Sun and Abraham methods */
*============================================================*
use "$data/sdata.dta", clear

