/* ML_2012_PT_eusilc_cs */

* PORTUGAL - 2012

* ELIGIBILITY
/*	-> pooled rights (i.e. individual and family rights to leave)
		- total leave: 120 or 150 (parents' choice)
		- ML refers to the leave reserved for mother
	-> compulsorily social insurance for employed and self-employed 
		- 6 months of work before childbirth	
	-> transferable to father only if the mother dies or is incapacitated => 
		we assume that this does not extend to abandonment of child by the mother 
*/
	
replace ml_eli = 1 			if country == "PT" & year == 2012 & gender == 1 ///
							& inlist(econ_status,1,2) & duremp >= 6

							
replace ml_eli = 0 			if ml_eli == . & country == "PT" & year == 2012 & gender == 1


* DURATION (weeks)
/*	-> postnatal leave: 6 weeks
	-> prenatal leave: no compulsory leave, option of 30 days from the leave (not coded) */
replace ml_dur1 = 0 		if country == "PT" & year == 2012 & ml_eli == 1

replace ml_dur2 = 6 		if country == "PT" & year == 2012 & ml_eli == 1



* BENEFIT (monthly)
/*	-> benefits are identical for all types of leave (reserved for mother, father, shared leave)
	-> influenced by parents' choice of duration (120 or 150 days) and whether leave is shared 
	-> 120 days: 100% earning
	-> 150 days, not shared: 80% earning
	-> 150 days, shared: 100% earning
	-> 180 days, shared: 83% earning 
	-> minimum: €419.22/month 
	-> most generous option coded (100%)*/

replace ml_ben1 = earning 		if country == "PT" & year == 2012 & ml_eli == 1
replace ml_ben1 = 419.22		if country == "PT" & year == 2012 & ml_eli == 1 ///
								& ml_ben1 < 419.22
								
replace ml_ben2 = ml_ben1 		if country == "PT" & year == 2012 & ml_eli == 1

foreach x in 1 2 {
    replace ml_dur`x' = 0 	if ml_eli == 0 & country == "PT" & year == 2012
	replace ml_ben`x' = 0 	if ml_eli == 0 & country == "PT" & year == 2012
}

