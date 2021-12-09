/* PT_2016_BE_eusilc_cs */


* Belgium - 2016

* ELIGIBILITY
/*	-> employed
*/
replace pt_eli = 1 		if country == "BE" & year == 2016 & gender == 2 ///
						& econ_status == 1
replace pt_eli = 0 		if pt_eli == . & country == "BE" & year == 2016 & gender == 2 


* DURATION (weeks)
/*	->  10 days		 */
replace pt_dur = 10/5 	if country == "BE" & year == 2016 & gender == 2 ///
						& pt_eli == 1


* BENEFIT (monthly)
/*	-> 82% of earnings
	-> ceiling = €114.59/day 		*/
	


replace pt_ben1 = ((earning*0.82) * (10/21.7))	+ (earning * ((21.7-10)/21.7)) ///
									if country == "BE" & year == 2016 ///
									& gender == 2  & pt_eli == 1					

* above ceiling
replace pt_ben1 = (114.59*10) + (earning * ((21.7-10)/21.7)) ///
									if country == "BE" & year == 2016 ///
									& gender == 2  & pt_eli == 1 ///
									& ((0.82*earning)/21.7) > 114.59
									

replace pt_ben2 = pt_ben1 			if country == "BE" & year == 2016 & gender == 2


foreach x in 1 2 {
	replace pt_ben`x' = 0 	if pt_eli == 0 & country == "BE" & year == 2016
}

replace pt_dur = 0 if pt_eli == 0 & country == "BE" & year == 2016


