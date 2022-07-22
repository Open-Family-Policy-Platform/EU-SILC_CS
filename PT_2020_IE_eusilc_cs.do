/* PT_2020_IE_eusilc_cs */


* IRELAND - 2020


* ELIGIBILITY
/*	-> employed: at least 39 weeks (9 months) compulsory social insurance contributions in past 12 months
	-> self-employed: at least 52 weeks compulsory social insurance contribution in past 12 months
*/

replace pt_eli = 1 		if country == "IE" & year == 2020 & gender == 2 ///
						& econ_status == 1 & duremp >= 9
						
replace pt_eli = 1		if country == "IE" & year == 2020 & gender == 2 ///
						& econ_status == 2 & dursemp >= 12
						
replace pt_eli = 0 		if pt_eli == . & country == "IE" & year == 2020 & gender == 2


* DURATION (weeks)
/* 	-> 2 weeks (coded)
	-> within 6 months of birth (not coded)
*/

replace pt_dur = 2 	if country == "IE" & year == 2020 & pt_eli == 1


* BENEFIT (monthly)
/*	-> €245/week
*/

replace pt_ben1 = (245 * (pt_dur/4.3)) + (earning * ((4.3-pt_dur)/4.3)) 	///
									if country == "IE" & year == 2020 & pt_eli == 1

replace pt_ben2 = pt_ben1 	if country == "IE" & year == 2020 & pt_eli == 1

foreach x in 1 2 {
	replace pt_ben`x' = 0 	if pt_eli == 0 & country == "IE" & year == 2020
}

replace pt_dur = 0 if pt_eli == 0 & country == "IE" & year == 2020
