/* PT_2011_GB_eusilc_cs */

* UK - 2011

* ELIGIBILITY
/*	-> employed if:
		- employed by the same employer (not coded)
		- for 26 weeks
		- average weekly earning at least €136
		
*/	

replace pt_eli = 1 		if country == "GB" & year == 2011 & gender == 2 ///
						& econ_status == 1 & duremp >= 26/4.3 & earning/4.3 >= 136
						
replace pt_eli = 0 		if pt_eli == . & country == "GB" & year == 2011 & gender == 2


* DURATION (weeks)
/*	-> father can choose between 1 or 2 weeks (coded) */

replace pt_dur = 2 	if country == "GB" & year == 2011 & pt_eli == 1


* BENEFIT (monthly)
/*	-> 90% earning 
	-> ceiling: €142/week			*/



replace pt_ben1 = ((0.9 * earning) * (2/4.3)) + (earning * ((4.3-2)/4.3)) ///
								if country == "GB" & year == 2011 & pt_eli == 1
								
* above ceiling
replace pt_ben1 = (142*2) + (earning * ((4.3-2)/4.3)) ///
								if country == "GB" & year == 2011 & pt_eli == 1 ///
								& ((0.9*earning)/4.3) > 142

	

replace pt_ben2 = pt_ben1 	if country == "GB" & year == 2011 & pt_eli == 1



foreach x in 1 2 {
	replace pt_ben`x' = 0 	if country == "GB" & year == 2011 & pt_eli == 0
}

replace pt_dur = 0 		if country == "GB" & year == 2011 & pt_eli == 0 




