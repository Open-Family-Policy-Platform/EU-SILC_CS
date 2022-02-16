/* PT_2017_GR_eusilc_cs

date created: 29/09/2021

*/

* GREECE - 2017

* ELIGIBILITY
/*	-> employed */
replace pt_eli = 1 		if country == "GR" & year == 2017 & gender == 2 ///
						& econ_status == 1
replace pt_eli = 0 		if pt_eli == . & country == "GR" & year == 2017 & gender == 2

* DURATION (weeks)
/*	-> 2 days */
replace pt_dur = 2/5 	if country == "GR" & year == 2017 & pt_eli == 1


* BENEFIT (monthly)
/*	-> 100% (LP&R 2017)
	-> paid by the employer 
*/
	
replace pt_ben1 = earning 	if country == "GR" & year == 2017 & pt_eli == 1
replace pt_ben2 = pt_ben1 	if country == "GR" & year == 2017 & pt_eli == 1


foreach x in 1 2 {
	replace pt_ben`x' = 0 	if pt_eli == 0 & country == "GR" & year == 2017
}

replace pt_dur = 0 if pt_eli == 0 & country == "GR" & year == 2017
