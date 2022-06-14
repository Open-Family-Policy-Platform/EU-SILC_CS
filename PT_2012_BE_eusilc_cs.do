/* PT_2012_BE_eusilc_cs */


* Belgium - 2012

* ELIGIBILITY
/*	-> employed
*/
replace pt_eli = 1 		if country == "BE" & year == 2012 & gender == 2 ///
						& econ_status == 1
replace pt_eli = 0 		if pt_eli == . & country == "BE" & year == 2012 & gender == 2 


* DURATION (weeks)
/*	->  10 days		 */
replace pt_dur = 10/5 	if country == "BE" & year == 2012 & gender == 2 ///
						& pt_eli == 1


* BENEFIT (monthly)
/*	-> 82% of earnings
	-> ceiling = €103.72/day 		*/
	


replace pt_ben1 = ((earning*0.82) * (10/21.7))	+ (earning * ((21.7-10)/21.7)) ///
									if country == "BE" & year == 2012 ///
									& gender == 2  & pt_eli == 1					

* above ceiling
replace pt_ben1 = (103.72*10) + (earning * ((21.7-10)/21.7)) ///
									if country == "BE" & year == 2012 ///
									& gender == 2  & pt_eli == 1 ///
									& ((0.82*earning)/21.7) > 103.72
									

replace pt_ben2 = pt_ben1 			if country == "BE" & year == 2012 & gender == 2


foreach x in 1 2 {
	replace pt_ben`x' = 0 	if pt_eli == 0 & country == "BE" & year == 2012
}

replace pt_dur = 0 if pt_eli == 0 & country == "BE" & year == 2012

