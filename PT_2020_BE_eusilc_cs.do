/* PT_2020_BE_eusilc_cs */


* Belgium - 2020

* ELIGIBILITY
/*	-> employed
*/

replace pt_eli = 1 		if country == "BE" & year == 2020 & gender == 2 ///
						& econ_status == 1
replace pt_eli = 0 		if pt_eli == . & country == "BE" & year == 2020 & gender == 2 


* DURATION (weeks)
/*	->  10 days	to be taken within 4 months after birth	 */
replace pt_dur = 10/5 	if country == "BE" & year == 2020 & gender == 2 ///
						& pt_eli == 1


* BENEFIT (monthly)
/*	
	-> 100% earning for 3 days (paid by the employer;LP&R 2020)
	-> 82% of earnings for remaining 7 days 
		-> ceiling: €120.52/day
*/
	


replace pt_ben1 = ((earning*0.82) * (7/21.7))	+ (earning * ((21.7-7)/21.7)) ///
									if country == "BE" & year == 2020 ///
									& gender == 2  & pt_eli == 1					

* above ceiling
replace pt_ben1 = (120.52*7) + (earning * ((21.7-7)/21.7)) ///
									if country == "BE" & year == 2020 ///
									& gender == 2  & pt_eli == 1 ///
									& ((0.82*earning)/21.7) > 120.52
									

replace pt_ben2 = pt_ben1 			if country == "BE" & year == 2020 & gender == 2

	

replace pt_ben2 = pt_ben1 			if country == "BE" & year == 2020 & gender == 2


foreach x in 1 2 {
	replace pt_ben`x' = 0 	if pt_eli == 0 & country == "BE" & year == 2020
}

replace pt_dur = 0 if pt_eli == 0 & country == "BE" & year == 2020


