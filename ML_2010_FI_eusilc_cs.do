/* ML_2010_FI_eusilc_cs */


* Finland - 2010 

* ELIGIBILITY 
/*	-> all residents (at least 180 days of residency - not coded)
	-> non-residents: 4 months of employment or self-employment (not coded)
	-> ML can be transferred to father in case of death or illness => it is assumed that 
		this does not apply to cases where the mother abandoned her child (not coded)
*/
replace ml_eli = 1 			if country == "FI" & year == 2010 & gender == 1 
			
			
replace ml_eli = 0 			if ml_eli == . & country == "FI" & year == 2010 & gender == 1



* DURATION (weeks)
/*	-> prenatal: 30 days
	-> total: 105 days
	-> 6 days working week */

replace ml_dur1 = 30/6 if country == "FI" & year == 2010 & gender == 1 & ml_eli == 1

replace ml_dur2 = (105-30)/6 if country == "FI" & year == 2010 & gender == 1 & ml_eli == 1



* BENEFIT 
/* first 56 days:
	-> €22.04/day if unemployed and those with earnings below €9,447 (income group 56a; data from 2011)
	-> 90% of earnings between €9,447 and €50,606/year (IG 56b)
	-> 32.5% of earnings above €50,606/year (IG 56c)

remaining 49 days:
	-> €22.04/day if unemployed and those with earnings below €9,447 (income group 49a; LP&R 2010)
	-> 70% on earnings between €9,447 and €32,892/year (IG 49b)
	-> 40% on earnings between €32,893/year and €50,606/year (IG 49c)
	-> 25% on earnings above €50,606/year   (IG 49d) 						*/ 

* Income group (IG) 56a & 49a
	* non-working 
gen ml_ben1 = 22.04 * 21.7 			if country == "FI" & year == 2010 ///
									& gender == 1 & ml_eli == 1 ///
									& inlist(econ_status,3,4)

replace ml_ben1 = 22.04 * 21.7 	if country == "FI" & year == 2010 ///
									& gender == 1 & ml_eli == 1 ///
									& inlist(econ_status,1,2) & (earning*12) < 9447


* IG 56b			
replace ml_ben56 = (earning * 0.9) 	if country == "FI" & year == 2010 ///
									& gender == 1 & ml_eli == 1 & ml_ben56 == . ///
									& inrange((earning*12),9477,50606)

* IG 56c			
gen ml_ben56a = (50606/12) * 0.9 	if country == "FI" & year == 2010 ///
									& gender == 1 & (earning*12) > 50606 ///
									& ml_eli == 1
									
gen ml_ben56b = (earning - (50606/12)) * 0.325 		if country == "FI" & year == 2010 ///
													& gender == 1 ///
													& (earning*12) > 50606 & ml_eli == 1
	
	
replace ml_ben56 = ml_ben56a + ml_ben56b 		if country == "FI" & year == 2010 ///
												& gender == 1 & ml_eli == 1 ///
												& ml_ben56 == . ///
												& (earning*12) > 50606 & ml_eli == 1




* IG 49b - annual earnings under €32,892
replace ml_ben49 = earning * 0.7 	if country == "FI" & year == 2010 & gender == 1 ///
									& ml_eli == 1 & ml_ben49 == . ///
									& (earning*12) <= 32892)

* IG 49c - annual earnings between €32,893/year and €56,443/year
gen ml_ben49a = (32893/12) * 0.7 	if country == "FI" & year == 2010 & gender == 1 ///
									& ml_eli == 1 & (earning*12) > 32893
			
gen ml_ben49b = (earning - (32893/12)) * 0.4 		if country == "FI" ///
									& year == 2010	& gender == 1 & ml_eli == 1 ///
									& inrange((earning*12),32893,50606)

replace ml_ben49 = ml_ben49a + ml_ben49b 		if country == "FI" ///
												& year == 2010	& gender == 1 ///
												& ml_eli == 1 & ml_ben49 == . ///
												& inrange((earning*12),32893,50606)			
			
* IG 49d - annual earnings above €50,443	
gen ml_ben49c = (50606/12) * 0.4			if country == "FI" ///
													& year == 2010	& gender == 1 ///
													& ml_eli == 1 & (earning*12) > 50606	
	
gen ml_ben49d = (earning - (50606/12)) * 0.25 		if country == "FI" ///
									& year == 2010	& gender == 1 & ml_eli == 1 ///
									& (earning*12) > 50606	
			

replace ml_ben49 = ml_ben49a + ml_ben49c + ml_ben49d 		if country == "FI" ///
							& year == 2010	& gender == 1 & ml_eli == 1 & ml_ben49 == . ///
							& (earning*12) > 50606	
			

* ML benefit 
replace ml_ben1 = ((ml_ben56 * (56/105) ) + (ml_ben49 * (49/105)))		if country == "FI" ///
												& year == 2010	& gender == 1 & ml_eli == 1 & ml_ben1 == . 


			 
replace ml_ben2 = ml_ben56 		if country == "FI" & year == 2010 & gender == 1 & ml_eli == 1

foreach x in 1 2 {
    replace ml_dur`x' = 0 	if ml_eli == 0 & country == "FI" & year == 2010
	replace ml_ben`x' = 0 	if ml_eli == 0 & country == "FI" & year == 2010
}



drop ml_ben56a ml_ben56b ml_ben49a ml_ben49b ml_ben49c ml_ben49d
