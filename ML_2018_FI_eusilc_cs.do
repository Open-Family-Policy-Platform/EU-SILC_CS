/* ML_2018_FI_eusilc_cs

date created: 18/02/2021

*/

* Finland - 2018 

* ELIGIBILITY (MISSOC 01/07/2018)
/*	-> all residents (women)
	-> non-residents: 4 months of employment or self-employment (not coded)
	-> ML can be transferred to father in case of death or illness => it is assumed that 
		this does not apply to cases where the mother abandoned her child (not coded)
*/
replace ml_eli = 1 			if country == "FI" & year == 2018 & gender == 1 
			
			
replace ml_eli = 0 			if ml_eli == . & country == "FI" & year == 2018 & gender == 1



* DURATION (weeks)
/*	-> prenatal: 30 days
	-> total: 105 days
	-> 6 days working week */

replace ml_dur1 = 30/6 if country == "FI" & year == 2018 & gender == 1 & ml_eli == 1

replace ml_dur2 = (105-30)/6 if country == "FI" & year == 2018 & gender == 1 & ml_eli == 1



* BENEFIT (monthly; LP&R 2018)
/* first 56 days:
	-> E 24.64/day if unemployed or earnings are less than €8,215/year (income group 56a)
	-> 90% of earnings between €8,215/year and €57,183/year (IG 56b)
	-> 32.5% of earnings above €57,183/year (IG 56c)

remaining 49 days:
	-> €24.64/day if unemployed or earnings are less than €10,562/year (income group 49a)
	-> 70% on earnings between €10,562/year and €37,167/year (IG 49b)
	-> 40% on earnings between €37,168/year and €57,183/year (IG 49c)
	-> 25% on earnings above €57,183/year   (IG 49d) 						*/ 

* Income group (IG) 56a
gen ml_ben56 = 24.64 * 21.7 		if country == "FI" & year == 2018 ///
									& gender == 1 & ml_eli == 1 ///
									& (earning*12) < 8215

* IG 56b			
replace ml_ben56 = (earning * 0.9) 	if country == "FI" & year == 2018 ///
									& gender == 1 & ml_eli == 1 & ml_ben56 == . ///
									& inrange((earning*12),8215,57183)

* IG 56c			
gen ml_ben56a = (57183/12) * 0.9 	if country == "FI" & year == 2018 ///
									& gender == 1 & (earning*12) > 57183 ///
									& ml_eli == 1
									
gen ml_ben56b = ((earning*12) - 57183) * 0.325 		if country == "FI" & year == 2018 ///
													& gender == 1 ///
													& (earning*12) > 57183 & ml_eli == 1
	
	
replace ml_ben56 = ml_ben56a + ml_ben56b 		if country == "FI" & year == 2018 ///
												& gender == 1 & ml_eli == 1 ///
												& ml_ben56 == . ///
												& (earning*12) > 57183 & ml_eli == 1


* IG 49a
gen ml_ben49 = 24.64 * 21.7 		if country == "FI" & year == 2018 & gender == 1 ///
									& ml_eli == 1 & (earning*12) < 10562

* IG 49b
replace ml_ben49 = earning * 0.7 	if country == "FI" & year == 2018 & gender == 1 ///
									& ml_eli == 1 & ml_ben49 == . ///
									& inrange((earning*12),10562,37167)

* IG 49c 
gen ml_ben49a = (37167/12) * 0.7 	if country == "FI" & year == 2018 & gender == 1 ///
									& ml_eli == 1 & inrange((earning*12),37168,57182)
			
gen ml_ben49b = (((earning*12) - 37167) / 12) * 0.4 		if country == "FI" ///
									& year == 2018	& gender == 1 & ml_eli == 1 ///
									& inrange((earning*12),37168,57182)

replace ml_ben49 = ml_ben49a + ml_ben49b 		if country == "FI" ///
												& year == 2018	& gender == 1 ///
												& ml_eli == 1 & ml_ben49 == . ///
												& inrange((earning*12),37167,57182)			
			
* IG 49d	
gen ml_ben49c = ((57183-37167) / 12) * 0.4			if country == "FI" ///
													& year == 2018	& gender == 1 ///
													& ml_eli == 1 & (earning*12) > 57183
	
gen ml_ben49d = (((earning*12) - 57183) / 12) * 0.25 		if country == "FI" ///
									& year == 2018	& gender == 1 & ml_eli == 1 ///
									& (earning*12) > 57183
			

replace ml_ben49 = ml_ben49a + ml_ben49c + ml_ben49d 		if country == "FI" ///
							& year == 2018	& gender == 1 & ml_eli == 1 & ml_ben49 == . ///
							& (earning*12) > 57183
			

* ML benefit 
replace ml_ben1 = ((ml_ben56 * (56/6) ) + (ml_ben49 * (49/6))) * 4.3 		if country == "FI" ///
												& year == 2018	& gender == 1 & ml_eli == 1


			 
replace ml_ben2 = ml_ben56 		if country == "FI" & year == 2018 & gender == 1 & ml_eli == 1

foreach x in 1 2 {
    replace ml_dur`x' = 0 	if ml_eli == 0 & country == "FI" & year == 2018
	replace ml_ben`x' = 0 	if ml_eli == 0 & country == "FI" & year == 2018
}



drop ml_ben56a ml_ben56b ml_ben49a ml_ben49b ml_ben49c ml_ben49d
