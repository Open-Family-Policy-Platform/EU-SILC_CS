/* PL_2018_AT_eusilc_cs */

* AUSTRIA - 2018

* ELIGIBILITY
/*	-> parental leave: employed, family entitlement (until child is 2 years old)
	-> parental benefit: all parents, family entitlement
*/
replace pl_eli = 1 	if country == "AT" & year == 2018 
replace pl_eli = 0 	if pl_eli == . & country == "AT" & year == 2018



* DURATION (weeks)
/*	-> parents choose the duration of benefits (affects benefit amount)
		- the duration of PL is between 365 and 851 days
		- the shortest period has the most generous per day benefits
		=> most generous option is coded (365 days)
	-> benefit family entitlement => father can claim if mother is not eligible 
	-> partnership bonus: 2 months if both parents share at least 60:40 (not coded)
		- €500 (not coded)
	-> Benefits are family entitlement => all entitlements assigned to the woman for 
		cohabiting couples. For single individuals they are asigned to the individual. 
	-> The duration of leave (365 days) is for after the birth of the child => 
		the period of postnatal maternity leave is deduced for women who would be 
		eligible for maternity leave. 	
		
	-> each parent can defer 3 months of PL until the child is 7 years old
	-> the benefits can only be claimed for the youngest child (i.e. if there are more children
	for whom the parents are eligible for PL benefit, they can only claim the benefit once)
*/

* employed   
	* eligible for ML
	* and cohabiting
replace pl_dur = (365/7) - ml_dur2 	if country == "AT" & year == 2018 & pl_eli == 1 ///
									& gender == 1 & (econ_status == 1 | p_econ_status == 1) ///
									& parstat == 2 & ml_eli == 1
	* and single
replace pl_dur = (365/7) - ml_dur2 	if country == "AT" & year == 2018 & pl_eli == 1 ///
									& gender == 1 & econ_status == 1 & parstat == 1 & ml_eli == 1 & pl_dur == .



	* not eligible for ML
	* and cohabiting
replace pl_dur = (365/7) 	if country == "AT" & year == 2018 & pl_eli == 1 ///
							& gender == 1 & (econ_status == 1 | p_econ_status == 1) ///
							& parstat == 2 & ml_eli != 1 & pl_dur == .
	* and single
replace pl_dur = (365/7) 	if country == "AT" & year == 2018 & pl_eli == 1 ///
							& econ_status == 1 & parstat == 1 & ml_eli != 1 & pl_dur == . 

		

		
* all other women
 replace pl_dur = (365/7) 	if country == "AT" & year == 2018 & pl_eli == 1 ///
							& gender == 1 & econ_status != 1 & pl_dur == . 





* BENEFIT (monthly)
/*	-> benefit is a family entitlement but among working parents it calculated 
		from one parents income => we assume parents will use earnings of the parent 
		with higher earnings
	-> employed: 80% of earnings (parent who claims the benefits)
		- ceiling: €66/day
			- paid for 365 days after childbirth
			- paid for 426 days after childbirth if both parents claim the benefit (not coded)
	-> all other parents: €33.88/day (most generous option corresponding with the coded leave duration)
	
	-> NOTE: only the income of the parent who receives the benefit is considered! (MISSOC 2018)
*/


 ** employed 
replace pl_ben1 = 0.8 * earning 	if country == "AT" & year == 2018 & pl_eli == 1 /// 
									& econ_status == 1 
									
									
replace pl_ben1 = 66 * 21.7			if country == "AT" & year == 2018 & pl_eli == 1 /// 
									& econ_status == 1 & pl_ben1 >= (66*21.7)								
 
 ** not employed 
replace pl_ben1 = 33.88 * 21.7	 	if country == "AT" & year == 2018 & pl_eli == 1 /// 
									& inrange(econ_status,2,4) 
 
 
replace pl_ben2 = pl_ben1		if country == "AT" & year == 2018 & pl_eli == 1

 
replace pl_ben2 = pl_ben1		if country == "AT" & year == 2018 & pl_eli == 1


foreach x in 1 2 {
	replace pl_ben`x' = 0 	if pl_eli == 0 & country == "AT" & year == 2018
}

replace pl_dur = 0 	if pl_eli == 0 & country == "AT" & year == 2018


