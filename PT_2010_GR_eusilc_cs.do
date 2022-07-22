/* PT_2010_GR_eusilc_cs */


* GREECE - 2010

* ELIGIBILITY
/*	-> employed */
replace pt_eli = 1 		if country == "GR" & year == 2010 & gender == 2 ///
						& econ_status == 1
replace pt_eli = 0 		if pt_eli == . & country == "GR" & year == 2010 & gender == 2

* DURATION (weeks)
/*	-> 2 days */
replace pt_dur = 2/5 	if country == "GR" & year == 2010 & pt_eli == 1


* BENEFIT (monthly)
/*	-> 100%
	-> paid by the employer  	*/
	
replace pt_ben1 = earning 	if country == "GR" & year == 2010 & pt_eli == 1
replace pt_ben2 = pt_ben1 	if country == "GR" & year == 2010 & pt_eli == 1


foreach x in 1 2 {
	replace pt_ben`x' = 0 	if pt_eli == 0 & country == "GR" & year == 2010
}

replace pt_dur = 0 if pt_eli == 0 & country == "GR" & year == 2010
