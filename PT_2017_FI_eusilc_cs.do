/* PT_2017_FI_eusilc_cs

date created: 28/09/2021

*/

* Finland - 2017

* ELIGIBILITY
/*	-> all residents
	-> non-residents: 4 months of employment or self-employment (not coded)
*/
replace pt_eli = 1 		if country == "FI" & year == 2017 & gender == 2 
						

replace pt_eli = 0 if pt_eli == . & country == "FI" & year == 2017 & gender == 2


* DURATION (weeks)
/* -> 54 days */ 
replace pt_dur = 54/6 if country == "FI" & year == 2017 & pt_eli == 1 


* BENEFIT (monthly)
/*	-> €23.73/day if unemployed or earnings are less than €1,426/year (income group a)
	-> 70% on earnings between €1,426/year and €37,113/year (IG b)
	-> 40% on earnings between €37,113/year and €57,101/year (IG c)
	-> 25% on earnings above €57,101/year   (IG d) 									
*/


* IGa
gen pt_ben = 23.73 * 21.7 			if country == "FI" & year == 2017 & gender == 2 ///
									& pt_eli == 1 & (earning*12) < 1426

* IGb
replace pt_ben = earning * 0.7 		if country == "FI" & year == 2017 & gender == 2 ///
									& pt_eli == 1 & pt_ben == . ///
									& inrange((earning*12),1426,37167)

* IGc 
gen pt_bena = (37113/12) * 0.7 		if country == "FI" & year == 2017 & gender == 2 ///
									& pt_eli == 1 & (earning*12) > 37113
			
gen pt_benb = (((earning*12) - 37113) / 12) * 0.4 		///
									if country == "FI" & year == 2017	///
									& gender == 2 & pt_eli == 1 ///
									& inrange((earning*12),37113,57101)

replace pt_ben = pt_bena + pt_benb 		if country == "FI" ///
												& year == 2017	& gender == 2 ///
												& pt_eli == 1 & pt_ben == . ///
												& inrange((earning*12),37113,57101)			
			
* IGd	
gen pt_benc = (57101/12) * 0.4			if country == "FI" ///
													& year == 2017	& gender == 2 ///
													& pt_eli == 1 & (earning*12) > 57101
	
gen pt_bend = (((earning*12) - 57101) / 12) * 0.25 		///
									if country == "FI" & year == 2017	///
									& gender == 2 & pt_eli == 1 ///
									& (earning*12) > 57101
			

replace pt_ben = pt_bena + pt_benc + pt_bend 		if country == "FI" ///
							& year == 2017	& gender == 2 & pt_eli == 1 & pt_ben == . ///
							& (earning*12) > 57101



foreach x in 1 2 {
	replace pt_ben`x' = 0 	if pt_eli == 0 & country == "FI" & year == 2017
}

replace pt_dur = 0 if pt_eli == 0 & country == "FI" & year == 2017			
			
drop pt_bena pt_benb pt_benc pt_bend


