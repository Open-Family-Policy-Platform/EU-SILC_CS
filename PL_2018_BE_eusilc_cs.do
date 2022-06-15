/* PL_2018_BE_eusilc_cs */


* BELGIUM - 2018

* ELIGIBILITY
/*	-> private sector: employees, 12 months (coded) of employement in last 15 months with the same employer (not 
		coded)
	-> public sector: employees (not coded; LP&R 2018)						*/
   
replace pl_eli = 1 		if country == "BE" & year == 2018 & pl_eli == . ///
						& econ_status == 1 & duremp >= 12 
replace pl_eli = 0 		if pl_eli == . & country == "BE" & year == 2018


* DURATION (weeks)
/*	-> 4 months/parent/child 
	-> until child is 12 years old (not coded) 		*/
	
replace pl_dur = 4 * 4.3 	if country == "BE" & year == 2018 & pl_eli == 1


* BENEFIT (monthly)
/*	
	-> 	the amoount of benefits vary depending on whether the parent is a single parent,
		what is the total work interruption (full, half-time, 1/5) and whether the recipient of the benefit is 
		above or below 50 years old. (MISSOC 2018)
	-> 	only information on full-time interruption is coded
	-> 	only values for recipients under 50 are coded
	
	-> full-time work interruption: €818.56/month 
	-> full-time work interruption - single parent: €1,129.61/month
	
	-> half-time work interruption: €409.27/month
	-> half-time work interruption - single parent: €564.80/month
*/

* single parent
replace pl_ben1 = 1129.61 		if country == "BE" & year == 2018 & pl_eli == 1 ///
								& parstat == 1
								
* cohabiting, married
replace pl_ben1 = 818.56 		if country == "BE" & year == 2018 & pl_eli == 1 ///
								& parstat == 2 & pl_ben1 == . 
			

replace pl_ben2 = pl_ben1 		if country == "BE" & year == 2018 & pl_eli == 1
								


foreach x in 1 2 {
	replace pl_ben`x' = 0 	if pl_eli == 0 & country == "BE" & year == 2018
}

replace pl_dur = 0 	if pl_eli == 0 & country == "BE" & year == 2018
