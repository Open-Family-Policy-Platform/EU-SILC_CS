/* ML_2015_SI_eusilc_cs */

* SLOVENIA - 2015

* ELIGIBILITY
/*	-> employed
	-> self-employed
	-> unemployed, inactive if they were compulsorily insured for at least 12 months (coded)
		over the past 3 years (not coded; LP&R 2015)
	-> benefits for unemployed and inactive people are not clearly specified in the sources => not coded
	-> single fathers are eligible (if mother abandoned the child)
*/
	
replace ml_eli = 1 			if country == "SI" & year == 2015 & gender == 1 ///
							& inlist(econ_status,1,2) 
replace ml_eli = 1 			if country == "SI" & year == 2015 & gender == 1 ///
							& inlist(econ_status,3,4) & (duremp + dursemp) >= 12

* single men
replace ml_eli = 1 			if country == "SI" & year == 2015 & gender == 2 ///
							& inlist(econ_status,1,2) & parstat == 1
replace ml_eli = 1 			if country == "SI" & year == 2015 & gender == 2 ///
							& inlist(econ_status,3,4) & (duremp+dursemp) >= 12 & parstat == 1
							
replace ml_eli = 0 			if ml_eli == . & country == "SI" & year == 2015 & gender == 1


* DURATION (weeks)
/*	-> total: 105 calendar days
	-> prenatal: 28 days, not compulsory => coded 0 
	-> single father: 80 days (LP&R 2015)
*/
	
replace ml_dur1 = 0 			if country == "SI" & year == 2015 & ml_eli == 1

replace ml_dur2 = 105/7 		if country == "SI" & year == 2015 & ml_eli == 1 ///
								& gender == 1
replace ml_dur2 = 80/7			if country == "SI" & year == 2015 & ml_eli == 1 ///
								& gender == 2 & parstat == 1


* BENEFIT (monthly)
/*	-> 100%
	-> ceiling: €3,080/month (LP&R 2015)
	-> minimum: €434.90/month (LP&R 2015)		*/
	
replace ml_ben1 = earning 		if country == "SI" & year == 2015 & ml_eli == 1 ///
								& inlist(econ_status,1,2)	
replace ml_ben1 = 434.90 		if country == "SI" & year == 2015 & ml_eli == 1 ///
								& inlist(econ_status,1,2) & ml_ben1 < 434.90
replace ml_ben1 = 2863	 		if country == "SI" & year == 2015 & ml_eli == 1 ///
								& inlist(econ_status,1,2) & ml_ben1 >= 3080 
					

replace ml_ben2 = ml_ben1 		if country == "SI" & year == 2015 & ml_eli == 1


foreach x in 1 2 {
    replace ml_dur`x' = 0 	if ml_eli == 0 & country == "SI" & year == 2015
	replace ml_ben`x' = 0 	if ml_eli == 0 & country == "SI" & year == 2015
}


