/* PT_2016_IE_eusilc_cs */

* IRELAND - 2016

* ELIGIBILITY
/*	-> employed: at least 39 weeks (9 months) compulsory social insurance contributions in past 12 months
	-> self-employed: at least 52 weeks compulsory social insurance contribution in past 12 months
*/
replace pt_eli = 1 		if country == "IE" & year == 2016 & gender == 2 ///
						& econ_status == 1 & duremp >= 9
						
replace pt_eli = 1		if country == "IE" & year == 2016 & gender == 2 ///
						& econ_status == 2 & dursemp >= 12
						
replace pt_eli = 0 		if pt_eli == . & country == "IE" & year == 2016 & gender == 2


* DURATION (weeks)
/* 	-> 2 weeks
	-> within 6 months of birth
*/
replace pt_dur = 2 	if country == "IE" & year == 2016 & pt_eli == 1


* BENEFIT (monthly)
/*	-> €240/week
*/
replace pt_ben1 = (240 * pt_dur) + (earning*(4.3-pt_dur)) 	///
									if country == "IE" & year == 2016 & pt_eli == 1

replace pt_ben2 = pt_ben1 	if country == "IE" & year == 2016 & pt_eli == 1

foreach x in 1 2 {
	replace pt_ben`x' = 0 	if pt_eli == 0 & country == "IE" & year == 2016
}

replace pt_dur = 0 if pt_eli == 0 & country == "IE" & year == 2016