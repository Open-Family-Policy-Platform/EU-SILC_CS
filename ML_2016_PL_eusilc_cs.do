/* ML_2016_PL_eusilc_cs */

* POLAND - 2016

* ELIGIBILITY
/*	-> compulsory social insurance for employed
	-> voluntary social insurance for self-employed (not coded) 
	-> can be shared with father but the source implies mother's consent => not coded 
		for single fathers (as a case child is abandoned by the mother)
*/
	
replace ml_eli = 1 			if country == "PL" & year == 2016 & gender == 1 ///
							& econ_status == 1
replace ml_eli = 0 			if ml_eli == . & country == "PL" & year == 2016 & gender == 1


* DURATION (weeks)
/*	-> total: 2 weeks (coded; ML and additional ML; LP&R 2016)
	-> prenatal: 6 weeks, not compulsory (not coded)		
*/
	
replace ml_dur1 = 0 		if country == "PL" & year == 2016 & ml_eli == 1

replace ml_dur2 = 20 		if country == "PL" & year == 2016 & ml_eli == 1


* BENEFIT (monthly)
/*	-> 100% earning, no ceiling
		- women may choose between 100% and 80% (LP&R 2015)
		- the choice determines the benefit of parental leave
			-> 100% ML replacement rate => 100% for the dirst 6 weeks & 60% for the remaining 26 weeks (not coded)
			-> 80% ML replacement rate => 80% parental leave replacement rate (coded)
			
	-> minimum: €226/month
*/
	
replace ml_ben1 = earning*0.8 		if country == "PL" & year == 2016 & ml_eli == 1

replace ml_ben1 = 226				if country == "PL" & year == 2016 & ml_eli == 1 & ml_ben1 < 226

replace ml_ben2 = ml_ben1 			if country == "PL" & year == 2016 & ml_eli == 1						

foreach x in 1 2 {
    replace ml_dur`x' = 0 	if ml_eli == 0 & country == "PL" & year == 2016
	replace ml_ben`x' = 0 	if ml_eli == 0 & country == "PL" & year == 2016
}

