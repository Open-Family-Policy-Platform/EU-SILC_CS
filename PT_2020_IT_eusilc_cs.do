/* PT_2020_IT_eusilc_cs */


* ITALY - 2020

* ELIGIBILITY
/*	-> employed (LP&R 2020; MISSOC 2020 understands paternity leave to also 
		be the maternity leave entitlements that cannot be used by mother) 		*/
		
replace pt_eli = 1 		if country == "IT" & year == 2020 & gender == 2 ///
						& econ_status == 1
replace pt_eli = 0 		if pt_eli == . & country == "IT" & year == 2020 & gender == 2


* DURATION (weeks)
/*	-> 7 days (compulsory) 
	-> to be used within 5 month after childbirth */

replace pt_dur = 7/5 	if country == "IT" & year == 2020 & pt_eli == 1


* BENEFIT (monthly)
/*	-> 100% earning */
replace pt_ben1 = earning 	if country == "IT" & year == 2020 & pt_eli == 1
replace pt_ben2 = earning 	if country == "IT" & year == 2020 & pt_eli == 1


foreach x in 1 2 {
	replace pt_ben`x' = 0 	if pt_eli == 0 & country == "IT" & year == 2020
}

replace pt_dur = 0 if pt_eli == 0 & country == "IT" & year == 2020
