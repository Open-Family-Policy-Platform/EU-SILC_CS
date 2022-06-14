/* PL_2012_PL_eusilc_cs */


* POLAND - 2012

* ELIGIBILITY
/*	-> proportional benefits: compulsorily insured employed parents
			- voluntarily insured self-employed (not coded)
	-> flat-rate benefits: everyone else 	*/
	
replace pl_eli = 1 			if country == "PL" & year == 2012 
replace pl_eli = 0			if pl_eli == . & country == "PL" & year == 2012


* DURATION (weeks)
/*	-> family entitlement => couples - leave assigned to mother 	
	-> 36 months
*/

replace pl_dur = 36*4.3 		if country == "PL" & year == 2012 & pl_eli == 1 ///
							& gender == 1
							

* single men
replace pl_dur = 36*4.3 		if country == "PL" & year == 2012 & pl_eli == 1 ///
							& gender == 2 & parstat == 1

							
* BENEFIT (monthly)
/*
	-> unpaid
	-> flat-rate benefit: €93 (if monthly household income does not exceed €128, paid for the first 24 months in case of 1 child.)
 */

replace pl_ben1 = 93				if country == "PL" & year == 2012 & pl_eli == 1 ///
									& earning < 128
									
replace pl_ben2 = pl_ben1			if country == "PL" & year == 2012 & pl_eli == 1


foreach x in 1 2 {
	replace pl_ben`x' = 0 	if pl_eli == 0 & country == "PL" & year == 2012
}

replace pl_dur = 0 	if pl_eli == 0 & country == "PL" & year == 2012
