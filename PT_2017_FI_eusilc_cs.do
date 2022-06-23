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
/*	-> €23.73/day if unemployed or earnings are less than €10,562/year (income group 49a)
	-> 70% on earnings between €10,562/year and €37,167/year (IG 49b)
	-> 40% on earnings between €37,168/year and €56,443/year (IG 49c)
	-> 25% on earnings above €56,443/year   (IG 49d) 									
*/


* IGa
gen pt_ben = 23.73 * 21.7 			if country == "FI" & year == 2017 & gender == 2 ///
									& pt_eli == 1 & (earning*12) < 10562

* IGb
replace pt_ben = earning * 0.7 		if country == "FI" & year == 2017 & gender == 2 ///
									& pt_eli == 1 & pt_ben == . ///
									& inrange((earning*12),10562,37167)

* IGc 
gen pt_bena = (37167/12) * 0.7 		if country == "FI" & year == 2017 & gender == 2 ///
									& pt_eli == 1 & (earning*12) > 37167
			
gen pt_benb = (((earning*12) - 37167) / 12) * 0.4 		///
									if country == "FI" & year == 2017	///
									& gender == 2 & pt_eli == 1 ///
									& inrange((earning*12),37167,56443)

replace pt_ben = pt_bena + pt_benb 		if country == "FI" ///
												& year == 2017	& gender == 2 ///
												& pt_eli == 1 & pt_ben == . ///
												& inrange((earning*12),37167,56443)			
			
* IGd	
gen pt_benc = (56443/12) * 0.4			if country == "FI" ///
													& year == 2017	& gender == 2 ///
													& pt_eli == 1 & (earning*12) > 56443
	
gen pt_bend = (((earning*12) - 56443) / 12) * 0.25 		///
									if country == "FI" & year == 2017	///
									& gender == 2 & pt_eli == 1 ///
									& (earning*12) > 56443
			

replace pt_ben = pt_bena + pt_benc + pt_bend 		if country == "FI" ///
							& year == 2017	& gender == 2 & pt_eli == 1 & pt_ben == . ///
							& (earning*12) > 56443



foreach x in 1 2 {
	replace pt_ben`x' = 0 	if pt_eli == 0 & country == "FI" & year == 2017
}

replace pt_dur = 0 if pt_eli == 0 & country == "FI" & year == 2017			
			
drop pt_bena pt_benb pt_benc pt_bend


