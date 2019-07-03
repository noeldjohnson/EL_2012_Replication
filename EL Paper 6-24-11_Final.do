set memory 500000
set matsize 800


use "/Users/Noel Johnson Notebook/Desktop/EL Trust MA/TGData 6-7-11 EL Paper.dta", clear

log using "/Users/Noel Johnson Notebook/Desktop/EL Trust MA/EL Paper 6-24-11.log", replace



/* 1. Summary Stats and Correlations */

sum wvs8199 wvs0508 wvsmean psentfraction trust psendend precend precenddummy anon rateret dbleblind student stratmeth bothroles randompayment realperson if wvstrustsample==1 , separator(0)

sum wvs8199 wvs0508 wvsmean psentfraction pretavail trust trustworthy psendend precend precenddummy anon rateret dbleblind student stratmeth bothroles randompayment if wvstrustworthysample==1 , separator(0)

/* 2. Kernel Density Plots of Two WVS samples */

kdensity wvs8199 if wvstrustsample==1, addplot(kdensity wvs0508)

graph save "/Users/Noel Johnson Notebook/Desktop/EL Trust MA/Figure1.gph", replace

pwcorr wvs8199 wvs0508 if wvstrustsample==1, sig
pwcorr wvs8199 wvs0508 if wvstrustworthysample==1, sig

/* 3.  Does WVS Predict Experimental Trust  */

regress trust wvsmean   if wvstrustsample==1, robust
estimates store aone

regress trust wvsmean  psendend precenddummy anon rateret dbleblind student bothroles randompayment stratmeth realperson  if wvstrustsample==1, robust
estimates store bone

xi: regress trust wvsmean psendend precenddummy anon rateret dbleblind student bothroles randompayment stratmeth realperson i.countrygroup  if wvstrustsample==1, robust
estimates store cone


/* 4.  Does WVS Predict Experimental Trustworthiness   */

/* Using a dummy for receiver endowment */ 

regress trustworthy wvsmean  if wvstrustworthysample==1, robust
estimates store done

regress trustworthy wvsmean  trust psendend precenddummy anon rateret dbleblind student bothroles randompayment stratmeth  if wvstrustworthysample==1, robust
estimates store eone

xi: regress trustworthy wvsmean  trust psendend precenddummy anon rateret dbleblind student bothroles randompayment stratmeth i.countrygroup  if wvstrustworthysample==1, robust
estimates store fone


outreg2 wvsmean [aone bone cone done eone fone] using TableA, replace bdec(4) nocons

/* 5.  Are Differences Between Results on Experimental Trust and Trustworthiness Due to Different Samples */

regress trust wvsmean   if wvstrustworthysample==1, robust

regress trust wvsmean  psendend precenddummy anon rateret dbleblind student bothroles randompayment stratmeth realperson  if wvstrustworthysample==1, robust

xi: regress trust wvsmean psendend precenddummy anon rateret dbleblind student bothroles randompayment stratmeth realperson i.countrygroup  if wvstrustworthysample==1, robust

/* 6.  Does WVS Predict Experimental Trust (no logit transform)  */

regress psentfraction wvsmean   if wvstrustsample==1, robust
estimates store aone

regress psentfraction wvsmean  psendend precenddummy anon rateret dbleblind student bothroles randompayment stratmeth realperson  if wvstrustsample==1, robust
estimates store bone

xi: regress psentfraction wvsmean psendend precenddummy anon rateret dbleblind student bothroles randompayment stratmeth realperson i.countrygroup  if wvstrustsample==1, robust
estimates store cone


/* 7.  Does WVS Predict Experimental Trustworthiness (no logit transform)  */


regress pretavail wvsmean  if wvstrustworthysample==1, robust
estimates store done

regress pretavail wvsmean  psentfraction psendend precenddummy anon rateret dbleblind student bothroles randompayment stratmeth  if wvstrustworthysample==1, robust
estimates store eone

xi: regress pretavail wvsmean  psentfraction psendend precenddummy anon rateret dbleblind student bothroles randompayment stratmeth i.countrygroup  if wvstrustworthysample==1, robust
estimates store fone


log close
