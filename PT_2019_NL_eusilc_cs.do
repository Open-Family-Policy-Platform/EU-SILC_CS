 /* PT_2019_NL_eusilc_cs */


* NETHERLANDS - 2019

* ELIGIBILITY 
/* -> employed (LP&R 2019)	*/

replace pt_eli = 1 		if country == "NL" & year == 2019 & gender == 2 ///
						& econ_status == 1
						
replace pt_eli = 0 		if pt_eli == . & country == "NL" & year == 2019 & gender == 2


* DURATION (weeks)
/* -> 5 days (calculated the same was as parental leave; LP&R 2019) */

replace pt_dur = 5/5 if country == "NL" & year == 2019 & pt_eli == 1  // LP&R 2019


* BENEFIT (monthly)
/* 100% of earning, no ceiling */

replace pt_ben1 = earning if country == "NL" & year == 2019 & pt_eli == 1
replace pt_ben2 = earning if country == "NL" & year == 2019 & pt_eli == 1


foreach x in 1 2 {
	replace pt_ben`x' = 0 	if pt_eli == 0 & country == "NL" & year == 2019
}

replace pt_dur = 0 if pt_eli == 0 & country == "NL" & year == 2019
