/* PL_2018_CZ_eusilc_cs */


* CZECHIA - 2018

* ELIGIBILITY
/*	-> cash benefits are available to all residents
	-> all employees are entitled to parental leave 
*/
	
replace pl_eli = 1 		if country == "CZ" & year == 2018 
replace pl_eli = 0 		if pl_eli == . & country == "CZ" & year == 2018

* DURATION (weeks)
/*	-> parents choose the monthly benefit amount (determines also the duration of PL) 

	-> maximum amount of benefit for the whole period: €8,461
   
	-> 70% of the daily assessment base
	-> ceiling: €1,255/month 
    
	-> The benefit is calculated from the higher daily assessment base (if man's dab is higher, it is calculated
   from his daily assessment base; if woman's dab is higher, it is calculated from hers).
	-> If neither of the parents have social insurance:
		- €292/month
		
	-> the most generous benefit is coded
   
	-> Social insurance is obligatory for employees, voluntary for self-employed (not coded)
	
	-> family entitlement => couples - all assigned to woman
*/


* Daily assessment base

/* daily assessment base (source: MISSOC 2018, IV. Maternity/Paternity):
	
	-> up to €38/day = 100% daily earning
	-> €38 - €58/day = 60% daily earning
	-> €58/day = 30% daily earning  
	-> earning over €115/day are not taken into account
	
	NOTE: 	DAB calculated in ML section
			Here only DAB for partner's variables (p_*)
*/

** DAILY ASSESSMENT BASE:
* daily earning < €38
gen dab = earning/21.7 				if country == "CZ" & year == 2018 & ml_eli == 1 ///
									& earning/21.7 < 38

* daily earning between €38 and €58
gen dab1 = 38 						if country == "CZ" & year == 2018 & ml_eli == 1 ///
									& inrange(earning/21.7,38,57)
gen dab2 = ((earning/21.7) - 38)*0.6 	if country == "CZ" & year == 2018 & ml_eli == 1 ///
										& inrange(earning/21.7,38,57)
replace dab = dab1 + dab2 				if country == "CZ" & year == 2018 & ml_eli == 1 ///
										& inrange(earning/21.7,38,57) & dab == .
drop dab1 dab2
										
* daily earning between €58 adn €115										
gen dab1 = 38 						if country == "CZ" & year == 2018 & ml_eli == 1 ///
									& inrange(earning/21.7,58,115)
gen dab2 = (58 - 38)*0.6 			if country == "CZ" & year == 2018 & ml_eli == 1 ///
									& inrange(earning/21.7,58,115)
gen dab3 = ((earning/21.7) - 58)*0.3 	if country == "CZ" & year == 2018 & ml_eli == 1 ///
										& inrange(earning/21.7,58,115)

replace dab = dab1 + dab2 + dab3  	if country == "CZ" & year == 2018 & ml_eli == 1 ///
									& inrange(earning/21.7,58,115) & dab == .									
drop dab1 dab2 dab3 

* daily earning over €115
gen dab1 = 38 						if country == "CZ" & year == 2018 & ml_eli == 1 ///
									& earning/21.7 > 115
gen dab2 = (58 - 38)*0.6 			if country == "CZ" & year == 2018 & ml_eli == 1 ///
									& earning/21.7 > 115
										
gen dab3 = (115 - 58)*0.3 			if country == "CZ" & year == 2018 & ml_eli == 1 ///
									& earning/21.7 > 115

replace dab = dab1 + dab2 + dab3 	if country == "CZ" & year == 2018 & ml_eli == 1 ///
									& earning/21.7 > 115 & dab == . 										
										
			


*** DURATION
/* -> maximum amount of benefit for the whole period: €8,461  
   
	-> if at least one of the parents has social insurance:
		-> 70% of the daily assessment base (dab)
		-> ceiling: €1,255/month 
		-> If neither of the parents have social insurance: €292/month
	-> social insurance compulsory only for employees
*/	
									
* not employed
	* women
replace pl_dur = 4*52					if country == "CZ" & year == 2018 & pl_eli == 1 ///
										& econ_status != 1 & gender == 1
										
	* single men
replace pl_dur = 4*52					if country == "CZ" & year == 2018 & pl_eli == 1 ///
										& econ_status != 1 & gender == 2 & parstat == 1
										
* employed
	* women
replace pl_dur = (8461 / ((0.7*dab)*21.7)) * 4.3 		if country == "CZ" & year == 2018 & pl_eli == 1 ///
														& econ_status == 1 & gender == 1 & pl_dur == . 
												
	* women - above ceiling
replace pl_dur = (8461 / 1255) * 4.3 					if country == "CZ" & year == 2018 & pl_eli == 1 ///
														& econ_status == 1 & gender == 1 & (0.7 * (21.7*dab)) >= 1255	

	* single men
replace pl_dur = (8461 / ((0.7*dab)*21.7)) * 4.3 		if country == "CZ" & year == 2018 & pl_eli == 1 ///
														& econ_status == 1 & gender == 2 & pl_dur == . & parstat == 1
														
	* single men - above ceiling
replace pl_dur = (8461 / 1255) * 4.3 					if country == "CZ" & year == 2018 & pl_eli == 1 ///
														& econ_status == 1 & gender == 2 & (0.7 * (21.7*dab)) >= 1255 & parstat == 1												
	* duration longer than 4 years
replace pl_dur = 208 		if country == "CZ" & year == 2018 & pl_eli == 1 ///
							& pl_dur != . & pl_dur >= 208				

	
	


* BENEFIT (monthly)
/* For explanation see "Duration (weeks)" above. 
   pl_ben2/3 refer to the most generous benefit 		*/

* not employed
	* women
replace pl_ben1 = 292 				if country == "CZ" & year == 2018 & pl_eli == 1 ///
																		& econ_status != 1 & gender == 1
																		
	* single men
replace pl_ben1 = 292 				if country == "CZ" & year == 2018 & pl_eli == 1 ///
																		& econ_status != 1 & gender == 2 & parstat == 1
																		

* employed
	* women
replace pl_ben1 = 0.7 * (21.7*dab)			if country == "CZ" & year == 2018 & pl_eli == 1 ///
											& econ_status == 1 & gender == 1
											
	* women - above ceiling
replace pl_ben1 = 1255						if country == "CZ" & year == 2018 & pl_eli == 1 ///
											& econ_status == 1 & gender == 1 & (0.7 * (21.7*dab)) >= 1255
											
	* single men
replace pl_ben1 = 0.7 * (21.7*dab)			if country == "CZ" & year == 2018 & pl_eli == 1 ///
											& econ_status == 1 & gender == 2 & parstat == 1
											
	* single men - above ceiling
replace pl_ben1 = 1255						if country == "CZ" & year == 2018 & pl_eli == 1 ///
											& econ_status == 1 & gender == 2 & (0.7 * (21.7*dab)) >= 1255 ///
											& parstat == 1

							

replace pl_ben2 = pl_ben1 				if country == "CZ" & year == 2018 & pl_eli == 1 
			
			
   
foreach x in 1 2 {
	replace pl_ben`x' = 0 	if pl_eli == 0 & country == "CZ" & year == 2018
}

replace pl_dur = 0 	if pl_eli == 0 & country == "CZ" & year == 2018

drop dab dab1 dab2 dab3 
