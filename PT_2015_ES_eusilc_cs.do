/* PT_2015_ES_eusilc_cs */

* SPAIN - 2015

* ELIGIBILITY
/*	-> employed, self-employed
	-> 180 contribution days (coded) during the past 7 years (not coded) or 360 over their working life (not coded)
*/

replace pt_eli = 1 		if country == "ES" & year == 2015 & gender == 2 ///
						& inlist(econ_status,1,2) & (duremp+dursemp) >= 180/21.7
						
replace pt_eli = 0 		if pt_eli == . & country == "ES" & year == 2015 & gender == 2


* DURATION (weeks)
/*	-> 15 days (LP&R 2015)
*/
replace pt_dur = 15/5	 		if country == "ES" & year == 2015 & pt_eli == 1 


* BENEFIT (monthly)
/*	-> 100%
	-> ceiling: €3,606.00/month
*/

replace pt_ben1 = earning 	if country == "ES" & year == 2015 & pt_eli == 1

replace pt_ben1 = 3606 		if country == "ES" & year == 2015 & pt_eli == 1 ///
							& pt_ben1 > 3606

replace pt_ben2 = pt_ben1 	if country == "ES" & year == 2015 & pt_eli == 1



foreach x in 1 2 {
	replace pt_ben`x' = 0 	if country == "ES" & year == 2015 & pt_eli == 0
}

replace pt_dur = 0 		if country == "ES" & year == 2015 & pt_eli == 0 
