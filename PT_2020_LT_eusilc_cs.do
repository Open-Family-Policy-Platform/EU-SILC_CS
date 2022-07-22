/* PT_2020_LT_eusilc_cs */


* LITHUANIA - 2020

* ELIGIBILITY
/*	-> employed, self-employed: for 12 months (coded) during past 2 years (not coded) */

replace pt_eli = 1 		if country == "LT" & year == 2020 & gender == 2 ///
						& inlist(econ_status,1,2) & duremp + dursemp >= 12
						

replace pt_eli = 0 		if pt_eli == . & country == "LT" & year == 2020 & gender == 2


* DURATION (weeks)
/*	-> 1 month */
replace pt_dur = 4.3 	if country == "LT" & year == 2020 & pt_eli == 1


* BENEFIT (monthly)
/*	-> 77.58% earnings (NOTE: LP&R 2020 mentions 100%)
	-> minimum: €250.77/month  
	-> ceiling: 2* the national average monthly wage (M2020)
		-> €1,617.40 (LP&R 2019)
*/
	
replace pt_ben1 = 0.7758 * earning 	if country == "LT" & year == 2020 & pt_eli == 1 

replace pt_ben1 = 250.77 			if country == "LT" & year == 2020 & pt_eli == 1 ///
									& pt_ben1 < 250.77	

							
replace pt_ben1 = 1617.40 			if country == "LT" & year == 2020 & pt_eli == 1 ///
									& pt_ben1 >= 1617.40	
							
replace pt_ben2 = pt_ben1  			if country == "LT" & year == 2020 & pt_eli == 1


foreach x in 1 2 {
	replace pt_ben`x' = 0 	if pt_eli == 0 & country == "LT" & year == 2020
}

replace pt_dur = 0 if pt_eli == 0 & country == "LT" & year == 2020
