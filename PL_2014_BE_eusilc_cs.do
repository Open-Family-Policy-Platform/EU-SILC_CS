/* PL_2014_BE_eusilc_cs */


* BELGIUM - 2014

* ELIGIBILITY
/*	-> employees, 12 months (coded) of employement in last 15 months with the same employer (not 
		coded)
*/
   
replace pl_eli = 1 		if country == "BE" & year == 2014 & pl_eli == . ///
						& econ_status == 1 & duremp >= 12 
replace pl_eli = 0 		if pl_eli == . & country == "BE" & year == 2014


* DURATION (weeks)
/*	-> 4 months/parent/child 
	-> until child is 12 years old (not coded) 		*/
	
replace pl_dur = 4 * 4.3 	if country == "BE" & year == 2014 & pl_eli == 1


* BENEFIT (monthly)
/*	-> full-time work interruption: €771.33/month 
	-> part-time work interruption: €385.66 /month 
*/

replace pl_ben1 = 771.33 		if country == "BE" & year == 2014 & pl_eli == 1 ///
								& pl_ben1 == . 
			

replace pl_ben2 = pl_ben1 		if country == "BE" & year == 2014 & pl_eli == 1
								


foreach x in 1 2 {
	replace pl_ben`x' = 0 	if pl_eli == 0 & country == "BE" & year == 2014
}

replace pl_dur = 0 	if pl_eli == 0 & country == "BE" & year == 2014
