/* PT_2017_HU_eusilc_cs

date created: 29/09/2021

*/

* HUNGARY - 2017

* ELIGIBILITY
/*	-> employed
	Source: LP&R 2018 */
	
replace pt_eli = 1 		if country == "HU" & year == 2017 & gender == 2 ///
						& econ_status == 1 & duremp >= 12
						
						
replace pt_eli = 0 		if pt_eli == . & country == "HU" & year == 2017 & gender == 2

* DURATION (weeks)
/*	-> 5 working days 
	-> 7 working days for twins (not coded)*/
	
replace pt_dur = 5/5 	if country == "HU" & year == 2017 & pt_eli == 1


* BENEFIT (monthly)
/*	-> 100% earning (LP&R 2017)
	-> no ceiling 		*/ 
replace pt_ben1 = earning 	if country == "HU" & year == 2017 & pt_eli == 1
replace pt_ben2 = earning 	if country == "HU" & year == 2017 & pt_eli == 1


foreach x in 1 2 {
	replace pt_ben`x' = 0 	if pt_eli == 0 & country == "HU" & year == 2017
}

replace pt_dur = 0 if pt_eli == 0 & country == "HU" & year == 2017
