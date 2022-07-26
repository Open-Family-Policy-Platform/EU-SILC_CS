/* PL_2013_CZ_eusilc_cs */


* CZECHIA - 2013

* ELIGIBILITY
/*	-> cash benefits are available to all residents
	-> all employees are entitled to parental leave allowance
*/
	
replace pl_eli = 1 		if country == "CZ" & year == 2013 
replace pl_eli = 0 		if pl_eli == . & country == "CZ" & year == 2013


* DURATION (weeks)
/*	-> parents choose the monthly benefit amount (determines also the duration of PL) 

	-> maximum amount of benefit for the whole period: €8,541
   
	-> 70% of the daily assessment base
	-> ceiling: €442/month 
    
	-> If neither of the parents have social insurance:
		- €292/month until child is 10 months old, €146 until child is 48 months old => duration 4 years
		
	-> the most generous benefit is coded
   
	-> Social insurance is obligatory for employees, voluntary for self-employed (not coded)
	
	-> family entitlement => couples - all assigned to woman
*/


* Daily assessment base

/* daily assessment base (source: MISSOC 2013, IV. Maternity/Paternity):
	
	-> up to €33/day = 100% daily earning
	-> €33 - €50/day = 60% daily earning
	-> €50/day = 30% daily earning  
	-> earning over €100/day are not taken into account
	
*/

** DAILY ASSESSMENT BASE:
* daily earning < €33
gen dab = earning/21.7 				if country == "CZ" & year == 2013 & ml_eli == 1 ///
									& earning/21.7 < 33

* daily earning between €33 and €50
gen dab1 = 33					if country == "CZ" & year == 2013 & ml_eli == 1 ///
									& inrange(earning/21.7,33,50)
gen dab2 = ((earning/21.7) - 33)*0.6 	if country == "CZ" & year == 2013 & ml_eli == 1 ///
										& inrange(earning/21.7,33,50)
replace dab = dab1 + dab2 				if country == "CZ" & year == 2013 & ml_eli == 1 ///
										& inrange(earning/21.7,33,50) & dab == .
drop dab1 dab2
										
* daily earning between €50 and €100										
gen dab1 = 33 						if country == "CZ" & year == 2013 & ml_eli == 1 ///
									& inrange(earning/21.7,50,100)
gen dab2 = (50 - 33)*0.6 			if country == "CZ" & year == 2013 & ml_eli == 1 ///
									& inrange(earning/21.7,50,100)
gen dab3 = ((earning/21.7) - 50)*0.3 	if country == "CZ" & year == 2013 & ml_eli == 1 ///
										& inrange(earning/21.7,50,100)

replace dab = dab1 + dab2 + dab3  	if country == "CZ" & year == 2013 & ml_eli == 1 ///
									& inrange(earning/21.7,50,100) & dab == .									
drop dab1 dab2 dab3 

* daily earning over €100
gen dab1 = 33 						if country == "CZ" & year == 2013 & ml_eli == 1 ///
									& earning/21.7 > 100
gen dab2 = (50 - 33)*0.6 			if country == "CZ" & year == 2013 & ml_eli == 1 ///
									& earning/21.7 > 100
										
gen dab3 = (100 - 50)*0.3 			if country == "CZ" & year == 2013 & ml_eli == 1 ///
									& earning/21.7 > 100

replace dab = dab1 + dab2 + dab3 	if country == "CZ" & year == 2013 & ml_eli == 1 ///
									& earning/21.7 > 100 & dab == . 										
									



*** DURATION
/* 	-> not working: until child is 4 years old
	-> working: parents can choose the monthly amount of benefits -> determines the duration of benefit payment
			-> maximum amount of benefit for the whole period: €8,541
   
	-> if at least one of the parents has social insurance (the code only uses the information about mother):
		-> 70% of the daily assessment base (dab)
		-> ceiling: €442/month 
		-> If neither of the parents have social insurance:
			- €292/month until child is 10 months old, €146 until child is 48 months old => duration 4 years
	-> social insurance compulsory only for employees
	
	-> the duration for working parents is calculated based on the most generous benefits (70% of the daily asssessment base up to a ceiling)
*/	
									
