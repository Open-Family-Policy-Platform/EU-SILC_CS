/* PT_2014_PT_eusilc_cs */


* PORTUGAL - 2014

* ELIGIBILITY
/*	-> pooled rights (i.e. individual and family rights to leave)
		- total leave: 120 or 150 (parents' choice)
		- Paternity leave refers to the leave reserved for father
	-> compulsorily social insurance for employed and self-employed 
		- 6 months of work before childbirth	*/
		
replace pt_eli = 1 		if country == "PT" & year == 2014 & gender == 2 ///
						& inlist(econ_status,1,2) & (duremp+dursemp) >= 6

					
						
replace pt_eli = 0 		if pt_eli == . & country == "PT" & year == 2014 & gender == 2

* DURATION (weeks)
/*	-> 25 working days (LP&R 2014), 15 days are obligatory 
	-> LP&R 2014: single parents cannot use the other parent's entitlement => 
		father's share is not assigned to single woman 	*/

replace pt_dur = 25/5 	if country == "PT" & year == 2014 & pt_eli == 1


* BENEFIT (monthly)
/*	-> benefits are identical for all types of leave (reserved for mother, father, shared leave)
	-> influenced by parents' choice of duration (120 or 150 days) and whether leave is shared 
	-> 120 days: 100% earning (coded)
	-> 150 days, not shared: 80% earning
	-> 150 days, shared: 100% earning
	-> 180 days, shared: 83% earning 
	-> minimum: €419.22/month 
*/
	
replace pt_ben1 = earning  	if country == "PT" & year == 2014 & pt_eli == 1

replace pt_ben1 = 419.22  	if country == "PT" & year == 2014 & pt_eli == 1 ///
							& pt_ben1 < 419.22

replace pt_ben2 = pt_ben1 	if country == "PT" & year == 2014 & pt_eli == 1


foreach x in 1 2 {
	replace pt_ben`x' = 0 	if pt_eli == 0 & country == "PT" & year == 2014
}

replace pt_dur = 0 if pt_eli == 0 & country == "PT" & year == 2014