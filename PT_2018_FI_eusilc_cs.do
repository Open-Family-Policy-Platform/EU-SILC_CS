/* PT_2018_FI_eusilc_cs */


* Finland - 2018

* ELIGIBILITY
/*	-> all residents
	-> non-residents: 4 months of employment or self-employment (not coded)
*/
replace pt_eli = 1 		if country == "FI" & year == 2018 & gender == 2 
						

replace pt_eli = 0 if pt_eli == . & country == "FI" & year == 2018 & gender == 2


* DURATION (weeks)
/* -> 54 days */ 
replace pt_dur = 54/6 if country == "FI" & year == 2018 & pt_eli == 1 


* BENEFIT (monthly)
/*	-> €24.64/day if unemployed or earnings are less than €10,562/year (income group a)
	-> 70% on earnings between €10,562/year and €37,167/year (IG b)
	-> 40% on earnings between €37,168/year and €57,183/year (IG c)
	-> 25% on earnings above €57,183/year   (IG d) 									
*/


* IGa
replace pt_ben1 = 24.64 * 21.7 			if country == "FI" & year == 2018 & gender == 2 ///
									& pt_eli == 1 & inrange(econ_status,3,4)
									
replace pt_ben1 = 24.64 * 21.7 			if country == "FI" & year == 2018 & gender == 2 ///
									& pt_eli == 1 & inrange(econ_status,1,2) & (earning*12) < 10562


									
* IGb
replace pt_ben1 = earning * 0.7 	if country == "FI" & year == 2018 & gender == 2 ///
									& pt_eli == 1 & inrange((earning*12),10562,37167)

									
									
									
* IGc 
gen pt_bena = (37168/12) * 0.7 		if country == "FI" & year == 2018 & gender == 2 ///
									& pt_eli == 1 & (earning*12) > 37168
			
gen pt_benb = (earning - (37168/12)) * 0.4 		///
									if country == "FI" & year == 2018	///
									& gender == 2 & pt_eli == 1 ///
									& inrange((earning*12),37168,57183)
															

replace pt_ben1 = pt_bena + pt_benb 		if country == "FI" ///
												& year == 2018	& gender == 2 ///
												& pt_eli == 1 & inrange((earning*12),37168,57183)			
			


* IGd	
gen pt_benc = (57183/12) * 0.4			if country == "FI" ///
													& year == 2018	& gender == 2 ///
													& pt_eli == 1 & (earning*12) > 57183
	
gen pt_bend = (earning - (57183/12)) * 0.25 		///
									if country == "FI" & year == 2018	///
									& gender == 2 & pt_eli == 1 ///
									& (earning*12) > 57183
									
									

replace pt_ben1 = pt_bena + pt_benc + pt_bend 		if country == "FI" ///
									& year == 2018	& gender == 2 & pt_eli == 1 ///
									& (earning*12) > 57183


replace pt_ben2 = pt_ben1 	if country == "FI" & year == 2018 & gender == 2 & pt_eli == 1
									

foreach x in 1 2 {
	replace pt_ben`x' = 0 	if pt_eli == 0 & country == "FI" & year == 2018
}

replace pt_dur = 0 if pt_eli == 0 & country == "FI" & year == 2018			
			
drop pt_bena pt_benb pt_benc pt_bend