* not employed
	* women
replace pl_dur = 4*52					if country == "CZ" & year == 2013 & pl_eli == 1 ///
										& econ_status != 1 & gender == 1
										
	* single men
replace pl_dur = 4*52					if country == "CZ" & year == 2013 & pl_eli == 1 ///
										& econ_status != 1 & gender == 2 & parstat == 1
										
* employed
	* women
replace pl_dur = (8458 / ((0.7*dab)*21.7)) * 4.3 		if country == "CZ" & year == 2013 & pl_eli == 1 ///
														& econ_status == 1 & gender == 1 & pl_dur == . 
												
	* women - above ceiling
replace pl_dur = (8458 / 442) * 4.3 					if country == "CZ" & year == 2013 & pl_eli == 1 ///
														& econ_status == 1 & gender == 1 & (0.7 * (21.7*dab)) >= 442	

	* single men
replace pl_dur = (8458 / ((0.7*dab)*21.7)) * 4.3 		if country == "CZ" & year == 2013 & pl_eli == 1 ///
														& econ_status == 1 & gender == 2 & pl_dur == . & parstat == 1
														
	* single men - above ceiling
replace pl_dur = (8458 / 442) * 4.3 					if country == "CZ" & year == 2013 & pl_eli == 1 ///
														& econ_status == 1 & gender == 2 & (0.7 * (21.7*dab)) >= 442 & parstat == 1												
														
	* duration longer than 4 years
replace pl_dur = 208 		if country == "CZ" & year == 2013 & pl_eli == 1 ///
							& pl_dur != . & pl_dur >= 208															
																							
									
* BENEFIT (monthly)
/* For explanation see "Duration (weeks)" above. 
 */

* not employed
	* women
replace pl_ben1 = (292 * (10/48)) + (146 * ((48-10)/48)) 				if country == "CZ" & year == 2013 & pl_eli == 1 ///
																		& econ_status != 1 & gender == 1
																		
	* single men
replace pl_ben1 = (292 * (10/48)) + (146 * ((48-10)/48)) 				if country == "CZ" & year == 2013 & pl_eli == 1 ///
																		& econ_status != 1 & gender == 2 & parstat == 1
																		

* employed
	* women
replace pl_ben1 = 0.7 * (21.7*dab)			if country == "CZ" & year == 2013 & pl_eli == 1 ///
											& econ_status == 1 & gender == 1
											
	* women - above ceiling
replace pl_ben1 = 442						if country == "CZ" & year == 2013 & pl_eli == 1 ///
											& econ_status == 1 & gender == 1 & (0.7 * (21.7*dab)) >= 442
											
	* single men
replace pl_ben1 = 0.7 * (21.7*dab)			if country == "CZ" & year == 2013 & pl_eli == 1 ///
											& econ_status == 1 & gender == 2 & parstat == 1
											
	* single men - above ceiling
replace pl_ben1 = 442						if country == "CZ" & year == 2013 & pl_eli == 1 ///
											& econ_status == 1 & gender == 2 & (0.7 * (21.7*dab)) >= 442 ///
											& parstat == 1

							

replace pl_ben2 = pl_ben1 				if country == "CZ" & year == 2013 & pl_eli == 1 
replace pl_ben2 = 292					if country == "CZ" & year == 2013 & pl_eli == 1 ///
										& econ_status != 1 

foreach x in 1 2 {
	replace pl_ben`x' = 0 	if pl_eli == 0 & country == "CZ" & year == 2013
}

replace pl_dur = 0 	if pl_eli == 0 & country == "CZ" & year == 2013

drop dab dab1 dab2 dab3
