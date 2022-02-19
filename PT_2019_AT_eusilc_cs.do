/* PT_2019_AT_eusilc_cs */

* AUSTRIA - 2019

/*	No statutory entitlement to paternity leave.
	There is a 'Family-time bonus'/'Parental leave bonus' for fathers but it doesn't provide 
	job-protection during the period of leave => not coded.
	
	Source: LP&R 2019 
	
*/

* ELIGIBILITY

replace pt_eli = 0 if country == "AT" & year == 2019 & gender == 2 

* DURATION (weeks)
replace pt_dur = .a if country == "AT" & year == 2019 & gender == 2


* BENEFIT (monthly)
replace pt_ben1 = .a if country == "AT" & year == 2019 & gender == 2
replace pt_ben2 = .a if country == "AT" & year == 2019 & gender == 2

/*
foreach x in 1 2 {
	replace pt_ben`x' = 0 	if pt_eli == 0 & country == "AT" & year == 2019
}

replace pt_dur = 0 if pt_eli == 0 & country == "AT" & year == 2019
