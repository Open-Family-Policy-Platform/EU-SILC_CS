/* ML_2013_SI_eusilc_cs */

* SLOVENIA - 2013

* ELIGIBILITY
/*	-> employed
	-> self-employed
	-> unemployed, inactive if they were compulsorily insured for at least 12 months (coded)
		over the past 3 years (not coded; LP&R 2013)
	-> benefits for unemployed and inactive people are not clearly specified in the sources => not coded
	-> single fathers are eligible (if mother abandoned the child)
*/
	
replace ml_eli = 1 			if country == "SI" & year == 2013 & gender == 1 ///
							& inlist(econ_status,1,2) 
replace ml_eli = 1 			if country == "SI" & year == 2013 & gender == 1 ///
							& inlist(econ_status,3,4) & (duremp + dursemp) >= 12

* single men
replace ml_eli = 1 			if country == "SI" & year == 2013 & gender == 2 ///
							& inlist(econ_status,1,2) & parstat == 1
replace ml_eli = 1 			if country == "SI" & year == 2013 & gender == 2 ///
							& inlist(econ_status,3,4) & (duremp+dursemp) >= 12 & parstat == 1
							
replace ml_eli = 0 			if ml_eli == . & country == "SI" & year == 2013 & gender == 1


* DURATION (weeks)
/*	-> total: 105 calendar days
	-> prenatal: 28 days, not compulsory => coded 0 
	-> single father: 80 days (LP&R 2013)
*/
	
replace ml_dur1 = 0 			if country == "SI" & year == 2013 & ml_eli == 1

replace ml_dur2 = 105/7 		if country == "SI" & year == 2013 & ml_eli == 1 ///
								& gender == 1
replace ml_dur2 = 80/7			if country == "SI" & year == 2013 & ml_eli == 1 ///
								& gender == 2 & parstat == 1


* BENEFIT (monthly)
/*	-> 100%
	-> ceiling: €2,863/month (LP&R 2013)
	-> minimum: €323.55/month (LP&R 2013)		*/
	
replace ml_ben1 = earning 		if country == "SI" & year == 2013 & ml_eli == 1 ///
								& inlist(econ_status,1,2)	
replace ml_ben1 = 323.55 		if country == "SI" & year == 2013 & ml_eli == 1 ///
								& inlist(econ_status,1,2) & ml_ben1 < 323.55
replace ml_ben1 = 2863	 		if country == "SI" & year == 2013 & ml_eli == 1 ///
								& inlist(econ_status,1,2) & ml_ben1 >= 2863 
					

replace ml_ben2 = ml_ben1 		if country == "SI" & year == 2013 & ml_eli == 1


foreach x in 1 2 {
    replace ml_dur`x' = 0 	if ml_eli == 0 & country == "SI" & year == 2013
	replace ml_ben`x' = 0 	if ml_eli == 0 & country == "SI" & year == 2013
}


