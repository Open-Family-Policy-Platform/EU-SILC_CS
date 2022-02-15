/* PL_2014_CZ_eusilc_cs */


* CZECHIA - 2014

* ELIGIBILITY
/*	-> cash benefits are available to all residents
	-> all employees are entitled to parental leave 
*/
	
replace pl_eli = 1 		if country == "CZ" & year == 2014 
replace pl_eli = 0 		if pl_eli == . & country == "CZ" & year == 2014

* DURATION (weeks)
/*	-> parents choose the monthly benefit amount (determines also the duration of PL) 

	-> maximum amount of benefit for the whole period: €8,013
   
	-> 70% of the daily assessment base
	-> ceiling: €419/month 
    
	-> The benefit is calculated from the higher daily assessment base (if man's dab is higher, it is calculated
   from his daily assessment base; if woman's dab is higher, it is calculated from hers).
	-> If neither of the parents have social insurance:
		- €277/month until child is 10 months old, €138 until child is 48 months old => duration 4 years
		
	-> the most generous benefit is coded
   
	-> Social insurance is obligatory for employees, voluntary for self-employed (not coded)
	
	-> family entitlement => couples - all assigned to woman
*/


* Daily assessment base

/* daily assessment base (source: MISSOC 2014, IV. Maternity/Paternity):
	
	-> up to €32/day = 100% daily earning
	-> €32 - €47/day = 60% daily earning
	-> €47/day = 30% daily earning  
	-> earning over €95/day are not taken into account
	
	NOTE: 	DAB calculated in ML section
			Here only DAB for partner's variables (p_*)
*/

* daily earning < 32
gen p_dab = p_earning/21.7 				if country == "CZ" & year == 2014 ///
										& (p_earning/21.7) < 32 & parstat == 2 ///
										& econ_status != 1 & p_econ_status == 1

* daily earning between €32 and €47
gen p_dab1 = 32 							if country == "CZ" & year == 2014 ///
											& inrange(p_earning/21.7,32,47) & parstat == 2 ///
											& econ_status != 1 & p_econ_status == 1
											
gen p_dab2 = ((p_earning/21.7) - 32)*0.6 	if country == "CZ" & year == 2014 ///
											& inrange(p_earning/21.7,32,47) & parstat == 2 ///
											& econ_status != 1 & p_econ_status == 1
											 
replace p_dab = p_dab1 + p_dab2 			if country == "CZ" & year == 2014 ///
											& inrange(p_earning/21.7,32,47) & p_dab == .  ///
											& parstat == 2 & econ_status != 1 & p_econ_status == 1
drop p_dab1 p_dab2

										
* daily earning between €47 and €95										
gen p_dab1 = 32 						if country == "CZ" & year == 2014  ///
										& inrange(p_earning/21.7,47,95) ///
										& parstat == 2 & econ_status != 1 & p_econ_status == 1
										
gen p_dab2 = (47 - 32)*0.6 				if country == "CZ" & year == 2014 ///
										& inrange(p_earning/21.7,47,95) ///
										& parstat == 2 & econ_status != 1 & p_econ_status == 1
										
gen p_dab3 = ((p_earning/21.7) - 47)*0.3 	if country == "CZ" & year == 2014 ///
											& inrange(p_earning/21.7,47,95) & parstat == 2 ///
											& econ_status != 1 & p_econ_status == 1

										
replace p_dab = p_dab1 + p_dab2 + p_dab3  		if country == "CZ" & year == 2014 ///
												& inrange(p_earning/21.7,47,95)  ///
												& p_dab == . & parstat == 2 & econ_status != 1 ///
												& p_econ_status == 1
drop p_dab1 p_dab2 p_dab3 


* daily earning over €95
gen p_dab1 = 32 						if country == "CZ" & year == 2014  ///
										& p_earning/21.7 > 95 ///
										& parstat == 2 & econ_status != 1  & p_econ_status == 1
										
gen p_dab2 = (47 - 32)*0.6 				if country == "CZ" & year == 2014 ///
										& p_earning/21.7 > 95 & parstat == 2 ///
										& econ_status != 1 & p_econ_status == 1
										
gen p_dab3 = (95 - 47)*0.3			 	if country == "CZ" & year == 2014 ///
										& p_earning/21.7 > 95  & parstat == 2 ///
										& econ_status != 1 & p_econ_status == 1

										
replace p_dab = p_dab1 + p_dab2 + p_dab3  		if country == "CZ" & year == 2014 ///
												& p_earning/21.7 > 95   ///
												& p_dab == . & parstat == 2 & econ_status != 1 ///
												& p_econ_status == 1
drop p_dab1 p_dab2 p_dab3 



*** DURATION
/* -> maximum amount of benefit for the whole period: €8,013
   
	-> if at least one of the parents has social insurance:
		-> 70% of the daily assessment base (dab)
		-> ceiling: €419/month 
		-> If neither of the parents have social insurance: €277/month
	-> social insurance compulsory only for employees
*/	
									
