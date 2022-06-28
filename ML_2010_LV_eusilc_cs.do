/* ML_2010_LV_eusilc_cs */

* LATVIA - 2010

* ELIGIBILITY
/*	-> employed
	-> self-employed
*/
	
replace ml_eli = 1 			if country == "LV" & year == 2010 & gender == 1 ///
							& inlist(econ_status,1,2) 

							
replace ml_eli = 0 			if ml_eli == . & country == "LV" & year == 2010 & gender == 1


* DURATION (weeks)
/*	-> total: 112 calendar days
*/

replace ml_dur1 = 0		if country == "LV" & year == 2010 & ml_eli == 1

replace ml_dur2 = 112/7 		if country == "LV" & year == 2010 & ml_eli == 1 & gender == 1


* BENEFIT (monthly)
/*	-> 100% gross earnings, no ceiling */

replace ml_ben1 = earning 		if country == "LV" & year == 2010 & ml_eli == 1
replace ml_ben2 = ml_ben1 			if country == "LV" & year == 2010 & ml_eli == 1


foreach x in 1 2 {
    replace ml_dur`x' = 0 	if ml_eli == 0 & country == "LV" & year == 2010
	replace ml_ben`x' = 0 	if ml_eli == 0 & country == "LV" & year == 2010
}

