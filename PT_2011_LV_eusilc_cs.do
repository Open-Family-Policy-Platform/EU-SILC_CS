/* PT_2011_LV_eusilc_cs */

* LATVIA - 2011

* ELIGIBILITY
/*	-> employed
	-> self-employed 	*/
	
replace pt_eli = 1 		if country == "LV" & year == 2011 & gender == 2 & inlist(econ_status,1,2)
replace pt_eli = 0 		if pt_eli == . & country == "LV" & year == 2011 & gender == 2

* DURATION (weeks)
/*	-> 10 calendar days to be taken after childbirth */

replace pt_dur = 10/7 	if country == "LV" & year == 2011 & pt_eli == 1


* BENEFIT (monthly)
/*	-> 80% earnings, no ceiling */

replace pt_ben1 = ((earning * 0.8) * (10/21.7)) + (earning * ((21.7-10)/21.7)) ///
										if country == "LV" & year == 2011 & pt_eli == 1
						
replace pt_ben2 = pt_ben1 	if country == "LV" & year == 2011 & pt_eli == 1


foreach x in 1 2 {
	replace pt_ben`x' = 0 	if pt_eli == 0 & country == "LV" & year == 2011
}

replace pt_dur = 0 if pt_eli == 0 & country == "LV" & year == 2011
