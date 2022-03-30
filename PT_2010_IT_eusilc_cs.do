/* PT_2010_IT_eusilc_cs */


* ITALY - 2010

* ELIGIBILITY
/*	-> employed (LP&R 2010; MISSOC 2010 understands paternity leave to also 
		be the maternity leave entitlements that cannot be used by mother) 		*/
		
replace pt_eli = 1 		if country == "IT" & year == 2010 & gender == 2 ///
						& econ_status == 1
replace pt_eli = 0 		if pt_eli == . & country == "IT" & year == 2010 & gender == 2


* DURATION (weeks)
/*	-> 4 days */

replace pt_dur = 4/5 	if country == "IT" & year == 2010 & pt_eli == 1


* BENEFIT (monthly)
/*	-> 100% earning */
replace pt_ben1 = earning 	if country == "IT" & year == 2010 & pt_eli == 1
replace pt_ben2 = earning 	if country == "IT" & year == 2010 & pt_eli == 1


foreach x in 1 2 {
	replace pt_ben`x' = 0 	if pt_eli == 0 & country == "IT" & year == 2010
}

replace pt_dur = 0 if pt_eli == 0 & country == "IT" & year == 2010