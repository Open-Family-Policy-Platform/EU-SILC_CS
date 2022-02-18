/* ML_2014_GB_eusilc_cs */


* UK - 2014

* ELIGIBILITY
/*	-> employed (statutory maternity pay), self-employed (maternity allowance): 
		- for 26 weeks into the 15th week before due date
		- earning at least €37/week (maternity alllowance; statutory maternity pay has condition of €139/week)
	-> further restrictions for entitlement to cash benefits
	
	-> part of ML can be shared with the father (shared parental leave) if:
		- mother: 
			- employed by the same employer for at least 26 weeks 
		- father/partner:
			- employed or self-employed for at least 26 weeks into the 15th week before due date
			- earned at least €139 (coded) in total during 15 weeks (not coded) before the birth
	-> single fathers are not entitled to shared parental leave because it is 
	   dependent on the mother's economic status
*/

replace ml_eli = 1 			if country == "GB" & year == 2014 & gender == 1 ///
							& inlist(econ_status,1,2) & (earning/4.3) >= 37 ///
							& (duremp+dursemp) >= 26/4.3

* father's eligibility for shared parental leave 
replace ml_eli = 1 			if country == "GB" & year == 2014 & gender == 2 ///
							& inlist(econ_status,1,2) & (duremp+dursemp) >= 26/4.3 ///
							& (earning/4.3) >= 139 & p_econ_status == 1 ///
							& (p_duremp+p_dursemp) >= 26/4.3
							
replace ml_eli = 0 			if ml_eli == . & country == "GB" & year == 2014 & gender == 1

* DURATION (weeks)
/*	-> employed if (for paid leave):
		- employed by the same employer (not coded)
		- for 26 weeks 
		- average weekly earnings at least €139
		- duration: 52 weeks  
		
	-> self-employed and employed if
		- working for at least 26 weeks (coded) in the 66 weeks before birth (not coded)
		- average weekly earnings at least €37
		- duration: 39 weeks
		
	-> no compulsory prenatal leave (can take up to 11 weeks)
	
	-> shared parental leave: 50 weeks (without 2 compulsory weeks of ML)
		- not exclusive right of the father => not coded 
	
*/

replace ml_dur1 = 0 		if country == "GB" & year == 2014 & ml_eli == 1 & gender == 1

replace ml_dur2 = 52 		if country == "GB" & year == 2014 & ml_eli == 1 ///
							& econ_status == 1 & duremp >= 26/4.3 ///
							& (earning/4.3) >= 139 & gender == 1
							
replace ml_dur2 = 39		if country == "GB" & year == 2014 & ml_eli == 1 ///
							& inlist(econ_status,1,2) & ml_dur2 == . ///
							& (earning/4.3) >= 39 & gender == 1



* BENEFIT (monthly)
/*	->  employed women who fulfil the stricter conditions (see "Duration"; statutory maternity pay):
			- 6 weeks: 90% earnings (taxed)
			- 33 weeks: 90% earnings (taxed)
				- ceiling: €170/week 
			- 13 weeks: unpaid
			
	-> employed and self-employed (maternity allowance):
			-39 weeks: 90% earning (not taxed)
				- ceiling: €170/week 
*/


* statutory maternity pay

replace ml_ben1 = (0.9 * earning) * ((6+33)/52) 		if country == "GB" & year == 2014 & ml_eli == 1 ///
														& econ_status == 1 & duremp >= 26/4.3 ///
														& (earning/4.3) >= 139 & gender == 1


	* above ceiling
replace ml_ben1 = ((0.9 * earning) * (6/52)) + ((170 * 4.3) * (33/52)) 	if country == "GB" & year == 2014 ///
																		& ml_eli == 1 & (0.9*earning) >= (170*4.3)
																		
* maternity allowance 
replace ml_ben1 = (0.9 * earning) 		if country == "GB" & year == 2014 & ml_eli == 1 ///
										& inlist(econ_status,1,2) & ml_dur2 == . ///
										& (earning/4.3) >= 37 & (earning/4.3) < 139 & gender == 1 
										
	* above ceiling
replace ml_ben1 = 170 * 4.3				if country == "GB" & year == 2014 & ml_eli == 1 ///
										& inlist(econ_status,1,2) & ml_dur2 == . ///
										& (earning/4.3) >= 37 & (earning/4.3) < 139 & gender == 1 & (0.9*earning) >= (170*4.3)


	
	
	

* statutory maternity pay - 1st month										
replace ml_ben2 = 0.9 * earning 			if country == "GB" & year == 2014 & ml_eli == 1 & gender == 1
											
replace ml_ben2 = 170 * 4.3 				if country == "GB" & year == 2014 & ml_eli == 1 ///
											& inlist(econ_status,1,2) & ml_dur2 == . ///
											& (earning/4.3) >= 37 & (earning/4.3) < 139 & gender == 1 & (0.9*earning) >= (170*4.3)
										
replace ml_ben2 = ml_ben1 				if country == "GB" & year == 2014 & ml_eli == 1 ///
										& ml_dur2 == 39							
										
										

										
										
foreach x in 1 2 {
	replace ml_dur`x' = 0 	if country == "GB" & year == 2014 & ml_eli == 0
	replace ml_ben`x' = 0 	if country == "GB" & year == 2014 & ml_eli == 0
	
}

