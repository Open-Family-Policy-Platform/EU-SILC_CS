/* PT_2019_AT_eusilc_cs */

* AUSTRIA - 2019


/*	No statutory entitlement to paternity leave.
	Public sector workers - 1 month unpaid leave (not coded). 
	
	There is a 'Parental leave bonus for fathers' (MISSOC 2019)/'Family-time bonus' 
	for fathers (LP&R 2019). 
	It doesn't provide job-protection during the period of leave. 
	
	Introduced for children born from 1.3.2017.
	
	Source: LP&R 2019 
*/

* ELIGIBILITY
/*
	-> employed 
	-> must be taken immediately after childbirth
	-> non-transferable, must be taken full-time
	
	-> does not ensure job protection! (LP&R 2019)
*/

replace pt_eli = 1 		if country == "AT" & year == 2019 & gender == 2 & econ_status == 1
replace pt_eli = 0 		if country == "AT" & year == 2019 & gender == 2 & pt_eli == .


* DURATION (weeks)
/* 	-> father can choose between 28-31 days (longest coded)
*/
replace pt_dur = 31/5	 if country == "AT" & year == 2019 & gender == 2


* BENEFIT (monthly)
/* 	-> €22.60/day 
*/
replace pt_ben1 = 22.6 * 5	 if country == "AT" & year == 2019 & gender == 2
replace pt_ben2 = pt_ben1	 if country == "AT" & year == 2019 & gender == 2



foreach x in 1 2 {
	replace pt_ben`x' = 0 	if pt_eli == 0 & country == "AT" & year == 2019
}

replace pt_dur = 0 if pt_eli == 0 & country == "AT" & year == 2019
