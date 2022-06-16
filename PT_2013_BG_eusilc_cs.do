 /* PT_2013_BG_eusilc_cs */

 
* BULGARIA - 2013

* ELIGIBILITY
/*	-> Employed: at least 12 months of insurance.
	-> self-employed: voluntarily insured => not coded! 
	
	-> 	from the 6th month of the child's age, the mother can transfer her maternity
		leave to the father (until the child is 1); mother's permission is required => not coded
*/
   
replace pt_eli = 1 if country == "BG" & year == 2013 & gender == 2 ///
				& econ_status == 1 & duremp >= 12
replace pt_eli = 0 if pt_eli == . & country == "BG" & year == 2013 & gender == 2



* DURATION (weeks)
/*	-> 15 days */
replace pt_dur = 15/5 if country == "BG" & year == 2013 & pt_eli == 1

* BENEFIT (monthly)
/*	-> 90% earning 
	-> minimum: statutory minimum wage; €158.50 (source: Eurostat, Minimum wages, code: EARN_MW_CUR) 
	-> ceiling: average net income; annual net earnings = €1,899.03 (source: Eurostat, Annual net earnings, code: EARN_NT_NET)
	
*/


replace pt_ben1 = ((earning * 0.9) * (15/21.7)) + (earning * ((21.7-15)/21.7)) ///
										if country == "BG" & year == 2013 ///
										& pt_eli == 1 & pt_ben1 == .


* minimum
replace pt_ben1 = (158.50 * (15/21.7)) + (earning * ((21.7-15)/21.7)) 	if country == "BG" & year == 2013 ///
															& pt_eli == 1 & (earning * 0.9) < 158.50 

* maximum 
replace pt_ben1 = ((1899.03/12) * (15/21.7)) + (earning * ((21.7-15)/21.7)) 	if country == "BG" & year == 2013 ///
															& pt_eli == 1 & (earning * 0.9) >= (1899.03/12)




replace pt_ben2 = pt_ben1 if country == "BG" & year == 2013 & pt_eli == 1



foreach x in 1 2 {
	replace pt_ben`x' = 0 	if pt_eli == 0 & country == "BG" & year == 2013
}

replace pt_dur = 0 if pt_eli == 0 & country == "BG" & year == 2013

								
