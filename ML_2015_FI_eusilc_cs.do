/* ML_2015_FI_eusilc_cs */


* Finland - 2015 

* ELIGIBILITY (MISSOC 01/07/2015)
/*	-> all residents (women)
	-> non-residents: 4 months of employment or self-employment (not coded)
	-> ML can be transferred to father in case of death or illness => it is assumed that 
		this does not apply to cases where the mother abandoned her child (not coded)

*/
replace ml_eli = 1 			if country == "FI" & year == 2015 & gender == 1 
			
			
replace ml_eli = 0 			if ml_eli == . & country == "FI" & year == 2015 & gender == 1



* DURATION (weeks)
/*	-> prenatal: 30 days
	-> total: 105 days
	-> 6 days working week */

replace ml_dur1 = 30/6 if country == "FI" & year == 2015 & gender == 1 & ml_eli == 1

replace ml_dur2 = (105-30)/6 if country == "FI" & year == 2015 & gender == 1 & ml_eli == 1



* BENEFIT (monthly; LP&R 2015)
/* first 56 days:
	-> €24.02/day if unemployed or earnings are less than €8,010/year (income group 56a)
	-> 90% of earnings between €8,010/year and €56,032/year (IG 56b)
	-> 32.5% of earnings above €56,032/year (IG 56c)

remaining 49 days:
	-> €24.02/day if unemployed or earnings are less than €10,297/year (income group 49a)
	-> 70% on earnings between €10,297/year and 36,420/year (IG 49b)
	-> 40% on earnings between €36,420 /year and €56,032/year (IG 49c)
	-> 25% on earnings above €56,032/year   (IG 49d) 						*/ 

* Income group (IG) 56a
gen ml_ben56 = 24.02 * 21.7 		if country == "FI" & year == 2015 ///
									& gender == 1 & ml_eli == 1 ///
									& econ_status == 3


replace ml_ben56 = 24.02 * 21.7 		if country == "FI" & year == 2015 ///
									& gender == 1 & ml_eli == 1 ///
									& (earning*12) < 8010

* IG 56b			
replace ml_ben56 = (earning * 0.9) 	if country == "FI" & year == 2015 ///
									& gender == 1 & ml_eli == 1 & ml_ben56 == . ///
									& inrange((earning*12),8010,56032)

* IG 56c			
gen ml_ben56a = (56032/12) * 0.9 	if country == "FI" & year == 2015 ///
									& gender == 1 & (earning*12) > 56032 ///
									& ml_eli == 1
									
gen ml_ben56b = (earning - (57183/12)) * 0.325 		if country == "FI" & year == 2015 ///
													& gender == 1 ///
													& (earning*12) > 56032 & ml_eli == 1
	
	
replace ml_ben56 = ml_ben56a + ml_ben56b 		if country == "FI" & year == 2015 ///
												& gender == 1 & ml_eli == 1 ///
												& ml_ben56 == . ///
												& (earning*12) > 56032 & ml_eli == 1


* IG 49a
gen ml_ben49 = 24.02 * 21.7 		if country == "FI" & year == 2015 & gender == 1 ///
									& ml_eli == 1 & econ_status == 3


replace ml_ben49 = 24.02 * 21.7 		if country == "FI" & year == 2015 & gender == 1 ///
									& ml_eli == 1 & (earning*12) < 10297

* IG 49b - annual earnings under €36420
replace ml_ben49 = earning * 0.7 	if country == "FI" & year == 2015 & gender == 1 ///
									& ml_eli == 1 & ml_ben49 == . ///
									& inrange((earning*12),10297,36420)

* IG 49c - annual earnings between €36420/year and €56,032/year
gen ml_ben49a = (36420/12) * 0.7 	if country == "FI" & year == 2015 & gender == 1 ///
									& ml_eli == 1 & (earning*12) > 36420
			
gen ml_ben49b = (earning - (36420/12)) * 0.4 		if country == "FI" ///
									& year == 2015	& gender == 1 & ml_eli == 1 ///
									& inrange((earning*12),36420,56032)

replace ml_ben49 = ml_ben49a + ml_ben49b 		if country == "FI" ///
												& year == 2015	& gender == 1 ///
												& ml_eli == 1 & ml_ben49 == . ///
												& inrange((earning*12),36420,56032)			
			
* IG 49d - annual earnings above €56,032	
gen ml_ben49c = (56032/12) * 0.4			if country == "FI" ///
													& year == 2015	& gender == 1 ///
													& ml_eli == 1 & (earning*12) > 56032	
	
gen ml_ben49d = (earning - (56032/12)) * 0.25 		if country == "FI" ///
									& year == 2015	& gender == 1 & ml_eli == 1 ///
									& (earning*12) > 56032
			

replace ml_ben49 = ml_ben49a + ml_ben49c + ml_ben49d 		if country == "FI" ///
							& year == 2015	& gender == 1 & ml_eli == 1 & ml_ben49 == . ///
							& (earning*12) > 56032
			

* ML benefit 
replace ml_ben1 = ((ml_ben56 * (56/105) ) + (ml_ben49 * (49/105)))		if country == "FI" ///
												& year == 2015	& gender == 1 & ml_eli == 1


			 
replace ml_ben2 = ml_ben56 		if country == "FI" & year == 2015 & gender == 1 & ml_eli == 1

foreach x in 1 2 {
    replace ml_dur`x' = 0 	if ml_eli == 0 & country == "FI" & year == 2015
	replace ml_ben`x' = 0 	if ml_eli == 0 & country == "FI" & year == 2015
}



drop ml_ben56a ml_ben56b ml_ben49a ml_ben49b ml_ben49c ml_ben49d
