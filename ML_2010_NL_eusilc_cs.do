/* ML_2010_NL_eusilc_cs */

* NETHERLANDS - 2010


* ELIGIBILITY
/*	-> employed
	-> self-employed
	
	-> ML can be transferred to father if mother dies => it is assumed that this doesn'that		
		apply to the case when mother abandons the child (not coded)
 */
 
replace ml_eli = 1 		if country == "NL" & year == 2010 & gender == 1 ///
						& inlist(econ_status,1,2)
replace ml_eli = 0 		if ml_eli == . & country == "NL" & year == 2010 & gender == 1 


* DURATION (weeks)
/*	-> prenatal: 4 weeks (compulsory)
	-> total: 16 weeks
 */
replace ml_dur1 = 4 	if country == "NL" & year == 2010 & gender == 1 & ml_eli == 1

replace ml_dur2 = 16-4 	if country == "NL" & year == 2010 & gender == 1 & ml_eli == 1


* BENEFIT (monthly)
/*	-> employed: 100% of daily wage
	-> ceiling: €187.77/day 		
	(MISSOC 01/07/2010)		*/

replace ml_ben1 = earning 		if country == "NL" & year == 2010 & gender == 1 /// 
								& ml_eli == 1 & econ_status == 1 
replace ml_ben1 = 187.77 * 21.7 	if country == "NL" & year == 2010 & gender == 1 ///
									& ml_eli == 1 & econ_status == 1 & ml_ben1 > 187.77  * 21.7

/*	-> self-employed: 100% of the net trading income
	-> ceiling: € 1,407.60 (source: Eurostat (2021) Monthly minimum wages - bi-annual data, 2010-S2)	
	(MISSOC 01/07/2010) */
	
replace ml_ben1 = earning 		if country == "NL" & year == 2010 & gender == 1 /// 
								& ml_eli == 1 & econ_status == 2
							
replace ml_ben1 = 1407.60			if country == "NL" & year == 2010 & gender == 1 /// 
								& ml_eli == 1 & econ_status == 2 & earning >= 1407.60


		
		
replace ml_ben2 = ml_ben1	 if country == "NL" & year == 2010 & gender == 1 /// 
							& ml_eli == 1 
			

foreach x in 1 2 {
    replace ml_dur`x' = 0 	if ml_eli == 0 & country == "NL" & year == 2010
	replace ml_ben`x' = 0 	if ml_eli == 0 & country == "NL" & year == 2010
}

