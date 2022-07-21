/* PT_2010_NL_eusilc_cs */


* NETHERLANDS - 2010

* ELIGIBILITY 
/* -> employed (LP&R 2010) */

replace pt_eli = 1 		if country == "NL" & year == 2010 & gender == 2 ///
						& econ_status == 1
replace pt_eli = 0 		if pt_eli == . & country == "NL" & year == 2010 & gender == 2


* DURATION (weeks)
/* -> 2 days within the first 4 weeks following childbirth */

replace pt_dur = 2/5 if country == "NL" & year == 2010 & pt_eli == 1  // LP&R 2010


* BENEFIT (monthly)
/*	-> 100% of earning paid by the employer	
	(MISSOC 01/07/2010)		*/
	
replace pt_ben1 = earning 		if country == "NL" & year == 2010 & pt_eli == 1


foreach x in 1 2 {
	replace pt_ben`x' = 0 	if pt_eli == 0 & country == "NL" & year == 2010
}

replace pt_dur = 0 if pt_eli == 0 & country == "NL" & year == 2010
