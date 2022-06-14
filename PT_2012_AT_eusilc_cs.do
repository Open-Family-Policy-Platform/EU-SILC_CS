/* PT_2012_AT_eusilc_cs */

* AUSTRIA - 2012

/*	No statutory entitlement to paternity leave.
	
	Source: LP&R 2012
*/

* ELIGIBILITY
replace pt_eli = 0 if country == "AT" & year == 2012 & gender == 2 

* DURATION (weeks)
replace pt_dur = .a if country == "AT" & year == 2012 & gender == 2


* BENEFIT (monthly)
replace pt_ben1 = .a if country == "AT" & year == 2012 & gender == 2
replace pt_ben2 = .a if country == "AT" & year == 2012 & gender == 2


foreach x in 1 2 {
	replace pt_ben`x' = 0 	if pt_eli == 0 & country == "AT" & year == 2012
}

replace pt_dur = 0 if pt_eli == 0 & country == "AT" & year == 2012
