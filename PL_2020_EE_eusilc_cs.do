/* PL_2020_EE_eusilc_cs */


* ESTONIA - 2020

* ELIGIBILITY
/*	-> all residents are entitled to benefit
	-> family entitlement
	-> only one parent receives the benefit 
*/
replace pl_eli = 1	 		if country == "EE" & year == 2020 
replace pl_eli = 0 			if pl_eli == . & country == "EE" & year == 2020


* DURATION (weeks)
/*	-> until child is 3 years old
	-> family entitlement => assigned to women
	-> women eligible for ML => postnatal ML deducted from PL duration
	-> unemployed and inactive parent: benefits paid until child is 18 months old (LP&R)	
*/

* women	
replace pl_dur = (3*52) - ml_dur2 		if country == "EE" & year == 2020 ///
										& pl_eli == 1 & ml_eli == 1 & gender == 1
										
replace pl_dur = 18 * 4.3 				if country == "EE" & year == 2020 & pl_dur == . ///
										& pl_eli == 1 & gender == 1 & inlist(econ_status,3,4)

								
* single men										
replace pl_dur = 3*52 			if country == "EE" & year == 2020 ///
								& pl_eli == 1 & gender == 2 & parstat == 1
replace pl_dur = 18 * 4.3 		if country == "EE" & year == 2020 ///
								& pl_eli == 1 & gender == 2 & parstat == 1 ///
								& inlist(econ_status,3,4)
								


* BENEFIT (monthly)
/*	-> parental benefit:
		-> eligible for ML: 
			-> 435 days (LP&R 2020)
			-> 100% earnings
			-> minimum: €584/month
			-> maximum: €3,548.1/month	
		-> not eligible for ML: 
			-> 575 days (MISSOC 2020)
			-> €540/month (LP&R 2020)
	
	-> child care allowance:
		-> from the end of parental benefit until child is 3 years old
		-> €76.7/month  (data from MISSOC 2016; according to LP&R, the value of the benefit 
			didn't change over time => kept the original MISSOC value)
*/

* women
replace pl_ben1 = (earning * (435/(3*365)) + (76.7 * ((3*365)-435)/(3*365)) 	if country == "EE" & year == 2020 & pl_eli == 1 ///
																			& gender == 1 
																			
* single men							
replace pl_ben1 = (earning * (435/(3*365)) + (76.7 * ((3*365)-435)/(3*365)) 	if country == "EE" & year == 2020 & pl_eli == 1 ///
																			& gender == 2 & parstat == 1
																			
	* minimum 
replace pl_ben1 = (584 * (435/(3*365)) + (76.7 * ((3*365)-435)/(3*365))		if country == "EE" & year == 2020 & pl_eli == 1 ///
																			& earning < 584 & pl_ben1 != . & pl_ben1 != .

	* maximum
replace pl_ben1 = (3548.1	* (435/(3*365)) + (76.7 * ((3*365)-435)/(3*365)) 		if country == "EE" & year == 2020 & pl_eli == 1 ///
																			& earnings >= 3548.1 & pl_ben1 != . 
							
																			

* not eligible for maternity leave
	* women
replace pl_ben1 = (540 * (435/(3*365)) + (76.7 * ((3*365)-435)/(3*365)) 		if country == "EE" & year == 2020 & pl_eli == 1 ///
																			& inlist(econ_status,3,4) & gender == 1
	* single men
replace pl_ben1 = (540 * (435/(3*365)) + (76.7 * ((3*365)-435)/(3*365)) 		if country == "EE" & year == 2020 & pl_eli == 1 ///
																			& inlist(econ_status,3,4) & gender == 2 & parstat == 1							


	
	
* women
replace pl_ben2 = earning  		if country == "EE" & year == 2020 & pl_eli == 1 ///
								& gender == 1 
																			
* single men							
replace pl_ben2 = earning  		if country == "EE" & year == 2020 & pl_eli == 1 ///
								& gender == 2 & parstat == 1
																			
	* minimum 
replace pl_ben2 = 584 			if country == "EE" & year == 2020 & pl_eli == 1 ///
								& earnings < 430 & pl_ben2 != . & pl_ben1 != .

	* maximum
replace pl_ben2 = 3548.1	 		if country == "EE" & year == 2020 & pl_eli == 1 ///
								& earnings >= 3548.1 & pl_ben1 != . 
							
																			

* not eligible for maternity leave
	* women
replace pl_ben2 = 	430  		if country == "EE" & year == 2020 & pl_eli == 1 ///
								& inlist(econ_status,3,4) & gender == 1
	* single men
replace pl_ben2 = 430	 		if country == "EE" & year == 2020 & pl_eli == 1 ///
								& inlist(econ_status,3,4) & gender == 2 & parstat == 1							
																			
							
foreach x in 1 2 {
	replace pl_ben`x' = 0 	if pl_eli == 0 & country == "EE" & year == 2020
}

replace pl_dur = 0 	if pl_eli == 0 & country == "EE" & year == 2020
