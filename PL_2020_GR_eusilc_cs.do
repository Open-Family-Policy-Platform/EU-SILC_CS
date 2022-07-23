/* PL_2020_GR_eusilc_cs */


* GREECE - 2020

/*** NOTE: 	Greece has two separate schemes for private and public sector. 
			EU-SILC doesn't contain information on whether respondents are employed
			in a private or a public sector => all respondents are coded as private 
			sector employees.
*/
* ELIGIBILITY
/*	-> employed
	-> 12 months employment (coded) with the same employer (not coded) 	*/
	
replace pl_eli = 1 			if country == "GR" & year == 2020 & econ_status == 1 ///
							& duremp >= 12
replace pl_eli = 0 			if pl_eli == . & country == "GR" & year == 2020

* DURATION (weeks)
/*	-> 4 months/parent/child
	-> non-transferable*/
replace pl_dur = 4 		if country == "GR" & year == 2020 & pl_eli == 1


* BENEFIT (monthly)
/*	-> unpaid */
replace pl_ben1 = 0 		if country == "GR" & year == 2020 & pl_eli == 1
replace pl_ben2 = 0 		if country == "GR" & year == 2020 & pl_eli == 1


foreach x in 1 2 {
	replace pl_ben`x' = 0 	if pl_eli == 0 & country == "GR" & year == 2020
}

 replace pl_dur`x' = 0 	if pl_eli == 0 & country == "GR" & year == 2020
