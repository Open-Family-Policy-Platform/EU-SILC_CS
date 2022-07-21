/* PT_2013_NL_eusilc_cs */


* NETHERLANDS - 2013

* ELIGIBILITY 
/* -> employed (LP&R 2013) */

replace pt_eli = 1 		if country == "NL" & year == 2013 & gender == 2 ///
						& econ_status == 1
replace pt_eli = 0 		if pt_eli == . & country == "NL" & year == 2013 & gender == 2


* DURATION (weeks)
/* -> 2 days */

replace pt_dur = 2/5 if country == "NL" & year == 2013 & pt_eli == 1  // LP&R 2013


* BENEFIT (monthly)
/*	-> 100% of earning		
	(MISSOC 01/07/2013)		*/
	
replace pt_ben1 = earning 		if country == "NL" & year == 2013 & pt_eli == 1


foreach x in 1 2 {
	replace pt_ben`x' = 0 	if pt_eli == 0 & country == "NL" & year == 2013
}

replace pt_dur = 0 if pt_eli == 0 & country == "NL" & year == 2013
