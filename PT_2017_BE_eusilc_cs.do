/* PT_2017_BE_eusilc_cs

date created: 28/09/2021

*/

* Belgium - 2017

* ELIGIBILITY
/*	-> employed
*/
replace pt_eli = 1 		if country == "BE" & year == 2017 & gender == 2 ///
						& econ_status == 1
replace pt_eli = 0 		if pt_eli == . & country == "BE" & year == 2017 & gender == 2 


* DURATION (weeks)
/*	->  10 days		 */
replace pt_dur = 10/5 	if country == "BE" & year == 2017 & gender == 2 ///
						& pt_eli == 1


* BENEFIT (monthly)
/*	-> 82% of earnings, ceiling = €113.68/day 		*/

replace pt_ben1 = (((0.82 * earning)/4.3) * pt_dur)	+ (earning * (4.3-pt_dur)) ///
									if country == "BE" & year == 2017 ///
									& gender == 2  & pt_eli == 1					

* above ceiling
replace pt_ben1 = (114.59*10) + (earning * (4.3-pt_dur)) ///
									if country == "BE" & year == 2017 ///
									& gender == 2  & pt_eli == 1 ///
									& (((0.82 * earning)/4.3) * pt_dur) > (114.59 * 10)
	

replace pt_ben2 = pt_ben1 			if country == "BE" & year == 2017 & gender == 2


foreach x in 1 2 {
	replace pt_ben`x' = 0 	if pt_eli == 0 & country == "BE" & year == 2017
}

replace pt_dur = 0 if pt_eli == 0 & country == "BE" & year == 2017


