/* PL_2020_CZ_eusilc_cs */


* CZECHIA - 2020

* ELIGIBILITY
/*	-> cash benefits are available to all residents
	-> all employees are entitled to parental leave 
*/
	
replace pl_eli = 1 		if country == "CZ" & year == 2020 
replace pl_eli = 0 		if pl_eli == . & country == "CZ" & year == 2020

* DURATION (weeks)
/*	-> the duration of benefit payment is dependent on the monthly amount of benefits 
		parents choose (with ceiling & maximum benefit for the whole period of parental leave)
	-> it is calculated using the Daily Assessment Base (see Maternity Leave)

	-> maximum amount of benefit for the whole period: €11,429
   
	-> if at least one of the parents has social insurance 
		(compulsory for employed, voluntary for self-employed - not coded):
		
		-> 70% of the daily assessment base (dab)
		-> ceiling: €1,628/month 
	-> If neither of the parents have social insurance: €381/month 
    
	-> either parent's earnings can be used for calculating the benefit
		-> OFPP uses women's earning if she is employed
		-> not employed women living in partnership: man's earning
	
	-> family entitlement => couples - all assigned to woman
*/


* Daily assessment base

/* daily assessment base (source: MISSOC 2020, IV. Maternity/Paternity):
 
	-> up to €44/day = 100% daily earning
		-> €44 - €66/day = 60% daily earning
		-> €66/day = 30% daily earning  
		-> earnings over €133/day are not taken into account
		
	NOTE: 	DAB calculated in ML section
			Here only DAB for partner's variables (p_*)
*/
											
** DAILY ASSESSMENT BASE:
* daily earning < 44
gen dab = earning/21.7 				if country == "CZ" & year == 2020 & earning/21.7 < 44

* daily earning between €44 and €66
gen dab1 = 44 						if country == "CZ" & year == 2020 & inrange(earning/21.7,44,66)

gen dab2 = ((earning/21.7) - 44)*0.6 	if country == "CZ" & year == 2020 ///
										& inrange(earning/21.7,44,66)
replace dab = dab1 + dab2 				if country == "CZ" & year == 2020 ///
										& inrange(earning/21.7,44,66) & dab == .
drop dab1 dab2
										
* daily earning between €66 and €133										
gen dab1 = 44 						if country == "CZ" & year == 2020 ///
									& inrange(earning/21.7,66,133)
gen dab2 = (66 - 44)*0.6 			if country == "CZ" & year == 2020  ///
									& inrange(earning/21.7,66,133)
gen dab3 = ((earning/21.7) - 66)*0.3 	if country == "CZ" & year == 2020 ///
										& inrange(earning/21.7,66,133)

replace dab = dab1 + dab2 + dab3  	if country == "CZ" & year == 2020  ///
									& inrange(earning/21.7,66,133) & dab == .									
drop dab1 dab2 dab3 

* daily earning over €133
gen dab1 = 44 						if country == "CZ" & year == 2020 ///
									& earning/21.7 > 133
gen dab2 = (66 - 44)*0.6 			if country == "CZ" & year == 2020  ///
									& earning/21.7 > 133
										
gen dab3 = (133 - 66)*0.3 			if country == "CZ" & year == 2020  ///
									& earning/21.7 > 133

replace dab = dab1 + dab2 + dab3 	if country == "CZ" & year == 2020 ///
									& earning/21.7 > 133 & dab == . 										
						
			
			
*** DURATION
/* -> maximum amount of benefit for the whole period: €11,429
   
	-> if at least one of the parents has social insurance:
		-> 70% of the daily assessment base (dab)
		-> ceiling: €1,628/month 
		-> If neither of the parents have social insurance: €381/month 
	-> social insurance compulsory only for employees
*/									

* not employed
	* women
replace pl_dur = 4*52					if country == "CZ" & year == 2020 & pl_eli == 1 ///
										& econ_status != 1 & gender == 1
										
	* single men
replace pl_dur = 4*52					if country == "CZ" & year == 2020 & pl_eli == 1 ///
										& econ_status != 1 & gender == 2 & parstat == 1
										
* employed
	* women
replace pl_dur = (11429 / ((0.7*dab)*21.7)) * 4.3 		if country == "CZ" & year == 2020 & pl_eli == 1 ///
														& econ_status == 1 & gender == 1 & pl_dur == . 
												
	* women - above ceiling
replace pl_dur = (11429 / 1628) * 4.3 					if country == "CZ" & year == 2020 & pl_eli == 1 ///
														& econ_status == 1 & gender == 1 & (0.7 * (21.7*dab)) >= 1628	

	* single men
replace pl_dur = (11429 / ((0.7*dab)*21.7)) * 4.3 		if country == "CZ" & year == 2020 & pl_eli == 1 ///
														& econ_status == 1 & gender == 2 & pl_dur == . & parstat == 1
														
	* single men - above ceiling
replace pl_dur = (11429 / 1628) * 4.3 					if country == "CZ" & year == 2020 & pl_eli == 1 ///
														& econ_status == 1 & gender == 2 & (0.7 * (21.7*dab)) >= 1628 & parstat == 1		
	
	* duration longer than 4 years
replace pl_dur = 208 		if country == "CZ" & year == 2020 & pl_eli == 1 ///
							& pl_dur != . & pl_dur >= 208	
										

* BENEFIT (monthly)
/* For explanation see "Duration (weeks)" above. 
   pl_ben2/3 refer to the most generous benefit 		*/
   
   
* not employed
	* women
replace pl_ben1 = 381 				if country == "CZ" & year == 2020 & pl_eli == 1 ///
																		& econ_status != 1 & gender == 1
																		
	* single men
replace pl_ben1 = 381 				if country == "CZ" & year == 2020 & pl_eli == 1 ///
																		& econ_status != 1 & gender == 2 & parstat == 1
																		

* employed
	* women
replace pl_ben1 = 0.7 * (21.7*dab)			if country == "CZ" & year == 2020 & pl_eli == 1 ///
											& econ_status == 1 & gender == 1
											
	* women - above ceiling
replace pl_ben1 = 1628						if country == "CZ" & year == 2020 & pl_eli == 1 ///
											& econ_status == 1 & gender == 1 & (0.7 * (21.7*dab)) >= 1628
											
	* single men
replace pl_ben1 = 0.7 * (21.7*dab)			if country == "CZ" & year == 2020 & pl_eli == 1 ///
											& econ_status == 1 & gender == 2 & parstat == 1
											
	* single men - above ceiling
replace pl_ben1 = 1628						if country == "CZ" & year == 2020 & pl_eli == 1 ///
											& econ_status == 1 & gender == 2 & (0.7 * (21.7*dab)) >= 1628 ///
											& parstat == 1

							

replace pl_ben2 = pl_ben1 				if country == "CZ" & year == 2020 & pl_eli == 1 
			


foreach x in 1 2 {
	replace pl_ben`x' = 0 	if pl_eli == 0 & country == "CZ" & year == 2020
}

replace pl_dur = 0 	if pl_eli == 0 & country == "CZ" & year == 2020

drop dab dab1 dab2 dab3 
