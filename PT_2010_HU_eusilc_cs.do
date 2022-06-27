/* PT_2010_HU_eusilc_cs */


* HUNGARY - 2010

* ELIGIBILITY
/*	-> employed  (LP&R 2010) */
	
replace pt_eli = 1 		if country == "HU" & year == 2010 & gender == 2 ///
						& econ_status == 1
						
						
replace pt_eli = 0 		if pt_eli == . & country == "HU" & year == 2010 & gender == 2

* DURATION (weeks)
/*	-> 5 working days to be taken during first 2 months after childbirth (LP&R 2010)
*/
	
replace pt_dur = 5/5 	if country == "HU" & year == 2010 & pt_eli == 1


* BENEFIT (monthly)
/*	-> 100% earning (LP&R 2010)
	-> no ceiling 		*/ 
replace pt_ben1 = earning 	if country == "HU" & year == 2010 & pt_eli == 1
replace pt_ben2 = earning 	if country == "HU" & year == 2010 & pt_eli == 1


foreach x in 1 2 {
	replace pt_ben`x' = 0 	if pt_eli == 0 & country == "HU" & year == 2010
}

replace pt_dur = 0 if pt_eli == 0 & country == "HU" & year == 2010
