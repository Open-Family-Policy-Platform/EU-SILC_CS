/* PT_2012_EE_eusilc_cs */

* ESTONIA - 2012

* ELIGIBILITY
/*	-> employed (LP&R 2012) */ 

replace pt_eli = 1 		if country == "EE" & year == 2012 & gender == 2 ///
						& econ_status == 1
replace pt_eli = 0 		if pt_eli == . & country == "EE" & year == 2012


* DURATION (weeks)
/*	-> 10 working days 
	-> must be taken within 2 months after childbirth
*/

replace pt_dur = 10/5 	if country == "EE" & year == 2012 & pt_eli == 1


* BENEFIT (monthly)
/*	-> unpaid (LP&R 2012)		*/
	
replace pt_ben1 = 0 	if country == "EE" & year == 2012 & pt_eli == 1
							
replace pt_ben2 = pt_ben1 	if country == "EE" & year == 2012 & pt_eli == 1

foreach x in 1 2 {
	replace pt_ben`x' = 0 	if pt_eli == 0 & country == "EE" & year == 2012
}

replace pt_dur = 0 if pt_eli == 0 & country == "EE" & year == 2012
