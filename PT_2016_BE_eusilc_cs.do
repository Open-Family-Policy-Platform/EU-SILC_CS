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
/*	
	-> 100% earning for 3 days (paid by the employer)
	-> 82% of earnings for remaining 7 days 
		-> ceiling: €111.45/day
	-> to be used within 4 months from birth
	-> source: LP&R 2016		*/
	


replace pt_ben1 = ((earning*0.82) * (7/21.7))	+ (earning * ((21.7-7)/21.7)) ///
									if country == "BE" & year == 2016 ///
									& gender == 2  & pt_eli == 1					

* above ceiling
replace pt_ben1 = (111.45*7) + (earning * ((21.7-7)/21.7)) ///
									if country == "BE" & year == 2016 ///
									& gender == 2  & pt_eli == 1 ///
									& ((0.82*earning)/21.7) > 111.45
									

replace pt_ben2 = pt_ben1 			if country == "BE" & year == 2016 & gender == 2


foreach x in 1 2 {
	replace pt_ben`x' = 0 	if pt_eli == 0 & country == "BE" & year == 2016
}

replace pt_dur = 0 if pt_eli == 0 & country == "BE" & year == 2016


