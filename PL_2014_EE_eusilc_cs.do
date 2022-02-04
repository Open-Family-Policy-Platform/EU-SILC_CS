/* PL_2014_EE_eusilc_cs */

* ESTONIA - 2014

* ELIGIBILITY
/*	-> all residents 
	-> only one parent receives the benefit (i.e. family entitlement)
*/
replace pl_eli = 1	 		if country == "EE" & year == 2014 
replace pl_eli = 0 			if pl_eli == . & country == "EE" & year == 2014


* DURATION (weeks)
/*	-> until child is 3 years old
	-> family entitlement => assigned to women
	-> women eligible for ML => postnatal ML deducted from PL duration
	-> unemployed and inactive parent: benefits paid until child is 18 months old 	
*/

* women	
replace pl_dur = (3*52) - ml_dur2 		if country == "EE" & year == 2014 ///
										& pl_eli == 1 & ml_eli == 1 & gender == 1
										
replace pl_dur = 18 * 4.3 		if country == "EE" & year == 2014 & pl_dur == . ///
								& pl_eli == 1 & inlist(econ_status,3,4) & gender == 1 

								
* single men										
replace pl_dur = 3*52 			if country == "EE" & year == 2014 ///
										& pl_eli == 1 & gender == 2 & parstat == 1
										
replace pl_dur = 18 * 4.3 		if country == "EE" & year == 2014 ///
								& pl_eli == 1 & gender == 2 & parstat == 1 ///
								& inlist(econ_status,3,4)
								


* BENEFIT (monthly)
/*	-> 100% earnings
	-> minimum: €355/month
	-> maximum: €2,378/month		
	-> unemployed and inactive parent: €320
*/

replace pl_ben1 = earning 	if country == "EE" & year == 2014 & pl_eli == 1 ///
							& gender == 1 

replace pl_ben1 = earning 	if country == "EE" & year == 2014 & pl_eli == 1 ///
							& gender == 2 & parstat == 1
								
replace pl_ben1 = 355		if country == "EE" & year == 2014 & pl_eli == 1 ///
							& pl_ben1 < 355 & pl_ben1 != . & pl_ben1 != .
							
replace pl_ben1 = 2378	if country == "EE" & year == 2014 & pl_eli == 1 ///
							& pl_ben1 >= 2378 & pl_ben1 != . 
							
							
replace pl_ben1 = 320 		if country == "EE" & year == 2014 & pl_eli == 1 ///
							& inlist(econ_status,3,4) & gender == 1

replace pl_ben1 = 320 		if country == "EE" & year == 2014 & pl_eli == 1 ///
							& inlist(econ_status,3,4) & gender == 2 & parstat == 1							

replace pl_ben2 = pl_ben1 		if country == "EE" & year == 2014 & pl_eli == 1 

							
							
foreach x in 1 2 {
	replace pl_ben`x' = 0 	if pl_eli == 0 & country == "EE" & year == 2014
}

replace pl_dur = 0 	if pl_eli == 0 & country == "EE" & year == 2014