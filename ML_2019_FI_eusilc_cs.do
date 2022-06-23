/* ML_2019_FI_eusilc_cs */


* Finland - 2019 

* ELIGIBILITY 
/*	-> all residents (at least 180 days of residency - not coded)
	-> non-residents: 4 months of employment or self-employment (not coded)
	-> ML can be transferred to father in case of death or illness => it is assumed that 
		this does not apply to cases where the mother abandoned her child (not coded)
*/
replace ml_eli = 1 			if country == "FI" & year == 2019 & gender == 1 
			
			
replace ml_eli = 0 			if ml_eli == . & country == "FI" & year == 2019 & gender == 1



* DURATION (weeks)
/*	-> prenatal: 30 days
	-> total: 105 days
	-> 6 days working week */

replace ml_dur1 = 30/6 if country == "FI" & year == 2019 & gender == 1 & ml_eli == 1

replace ml_dur2 = (105-30)/6 if country == "FI" & year == 2019 & gender == 1 & ml_eli == 1



* BENEFIT 
/* first 56 days:
	-> €27.86/day if unemployed or earnings are less than €9,289/year (income group 56a; LP&R 2019)
	-> 90% of earnings between €9,289/year and €58,252/year (IG 56b; LP&R 2019)
	-> 32.5% of earnings above €58,252/year (IG 56c; LP&R 2019)

remaining 49 days:
	-> €27.86/day if unemployed or earnings are less than €11,942/year (income group 49a; LP&R 2019)
	-> 70% on earnings between €11,942/year and €37,861/year (IG 49b; M2019)
	-> 40% on earnings between €37,862/year and €58,252/year (IG 49c; M2019)
	-> 25% on earnings above €58,252/year   (IG 49d; M2019) 						*/ 

* Income group (IG) 56a
gen ml_ben56 = 27.86 * 21.7 		if country == "FI" & year == 2019 ///
									& gender == 1 & ml_eli == 1 & inlist(econ_status,3,4)



* IG 56b			
replace ml_ben56 = (earning * 0.9) 	if country == "FI" & year == 2019 ///
									& gender == 1 & ml_eli == 1 ///
									& inrange((earning*12),9289,58252)

* IG 56c			
gen ml_ben56a = (58252/12) * 0.9 	if country == "FI" & year == 2019 ///
									& gender == 1 & (earning*12) > 58252 ///
									& ml_eli == 1
									
gen ml_ben56b = (earning - (58252/12)) * 0.325 		if country == "FI" & year == 2019 ///
													& gender == 1 ///
													& (earning*12) > 58252 & ml_eli == 1
	
	
replace ml_ben56 = ml_ben56a + ml_ben56b 		if country == "FI" & year == 2019 ///
												& gender == 1 & ml_eli == 1 ///
												& (earning*12) > 58252 & ml_eli == 1


												
* IG 49a
gen ml_ben49 = 27.86 * 21.7 		if country == "FI" & year == 2019 & gender == 1 ///
									& ml_eli == 1 & inlist(econ_status,3,4)



* IG 49b - annual earnings under 37,861
replace ml_ben49 = earning * 0.7 	if country == "FI" & year == 2019 & gender == 1 ///
									& ml_eli == 1 & inrange((earning*12),11942,37861)

									
* IG 49c - annual earnings between €37,862/year and €58,252/year
gen ml_ben49a = (37861/12) * 0.7 	if country == "FI" & year == 2019 & gender == 1 ///
									& ml_eli == 1 & (earning*12) > 37861
			
gen ml_ben49b = (earning - (37862/12)) * 0.4 		if country == "FI" ///
													& year == 2019	& gender == 1 & ml_eli == 1 ///
													& inrange((earning*12),37862,58252)

replace ml_ben49 = ml_ben49a + ml_ben49b 		if country == "FI" ///
												& year == 2019	& gender == 1 ///
												& ml_eli == 1 & inrange((earning*12),37862,58252)			
			
* IG 49d - annual earnings above 58,252	
gen ml_ben49c = (58252/12) * 0.4			if country == "FI" ///
													& year == 2019	& gender == 1 ///
													& ml_eli == 1 & (earning*12) > 58252
	
gen ml_ben49d = (earning - (58252/12)) * 0.25 		if country == "FI" ///
									& year == 2019	& gender == 1 & ml_eli == 1 ///
									& (earning*12) > 58252
			

replace ml_ben49 = ml_ben49a + ml_ben49c + ml_ben49d 		if country == "FI" ///
															& year == 2019	& gender == 1 & ml_eli == 1 ///
															& (earning*12) > 58252
			

			
* ML benefit 
replace ml_ben1 = ((ml_ben56 * (56/105) ) + (ml_ben49 * (49/105))) 		if country == "FI" ///
																		& year == 2019	& gender == 1 & ml_eli == 1


			 
replace ml_ben2 = ml_ben56 		if country == "FI" & year == 2019 & gender == 1 & ml_eli == 1

foreach x in 1 2 {
    replace ml_dur`x' = 0 	if ml_eli == 0 & country == "FI" & year == 2019
	replace ml_ben`x' = 0 	if ml_eli == 0 & country == "FI" & year == 2019
}



drop ml_ben56 ml_ben49 ml_ben56a ml_ben56b ml_ben49a ml_ben49b ml_ben49c ml_ben49d
