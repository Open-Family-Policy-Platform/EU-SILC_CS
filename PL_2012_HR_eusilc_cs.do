/* PL_2012_HR_eusilc_cs */


* CROATIA - 2012

* ELIGIBILITY
/*	-> all parents but conditions and benefits differ by categories
	-> parental leave is an individual partially transferable (3 months) entitlement

	-> employed: parental leave
		-> working for 12 consecutive months or 18 months (coded in pl_dur) with interruption during past 2 years (not coded)
	-> self-employed: parental leave
		-> working for 12 consecutive months or 18 months (coded in pl_dur) with interruption during past 2 years (not coded)
	-> unemployed: parental exeption from work
	-> inactive: parental care for a child
*/

replace pl_eli = 1 		if country == "HR" & year == 2012
replace pl_eli = 0 		if pl_eli == . & country == "HR" & year == 2012



* DURATION (weeks)
/*	-> employed/self-employed:  3 months/parent/child
	*/
   
replace pl_dur = 3 		if country == "HR" & year == 2012 & pl_eli == 1 ///
						& inlist(econ_status,1,2) & (duremp+dursemp) >= 12 
						
						
replace pl_dur = 6 		if country == "HR" & year == 2012 & pl_eli == 1 ///
						& pl_dur == . 
				


* BENEFIT (monthly)
/*	-> Employed & self-employd: 100%
		-> ceiling = €563/month
*/

replace pl_ben1 = earning 		if country == "HR" & year == 2012 & pl_eli == 1 ///
								& inlist(econ_status,1,2) & (duremp+dursemp) >= 12

replace pl_ben1 = 563 	if country == "HR" & year == 2012 & pl_eli == 1 ///
						& inlist(econ_status,1,2) & (duremp+dursemp) >= 12 & earning > 563


 foreach x in 1 2 {
	replace pl_ben`x' = 0 	if pl_eli == 0 & country == "HR" & year == 2012
}

replace pl_dur = 0 	if pl_eli == 0 & country == "HR" & year == 2012
