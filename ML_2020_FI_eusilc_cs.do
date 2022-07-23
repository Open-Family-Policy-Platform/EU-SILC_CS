/* ML_2020_FI_eusilc_cs */


* Finland - 2020 

* ELIGIBILITY 
/*	-> all residents (at least 180 days of residency - not coded)
	-> non-residents: 4 months of employment or self-employment (not coded)
	-> ML can be transferred to father in case of death or illness => it is assumed that 
		this does not apply to cases where the mother abandoned her child (not coded)
*/
replace ml_eli = 1 			if country == "FI" & year == 2020 & gender == 1 
			
			
replace ml_eli = 0 			if ml_eli == . & country == "FI" & year == 2020 & gender == 1



* DURATION (weeks)
/*	-> prenatal: 30 days
	-> total: 105 days
	-> 6 days working week */

replace ml_dur1 = 30/6 if country == "FI" & year == 2020 & gender == 1 & ml_eli == 1

replace ml_dur2 = (105-30)/6 if country == "FI" & year == 2020 & gender == 1 & ml_eli == 1



* BENEFIT 
/* first 56 days:
	-> €28.94/day if unemployed or earnings are less than €9,649/year (income group 56a; LP&R 2020)
	-> 90% of earnings between €9,649/year and €59,444/year (IG 56b; LP&R 2020)
	-> 32.5% of earnings above €59,444/year (IG 56c; LP&R 2020)

remaining 49 days:
	-> €28.94/day if unemployed or earnings are less than €12,405/year (income group 49a; LP&R 2020)
	-> 70% on earnings between €12,405/year and €38,636/year (IG 49b; M2020)
	-> 40% on earnings between €38,637/year and €59,444/year (IG 49c; M2020)
	-> 25% on earnings above €59,444/year   (IG 49d; M2020) 						*/ 

* Income group (IG) 56a
gen ml_ben56 = 28.94 * 21.7 		if country == "FI" & year == 2020 ///
									& gender == 1 & ml_eli == 1 & inlist(econ_status,3,4)

gen ml_ben56 = 28.94 * 21.7 		if country == "FI" & year == 2020 ///
									& gender == 1 & ml_eli == 1 & inlist(econ_status,1,2) & (earning*12) < 9649

* IG 56b			
replace ml_ben56 = (earning * 0.9) 	if country == "FI" & year == 2020 ///
									& gender == 1 & ml_eli == 1 ///
									& inrange((earning*12),9649,59444)

* IG 56c			
gen ml_ben56a = (59444/12) * 0.9 	if country == "FI" & year == 2020 ///
									& gender == 1 & (earning*12) > 59444 ///
									& ml_eli == 1
									
gen ml_ben56b = (earning - (59444/12)) * 0.325 		if country == "FI" & year == 2020 ///
													& gender == 1 ///
													& (earning*12) > 59444 & ml_eli == 1
	
	
replace ml_ben56 = ml_ben56a + ml_ben56b 		if country == "FI" & year == 2020 ///
												& gender == 1 & ml_eli == 1 ///
												& (earning*12) > 59444 & ml_eli == 1


												
* IG 49a
gen ml_ben49 = 28.94 * 21.7 		if country == "FI" & year == 2020 & gender == 1 ///
									& ml_eli == 1 & inlist(econ_status,3,4)

gen ml_ben49 = 28.94 * 21.7 		if country == "FI" & year == 2020 & gender == 1 ///
									& ml_eli == 1 & inlist(econ_status,3,4) & (earning*12) < 12405

* IG 49b - annual earnings under 38,636
replace ml_ben49 = earning * 0.7 	if country == "FI" & year == 2020 & gender == 1 ///
									& ml_eli == 1 & inrange((earning*12),12405,38636)

									
* IG 49c - annual earnings between €38,637/year and €59,444/year
gen ml_ben49a = (38636/12) * 0.7 	if country == "FI" & year == 2020 & gender == 1 ///
									& ml_eli == 1 & (earning*12) > 38636
			
gen ml_ben49b = (earning - (38637/12)) * 0.4 		if country == "FI" ///
													& year == 2020	& gender == 1 & ml_eli == 1 ///
													& inrange((earning*12),38637,59444)

replace ml_ben49 = ml_ben49a + ml_ben49b 		if country == "FI" ///
												& year == 2020	& gender == 1 ///
												& ml_eli == 1 & inrange((earning*12),38637,59444)			
			
* IG 49d - annual earnings above 59,444	
gen ml_ben49c = (59444/12) * 0.4			if country == "FI" ///
													& year == 2020	& gender == 1 ///
													& ml_eli == 1 & (earning*12) > 59444
	
gen ml_ben49d = (earning - (59444/12)) * 0.25 		if country == "FI" ///
									& year == 2020	& gender == 1 & ml_eli == 1 ///
									& (earning*12) > 59444
			

replace ml_ben49 = ml_ben49a + ml_ben49c + ml_ben49d 		if country == "FI" ///
															& year == 2020	& gender == 1 & ml_eli == 1 ///
															& (earning*12) > 59444
			

			
* ML benefit 
replace ml_ben1 = ((ml_ben56 * (56/105) ) + (ml_ben49 * (49/105))) 		if country == "FI" ///
																		& year == 2020	& gender == 1 & ml_eli == 1


			 
replace ml_ben2 = ml_ben56 		if country == "FI" & year == 2020 & gender == 1 & ml_eli == 1

foreach x in 1 2 {
    replace ml_dur`x' = 0 	if ml_eli == 0 & country == "FI" & year == 2020
	replace ml_ben`x' = 0 	if ml_eli == 0 & country == "FI" & year == 2020
}



drop ml_ben56 ml_ben49 ml_ben56a ml_ben56b ml_ben49a ml_ben49b ml_ben49c ml_ben49d
