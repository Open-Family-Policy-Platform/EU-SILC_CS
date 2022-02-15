/* PL_2014_HR_eusilc_cs */


* CROATIA - 2014

* ELIGIBILITY
/*	-> all parents but conditions and benefits differ by categories
	-> parental leave is an individual partially transferable (2 months) entitlement

	-> employed: parental leave
		-> working for 12 consecutive months or 18 months (coded in pl_dur) with interruption during past 2 years (not coded)
	-> self-employed: parental leave
		-> working for 12 consecutive months or 18 months (coded in pl_dur) with interruption during past 2 years (not coded)
	-> unemployed: parental exeption from work
		-> permanent resident for at least 3 years (not coded)
		-> compulsory health insurance (not coded)
		-> registered as unemployed for at least 9 uninterrupted months or 12 months with interruptions
			in the last 2 years before childbirth (not coded because the benefits are identical as for inactive;
			it is assumed that unemployed ineligible for the parental exeption from work will be eligible for 
			parental care for a child)
	-> inactive: parental care for a child
		-> permanent resident for at least 5 years (not coded)
*/

replace pl_eli = 1 		if country == "HR" & year == 2014
replace pl_eli = 0 		if pl_eli == . & country == "HR" & year == 2014



* DURATION (weeks)
/*	-> employed/self-employed:  4 months/parent/child
	-> for everyone else: from 6th to 12th month of child's age
   Source: MISSOC 01/07/2014										*/
   
replace pl_dur = 4 		if country == "HR" & year == 2014 & pl_eli == 1 ///
						& inlist(econ_status,1,2) & (duremp+dursemp) >= 12 
						
						
replace pl_dur = 6 		if country == "HR" & year == 2014 & pl_eli == 1 ///
						& pl_dur == . 
				


* BENEFIT (monthly)
/*	-> Employed & self-employd: 100%
		-> ceiling = €565/month
	-> All others: €225.22/month
*/

replace pl_ben1 = earning 		if country == "HR" & year == 2014 & pl_eli == 1 ///
								& inlist(econ_status,1,2) & (duremp+dursemp) >= 12

replace pl_ben1 = 565 	if country == "HR" & year == 2014 & pl_eli == 1 ///
						& inlist(econ_status,1,2) & (duremp+dursemp) >= 12 & earning > 565


replace pl_ben1 = 225.22 	if country == "HR" & year == 2014 & pl_eli == 1 ///
						& pl_ben1 == . 
 

 foreach x in 1 2 {
	replace pl_ben`x' = 0 	if pl_eli == 0 & country == "HR" & year == 2014
}

replace pl_dur = 0 	if pl_eli == 0 & country == "HR" & year == 2014
