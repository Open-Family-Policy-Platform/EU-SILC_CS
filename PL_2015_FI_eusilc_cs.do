/* PL_2015_FI_eusilc_cs */


* FINLAND - 2015

* ELIGIBILITY
/*	-> all residents
	-> non-residents: 4 months of employment or self-employment (not coded)
 */
replace pl_eli = 1 			if country == "FI" & year == 2015 
			
replace pl_eli = 0 			if pl_eli == . & country == "FI" & year == 2015


* DURATION (weeks)
/* 	-> family entitlement 
	-> 158 days 
	-> couples: assigned to women
*/
   
replace pl_dur = 158/21.7 		if country == "FI" & year == 2015 & pl_eli == 1 ///
								& gender == 1

* single men
replace pl_dur = 158/21.7 		if country == "FI" & year == 2015 & pl_eli == 1 ///
								& gender == 2 & parstat == 1



* BENEFIT (monthly)
/*	-> first 30 days:
		-> €24.02/day if unemployed or earnings are less than €9,610/year (income group 30a)
		-> 75% on earnings between €9,610/year and €56,032/year (IG 30b)
		-> 32.5% on earnings above €56,032/year (IG 30c)
		
	-> remaining 128 days:
		-> €24.02/day if unemployed or earnings are less than €9,610/year (IG 24a)
		-> 70% on earnings between €10,297/year and €36,420/year (IG 24b)
		-> 40% on earnings between €36,420/year and €56,032/year (IG 24c)
		-> 25% on earnings above €56,032/year 		*/


* WOMEN 
* Income group (IG) 30a
replace pl_ben30 = 24.64 * 21.7 		if country == "FI" & year == 2015 ///
									& gender == 1 & pl_eli == 1 ///
									& (earning*12) < 9610

* IG 30b			
replace pl_ben30 = (earning * 0.75) 	if country == "FI" & year == 2015 ///
									& gender == 1 & pl_eli == 1 & pl_ben30 == . ///
									& inrange((earning*12),9610,56032)

* IG 30c			
gen pl_ben30a = (56032/12) * 0.75 	if country == "FI" & year == 2015 ///
									& gender == 1 & (earning*12) > 56032 ///
									& pl_eli == 1
									
gen pl_ben30b = (earning - (56032/12)) * 0.325 		if country == "FI" & year == 2015 ///
													& gender == 1 ///
													& (earning*12) > 57183 & pl_eli == 1
	
	
replace pl_ben30 = pl_ben30a + pl_ben30b 		if country == "FI" & year == 2015 ///
												& gender == 1 & pl_eli == 1 ///
												& pl_ben30 == . ///
												& (earning*12) > 56032 



* IG 128a - annual earnings less than €9,610/year
replace pl_ben128 = 24.64 * 21.7 		if country == "FI" & year == 2015 & gender == 1 ///
									& pl_eli == 1 & (earning*12) < 9610

* IG 128b - €10,297/year and €36,420/year
replace pl_ben128 = earning * 0.7 	if country == "FI" & year == 2015 & gender == 1 ///
									& pl_eli == 1 & pt_ben24 == . ///
									& inrange((earning*12),9610,36420)

* IG 128c - annual earnings between €36,420/year and €56,032/year
gen pl_ben128a = (37167/12) * 0.7 	if country == "FI" & year == 2015 & gender == 1 ///
									& pl_eli == 1 & (earning*12) > 36420
			
gen pl_ben128b = (earning - (36420/12)) * 0.4 		if country == "FI" ///
									& year == 2015	& gender == 1 & pl_eli == 1 ///
									& inrange((earning*12),36420,56032)

replace pl_ben128 = pl_ben128a + pl_ben128b 		if country == "FI" ///
												& year == 2015	& gender == 1 ///
												& pl_eli == 1 & pl_ben128 == . ///
												& inrange((earning*12),36420,56,032)			
			
* IG 128d - annual earnings above €56,032	
gen pl_ben128c = (56032/12) * 0.4			if country == "FI" ///
													& year == 2015	& gender == 1 ///
													& pl_eli == 1 & (earning*12) > 56032
	
gen pl_ben128d = (earning - (56032/12)) * 0.25 		if country == "FI" ///
									& year == 2015	& gender == 1 & pl_eli == 1 ///
									& (earning*12) > 56032
			

