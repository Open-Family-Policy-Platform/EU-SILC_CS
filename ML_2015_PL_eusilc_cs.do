/* ML_2015_PL_eusilc_cs */

* POLAND - 2015

* ELIGIBILITY
/*	-> compulsory social insurance for employed
	-> voluntary social insurance for self-employed (not coded) 
	-> can be shared with father but the source implies mother's consent => not coded 
		for single fathers (as a case child is abandoned by the mother)
*/
	
replace ml_eli = 1 			if country == "PL" & year == 2015 & gender == 1 ///
							& econ_status == 1
replace ml_eli = 0 			if ml_eli == . & country == "PL" & year == 2015 & gender == 1


* DURATION (weeks)
/*	-> total: 20 weeks (coded as postnatal)
	-> prenatal: 6 weeks, not compulsory (not coded)
	-> postnatal: 14 weeks (not coded) 			
*/
	
replace ml_dur1 = 0 		if country == "PL" & year == 2015 & ml_eli == 1

replace ml_dur2 = 20 		if country == "PL" & year == 2015 & ml_eli == 1


* BENEFIT (monthly)
/*	-> 100% earning, no ceiling
		- women may choose between 100% and 80% (LP&R 2015)
		- the choice will determine the duration of parental leave (100% more generous 
		in a short run, 80% more generous in a long run => 80% coded), less generous 
		cash benefits imply longer parental leave
	*/
	
replace ml_ben1 = earning*0.8 		if country == "PL" & year == 2015 & ml_eli == 1


replace ml_ben2 = ml_ben1 			if country == "PL" & year == 2015 & ml_eli == 1						

foreach x in 1 2 {
    replace ml_dur`x' = 0 	if ml_eli == 0 & country == "PL" & year == 2015
	replace ml_ben`x' = 0 	if ml_eli == 0 & country == "PL" & year == 2015
}

