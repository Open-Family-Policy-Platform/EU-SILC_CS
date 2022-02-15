/* PT_2014_AT_eusilc_cs */

* AUSTRIA - 2014

/*	No statutory entitlement to paternity leave.
	
	Source: LP&R 2014
*/

* ELIGIBILITY
replace pt_eli = 0 if country == "AT" & year == 2014 & gender == 2 

* DURATION (weeks)
replace pt_dur = .a if country == "AT" & year == 2014 & gender == 2


* BENEFIT (monthly)
replace pt_ben1 = .a if country == "AT" & year == 2014 & gender == 2
replace pt_ben2 = .a if country == "AT" & year == 2014 & gender == 2


foreach x in 1 2 {
	replace pt_ben`x' = 0 	if pt_eli == 0 & country == "AT" & year == 2014
}

replace pt_dur = 0 if pt_eli == 0 & country == "AT" & year == 2014
