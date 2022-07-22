/* PT_2020_LU_eusilc_cs */


* LUXEMBOURG - 2020

* ELIGIBILITY
/*	-> employed (LP&R 2020) */

replace pt_eli = 1 		if country == "LU" & year == 2020 & gender == 2 & econ_status == 1
replace pt_eli = 0 		if pt_eli == . & country == "LU" & year == 2020 & gender == 2


* DURATION (weeks)
/*	-> 10 days */

replace pt_dur = 10/5 	if country == "LU" & year == 2020 & pt_eli == 1


* BENEFIT (monthly)
/*	-> 100% 
	-> ceiling: €10,709.97/month		*/
	
replace pt_ben1 = earning 	if country == "LU" & year == 2020 & pt_eli == 1

* ceiling
replace pt_ben1 = (10709.97 * (pt_dur/4.3)) + (earning * ((4.3-pt_dur)/4.3)) ///
							if country == "LU" & year == 2020 & pt_eli == 1 ///
							& earning >= 10709.97

replace pt_ben2 = pt_ben1 	if country == "LU" & year == 2020 & pt_eli == 1


foreach x in 1 2 {
	replace pt_ben`x' = 0 	if pt_eli == 0 & country == "LU" & year == 2020
}

replace pt_dur = 0 if pt_eli == 0 & country == "LU" & year == 2020
