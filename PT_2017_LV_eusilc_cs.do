/* PT_2017_LV_eusilc_cs

date created: 27/09/2021

*/

* LATVIA - 2017

* ELIGIBILITY
/*	-> employed
	-> self-employed 	*/
	
replace pt_eli = 1 		if country == "LV" & year == 2017 & gender == 2 
replace pt_eli = 0 		if pt_eli == . & country == "LV" & year == 2017 & gender == 2

* DURATION (weeks)
/*	-> 10 calendar days to be taken after childbirth */

replace pt_dur = 10/7 	if country == "LV" & year == 2017 & pt_eli == 1


* BENEFIT (monthly)
/*	-> 80% earnings, no ceiling */

replace pt_ben1 = (((0.8 * earning)/4.3)* pt_dur) + ((earning/4.3)*(4.3-pt_dur)) ///
										if country == "LV" & year == 2017 & pt_eli == 1
						
replace pt_ben2 = pt_ben1 	if country == "LV" & year == 2017 & pt_eli == 1


foreach x in 1 2 {
	replace pt_ben`x' = 0 	if pt_eli == 0 & country == "LV" & year == 2017
}

replace pt_dur = 0 if pt_eli == 0 & country == "LV" & year == 2017
