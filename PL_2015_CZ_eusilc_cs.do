/* PL_2015_CZ_eusilc_cs */


* CZECHIA - 2015

* ELIGIBILITY
/*	-> cash benefits are available to all residents
	-> all employees are entitled to parental leave 
*/
	
replace pl_eli = 1 		if country == "CZ" & year == 2015 
replace pl_eli = 0 		if pl_eli == . & country == "CZ" & year == 2015

* DURATION (weeks)
/*	-> parents choose the monthly benefit amount (determines also the duration of PL) 

	-> maximum amount of benefit for the whole period: €8,075
   
	-> 70% of the daily assessment base
	-> ceiling: €422/month 
    
	-> The benefit is calculated from the higher daily assessment base (if man's dab is higher, it is calculated
   from his daily assessment base; if woman's dab is higher, it is calculated from hers).
	-> If neither of the parents have social insurance:
		- €279/month until child is 10 months old
		- €139/month after child is 10 months old until they are 48 months old
		
	-> the most generous benefit is coded
   
	-> Social insurance is obligatory for employees, voluntary for self-employed (not coded)
	
	-> family entitlement => couples - all assigned to woman
*/


* Daily assessment base

/* daily assessment base (source: MISSOC 2015, IV. Maternity/Paternity):
	
	-> up to €33/day = 100% daily earning
	-> €33 - €49/day = 60% daily earning
	-> €49/day - €98/day = 30% daily earning  
	-> earning over €98/day are not taken into account
	
	NOTE: 	DAB calculated in ML section
			Here only DAB for partner's variables (p_*)
*/

** DAILY ASSESSMENT BASE:
* daily earning < €33
gen dab = earning/21.7 				if country == "CZ" & year == 2015 & ml_eli == 1 ///
									& earning/21.7 < 33

* daily earning between €33 and €49
gen dab1 = 33					if country == "CZ" & year == 2015 & ml_eli == 1 ///
									& inrange(earning/21.7,33,49)
gen dab2 = ((earning/21.7) - 33)*0.6 	if country == "CZ" & year == 2015 & ml_eli == 1 ///
										& inrange(earning/21.7,33,49)
replace dab = dab1 + dab2 				if country == "CZ" & year == 2015 & ml_eli == 1 ///
										& inrange(earning/21.7,33,49) & dab == .
drop dab1 dab2
										
* daily earning between €49 and €98										
gen dab1 = 33 						if country == "CZ" & year == 2015 & ml_eli == 1 ///
									& inrange(earning/21.7,49,98)
gen dab2 = (49 - 33)*0.6 			if country == "CZ" & year == 2015 & ml_eli == 1 ///
									& inrange(earning/21.7,49,98)
gen dab3 = ((earning/21.7) - 49)*0.3 	if country == "CZ" & year == 2015 & ml_eli == 1 ///
										& inrange(earning/21.7,49,98)

replace dab = dab1 + dab2 + dab3  	if country == "CZ" & year == 2015 & ml_eli == 1 ///
									& inrange(earning/21.7,49,98) & dab == .									
drop dab1 dab2 dab3 

* daily earning over €98
gen dab1 = 33 						if country == "CZ" & year == 2015 & ml_eli == 1 ///
									& earning/21.7 > 98
gen dab2 = (49 - 33)*0.6 			if country == "CZ" & year == 2015 & ml_eli == 1 ///
									& earning/21.7 > 98
										
gen dab3 = (98 - 49)*0.3 			if country == "CZ" & year == 2015 & ml_eli == 1 ///
									& earning/21.7 > 98

replace dab = dab1 + dab2 + dab3 	if country == "CZ" & year == 2015 & ml_eli == 1 ///
									& earning/21.7 > 98 & dab == . 										
					
					
*** DURATION
/* -> maximum amount of benefit for the whole period: €8,075
   
	-> if at least one of the parents has social insurance:
		-> 70% of the daily assessment base (dab)
		-> ceiling: €422/month 
		-> If neither of the parents have social insurance: €279/month
	-> social insurance compulsory only for employees
*/
									
* not employed
	* women
replace pl_dur = 4*52					if country == "CZ" & year == 2015 & pl_eli == 1 ///
										& econ_status != 1 & gender == 1
										
	* single men
replace pl_dur = 4*52					if country == "CZ" & year == 2015 & pl_eli == 1 ///
										& econ_status != 1 & gender == 2 & parstat == 1
										
* employed
	* women
replace pl_dur = (8075 / ((0.7*dab)*21.7)) * 4.3 		if country == "CZ" & year == 2015 & pl_eli == 1 ///
														& econ_status == 1 & gender == 1 & pl_dur == . 
												
	* women - above ceiling
replace pl_dur = (8075 / 422) * 4.3 					if country == "CZ" & year == 2015 & pl_eli == 1 ///
														& econ_status == 1 & gender == 1 & (0.7 * (21.7*dab)) >= 422	

	* single men
replace pl_dur = (8075 / ((0.7*dab)*21.7)) * 4.3 		if country == "CZ" & year == 2015 & pl_eli == 1 ///
														& econ_status == 1 & gender == 2 & pl_dur == . & parstat == 1
														
	* single men - above ceiling
replace pl_dur = (8075 / 422) * 4.3 					if country == "CZ" & year == 2015 & pl_eli == 1 ///
														& econ_status == 1 & gender == 2 & (0.7 * (21.7*dab)) >= 422 & parstat == 1												
			
	* duration longer than 4 years
replace pl_dur = 208 		if country == "CZ" & year == 2015 & pl_eli == 1 ///
							& pl_dur != . & pl_dur >= 208	
	
	


* BENEFIT (monthly)
/* For explanation see "Duration (weeks)" above. 
   pl_ben2/3 refer to the most generous benefit 		*/

* not employed
	* women
replace pl_ben1 = (279 * (10/48)) + (138 * ((48-10)/48)) 				if country == "CZ" & year == 2015 & pl_eli == 1 ///
																		& econ_status != 1 & gender == 1
																		
	* single men
replace pl_ben1 = (279 * (10/48)) + (138 * ((48-10)/48)) 				if country == "CZ" & year == 2015 & pl_eli == 1 ///
																		& econ_status != 1 & gender == 2 & parstat == 1
																		

* employed
	* women
replace pl_ben1 = 0.7 * (21.7*dab)			if country == "CZ" & year == 2015 & pl_eli == 1 ///
											& econ_status == 1 & gender == 1
											
	* women - above ceiling
replace pl_ben1 = 422						if country == "CZ" & year == 2015 & pl_eli == 1 ///
											& econ_status == 1 & gender == 1 & (0.7 * (21.7*dab)) >= 422
											
	* single men
replace pl_ben1 = 0.7 * (21.7*dab)			if country == "CZ" & year == 2015 & pl_eli == 1 ///
											& econ_status == 1 & gender == 2 & parstat == 1
											
	* single men - above ceiling
replace pl_ben1 = 422						if country == "CZ" & year == 2015 & pl_eli == 1 ///
											& econ_status == 1 & gender == 2 & (0.7 * (21.7*dab)) >= 422 ///
											& parstat == 1

							

replace pl_ben2 = pl_ben1 				if country == "CZ" & year == 2015 & pl_eli == 1 
replace pl_ben2 = 279					if country == "CZ" & year == 2015 & pl_eli == 1 ///
										& econ_status != 1 
										
			

foreach x in 1 2 {
	replace pl_ben`x' = 0 	if pl_eli == 0 & country == "CZ" & year == 2015
}

replace pl_dur = 0 	if pl_eli == 0 & country == "CZ" & year == 2015

drop dab dab1 dab2 dab3 
