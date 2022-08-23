/* PL_2020_HR_eusilc_cs */


* CROATIA - 2020

* ELIGIBILITY
/*	-> 	employed, self-employed (parental leave; income-related benefit)
	-> 	non-working (parental exemption form work; flat-rate benefit)
*/

replace pl_eli = 1 		if country == "HR" & year == 2020
replace pl_eli = 0 		if pl_eli == . & country == "HR" & year == 2020



* DURATION (weeks)
/*	-> employed/self-employed: 
		-> 1st and 2nd child:
			-> 4 months/parent/child (MISSOC 1/7/2020)
			-> until child is 8 years old
			-> individual transferable right: 2 months can be transferred 
		-> 3rd+ child:
			-> 30 months in total (15 months/parent)
		
	-> non-working: 
		-> 1st and 2nd child:
			-> from 6th to 12th month of child's age
		-> 3rd+ child:
			-> until child is 3 years old (assigned to women; unclear whether it is still
				and individul transferable right and how much is assigned to each parent)
 */
   
replace pl_dur = 3*4.3 		if country == "HR" & year == 2020 & pl_eli == 1 ///
							& inlist(econ_status,1,2) & (duremp+dursemp) >= 12 ///
							& childc <= 2
						
replace pl_dur = 15*4.3 		if country == "HR" & year == 2020 & pl_eli == 1 ///
								& inlist(econ_status,1,2) & (duremp+dursemp) >= 12 ///
								& childc > 2 
						
replace pl_dur = 6*4.3 		if country == "HR" & year == 2020 & pl_eli == 1 ///
							& pl_dur == . & childc <= 2 & gender == 1
						
replace pl_dur = (3*52) - ml_dur2 		if country == "HR" & year == 2020 & pl_eli == 1 ///
										& pl_dur == . & childc > 2 & gender == 1
						
				


* BENEFIT (monthly)
/*	-> Employed & self-employd: 
		-> <= 2 children:
			-> first 6 months:
				-> 100% 
				-> ceiling: €747/month (MISSOC 1/7/2020)
			-> after:
				-> 70%
				-> ceiling: €747/month (MISSOC 1/7/2020)
				-> NOT CODED - will affect the benefit of that parent who use the benefit second
				
		-> 3+ children:
			-> first 6 months:
				-> 100% 
				-> ceiling: €747/month (MISSOC 1/7/2020)
			-> after that: 
				-> €308/month for 24 months
		
	-> unemployed & inactive:
		-> €308/month
*/

* for 1-2 children
replace pl_ben1 = earning 		if country == "HR" & year == 2020 & pl_eli == 1 ///
								& inlist(econ_status,1,2) & (duremp+dursemp) >= 12 & gender == 1 ///
								& childc <= 2
								
replace pl_ben1 = 747 			if country == "HR" & year == 2020 & pl_eli == 1 ///
								& inlist(econ_status,1,2) & (duremp+dursemp) >= 12 & pl_ben1 > 530 ///
								& childc <= 2

								
* for 3+ children
replace pl_ben1 = ((earning * (6/30)) + (308 * 24)) / 30 		if country == "HR" & year == 2020 & pl_eli == 1 ///
																& inlist(econ_status,1,2) & (duremp+dursemp) >= 12 & gender == 1 ///
																& childc > 2
								
replace pl_ben1 = ((747 * 6) + (308 * 24)) / 30			if country == "HR" & year == 2020 & pl_eli == 1 ///
														& inlist(econ_status,1,2) & (duremp+dursemp) >= 12 & pl_ben1 > 530 ///
														& childc > 2
								
								
* non-working								
replace pl_ben1 = 308 			if country == "HR" & year == 2020 & pl_eli == 1 ///
								& pl_ben1 == . & pl_eli == 1
						
						
						
replace pl_ben2 = pl_ben1   	if country == "HR" & year == 2020 & pl_eli == 1 
replace pl_ben2 = earning 		if country == "HR" & year == 2020 & pl_eli == 1 ///
								& inlist(econ_status,1,2) & (duremp+dursemp) >= 12 & gender == 1 ///
								& childc > 2
replace pl_ben2 = 747 			if country == "HR" & year == 2020 & pl_eli == 1 ///
								& inlist(econ_status,1,2) & (duremp+dursemp) >= 12 & pl_ben1 > 530 ///
								& childc > 2		
						
						
 
 foreach x in 1 2 {
	replace pl_ben`x' = 0 	if pl_eli == 0 & country == "HR" & year == 2020
}

replace pl_dur = 0 	if pl_eli == 0 & country == "HR" & year == 2020
