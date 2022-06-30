/* PT_2014_LT_eusilc_cs */


* LITHUANIA - 2014

* ELIGIBILITY
/*	-> employed, self-employed: for 12 months (coded) during past 2 years (not coded) 
		-> the condition doesn't apply for fathers under 26 (MISSOC 07/2014)) */

replace pt_eli = 1 		if country == "LT" & year == 2014 & gender == 2 ///
						& econ_status == 1 & (duremp+dursemp) >= 12
replace pt_eli = 1 		if country == "LT" & year == 2014 & gender == 2 ///
						& econ_status == 1 & age < 26
						
replace pt_eli = 0 		if pt_eli == . & country == "LT" & year == 2014 & gender == 2


* DURATION (weeks)
/*	-> 1 month */
replace pt_dur = 4.3 	if country == "LT" & year == 2014 & pt_eli == 1


* BENEFIT (monthly)
/*	-> 100% average earnings (MISSOC 07/2014)
	-> ceiling: €1,380/month (LP&R 2014)
*/
	
replace pt_ben1 = earning 	if country == "LT" & year == 2014 & pt_eli == 1 
							
replace pt_ben1 = 1380		if country == "LT" & year == 2014 & pt_eli == 1 ///
							& pt_ben1 >= 1380	
							
replace pt_ben2 = pt_ben1  	if country == "LT" & year == 2014 & pt_eli == 1


foreach x in 1 2 {
	replace pt_ben`x' = 0 	if pt_eli == 0 & country == "LT" & year == 2014
}

replace pt_dur = 0 if pt_eli == 0 & country == "LT" & year == 2014
