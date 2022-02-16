/* PT_2017_AT_eusilc_cs

date created: 27/09/2021

*/

* AUSTRIA - 2017

/*	No statutory entitlement to paternity leave.
	Public sector workers - 1 month unpaid leave (not coded). 
	There is a 'Family-time bonus' for fathers but it doesn't provide 
	job-protection during the period of leave => not coded. Introduced 
	for children born from 1.3.2017.
	
	Source: LP&R 2017 
*/

* ELIGIBILITY
replace pt_eli = 0 if country == "AT" & year == 2017 & gender == 2 

* DURATION (weeks)
replace pt_dur = .a if country == "AT" & year == 2017 & gender == 2


* BENEFIT (monthly)
replace pt_ben1 = .a if country == "AT" & year == 2017 & gender == 2
replace pt_ben2 = .a if country == "AT" & year == 2017 & gender == 2


foreach x in 1 2 {
	replace pt_ben`x' = 0 	if pt_eli == 0 & country == "AT" & year == 2017
}

replace pt_dur = 0 if pt_eli == 0 & country == "AT" & year == 2017
