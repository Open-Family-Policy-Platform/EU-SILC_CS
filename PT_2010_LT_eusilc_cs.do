/* PT_2010_LT_eusilc_cs */


* LITHUANIA - 2010

* ELIGIBILITY
/*	-> employed: for 12 months (coded) during past 2 years (not coded) 
		-> the condition doesn't apply for fathers under 26 (MISSOC 07/2010)
*/

replace pt_eli = 1 		if country == "LT" & year == 2010 & gender == 2 ///
						& econ_status == 1 & duremp >= 12
replace pt_eli = 1 		if country == "LT" & year == 2010 & gender == 2 ///
						& econ_status == 1 & age < 26

replace pt_eli = 0 		if pt_eli == . & country == "LT" & year == 2010 & gender == 2


* DURATION (weeks)
/*	-> 1 month */
replace pt_dur = 4.3 	if country == "LT" & year == 2010 & pt_eli == 1


* BENEFIT (monthly)
/*	-> 100% average earnings (MISSOC 07/2010)
*/
	
replace pt_ben1 = earning 	if country == "LT" & year == 2010 & pt_eli == 1 
							
replace pt_ben2 = pt_ben1  	if country == "LT" & year == 2010 & pt_eli == 1


foreach x in 1 2 {
	replace pt_ben`x' = 0 	if pt_eli == 0 & country == "LT" & year == 2010
}

replace pt_dur = 0 if pt_eli == 0 & country == "LT" & year == 2010
