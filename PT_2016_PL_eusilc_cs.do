/* PT_2016_PL_eusilc_cs */


* POLAND - 2016

* ELIGIBILITY
/*	-> compulsory social insurance for employees
	-> voluntary social insurance for self-employed (not coded) 		*/
	
replace pt_eli = 1 		if country == "PL" & year == 2016 & gender == 2 ///
						& econ_status == 1
replace pt_eli = 0 		if pt_eli == . & country == "PL" & year == 2016 & gender == 2


* DURATION (weeks)
/*	-> 2 weeks */
replace pt_dur = 2 	if country == "PL" & year == 2016 & pt_eli == 1


* BENEFIT (monthly)
/*	-> 100% earnings, no ceiling */

replace pt_ben1 = earning 	if country == "PL" & year == 2016 & pt_eli == 1
replace pt_ben2 = earning 	if country == "PL" & year == 2016 & pt_eli == 1


foreach x in 1 2 {
	replace pt_ben`x' = 0 	if pt_eli == 0 & country == "PL" & year == 2016
}

replace pt_dur = 0 if pt_eli == 0 & country == "PL" & year == 2016
