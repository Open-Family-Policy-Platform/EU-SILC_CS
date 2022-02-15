/* PT_2015_RO_eusilc_cs */

* ROMANIA - 2015

* ELIGIBILITY
/*	-> employed
	-> self-employed 
*/

replace pt_eli = 1 		if country == "RO" & year == 2015 & gender == 2 ///
						& inlist(econ_status,1,2)
replace pt_eli = 0 		if pt_eli == . & country == "RO" & year == 2015 & gender == 2



* DURATION (weeks)
/*	-> 5 days
	-> can be extended of 5 days if father attends a course in childcare (not coded)
*/
	
replace pt_dur = 5/5 	if country == "RO" & year == 2015 & pt_eli == 1


* BENEFIT (monthly)
/*	-> 100% earning */

replace pt_ben1 = earning 	if country == "RO" & year == 2015 & pt_eli == 1

replace pt_ben2 = pt_ben1 	if country == "RO" & year == 2015 & pt_eli == 1


foreach x in 1 2 {
	replace pt_ben`x' = 0 	if pt_eli == 0 & country == "RO" & year == 2015
}

replace pt_dur = 0 if pt_eli == 0 & country == "RO" & year == 2015
