 /* PT_2010_BG_eusilc_cs */

 
* BULGARIA - 2010

* ELIGIBILITY
/*	-> Employed: at least 12 months of insurance.
	-> self-employed: voluntarily insured => not coded! 
	
	-> 	from the 6th month of the child's age, the mother can transfer her maternity
		leave to the father (until the child is 1); mother's permission is required => not coded
*/
   
replace pt_eli = 1 if country == "BG" & year == 2010 & gender == 2 ///
				& econ_status == 1 & duremp >= 12
replace pt_eli = 0 if pt_eli == . & country == "BG" & year == 2010 & gender == 2



* DURATION (weeks)
/*	-> 15 days */
replace pt_dur = 15/5 if country == "BG" & year == 2010 & pt_eli == 1



* BENEFIT (monthly)
/*	-> 90% earning 
*/

	
replace pt_ben1 = ((earning * 0.9) * (15/21.7)) + (earning * ((21.7-15)/21.7)) ///
										if country == "BG" & year == 2010 ///
										& pt_eli == 1 & pt_ben1 == .

									

replace pt_ben2 = pt_ben1 if country == "BG" & year == 2010 & pt_eli == 1



foreach x in 1 2 {
	replace pt_ben`x' = 0 	if pt_eli == 0 & country == "BG" & year == 2010
}

replace pt_dur = 0 if pt_eli == 0 & country == "BG" & year == 2010



