 /* PT_2018_BG_eusilc_cs */

 
* BULGARIA - 2018

* ELIGIBILITY
/*	-> Employed: at least 12 months of insurance.
	-> self-employed: voluntarily insured => not coded! 
	
	-> 	from the 6th month of the child's age, the mother can transfer her maternity
		leave to the father (until the child is 1); mother's permission is required => not coded
*/
   
replace pt_eli = 1 if country == "BG" & year == 2018 & gender == 2 ///
				& econ_status == 1 & duremp >= 12
replace pt_eli = 0 if pt_eli == . & country == "BG" & year == 2018 & gender == 2



* DURATION (weeks)
/*	-> 15 days */
replace pt_dur = 15/5 if country == "BG" & year == 2018 & pt_eli == 1



* BENEFIT (monthly)
/*	-> 90% earning 
	-> minimum: statutory minimum wage; €260.76 (source: Eurostat, Minimum wages, code: EARN_MW_CUR) 
	-> ceiling: average net income; annual net earnings = €2,732.55 (source: Eurostat, Annual net earnings, code: EARN_NT_NET)
*/

	
replace pt_ben1 = ((earning * 0.9) * (15/21.7)) + (earning * ((21.7-15)/21.7)) ///
										if country == "BG" & year == 2018 ///
										& pt_eli == 1 & pt_ben1 == .
	
	
* minimum
replace pt_ben1 = (260.76 * (15/21.7)) + (earning * ((21.7-15)/21.7)) 	if country == "BG" & year == 2018 ///
															& pt_eli == 1 & ((earning * 0.9) * (15/21.7)) < 260.76
 
* maximum 
replace pt_ben1 = ((2732.55/12) * (15/21.7)) + (earning * ((21.7-15)/21.7)) 	if country == "BG" & year == 2018 ///
															& pt_eli == 1 & (earning * 0.9) >= (2732.55/12)
										

									

replace pt_ben2 = pt_ben1 if country == "BG" & year == 2018 & pt_eli == 1



foreach x in 1 2 {
	replace pt_ben`x' = 0 	if pt_eli == 0 & country == "BG" & year == 2018
}

replace pt_dur = 0 if pt_eli == 0 & country == "BG" & year == 2018



