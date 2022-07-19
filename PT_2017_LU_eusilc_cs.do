/* PT_2017_LU_eusilc_cs */

* LUXEMBOURG - 2017

* ELIGIBILITY
/*	-> employed  (LP&R 2018) */

replace pt_eli = 1 		if country == "LU" & year == 2017 & gender == 2 & econ_status == 1
replace pt_eli = 0 		if pt_eli == . & country == "LU" & year == 2017 & gender == 2


* DURATION (weeks)
/*	-> 2 days */
replace pt_dur = 2/5 	if country == "LU" & year == 2017 & pt_eli == 1


* BENEFIT (monthly)
/*	-> 100%  */
	
replace pt_ben1 = earning 	if country == "LU" & year == 2017 & pt_eli == 1

replace pt_ben2 = pt_ben1 	if country == "LU" & year == 2017 & pt_eli == 1

foreach x in 1 2 {
	replace pt_ben`x' = 0 	if pt_eli == 0 & country == "LU" & year == 2017
}

replace pt_dur = 0 if pt_eli == 0 & country == "LU" & year == 2017
