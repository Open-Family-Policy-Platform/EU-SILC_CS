/* ML_2010_BG_eusilc_cs */


* BULGARIA - 2010

* ELIGIBILITY
/*	-> 	parents who took pregnancy and childbirth benefit are entitled to 
			a "benefit for raising a small child"
			=> the eligibility condition is identical with maternity leave
			
		-> 	if the child is placed in a childcare, the parent is no longer
			entitled to the benefit
			
		-> family entitlement => assigned to women
*/

replace ml_eli = 1  	if country == "BG" & year == 2010 & gender == 1 ///
						& econ_status == 1 & duremp >= 12
						
replace ml_eli = 0 		if ml_eli == . & country == "BG" & year == 2010 & gender == 1


* DURATION (weeks)
/* 	-> total leave = 410 days
	-> prenatal leave = 45 days				*/
	
replace ml_dur1 = 45/5 			if country == "BG" & year == 2010 & gender == 1 & ml_eli == 1

replace ml_dur2 = (410-45)/5 	if country == "BG" & year == 2010 & gender == 1 & ml_eli == 1


* BENEFIT (monthly)
/*	-> 90% earning 
*/ 

replace ml_ben1 = earning * 0.9 		if country == "BG" & year == 2010 ///
										& gender == 1 & ml_eli == 1 
				
				
replace ml_ben2 = ml_ben1 	if country == "BG" & year == 2010 & gender == 1 & ml_eli == 1


foreach x in 1 2 {
    replace ml_dur`x' = 0 	if ml_eli == 0 & country == "BG" & year == 2010
	replace ml_ben`x' = 0 	if ml_eli == 0 & country == "BG" & year == 2010
}

