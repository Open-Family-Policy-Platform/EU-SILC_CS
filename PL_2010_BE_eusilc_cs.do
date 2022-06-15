/* PL_2010_BE_eusilc_cs */


* BELGIUM - 2010

* ELIGIBILITY
/*	-> employees, 12 months (coded) of employement in last 15 months with the same employer (not 
		coded)
*/
   
replace pl_eli = 1 		if country == "BE" & year == 2010 & pl_eli == . ///
						& econ_status == 1 & duremp >= 12 
replace pl_eli = 0 		if pl_eli == . & country == "BE" & year == 2010


* DURATION (weeks)
/*	-> 3 months/parent/child 
	-> until child is 12 years old (not coded) 		*/
	
replace pl_dur = 4 * 4.3 	if country == "BE" & year == 2010 & pl_eli == 1


* BENEFIT (monthly)
/*	-> full-time work interruption: €684.94/month 
	-> part-time work interruption: €342.46/month
*/

replace pl_ben1 = 684.94 		if country == "BE" & year == 2010 & pl_eli == 1 ///
								& pl_ben1 == . 
			

replace pl_ben2 = pl_ben1 		if country == "BE" & year == 2010 & pl_eli == 1
								


foreach x in 1 2 {
	replace pl_ben`x' = 0 	if pl_eli == 0 & country == "BE" & year == 2010
}

replace pl_dur = 0 	if pl_eli == 0 & country == "BE" & year == 2010
