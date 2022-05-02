/* PL_2013_PL_eusilc_cs */


* POLAND - 2013

* ELIGIBILITY
/*	-> proportional benefits: compulsorily insured employed parents
			- voluntarily insured self-employed (not coded)
	*/
	
replace pl_eli = 1 			if country == "PL" & year == 2013 & duremp >= 6
replace pl_eli = 0			if pl_eli == . & country == "PL" & year == 2013




* DURATION (weeks)
/*	-> family entitlement => couples - leave assigned to mother 
	-> 36 weeks for compulsorily insured employed
		-> 34 weeks = family entitlement
		-> 1 month mother's entitlement, 1 month father's entitlement
	-> family entitlement => couples - leave assigned to mother 
	-> 52 weeks for everyone else 			
*/

replace pl_dur = (36*4.3) 		if country == "PL" & year == 2013 & pl_eli == 1 ///
							& gender == 1 
							
* single men
replace pl_dur = (36*4.3) 		if country == "PL" & year == 2013 & pl_eli == 1 ///
							& gender == 2 & parstat == 1 & econ_status == 1

							
* BENEFIT (monthly)
/*	-> flat-rate benefit: €96/month if household income per capita doesn't exceed €132/month (LP&R 2013; not coded)
 */
 
replace pl_ben1 = 0				if country == "PL" & year == 2013 & pl_eli == 1 
									
replace pl_ben2 = pl_ben1			if country == "PL" & year == 2013 & pl_eli == 1

foreach x in 1 2 {
	replace pl_ben`x' = 0 	if pl_eli == 0 & country == "PL" & year == 2013
}

replace pl_dur = 0 	if pl_eli == 0 & country == "PL" & year == 2013
