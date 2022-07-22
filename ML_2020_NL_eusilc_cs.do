/* ML_2020_NL_eusilc_cs */


* NETHERLANDS - 2020


* ELIGIBILITY
/*	-> employed
	-> self-employed
	
	-> ML can be transferred to father if mother dies => it is assumed that this doesn'that		
		apply to the case when mother abandons the child (not coded)
 */
 
replace ml_eli = 1 		if country == "NL" & year == 2020 & gender == 1 ///
						& inlist(econ_status,1,2)
						
replace ml_eli = 0 		if ml_eli == . & country == "NL" & year == 2020 & gender == 1 


* DURATION (weeks)
/*	-> prenatal: 4 weeks (compulsory)
	-> total: 16 weeks
	-> for self-employed (M2020: Self-employed database)
 */
 
replace ml_dur1 = 4 	if country == "NL" & year == 2020 & gender == 1 & ml_eli == 1

replace ml_dur2 = 16-4 	if country == "NL" & year == 2020 & gender == 1 & ml_eli == 1


* BENEFIT (monthly)
/*	-> employed: 100% 
	-> ceiling: €222.78/day 			
*/

replace ml_ben1 = earning 		if country == "NL" & year == 2020 & gender == 1 /// 
								& ml_eli == 1 & econ_status == 1 
replace ml_ben1 = 222.78 * 21.7 	if country == "NL" & year == 2020 & gender == 1 ///
									& ml_eli == 1 & econ_status == 1 & ml_ben1 > 222.78 * 21.7

									
/*	->self-employed: 100% of the net trading income
	-> ceiling: €1680/month 		 (M2020: Self-employed database)
*/
	
replace ml_ben1 = earning 		if country == "NL" & year == 2020 & gender == 1 /// 
								& ml_eli == 1 & econ_status == 2
							
replace ml_ben1 = 1680 		if country == "NL" & year == 2020 & gender == 1 /// 
								& ml_eli == 1 & econ_status == 2 & earning >= 1680


		
		
replace ml_ben2 = ml_ben1	 if country == "NL" & year == 2020 & gender == 1 /// 
							& ml_eli == 1 
			

foreach x in 1 2 {
    replace ml_dur`x' = 0 	if ml_eli == 0 & country == "NL" & year == 2020
	replace ml_ben`x' = 0 	if ml_eli == 0 & country == "NL" & year == 2020
}

