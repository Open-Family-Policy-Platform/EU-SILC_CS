/* ML_2012_PL_eusilc_cs */

* POLAND - 2012

* ELIGIBILITY
/*	-> compulsory social insurance for employed
	-> voluntary social insurance for self-employed (not coded) 
	-> can be shared with father but the source implies mother's consent => not coded 
		for single fathers (as a case child is abandoned by the mother)
*/
	
replace ml_eli = 1 			if country == "PL" & year == 2012 & gender == 1 ///
							& econ_status == 1
replace ml_eli = 0 			if ml_eli == . & country == "PL" & year == 2012 & gender == 1


* DURATION (weeks)
/*	-> total: 24 weeks (coded; ML and additional ML; LP&r 2012)
	-> prenatal: 2 weeks, not compulsory (not coded)	
*/
	
replace ml_dur1 = 0 		if country == "PL" & year == 2012 & ml_eli == 1

replace ml_dur2 = 24 		if country == "PL" & year == 2012 & ml_eli == 1


* BENEFIT (monthly)
/*	-> 100% earning, no ceiling */
	
replace ml_ben1 = earning 		if country == "PL" & year == 2012 & ml_eli == 1

replace ml_ben2 = ml_ben1 		if country == "PL" & year == 2012 & ml_eli == 1						

foreach x in 1 2 {
    replace ml_dur`x' = 0 	if ml_eli == 0 & country == "PL" & year == 2012
	replace ml_ben`x' = 0 	if ml_eli == 0 & country == "PL" & year == 2012
}

