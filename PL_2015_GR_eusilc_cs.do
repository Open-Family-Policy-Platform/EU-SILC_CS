/* PL_2015_GR_eusilc_cs */

* GREECE - 2015

* ELIGIBILITY
/*	-> employed
	-> 12 months employment (coded) with the same employer (not coded) 	*/
	
replace pl_eli = 1 			if country == "GR" & year == 2015 & econ_status == 1 ///
							& duremp >= 12
replace pl_eli = 0 			if pl_eli == . & country == "GR" & year == 2015

* DURATION (weeks)
/*	-> 4 months/parent  */
replace pl_dur = 4 		if country == "GR" & year == 2015 & pl_eli == 1


* BENEFIT (monthly)
/*	-> unpaid */
replace pl_ben1 = 0 		if country == "GR" & year == 2015 & pl_eli == 1
replace pl_ben2 = 0 		if country == "GR" & year == 2015 & pl_eli == 1


foreach x in 1 2 {
	replace pl_ben`x' = 0 	if pl_eli == 0 & country == "GR" & year == 2015
}

 replace pl_dur`x' = 0 	if pl_eli == 0 & country == "GR" & year == 2015
