/* PT_2020_ES_eusilc_cs */


* SPAIN - 2020

/* NOTE: 	MISSOC 07/2020 doesn't include information on paternity leave. This code 
			is based on information published in LP&R 2020. */

* ELIGIBILITY 
/*	-> employed, self-employed (LP&R 2020)
*/

replace pt_eli = 1 		if country == "ES" & year == 2020 & gender == 2 ///
						& inlist(econ_status,1,2) 
						
replace pt_eli = 0 		if pt_eli == . & country == "ES" & year == 2020 & gender == 2


* DURATION (weeks)
/*	-> employed, self-employed: 12 weeks 	*/

replace pt_dur = 12 		if country == "ES" & year == 2020 & pt_eli == 1 ///
							& inrange(econ_status,1,2)


* BENEFIT (monthly)
/*	-> 100%
	-> ceiling: €4,070.10/month
*/

replace pt_ben1 = earning 	if country == "ES" & year == 2020 & pt_eli == 1
replace pt_ben1 = 4070.10 	if country == "ES" & year == 2020 & pt_eli == 1 ///
							& pt_ben1 > 4070.10

replace pt_ben2 = pt_ben1 	if country == "ES" & year == 2020 & pt_eli == 1



foreach x in 1 2 {
	replace pt_ben`x' = 0 	if country == "ES" & year == 2020 & pt_eli == 0
}

replace pt_dur = 0 		if country == "ES" & year == 2020 & pt_eli == 0 
