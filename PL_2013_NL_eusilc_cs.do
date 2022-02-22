/* PL_2013_NL_eusilc_cs */


* NETHERLANDS - 2013

* ELIGIBILITY
/*	-> employed
 */
replace pl_eli = 1 		if country == "NL" & year == 2013 ///
						& econ_status == 1
replace pl_eli = 0 		if pl_eli == . & country == "NL" & year == 2013


* DURATION (weeks)
/* -> 26 times the number of weekly working hours per parent per child
*/
replace pl_dur = 26 * whours if country == "NL" & year == 2013 & pl_eli == 1


* BENEFIT (monthly)
/*	-> no statutory cash benefits
 */
replace pl_ben1 = 0 if country == "NL" & year == 2013 & pl_eli == 1
replace pl_ben2 = 0 if country == "NL" & year == 2013 & pl_eli == 1


foreach x in 1 2 {
	replace pl_ben`x' = 0 	if pl_eli == 0 & country == "NL" & year == 2013
}

replace pl_dur = 0 	if pl_eli == 0 & country == "NL" & year == 2013