* SINGLE (women & men)
	* not employed (4 years)
replace pl_dur = 4*52		if country == "CZ" & year == 2014 & pl_eli == 1 ///
										& econ_status != 1 & parstat == 1

	* employed
replace pl_dur = (8013 / ((0.7*dab)*21.7)) * 4.3 		if country == "CZ" & year == 2014 & pl_eli == 1 ///
														& econ_status == 1 & parstat == 1 & pl_dur == . ///
														& earning < 419
	* employed, above ceiling	
replace pl_dur = (8013 / 419) * 4.3 					if country == "CZ" & year == 2014 & pl_eli == 1 ///
														& econ_status == 1 & parstat == 1 & pl_dur == . ///
														& earning >= 419


* COUPLE (assigned to women)
	* neither is working (4 years)														
replace pl_dur = 4*52 		if country == "CZ" & year == 2014 & pl_eli == 1 ///
										& econ_status != 1 & !inlist(p_econ_status,.,1) & parstat == 2
										
	* woman not employed, man employed, below ceiling
replace pl_dur = (8013/((0.7 * p_dab)*21.7)) * 4.3 	if country == "CZ" & year == 2014 & pl_eli == 1 /// 
													& p_econ_status == 1 & !inlist(econ_status,.,1) ///
													& parstat == 2 & ((0.7*p_dab)*21.7) < 419
																										
	* woman not employed, man employed, above ceiling
replace pl_dur = (8013/419) * 4.3					if country == "CZ" & year == 2014 & pl_eli == 1 /// 
													& p_econ_status == 1 & econ_status != 1 ///
													& parstat == 2 & ((0.7*p_dab)*21.7) >= 419
															
	* woman employed, below ceiling
replace pl_dur = (8013/((0.7 * dab)*21.7)) * 4.3 	if country == "CZ" & year == 2014 & pl_eli == 1 /// 
													& econ_status == 1 & parstat == 2 ///
													& ((0.7*dab)*21.7) < 419

	* woman employed, above ceiling
replace pl_dur = (8013/419) * 4.3				 	if country == "CZ" & year == 2014 & pl_eli == 1 /// 
													& econ_status == 1 & parstat == 2 ///
													& ((0.7*dab)*21.7) >= 419
	
	
	
	
	


* BENEFIT (monthly)
/* For explanation see "Duration (weeks)" above. 
   pl_ben2/3 refer to the most generous benefit 		*/

* SINGLE
	* not employed
replace pl_ben1 = (277 * (10/58)) + (138 * (48/58)) 					if country == "CZ" & year == 2014 & pl_eli == 1 ///
										& econ_status != 1 & parstat == 1
										
	* employed, below ceiling
replace pl_ben1 = 0.7 * (21.7*dab)		if country == "CZ" & year == 2014 & pl_eli == 1 ///
										& econ_status == 1 & parstat == 1 
										
	* employed, above ceiling
replace pl_ben1 = 419					if country == "CZ" & year == 2014 & pl_eli == 1 ///
										& econ_status == 1 & parstat == 1 & pl_ben1 >= 419

	
		
* COUPLE (assigned to women)
	* neither employed
replace pl_ben1 = (277 * (10/58)) + (138 * (48/58)) 					if country == "CZ" & year == 2014 & pl_eli == 1 ///
										& econ_status != 1 & !inlist(p_econ_status,.,1) & parstat == 2
										
	* woman not employed, man employed
replace pl_ben1 =  0.7 * (21.7*p_dab)	if country == "CZ" & year == 2014 & pl_eli == 1 ///
										& econ_status != 1 & p_econ_status == 1 & parstat == 2
										
	
	* woman not employed, man employed, above ceiling
replace pl_ben1 =  419					if country == "CZ" & year == 2014 & pl_eli == 1 ///
										& econ_status != 1 & p_econ_status == 1 & parstat == 2 ///
										& pl_ben1 >= 419	
										
	* woman employed, below ceiling
replace pl_ben1 =  0.7 * (21.7*dab)	if country == "CZ" & year == 2014 & pl_eli == 1 ///
										& econ_status == 1 & parstat == 2 
										
	
	* above ceiling
replace pl_ben1 =  419					if country == "CZ" & year == 2014 & pl_eli == 1 ///
										& econ_status == 1 & parstat == 2 ///
										& pl_ben1 >= 419
	

replace pl_ben2 = pl_ben1 				if country == "CZ" & year == 2014 & pl_eli == 1 

foreach x in 1 2 {
	replace pl_ben`x' = 0 	if pl_eli == 0 & country == "CZ" & year == 2014
}

replace pl_dur = 0 	if pl_eli == 0 & country == "CZ" & year == 2014

drop dab dab1 dab2 dab3 
