/* PL_2019_HR_eusilc_cs */


* CROATIA - 2019

* ELIGIBILITY
/*	-> 	employed, self-employed (parental leave; income-related benefit)
	-> 	non-working (parental exemption form work; flat-rate benefit)
*/

replace pl_eli = 1 		if country == "HR" & year == 2019
replace pl_eli = 0 		if pl_eli == . & country == "HR" & year == 2019



* DURATION (weeks)
/*	-> employed/self-employed: 
		-> 1st and 2nd child:
			-> 4 months/parent/child (MISSOC 1/7/2019)
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
   
replace pl_dur = 3*4.3 		if country == "HR" & year == 2019 & pl_eli == 1 ///
							& inlist(econ_status,1,2) & (duremp+dursemp) >= 12 ///
							& childc <= 2
						
replace pl_dur = 15/4.3 		if country == "HR" & year == 2019 & pl_eli == 1 ///
								& inlist(econ_status,1,2) & (duremp+dursemp) >= 12 ///
								& childc > 2 
						
replace pl_dur = 6*4.3 		if country == "HR" & year == 2019 & pl_eli == 1 ///
							& pl_dur == . & childc <= 2 & gender == 1
						
replace pl_dur = (3*52) - ml_dur2 		if country == "HR" & year == 2019 & pl_eli == 1 ///
										& pl_dur == . & childc > 2 & gender == 1
						
				


* BENEFIT (monthly)
/*	-> Employed & self-employd: 100%
		-> ceiling = €540/month
	-> All others: €315/month
*/

replace pl_ben1 = earning 		if country == "HR" & year == 2019 & pl_eli == 1 ///
								& inlist(econ_status,1,2) & (duremp+dursemp) >= 12 ///
								& childc <= 2

replace pl_ben1 = 540 	if country == "HR" & year == 2019 & pl_eli == 1 ///
						& inlist(econ_status,1,2) & (duremp+dursemp) >= 12 & earning >= 540 ///
						& childc <= 2


replace pl_ben1 = 315 	if country == "HR" & year == 2019 & pl_eli == 1 ///
						& pl_ben1 == . 
 

replace pl_ben2 = pl_ben1   	if country == "HR" & year == 2019 & pl_eli == 1 
						 
 
 foreach x in 1 2 {
	replace pl_ben`x' = 0 	if pl_eli == 0 & country == "HR" & year == 2019
}

replace pl_dur = 0 	if pl_eli == 0 & country == "HR" & year == 2019
