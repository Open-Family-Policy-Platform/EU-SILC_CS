/* PT_2020_FI_eusilc_cs */


* Finland - 2020

* ELIGIBILITY
/*	-> all residents
	-> non-residents: 4 months of emptoyment or self-emptoyment (not coded)
*/
replace pt_eli = 1 		if country == "FI" & year == 2020 & gender == 2 
						
replace pt_eli = 0 if pt_eli == . & country == "FI" & year == 2020 & gender == 2


* DURATION (weeks)
/* -> 54 days */ 
replace pt_dur = 54/6 if country == "FI" & year == 2020 & pt_eli == 1 



* BENEFIT (monthly; LP&R 2020) 
/*	-> €28.94/day if unemptoyed or earnings are less than €9,649/year (income group IGa; LP&R 2020)
	-> 70% on earnings between €9,649/year and €38,636/year (IGb; M2020)
	-> 40% on earnings between €38,637/year and €59,444/year (IGc; M2020)
	-> 25% on earnings above €59,444/year   (IGd; M2020) 									
*/


* IGa
replace pt_ben1 = 28.94 * 21.7 			if country == "FI" & year == 2020 & gender == 2 ///
										& pt_eli == 1 & inrange(econ_status,3,4)
									
replace pt_ben1 = 28.94 * 21.7 			if country == "FI" & year == 2020 & gender == 2 ///
										& pt_eli == 1 & inrange(econ_status,1,2) & (earning*12) < 9649

* IGb
replace pt_ben1 = earning * 0.7 		if country == "FI" & year == 2020 & gender == 2 ///
										& pt_eli == 1 & inrange((earning*12),9649,38636)
										 

									
* IGc 
gen pt_bena = (38636/12) * 0.7 		if country == "FI" & year == 2020 & gender == 2 ///
									& pt_eli == 1 & earning*12 >= 38636 
			
gen pt_benb = (earning - (38637/12)) * 0.4 		///
									if country == "FI" & year == 2020	///
									& gender == 2 & pt_eli == 1 ///
									& inrange((earning*12),38636,59444) 

replace pt_ben1 = pt_bena + pt_benb 		if country == "FI" ///
												& year == 2020	& gender == 2 ///
												& pt_eli == 1 & inrange((earning*12),38636,59444) ///
												

																																			
* IGd	


gen pt_benc = (57183/12) * 0.4		if country == "FI" & year == 2020	& gender == 2 ///
										& pt_eli == 1 & (earning*12) > 59444 
	
gen pt_bend = (earning - (59444/12)) * 0.25  		///
									if country == "FI" & year == 2020	///
									& gender == 2 & pt_eli == 1 ///
									& (earning*12) >= 59444 
			

replace pt_ben1 = pt_bena + pt_benc + pt_bend 		if country == "FI" ///
							& year == 2020	& gender == 2 & pt_eli == 1 ///
							& (earning*12) >= 59444 

							
replace pt_ben2 = pt_ben1 	if country == "FI" & year == 2020 & gender == 2 & pt_eli == 1
						
			


foreach x in 1 2 {
	replace pt_ben`x' = 0 	if pt_eli == 0 & country == "FI" & year == 2020
}

replace pt_dur = 0 if pt_eli == 0 & country == "FI" & year == 2020			
			
drop pt_bena pt_benb pt_benc pt_bend


