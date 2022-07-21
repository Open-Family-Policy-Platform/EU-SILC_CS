/* ML_2014_NO_eusilc_cs */

/*	Norway doesn't recognise ML and PT but only PL with individual entitlements for mother
	and father, and family entitlement. 
	The information here refers to the individual entitlement for mothers (mother's quota).
*/

* NORWAY - 2014

* ELIGIBILITY
/*	-> employed, self-employed: worked for at least 6 months (coded) during 10 months (not coded) before birth
	-> inactive women: maternity grant
*/

replace ml_eli = 1 			if country == "NO" & year == 2014 & gender == 1 

replace ml_eli = 0 			if ml_eli == . & country == "NO" & year == 2014 & gender == 1


* DURATION (weeks)
/*	
	-> mother's quota: 10 weeks
		-> prenatal: 3 weeks 
		-> postnatal: 7 weeks 

*/

replace ml_dur1 = 3 		if country == "NO" & year == 2014 & ml_eli == 1 & gender == 1

replace ml_dur2 = 7 		if country == "NO" & year == 2014 & ml_eli == 1 & gender == 1
														
	
				
* BENEFIT (monthly)
/*	-> parents can choose between 2 options for the whole leave:
		- 46 weeks on 100% earning (coded)
		- 56 weeks on 80% earning
	-> ceiling: €63,363/year
	-> minimum: maternity grant - €4,631 for the whole period (11 months)
*/
	
replace ml_ben1 = earning 		if country == "NO" & year == 2014 & ml_eli == 1
replace ml_ben1 = 63363/12			if country == "NO" & year == 2014 & ml_eli == 1 ///
								& ml_ben1 >= 63363/12
replace ml_ben1 = 4631/11			if country == "NO" & year == 2014 & ml_eli == 1 ///
								& ml_ben1 < 4631/11


replace ml_ben2 = ml_ben1 		if country == "NO" & year == 2014 & ml_eli == 1


foreach x in 1 2 {
	replace ml_dur`x' = 0 	if country == "NO" & year == 2014 & ml_eli == 0
	replace ml_ben`x' = 0 	if country == "NO" & year == 2014 & ml_eli == 0
	
}
