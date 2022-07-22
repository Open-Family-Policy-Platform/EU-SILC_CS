/* PT_2020_EE_eusilc_cs */


* ESTONIA - 2020

* ELIGIBILITY
/*	
	-> paternity leave was abolished on 1 July 2020 and replaced by the "additional parental leave for fathers"
	-> individual non-transferable
	-> additional parental leave coded for 2020
	
		-> all resident fathers
*/ 

replace pt_eli = 1 		if country == "EE" & year == 2020 & gender == 2 
replace pt_eli = 0 		if pt_eli == . & country == "EE" & year == 2020


* DURATION (weeks)
/*	-> 30 calendar days
	-> must be taken within 3 years after birth (not coded)
	-> can be taken within the 30 days before the planned childbirth (not coded)
*/

replace pt_dur = 30/7 	if country == "EE" & year == 2020 & pt_eli == 1


* BENEFIT (monthly)
/*	-> 100% of earning
	-> maximum: €3,548.1/month
	-> minimum: €584		*/
	
replace pt_ben1 = earning 	if country == "EE" & year == 2020 & pt_eli == 1
							
							
replace pt_ben1 = 3548.1 	if country == "EE" & year == 2020 & pt_eli == 1 ///
							& pt_ben1 >= 3548.1
							
replace pt_ben1 = 584 		if country == "EE" & year == 2020 & pt_eli == 1 ///
							& pt_ben1 < 584
							
							
replace pt_ben2 = pt_ben1 	if country == "EE" & year == 2020 & pt_eli == 1


foreach x in 1 2 {
	replace pt_ben`x' = 0 	if pt_eli == 0 & country == "EE" & year == 2020
}

replace pt_dur = 0 if pt_eli == 0 & country == "EE" & year == 2020
