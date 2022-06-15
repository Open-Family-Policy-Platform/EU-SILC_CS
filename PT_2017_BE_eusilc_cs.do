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
/*	
	-> 100% earning for 3 days (paid by the employer)
	-> 82% of earnings for remaining 7 days 
		-> ceiling: €113.68/day
	-> to be used within 4 months from birth
	-> source: LP&R 2017		*/
	


replace pt_ben1 = ((earning*0.82) * (7/21.7))	+ (earning * ((21.7-7)/21.7)) ///
									if country == "BE" & year == 2017 ///
									& gender == 2  & pt_eli == 1					

* above ceiling
replace pt_ben1 = (113.68*7) + (earning * ((21.7-7)/21.7)) ///
									if country == "BE" & year == 2017 ///
									& gender == 2  & pt_eli == 1 ///
									& ((0.82*earning)/21.7) > 113.68
									

replace pt_ben2 = pt_ben1 			if country == "BE" & year == 2017 & gender == 2

foreach x in 1 2 {
	replace pt_ben`x' = 0 	if pt_eli == 0 & country == "BE" & year == 2017
}

replace pt_dur = 0 if pt_eli == 0 & country == "BE" & year == 2017


