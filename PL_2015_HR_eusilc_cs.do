/* PL_2015_HR_eusilc_cs */


* CROATIA - 2015

* ELIGIBILITY
/*	-> all parents but conditions and benefits differ by categories

	-> parental leave is an individual partially transferable (2 months) entitlement (LP&R 2014)

	-> employed: parental leave
	-> self-employed: parental leave
	-> unemployed: parental exeption from work	
	-> inactive: parental care for a child
		
*/

replace pl_eli = 1 		if country == "HR" & year == 2015
replace pl_eli = 0 		if pl_eli == . & country == "HR" & year == 2015



* DURATION (weeks)
/*	-> 4 months/parent/child
	-> for everyone else: from 6th to 12th month of child's age
   Source: MISSOC 01/07/2015										
  										*/
   
replace pl_dur = 4 		if country == "HR" & year == 2015 & pl_eli == 1 ///
						& inlist(econ_status,1,2) 
						
replace pl_dur = 6 		if country == "HR" & year == 2015 & pl_eli == 1 ///
						& pl_dur == . 
										
						
				


* BENEFIT (monthly)
/*	-> Employed & self-employd: 
		-> 100% for the first 6 months
		-> ceiling: €351/month
		
	-> All others: €225.22/month 
*/

replace pl_ben1 = earning 		if country == "HR" & year == 2015 & pl_eli == 1 ///
								& inlist(econ_status,1,2) & (duremp+dursemp) >= 12

replace pl_ben1 = 351 	if country == "HR" & year == 2015 & pl_eli == 1 ///
						& inlist(econ_status,1,2) & (duremp+dursemp) >= 12 & earning > 565


replace pl_ben1 = 225.22 	if country == "HR" & year == 2015 & pl_eli == 1 ///
						& pl_ben1 == . 
 
replace pl_ben2 = pl_ben1   	if country == "HR" & year == 2015 & pl_eli == 1 
						
 foreach x in 1 2 {
	replace pl_ben`x' = 0 	if pl_eli == 0 & country == "HR" & year == 2015
}

replace pl_dur = 0 	if pl_eli == 0 & country == "HR" & year == 2015
