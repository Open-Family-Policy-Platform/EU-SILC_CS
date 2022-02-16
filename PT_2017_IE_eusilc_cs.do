/* PT_2017_IE_eusilc_cs

date created: 29/09/2021

*/

* IRELAND - 2017

* ELIGIBILITY
/*	-> employed: at least 39 weeks (9 months; coded) compulsory social insurance contributions in past 12 months (not coded)
	-> self-employed: at least 52 weeks (coded) compulsory social insurance contribution in past 12 months (not coded)
*/
replace pt_eli = 1 		if country == "IE" & year == 2017 & gender == 2 ///
						& econ_status == 1 & duremp+dursemp >= 9
						
replace pt_eli = 1		if country == "IE" & year == 2017 & gender == 2 ///
						& econ_status == 2 & dursemp+duremp >= 12
						
replace pt_eli = 0 		if pt_eli == . & country == "IE" & year == 2017 & gender == 2


* DURATION (weeks)
/* 	-> 2 weeks
	-> within 6 months of birth
*/
replace pt_dur = 2 	if country == "IE" & year == 2017 & pt_eli == 1


* BENEFIT (monthly)
/*	-> €235/week
*/
replace pt_ben1 = (235 * pt_dur) + (earning*(4.3-pt_dur)) 	///
									if country == "IE" & year == 2017 & pt_eli == 1

replace pt_ben2 = pt_ben1 	if country == "IE" & year == 2017 & pt_eli == 1

foreach x in 1 2 {
	replace pt_ben`x' = 0 	if pt_eli == 0 & country == "IE" & year == 2017
}

replace pt_dur = 0 if pt_eli == 0 & country == "IE" & year == 2017
