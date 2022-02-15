/* ML_2014_FI_eusilc_cs */


* Finland - 2014 

* ELIGIBILITY (MISSOC 01/07/2014)
/*	-> all residents (women)
	-> non-residents: 4 months of employment or self-employment (not coded)
	-> ML can be transferred to father in case of death or illness => it is assumed that 
		this does not apply to cases where the mother abandoned her child (not coded)
*/
replace ml_eli = 1 			if country == "FI" & year == 2014 & gender == 1 
			
			
replace ml_eli = 0 			if ml_eli == . & country == "FI" & year == 2014 & gender == 1



* DURATION (weeks)
/*	-> prenatal: 30 days
	-> total: 105 days
	-> 6 days working week */

replace ml_dur1 = 30/6 if country == "FI" & year == 2014 & gender == 1 & ml_eli == 1

replace ml_dur2 = (105-30)/6 if country == "FI" & year == 2014 & gender == 1 & ml_eli == 1



* BENEFIT (monthly; LP&R 2014)
/* first 56 days:
	-> €23.92/day if unemployed or earnings are less than €10,253/year (income group 56a)
	-> 90% of earnings between €10,253/year and €55,498/year (IG 56b)
	-> 32.5% of earnings above €55,498/year (IG 56c)

remaining 49 days:
	-> €23.92/day if unemployed or earnings are less than €10,253/year (income group 49a)
	-> 70% on earnings between €10,253/year and €36,071/year (IG 49b)
	-> 40% on earnings between €36,071/year and €56,498/year (IG 49c)
	-> 25% on earnings above €55,498/year   (IG 49d) 						*/ 

* Income group (IG) 56a
gen ml_ben56 = 23.92 * 21.7 		if country == "FI" & year == 2014 ///
									& gender == 1 & ml_eli == 1 ///
									& econ_status == 3


replace ml_ben56 = 23.92 * 21.7 		if country == "FI" & year == 2014 ///
									& gender == 1 & ml_eli == 1 ///
									& (earning*12) < 10253

* IG 56b			
replace ml_ben56 = (earning * 0.9) 	if country == "FI" & year == 2014 ///
									& gender == 1 & ml_eli == 1 & ml_ben56 == . ///
									& inrange((earning*12),10253,55498)

* IG 56c			
gen ml_ben56a = (55498/12) * 0.9 	if country == "FI" & year == 2014 ///
									& gender == 1 & (earning*12) > 55498 ///
									& ml_eli == 1
									
gen ml_ben56b = (earning - (57183/12)) * 0.325 		if country == "FI" & year == 2014 ///
													& gender == 1 ///
													& (earning*12) > 55498 & ml_eli == 1
	
	
replace ml_ben56 = ml_ben56a + ml_ben56b 		if country == "FI" & year == 2014 ///
												& gender == 1 & ml_eli == 1 ///
												& ml_ben56 == . ///
												& (earning*12) > 55498 & ml_eli == 1


* IG 49a
gen ml_ben49 = 23.92 * 21.7 		if country == "FI" & year == 2014 & gender == 1 ///
									& ml_eli == 1 & econ_status == 3


replace ml_ben49 = 23.92 * 21.7 		if country == "FI" & year == 2014 & gender == 1 ///
									& ml_eli == 1 & (earning*12) < 10253

* IG 49b - annual earnings under €36,071
replace ml_ben49 = earning * 0.7 	if country == "FI" & year == 2014 & gender == 1 ///
									& ml_eli == 1 & ml_ben49 == . ///
									& inrange((earning*12),10253,36686)

* IG 49c - annual earnings between €36,687/year and €56,443/year
gen ml_ben49a = (36687/12) * 0.7 	if country == "FI" & year == 2014 & gender == 1 ///
									& ml_eli == 1 & (earning*12) > 36687
			
gen ml_ben49b = (earning - (36687/12)) * 0.4 		if country == "FI" ///
									& year == 2014	& gender == 1 & ml_eli == 1 ///
									& inrange((earning*12),36687,55498)

replace ml_ben49 = ml_ben49a + ml_ben49b 		if country == "FI" ///
												& year == 2014	& gender == 1 ///
												& ml_eli == 1 & ml_ben49 == . ///
												& inrange((earning*12),36687,55498)			
			
* IG 49d - annual earnings above €56,443	
gen ml_ben49c = (55498/12) * 0.4			if country == "FI" ///
													& year == 2014	& gender == 1 ///
													& ml_eli == 1 & (earning*12) > 55498	
	
gen ml_ben49d = (earning - (55498/12)) * 0.25 		if country == "FI" ///
									& year == 2014	& gender == 1 & ml_eli == 1 ///
									& (earning*12) > 55498	
			

replace ml_ben49 = ml_ben49a + ml_ben49c + ml_ben49d 		if country == "FI" ///
							& year == 2014	& gender == 1 & ml_eli == 1 & ml_ben49 == . ///
							& (earning*12) > 55498	
			

* ML benefit 
replace ml_ben1 = ((ml_ben56 * (56/105) ) + (ml_ben49 * (49/105)))		if country == "FI" ///
												& year == 2014	& gender == 1 & ml_eli == 1


			 
replace ml_ben2 = ml_ben56 		if country == "FI" & year == 2014 & gender == 1 & ml_eli == 1

foreach x in 1 2 {
    replace ml_dur`x' = 0 	if ml_eli == 0 & country == "FI" & year == 2014
	replace ml_ben`x' = 0 	if ml_eli == 0 & country == "FI" & year == 2014
}



drop ml_ben56a ml_ben56b ml_ben49a ml_ben49b ml_ben49c ml_ben49d
