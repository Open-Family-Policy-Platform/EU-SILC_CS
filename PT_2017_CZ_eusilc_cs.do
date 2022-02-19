/* PT_2017_CZ_eusilc_cs

date created: 28/09/2021

*/

* Czechia - 2017

/* No statutory entitlement to paternity leave. */


* ELIGIBILITY
replace pt_eli = 0 		if country == "CZ" & year == 2017 & gender == 2 ///


* DURATION (weeks)
replace pt_dur = .a  	if country == "CZ" & year == 2017 & gender == 2 & pt_eli == 1 


* BENEFIT (monthly)

replace pt_ben1 = .a		if country == "CZ" & year == 2017 & pt_eli == 1

replace pt_ben2 = .a 	if country == "CZ" & year == 2017 & pt_eli == 1

/*
foreach x in 1 2 {
	replace pt_ben`x' = 0 	if pt_eli == 0 & country == "CZ" & year == 2017
}

replace pt_dur = 0 if pt_eli == 0 & country == "CZ" & year == 2017


