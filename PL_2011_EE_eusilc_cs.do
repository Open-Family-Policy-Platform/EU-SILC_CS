/* PL_2011_EE_eusilc_cs */

* ESTONIA - 2011

* ELIGIBILITY
/*	-> all residents are entitled to benefit
	-> family entitlement
	-> only one parent receives the benefit 
*/
replace pl_eli = 1	 		if country == "EE" & year == 2011 
replace pl_eli = 0 			if pl_eli == . & country == "EE" & year == 2011


* DURATION (weeks)
/*	-> until child is 3 years old
	-> family entitlement => assigned to women
	-> women eligible for ML => postnatal ML deducted from PL duration
	-> unemployed and inactive parent: benefits paid until child is 18 months old (LP&R)
*/

* women	
replace pl_dur = (3*52) - ml_dur2 		if country == "EE" & year == 2011 ///
										& pl_eli == 1 & ml_eli == 1 & gender == 1
										
replace pl_dur = 18 * 4.3 		if country == "EE" & year == 2011 & pl_dur == . ///
								& pl_eli == 1 & inlist(econ_status,3,4) & gender == 1 

								
* single men										
replace pl_dur = 3*52 			if country == "EE" & year == 2011 ///
										& pl_eli == 1 & gender == 2 & parstat == 1
										
replace pl_dur = 18 * 4.3 		if country == "EE" & year == 2011 ///
								& pl_eli == 1 & gender == 2 & parstat == 1 ///
								& inlist(econ_status,3,4)
								


* BENEFIT (monthly)
/*	-> parental benefit:
		-> eligible for ML: 
			-> 435 days (LP&R 2011)
			-> 100% earning
			-> minimum: €278/month
			-> maximum: €2,157/month	
		-> not eligible for ML: 
			-> 575 days (MISSOC 2011)
			-> €278/month (LP&R 2011)
	
	-> child care allowance:
		-> from the end of parental benefit until child is 3 years old
		-> €76.7/month
*/

* women
replace pl_ben1 = (earning * (435/(3*365))) + (76.7 * ((3*365)-435)/(3*365)) 	if country == "EE" & year == 2011 & pl_eli == 1 ///
																			& gender == 1 
																			
* single men							
replace pl_ben1 = (earning * (435/(3*365))) + (76.7 * ((3*365)-435)/(3*365)) 	if country == "EE" & year == 2011 & pl_eli == 1 ///
																			& gender == 2 & parstat == 1
																			
	* minimum 
replace pl_ben1 = (278 * (435/(3*365))) + (76.7 * ((3*365)-435)/(3*365))		if country == "EE" & year == 2011 & pl_eli == 1 ///
																			& earning < 278 & pl_ben1 != . & pl_ben1 != .

	* maximum
replace pl_ben1 = (2157	* (435/(3*365))) + (76.7 * ((3*365)-435)/(3*365)) 		if country == "EE" & year == 2011 & pl_eli == 1 ///
																			& earning >= 2157 & pl_ben1 != . 
							
																			

* not eligible for maternity leave
	* women
replace pl_ben1 = (278 * (435/(3*365))) + (76.7 * ((3*365)-435)/(3*365)) 		if country == "EE" & year == 2011 & pl_eli == 1 ///
																			& inlist(econ_status,3,4) & gender == 1
	* single men
replace pl_ben1 = (278 * (435/(3*365))) + (76.7 * ((3*365)-435)/(3*365)) 		if country == "EE" & year == 2011 & pl_eli == 1 ///
																			& inlist(econ_status,3,4) & gender == 2 & parstat == 1							


	
	
* women
replace pl_ben2 = earning  		if country == "EE" & year == 2011 & pl_eli == 1 ///
								& gender == 1 
																			
* single men							
replace pl_ben2 = earning  		if country == "EE" & year == 2011 & pl_eli == 1 ///
								& gender == 2 & parstat == 1
																			
	* minimum 
replace pl_ben2 = 278 			if country == "EE" & year == 2011 & pl_eli == 1 ///
								& earning < 278 & pl_ben2 != . & pl_ben1 != .

	* maximum
replace pl_ben2 = 2157	 		if country == "EE" & year == 2011 & pl_eli == 1 ///
								& earning >= 2157 & pl_ben1 != . 
							
																			

* not eligible for maternity leave
	* women
replace pl_ben2 = 	278  		if country == "EE" & year == 2011 & pl_eli == 1 ///
								& inlist(econ_status,3,4) & gender == 1
	* single men
replace pl_ben2 = 278	 		if country == "EE" & year == 2011 & pl_eli == 1 ///
								& inlist(econ_status,3,4) & gender == 2 & parstat == 1							
																			


							
							
foreach x in 1 2 {
	replace pl_ben`x' = 0 	if pl_eli == 0 & country == "EE" & year == 2011
}

replace pl_dur = 0 	if pl_eli == 0 & country == "EE" & year == 2011
