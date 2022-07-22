/* PT_2020_NO_eusilc_cs */


/*	Norway doesn't recognise ML and PT but only PL with individual entitlements for mother
	and father, and family entitlement. 
	The information here refers to the individual entitlement for fathers (father's quota).
	
*/


* NORWAY - 2020

* ELIGIBILITY
/*	-> employed, self-employed: worked for at least 6 months (coded) during 10 months (not coded) before birth
	
*/

replace pt_eli = 1 			if country == "NO" & year == 2020 & gender == 2 ///
							& (duremp + dursemp) >= 6  

replace pt_eli = 0 			if pt_eli == . & country == "NO" & year == 2020 & gender == 2


* DURATION (weeks)
/*	
	-> father's quota: 15 weeks
*/


replace pt_dur = 15 		if country == "NO" & year == 2020 & pt_eli == 1 



* BENEFIT (monthly)
/*	-> parents can choose between 2 options for the whole leave:
		- 46 weeks on 100% earning (coded)
		- 56 weeks on 80% earning
	-> ceiling: €54,961/year  
*/

replace pt_ben1 = earning 		if country == "NO" & year == 2020 & pt_eli == 1

replace pt_ben1 = 54961/12		if country == "NO" & year == 2020 & pt_eli == 1 ///
								& pt_ben1 >= 54961/12
								


replace pt_ben2 = pt_ben1 		if country == "NO" & year == 2020 & pt_eli == 1





foreach x in 1 2 {
	replace pt_ben`x' = 0 	if country == "NO" & year == 2020 & pt_eli == 0
}

replace pt_dur = 0 		if country == "NO" & year == 2020 & pt_eli == 0 
