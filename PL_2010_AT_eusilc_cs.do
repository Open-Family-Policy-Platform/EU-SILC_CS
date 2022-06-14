/* PL_2010_AT_eusilc_cs */

* AUSTRIA - 2010

* ELIGIBILITY
/*	-> parental leave: employed, family entitlement (until child is 2 years old)
	-> parental benefit: all parents, family entitlement
*/
replace pl_eli = 1 	if country == "AT" & year == 2010 
replace pl_eli = 0 	if pl_eli == . & country == "AT" & year == 2010



* DURATION (weeks)
/*	
	-> refers to the duration of benefit payments
	-> parents can choose from 5 options:
		-> €14.53 daily until the child reaches 30 months of age; if other parent applies as well -> 30 months (not coded)
		-> €20.80 daily until the child reaches 20 months of age; if other parent applies as well -> 20 months (not coded)
		-> €26.60 daily until the child reaches 15 months of age; if other parent applies as well -> 15 months (not coded)
		-> €33 daily until the child reaches 12 months of age (coded); if other parent applies as well -> 12 months (not coded)
		-> 80% of earnings until the child reaches 12 months of age (coded); if other parent applies as well -> 12 months (not coded)
			- only available to employed parents
			
	-> if the other parent also receives the child-raising allowance, the duration of leave can be extended (not coded)
		-> the amount of extra months depends on the option chosen
		-> 30 -> 36 months; 20 -> 24 months; 15 -> 18 months; 12 -> 14 months
		
		
	-> benefit family entitlement => father can claim if mother is not eligible 
	-> Benefits are family entitlement => all entitlements assigned to the woman for 
		cohabiting couples. For single individuals they are asigned to the individual. 
	-> The duration of leave (365 days) is for after the birth of the child => 
		the period of postnatal maternity leave is deduced for women who would be 
		eligible for maternity leave. 	
		
	-> NOTE: if missing values on partner's economic status or earning => women's information is used
*/

* employed   
	* eligible for ML
	* and cohabiting
replace pl_dur = 52 - ml_dur2 	if country == "AT" & year == 2010 & pl_eli == 1 ///
									& gender == 1 & (econ_status == 1 | p_econ_status == 1) ///
									& parstat == 2 & ml_eli == 1
	* and single
replace pl_dur = 52 - ml_dur2 	if country == "AT" & year == 2010 & pl_eli == 1 ///
									& gender == 1 & econ_status == 1 & parstat == 1 & ml_eli == 1 & pl_dur == .



	* not eligible for ML
	* and cohabiting
replace pl_dur = 52 	if country == "AT" & year == 2010 & pl_eli == 1 ///
							& gender == 1 & (econ_status == 1 | p_econ_status == 1) ///
							& parstat == 2 & ml_eli != 1 & pl_dur == .
	* and single
replace pl_dur = 52 	if country == "AT" & year == 2010 & pl_eli == 1 ///
							& econ_status == 1 & parstat == 1 & ml_eli != 1 & pl_dur == . 

		

		
* all other women
 replace pl_dur = 52 	if country == "AT" & year == 2010 & pl_eli == 1 ///
							& gender == 1 & econ_status != 1 & pl_dur == . 





* BENEFIT (monthly)
/*	-> benefit is a family entitlement but among working parents it calculated 
		from one parents income => we assume parents will use earnings of the parent 
		with higher earnings
	-> employed: 80% of earnings (parent who claims the benefits)
			- no ceiling
			- paid for 365 days after childbirth
	-> all other parents: €33/day (most generous option corresponding with the coded leave duration)
*/


 ** employed & single
replace pl_ben1 = 0.8 * earning 	if country == "AT" & year == 2010 & pl_eli == 1 /// 
									& econ_status == 1 & parstat == 1 
									
									
						
 ** not employed & single
replace pl_ben1 = 33 * 21.7	 	if country == "AT" & year == 2010 & pl_eli == 1 /// 
									& inrange(econ_status,2,4) & parstat == 1
 
 
 
 ** cohabiting -> asssigned to a woman
	* employed, woman higher earning
replace pl_ben1 = 0.8 * earning		if country == "AT" & year == 2010 & pl_eli == 1 ///
									& econ_status == 1 & earning > p_earning & pl_ben1 == . ///
									& gender == 1 & parstat == 2 & p_earning != .
									
	* employed, man higher earning
replace pl_ben1 = 0.8 * p_earning	if country == "AT" & year == 2010 & pl_eli == 1 ///
									& p_econ_status == 1 & earning < p_earning & pl_ben1 == . ///
									& gender == 1 & parstat == 2 & p_earning != .
									
									
	* neither of the partners is employed										
replace pl_ben1 = 33 * 21.7 		if country == "AT" & year == 2010 & pl_eli == 1 ///
									& inrange(econ_status,2,4) & !inlist(p_econ_status,.,1) & pl_ben1 == . ///
									& gender == 1

									
	* employed, partner's earning is missing	
replace pl_ben1 = 0.8 * earning 	if country == "AT" & year == 2010 & pl_eli == 1 /// 
									& econ_status == 1 & parstat == 2 & p_earning == .
									
	* not employed
replace pl_ben1 = 33 * 21.7	 	if country == "AT" & year == 2010 & pl_eli == 1 /// 
									& inrange(econ_status,2,4) & parstat == 2 & pl_ben1 == .
									


									


 
 
 
replace pl_ben2 = pl_ben1		if country == "AT" & year == 2010 & pl_eli == 1


foreach x in 1 2 {
	replace pl_ben`x' = 0 	if pl_eli == 0 & country == "AT" & year == 2010
}

replace pl_dur = 0 	if pl_eli == 0 & country == "AT" & year == 2010


