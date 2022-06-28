/* PT_2018_IT_eusilc_cs */


* ITALY - 2018

* ELIGIBILITY
/*	-> employed (LP&R 2018; MISSOC 2018 understands paternity leave to also 
		be the maternity leave entitlements that cannot be used by mother) 		*/
		
replace pt_eli = 1 		if country == "IT" & year == 2018 & gender == 2 ///
						& econ_status == 1
replace pt_eli = 0 		if pt_eli == . & country == "IT" & year == 2018 & gender == 2


* DURATION (weeks)
/*	-> 4 days 
	-> mother can transfer 3 days from her ML (not coded)*/

replace pt_dur = 4/5 	if country == "IT" & year == 2018 & pt_eli == 1


* BENEFIT (monthly)
/*	-> 100% earning */
replace pt_ben1 = earning 	if country == "IT" & year == 2018 & pt_eli == 1
replace pt_ben2 = earning 	if country == "IT" & year == 2018 & pt_eli == 1


foreach x in 1 2 {
	replace pt_ben`x' = 0 	if pt_eli == 0 & country == "IT" & year == 2018
}

replace pt_dur = 0 if pt_eli == 0 & country == "IT" & year == 2018
