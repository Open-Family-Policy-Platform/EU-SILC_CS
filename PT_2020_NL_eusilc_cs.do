 /* PT_2020_NL_eusilc_cs */


* NETHERLANDS - 2020

* ELIGIBILITY 
/* 	-> employed (LP&R 2020)	

	-> for children born after 1 July 2020: additional paternity leave (coded for 2020) 
*/

replace pt_eli = 1 		if country == "NL" & year == 2020 & gender == 2 ///
						& econ_status == 1
						
replace pt_eli = 0 		if pt_eli == . & country == "NL" & year == 2020 & gender == 2


* DURATION (weeks)
/* 	-> 1 working week
	-> 5 weeks of additional paternity leave */

replace pt_dur = 6 if country == "NL" & year == 2020 & pt_eli == 1  // LP&R 2020


* BENEFIT (monthly)
/*  -> 1st week: 100% of earning, no ceiling (paid by the employer)
	-> 5 weeks: 70% earning
		-> ceiling: €222.78
	
*/

replace pt_ben1 = (earning * (1/6)) + ((earning*0.7)*(5/6)) 	if country == "NL" & year == 2020 & pt_eli == 1
replace pt_ben2 = earning if country == "NL" & year == 2020 & pt_eli == 1


foreach x in 1 2 {
	replace pt_ben`x' = 0 	if pt_eli == 0 & country == "NL" & year == 2020
}

replace pt_dur = 0 if pt_eli == 0 & country == "NL" & year == 2020
