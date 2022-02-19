/* PT_2019_LU_eusilc_cs */


* LUXEMBOURG - 2019

* ELIGIBILITY
/*	-> employed (LP&R 2019) */

replace pt_eli = 1 		if country == "LU" & year == 2019 & gender == 2 & econ_status == 1
replace pt_eli = 0 		if pt_eli == . & country == "LU" & year == 2019 & gender == 2


* DURATION (weeks)
/*	-> 10 days */

replace pt_dur = 10/5 	if country == "LU" & year == 2019 & pt_eli == 1


* BENEFIT (monthly)
/*	-> 100% 
	-> ceiling: €10,448.75/month	(LP&R 2019)	*/
	
replace pt_ben1 = earning 	if country == "LU" & year == 2019 & pt_eli == 1

* ceiling
replace pt_ben1 = (10448.75 * (pt_dur/4.3)) + (earning * ((4.3-pt_dur)/4.3)) ///
							if country == "LU" & year == 2019 & pt_eli == 1 ///
							& earning >= 10448.75

replace pt_ben2 = pt_ben1 	if country == "LU" & year == 2019 & pt_eli == 1


foreach x in 1 2 {
	replace pt_ben`x' = 0 	if pt_eli == 0 & country == "LU" & year == 2019
}

replace pt_dur = 0 if pt_eli == 0 & country == "LU" & year == 2019
