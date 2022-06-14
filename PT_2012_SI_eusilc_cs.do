/* PT_2012_SI_eusilc_cs */


* SLOVENIA - 2012

* ELIGIBILITY
/*	-> employed
	-> self-employed
	-> unemployed, inactive if they were compulsorily insured for at least 12 months (coded)
		over the past 3 years (not coded; LP&R 2012)
	-> benefits for unemployed and inactive people are not clearly specified in the sources => not coded
	
*/

replace pt_eli = 1 			if country == "SI" & year == 2012 & gender == 2 ///
							& inlist(econ_status,1,2) 
replace pt_eli = 1 			if country == "SI" & year == 2012 & gender == 2 ///
							& inlist(econ_status,3,4) & (duremp + dursemp) >= 12	
	

* DURATION (weeks)
/*	-> 90 calendar days in total
*/

replace pt_dur = 90/7 	if country == "SI" & year == 2012 & pt_eli == 1


* BENEFIT (monthly)
/*	-> 100% earnings for 15 days
	-> ceiling: €3,865/month (LP&R 2012) 	
	-> minimum: €420/month (LP&R 2012)
	-> flat-rate benefit of €169/month for remaining 75 days
*/

replace pt_ben1 = earning * (15/90) + 169 * (75/90)		if country == "SI" & year == 2012 & pt_eli == 1 
replace pt_ben1 = 420 * (15/90) + 169 * (75/90)	 		if country == "SI" & year == 2012 & pt_eli == 1 ///
									& earning < 420
replace pt_ben1 = 3865 + 169 * (75/90) 	 			if country == "SI" & year == 2012 & pt_eli == 1 ///
									& earning > 3865


replace pt_ben2 = earning * (15/21.7)	 	if country == "SI" & year == 2012 & pt_eli == 1
replace pt_ben2 = pt_ben1 			if country == "SI" & year == 2012 & pt_eli == 1 if (earning < 420 | earning > 3865)

foreach x in 1 2 {
	replace pt_ben`x' = 0 	if pt_eli == 0 & country == "SI" & year == 2012
}

replace pt_dur = 0 if pt_eli == 0 & country == "SI" & year == 2012
