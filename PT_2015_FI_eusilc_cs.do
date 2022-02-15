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
/*	-> first 30 days:
		-> €24.02/day if unemployed or earnings are less than €9,610/year (income group 30a)
		-> 75% on earnings between €9,610/year and €56,032/year (IG 30b)
		-> 32.5% on earnings above €56,032/year (IG 30c)
		
	-> remaining 24 days:
		-> €24.02/day if unemployed or earnings are less than €9,610/year (IG 24a)
		-> 70% on earnings between €10,297/year and €36,420/year (IG 24b)
		-> 40% on earnings between €36,420/year and €56,032/year (IG 24c)
		-> 25% on earnings above €56,032/year
								
*/


* Income group (IG) 30a
replace pt_ben30 = 24.64 * 21.7 		if country == "FI" & year == 2015 ///
									& gender == 2 & pt_eli == 1 ///
									& (earning*12) < 9610

* IG 30b			
replace pt_ben30 = (earning * 0.75) 	if country == "FI" & year == 2015 ///
									& gender == 2 & pt_eli == 1 & pt_ben30 == . ///
									& inrange((earning*12),9610,56032)

* IG 30c			
gen pt_ben30a = (56032/12) * 0.75 	if country == "FI" & year == 2015 ///
									& gender == 2 & (earning*12) > 56032 ///
									& pt_eli == 1
									
gen pt_ben30b = (earning - (56032/12)) * 0.325 		if country == "FI" & year == 2015 ///
													& gender == 2 ///
													& (earning*12) > 57183 & pt_eli == 1
	
	
replace pt_ben30 = pt_ben30a + pt_ben30b 		if country == "FI" & year == 2015 ///
												& gender == 2 & pt_eli == 1 ///
												& pt_ben30 == . ///
												& (earning*12) > 56032 



* IG 24a - annual earnings less than €9,610/year
replace pt_ben24 = 24.64 * 21.7 		if country == "FI" & year == 2015 & gender == 2 ///
									& pt_eli == 1 & (earning*12) < 9610

* IG 24b - €10,297/year and €36,420/year
replace pt_ben24 = earning * 0.7 	if country == "FI" & year == 2015 & gender == 2 ///
									& pt_eli == 1 & pt_ben24 == . ///
									& inrange((earning*12),9610,36420)

* IG 24c - annual earnings between €36,420/year and €56,032/year
gen pt_ben24a = (37167/12) * 0.7 	if country == "FI" & year == 2015 & gender == 2 ///
									& pt_eli == 1 & (earning*12) > 36420
			
gen pt_ben24b = (earning - (36420/12)) * 0.4 		if country == "FI" ///
									& year == 2015	& gender == 2 & pt_eli == 1 ///
									& inrange((earning*12),36420,56032)

replace pt_ben24 = pt_ben24a + pt_ben24b 		if country == "FI" ///
												& year == 2015	& gender == 2 ///
												& pt_eli == 1 & pt_ben24 == . ///
												& inrange((earning*12),36420,56,032)			
			
* IG 24d - annual earnings above €56,032	
gen pt_ben24c = (56032/12) * 0.4			if country == "FI" ///
													& year == 2015	& gender == 2 ///
													& pt_eli == 1 & (earning*12) > 56032
	
gen pt_ben24d = (earning - (56032/12)) * 0.25 		if country == "FI" ///
									& year == 2015	& gender == 2 & pt_eli == 1 ///
									& (earning*12) > 56032
			

replace pt_ben24 = pt_ben24a + pt_ben24c + pt_ben24d 		if country == "FI" ///
							& year == 2015	& gender == 2 & pt_eli == 1 & pt_ben24 == . ///
							& (earning*12) > 56032



* PT benefit 
replace pt_ben1 = ((pt_ben30 * (30/54) ) + (pt_ben24 * (24/54)))		if country == "FI" ///
												& year == 2015	& gender == 2 & pt_eli == 1


			 
replace pt_ben2 = pt_ben30 		if country == "FI" & year == 2015 & gender == 2 & pt_eli == 1




								
foreach x in 1 2 {
	replace pt_ben`x' = 0 	if pt_eli == 0 & country == "FI" & year == 2015
}

replace pt_dur = 0 if pt_eli == 0 & country == "FI" & year == 2015			
			
drop pt_bena pt_benb


