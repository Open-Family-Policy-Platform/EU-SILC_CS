/* PT_2019_FI_eusilc_cs */


* Finland - 2019

* ELIGIBILITY
/*	-> all residents
	-> non-residents: 4 months of emptoyment or self-emptoyment (not coded)
*/
replace pt_eli = 1 		if country == "FI" & year == 2019 & gender == 2 
						
replace pt_eli = 0 if pt_eli == . & country == "FI" & year == 2019 & gender == 2


* DURATION (weeks)
/* -> 54 days */ 
replace pt_dur = 54/6 if country == "FI" & year == 2019 & pt_eli == 1 



* BENEFIT (monthly; LP&R 2019) 
/*	-> €27.86/day if unemptoyed or earnings are less than €11,942/year (income group IGa; LP&R 2019)
	-> 70% on earnings between €11,942/year and €37,861/year (IGb; M2019)
	-> 40% on earnings between €37,862/year and €58,252/year (IGc; M2019)
	-> 25% on earnings above €58,252/year   (IGd; M2019) 									
*/


* IGa
replace pt_ben1 = 27.86 * 21.7 			if country == "FI" & year == 2019 & gender == 2 ///
										& pt_eli == 1 & inrange(econ_status,3,4)
									
replace pt_ben1 = 27.86 * 21.7 			if country == "FI" & year == 2019 & gender == 2 ///
										& pt_eli == 1 & inrange(econ_status,1,2) & (earning*12) < 11942

* IGb
replace pt_ben1 = earning * 0.7 		if country == "FI" & year == 2019 & gender == 2 ///
										& pt_eli == 1 & inrange((earning*12),11942,37861)
										 

									
* IGc 
gen pt_bena = (37861/12) * 0.7 		if country == "FI" & year == 2019 & gender == 2 ///
									& pt_eli == 1 & earning*12 >= 37861 
			
gen pt_benb = (earning - (37862/12)) * 0.4 		///
									if country == "FI" & year == 2019	///
									& gender == 2 & pt_eli == 1 ///
									& inrange((earning*12),37861,58252) 

replace pt_ben1 = pt_bena + pt_benb 		if country == "FI" ///
												& year == 2019	& gender == 2 ///
												& pt_eli == 1 & inrange((earning*12),37861,58252) ///
												

																																			
* IGd	


gen pt_benc = (57183/12) * 0.4		if country == "FI" & year == 2019	& gender == 2 ///
										& pt_eli == 1 & (earning*12) > 58252 
	
gen pt_bend = (earning - (58252/12)) * 0.25  		///
									if country == "FI" & year == 2019	///
									& gender == 2 & pt_eli == 1 ///
									& (earning*12) >= 58252 
			

replace pt_ben1 = pt_bena + pt_benc + pt_bend 		if country == "FI" ///
							& year == 2019	& gender == 2 & pt_eli == 1 ///
							& (earning*12) >= 58252 

							
replace pt_ben2 = pt_ben1 	if country == "FI" & year == 2019 & gender == 2 & pt_eli == 1
						
			


foreach x in 1 2 {
	replace pt_ben`x' = 0 	if pt_eli == 0 & country == "FI" & year == 2019
}

replace pt_dur = 0 if pt_eli == 0 & country == "FI" & year == 2019			
			
drop pt_bena pt_benb pt_benc pt_bend