replace pl_ben128 = pl_ben128a + pl_ben128c + pl_ben128d 		if country == "FI" ///
							& year == 2015	& gender == 1 & pl_eli == 1 & pl_ben128 == . ///
							& (earning*12) > 56032




* SINGLE MEN
* Income group (IG) 30a
replace pl_ben30 = 24.64 * 21.7 		if country == "FI" & year == 2015 ///
									& gender == 2 & pl_eli == 1 ///
									& (earning*12) < 9610 & parstat == 1

* IG 30b			
replace pl_ben30 = (earning * 0.75) 	if country == "FI" & year == 2015 ///
									& gender == 2 & pl_eli == 1 & pl_ben30 == . ///
									& inrange((earning*12),9610,56032) & parstat == 1

* IG 30c			
gen pl_ben30a = (56032/12) * 0.75 	if country == "FI" & year == 2015 ///
									& gender == 2 & (earning*12) > 56032 ///
									& pl_eli == 1 & parstat == 1
									
gen pl_ben30b = (earning - (56032/12)) * 0.325 		if country == "FI" & year == 2015 ///
													& gender == 2 ///
													& (earning*12) > 57183 & pl_eli == 1 & parstat == 1
	
	
replace pl_ben30 = pl_ben30a + pl_ben30b 		if country == "FI" & year == 2015 ///
												& gender == 2 & pl_eli == 1 ///
												& pl_ben30 == . ///
												& (earning*12) > 56032 & parstat == 1



* IG 128a - annual earnings less than €9,610/year
replace pl_ben128 = 24.64 * 21.7 		if country == "FI" & year == 2015 & gender == 2 ///
									& pl_eli == 1 & (earning*12) < 9610 & parstat == 1

* IG 128b - €10,297/year and €36,420/year
replace pl_ben128 = earning * 0.7 	if country == "FI" & year == 2015 & gender == 2 ///
									& pl_eli == 1 & pt_ben24 == . ///
									& inrange((earning*12),9610,36420) & parstat == 1

* IG 128c - annual earnings between €36,420/year and €56,032/year
gen pl_ben128a = (37167/12) * 0.7 	if country == "FI" & year == 2015 & gender == 2 ///
									& pl_eli == 1 & (earning*12) > 36420 & parstat == 1
			
gen pl_ben128b = (earning - (36420/12)) * 0.4 		if country == "FI" ///
									& year == 2015	& gender == 2 & pl_eli == 1 ///
									& inrange((earning*12),36420,56032) & parstat == 1

replace pl_ben128 = pl_ben128a + pl_ben128b 		if country == "FI" ///
												& year == 2015	& gender == 2 ///
												& pl_eli == 1 & pl_ben128 == . ///
												& inrange((earning*12),36420,56,032) & parstat == 1			
			
* IG 128d - annual earnings above €56,032	
gen pl_ben128c = (56032/12) * 0.4			if country == "FI" ///
													& year == 2015	& gender == 2 ///
													& pl_eli == 1 & (earning*12) > 56032 & parstat == 1
	
gen pl_ben128d = (earning - (56032/12)) * 0.25 		if country == "FI" ///
									& year == 2015	& gender == 2 & pl_eli == 1 ///
									& (earning*12) > 56032 & parstat == 1
			

replace pl_ben128 = pl_ben128a + pl_ben128c + pl_ben128d 		if country == "FI" ///
							& year == 2015	& gender == 2 & pl_eli == 1 & pl_ben128 == . ///
							& (earning*12) > 56032 & parstat == 1








* PT benefit 
replace pl_ben1 = ((pl_ben30 * (30/158) ) + (pt_ben24 * (128/158)))		if country == "FI" ///
												& year == 2015	& gender == 1 & pl_eli == 1
			
replace pl_ben1 = ((pl_ben30 * (30/158) ) + (pt_ben24 * (128/158)))		if country == "FI" ///
												& year == 2015	& gender == 2 & pl_eli == 1 & parstat == 1


replace pl_ben2 = pl_ben30			if country == "FI" & year == 2015 & pl_eli == 1


foreach x in 1 2 {
	replace pl_ben`x' = 0 	if pl_eli == 0 & country == "FI" & year == 2015
}

replace pl_dur = 0 	if pl_eli == 0 & country == "FI" & year == 2015
