/* PL_2012_BG_eusilc_cs */


* BULGARIA - 2012

* ELIGIBILITY
/* -> 	parents who took pregnancy and childbirth benefit are entitled to 
			a "benefit for raising a small child"
			=> the eligibility condition is identical with maternity leave
			-> employed for at least 12 months before childbirth
			
		-> 	if the child is placed in a childcare, the parent is no longer
			entitled to the benefit
			
		-> family entitlement => assigned to women
*/

replace pl_eli = 1  	if country == "BG" & year == 2011 & gender == 1 ///
						& econ_status == 1 & duremp >= 12
replace pl_eli = 0 	if pl_eli == . & country == "BG" & year == 2012 


* DURATION (weeks)
/*	-> 1st, 2nd, 3rd child: until the child is 2 years old
	-> 4th + children: 6 months (not coded)
*/
   
replace pl_dur = (2*52) - ml_dur2 		if country == "BG" & year == 2012 & pl_eli == 1 ///
										& gender == 1 & econ_status == 1 & duremp >= 12 ///
										& ml_eli == 1



* BENEFIT (monthly)
/*	-> €123/month
	Source: MISSOC 01/07/2011*/
   
replace pl_ben1 =  123	 if country == "BG" & year == 2012 & pl_eli == 1 ///
						 & gender == 1 


replace pl_ben2 = pl_ben1 	if country == "BG" & year == 2012 & pl_eli == 1 ///
							& gender == 1

							
foreach x in 1 2 {
	replace pl_ben`x' = 0 	if pl_eli == 0 & country == "BG" & year == 2012
}

replace pl_dur = 0 	if pl_eli == 0 & country == "BG" & year == 2012
