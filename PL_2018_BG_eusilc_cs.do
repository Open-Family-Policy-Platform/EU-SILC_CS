/* PL_2018_BG_eusilc_cs */


* BULGARIA - 2018

* ELIGIBILITY
/* 	-> 	parents who took pregnancy and childbirth benefit are entitled to 
			a "benefit for raising a small child"
			=> the eligibility condition is identical with maternity leave
			-> employed for at least 12 months before childbirth
			
		-> 	parents who don't fulfill the above-mentioned conditions are entitled 
			to the benefit until the child is 1 year old 
				-> condition: the monthly family income is lower than or equal to €230/person (coded as personal income!)
				
		-> 	if the child is placed in a childcare, the parent is no longer
			entitled to the benefit
			
		-> family entitlement => assigned to women
	
*/

replace pl_eli = 1 	if country == "BG" & year == 2018 & gender == 1 & econ_status == 1 & duremp >= 12
replace pl_eli = 1 	if country == "BG" & year == 2018 & gender == 1 & econ_status == 1 & duremp < 12 & duremp != .
replace pl_eli = 1 	if country == "BG" & year == 2018 & gender == 1 & inrange(econ_status,2,4) & earning < 230

replace pl_eli = 0 	if pl_eli == . & country == "BG" & year == 2018 


* DURATION (weeks)
/*	-> employed for at least 12 months: 
		-> 1st, 2nd, 3rd child: until the child is 2 years old
		-> 4th + children: 6 months (not coded)
		
	-> mothers who don't fulfill the above-mentioned conditions:
		-> until the child is 1 year old
		-> condition: the monthly family income is lower than or equal to €230/person (coded as personal income!)
*/
 
	* employed mothers for at least 12 months
replace pl_dur = (2*52) - ml_dur2 		if country == "BG" & year == 2018 & pl_eli == 1 ///
										& gender == 1 & econ_status == 1 & duremp >= 12 ///
										& ml_eli == 1
										
	* not fulfiling the employment requirement
replace pl_dur = 52 		if country == "BG" & year == 2018 & pl_eli == 1 ///
							& gender == 1 & pl_dur == . & pl_eli == 1 & earning <= 230




* BENEFIT (monthly)
/*	-> women employed for at least 12 months: €194/month
	-> all other women: €51/month
	Source: MISSOC 01/07/2018*/
   
replace pl_ben1 = 194	 if country == "BG" & year == 2018 & pl_eli == 1 ///
						 & gender == 1 & econ_status == 1 & duremp >= 12
replace pl_ben1 = 51	 if country == "BG" & year == 2018 & pl_eli == 1 ///
						 & gender == 1 & pl_ben1 == . & pl_eli == 1 


replace pl_ben2 = pl_ben1 	if country == "BG" & year == 2018 & pl_eli == 1 ///
							& gender == 1

							
foreach x in 1 2 {
	replace pl_ben`x' = 0 	if pl_eli == 0 & country == "BG" & year == 2018
}

replace pl_dur = 0 	if pl_eli == 0 & country == "BG" & year == 2018
