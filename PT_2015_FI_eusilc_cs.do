/* PT_2015_FI_eusilc_cs */


* Finland - 2015

* ELIGIBILITY
/*	-> all residents
	-> non-residents: 4 months of employment or self-employment (not coded)
*/
replace pt_eli = 1 		if country == "FI" & year == 2015 & gender == 2 
						

replace pt_eli = 0 if pt_eli == . & country == "FI" & year == 2015 & gender == 2


* DURATION (weeks)
/* -> 54 days */ 
replace pt_dur = 54/6 if country == "FI" & year == 2015 & pt_eli == 1 


* BENEFIT (monthly)
/*	-> €24.02/day if unemployed or earnings are less than €10,297/year (income group IGa)
	-> 70% on earnings between €10,297/year and 36,420/year (IGb)
	-> 40% on earnings between €36,420 /year and €56,032/year (IGc)
	-> 25% on earnings above €56,032/year   (IGd) 
								
*/


* IGa
replace pt_ben1 = 24.02 * 21.7 			if country == "FI" & year == 2015 & gender == 2 ///
									& pt_eli == 1 & inlist(econ_status,3,4)
									
replace pt_ben1 = 24.02 * 21.7 			if country == "FI" & year == 2015 & gender == 2 ///
									& pt_eli == 1 & inlist(econ_status,1,2) & (earning*12) < 10297


									
* IGb
replace pt_ben1 = earning * 0.7 	if country == "FI" & year == 2015 & gender == 2 ///
									& pt_eli == 1 & inrange((earning*12),10297,36420)

									
									
									
* IGc 
gen pt_bena = (36420/12) * 0.7 		if country == "FI" & year == 2015 & gender == 2 ///
									& pt_eli == 1 & (earning*12) > 36420
			
gen pt_benb = (earning - (36420/12)) * 0.4 		///
									if country == "FI" & year == 2015	///
									& gender == 2 & pt_eli == 1 ///
									& inrange((earning*12),36420,56032)
															

replace pt_ben1 = pt_bena + pt_benb 		if country == "FI" ///
												& year == 2015	& gender == 2 ///
												& pt_eli == 1 & inrange((earning*12),36420,56032)			
			


* IGd	
gen pt_benc = (56032/12) * 0.4			if country == "FI" ///
													& year == 2015	& gender == 2 ///
													& pt_eli == 1 & (earning*12) > 56032
	
gen pt_bend = (earning - (56032/12)) * 0.25 		///
									if country == "FI" & year == 2015	///
									& gender == 2 & pt_eli == 1 ///
									& (earning*12) > 56032
									
									

replace pt_ben1 = pt_bena + pt_benc + pt_bend 		if country == "FI" ///
									& year == 2015	& gender == 2 & pt_eli == 1 ///
									& (earning*12) > 56032


replace pt_ben2 = pt_ben1 	if country == "FI" & year == 2015 & gender == 2 & pt_eli == 1
		
								
foreach x in 1 2 {
	replace pt_ben`x' = 0 	if pt_eli == 0 & country == "FI" & year == 2015
}

replace pt_dur = 0 if pt_eli == 0 & country == "FI" & year == 2015			
			
drop pt_bena pt_benb pt_benc pt_bend


