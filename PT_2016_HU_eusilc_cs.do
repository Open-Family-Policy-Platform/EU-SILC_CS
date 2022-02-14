/* PT_2016_HU_eusilc_cs */


* HUNGARY - 2016

* ELIGIBILITY
/*	-> employed  */
	
replace pt_eli = 1 		if country == "HU" & year == 2016 & gender == 2 ///
						& econ_status == 1
						
						
replace pt_eli = 0 		if pt_eli == . & country == "HU" & year == 2016 & gender == 2

* DURATION (weeks)
/*	-> 5 working days (LP&R 2016)
	-> 7 working days for twins (not coded; MISSOC 2016)*/
	
replace pt_dur = 5/5 	if country == "HU" & year == 2016 & pt_eli == 1


* BENEFIT (monthly)
/*	-> 100% earning (LP&R 2016)
	-> no ceiling 		*/ 
replace pt_ben1 = earning 	if country == "HU" & year == 2016 & pt_eli == 1
replace pt_ben2 = earning 	if country == "HU" & year == 2016 & pt_eli == 1


foreach x in 1 2 {
	replace pt_ben`x' = 0 	if pt_eli == 0 & country == "HU" & year == 2016
}

replace pt_dur = 0 if pt_eli == 0 & country == "HU" & year == 2016
