/* PT_2012_CZ_eusilc_cs */


* Czechia - 2012

* ELIGIBILITY
/*	-> 	no statutory entitlement */
replace pt_eli = .a 		if country == "CZ" & year == 2012 & gender == 2

* DURATION (weeks)
replace pt_dur = .a if country == "CZ" & year == 2012 & gender == 2


* BENEFIT (monthly)
replace pt_ben1 = .a if country == "CZ" & year == 2012 & gender == 2
replace pt_ben2 = .a if country == "CZ" & year == 2012 & gender == 2

/*
foreach x in 1 2 {
	replace pt_ben`x' = 0 	if pt_eli == 0 & country == "CZ" & year == 2012
}

replace pt_dur = 0 if pt_eli == 0 & country == "CZ" & year == 2012
*/
