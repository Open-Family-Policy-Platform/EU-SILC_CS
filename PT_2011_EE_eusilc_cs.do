/* PT_2011_EE_eusilc_cs */

* ESTONIA - 2011

* ELIGIBILITY
/*	-> employed (LP&R 2011) */ 

replace pt_eli = 1 		if country == "EE" & year == 2011 & gender == 2 ///
						& econ_status == 1
replace pt_eli = 0 		if pt_eli == . & country == "EE" & year == 2011


* DURATION (weeks)
/*	-> 10 working days 
	-> must be taken within 2 months after childbirth
*/

replace pt_dur = 10/5 	if country == "EE" & year == 2011 & pt_eli == 1


* BENEFIT (monthly)
/*	-> unpaid (LP&R 2011)	*/
	
replace pt_ben1 = 0 	if country == "EE" & year == 2011 & pt_eli == 1
							
				
replace pt_ben2 = pt_ben1 	if country == "EE" & year == 2011 & pt_eli == 1


foreach x in 1 2 {
	replace pt_ben`x' = 0 	if pt_eli == 0 & country == "EE" & year == 2011
}

replace pt_dur = 0 if pt_eli == 0 & country == "EE" & year == 2011
