/* PL_2014_PL_eusilc_cs */


* POLAND - 2014

* ELIGIBILITY
/*	-> proportional benefits: compulsorily insured employed parents
			- voluntarily insured self-employed (not coded)
	-> flat-rate benefits: everyone else 	*/
	
replace pl_eli = 1 			if country == "PL" & year == 2014 
replace pl_eli = 0			if pl_eli == . & country == "PL" & year == 2014


* DURATION (weeks)
/*	-> 36 weeks for compulsorily insured employed
		-> 34 weeks = family entitlement
		-> 1 month mother's entitlement, 1 month father's entitlement
	-> family entitlement => couples - leave assigned to mother 
	-> 52 weeks for everyone else 		
*/

replace pl_dur = 35 		if country == "PL" & year == 2014 & pl_eli == 1 ///
							& gender == 1 & econ_status == 1
							
replace pl_dur = 1 		if country == "PL" & year == 2014 & pl_eli == 1 ///
							& gender == 2 & econ_status == 1 & parstat == 2
							
replace pl_dur = 52 		if country == "PL" & year == 2014 & pl_eli == 1 ///
							& gender == 1 & inrange(econ_status,2,4)
							

* single men
replace pl_dur = 35 		if country == "PL" & year == 2014 & pl_eli == 1 ///
							& gender == 2 & parstat == 1 & econ_status == 1
replace pl_dur = 52 		if country == "PL" & year == 2014 & pl_eli == 1 ///
							& gender == 2 & parstat == 1 & inrange(econ_status,2,4)

							
* BENEFIT (monthly)
/*
	-> flat-rate benefit: €95/month if household income per capita doesn't exceed €131/month (LP&R 2014; not coded)
 */
 
replace pl_ben1 = 95				if country == "PL" & year == 2014 & pl_eli == 1 
									
replace pl_ben2 = pl_ben1			if country == "PL" & year == 2014 & pl_eli == 1


foreach x in 1 2 {
	replace pl_ben`x' = 0 	if pl_eli == 0 & country == "PL" & year == 2014
}

replace pl_dur = 0 	if pl_eli == 0 & country == "PL" & year == 2014
