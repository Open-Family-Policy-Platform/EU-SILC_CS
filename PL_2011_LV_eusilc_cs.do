/* PL_2011_LV_eusilc_cs */


* LATVIA - 2011

* ELIGIBILITY
/*	-> 2 types of benefits:
		-> parental benefit
			-> employed
			-> self-employed
		-> childraisin allowance:
			-> all residents

	-> leave benefits are family entitlement => assigned to women 		*/
	
replace pl_eli = 1 			if country == "LV" & year == 2011 
replace pl_eli =  0			if pl_eli == . & country == "LV" & year == 2011


* DURATION (weeks)
/*	-> parental benefit: until the child is 1 
	-> childraising allowance: until child is 2	
		-> available to all parents 	*/

* women	eligible for maternity leave
replace pl_dur =  52 - ml_dur2		if country == "LV" & year == 2011 & pl_eli == 1 ///
									& inlist(econ_status,1,2) & gender == 1
									
* women, unemployed or inactive									
replace pl_dur = 2*52				if country == "LV" & year == 2011 & pl_eli == 1 ///
									& inlist(econ_status,3,4) & gender == 1
							
* single men, eligible for maternity leave
replace pl_dur = 52 - ml_dur2		if country == "LV" & year == 2011 & pl_eli == 1 ///
									& inlist(econ_status,1,2) & gender == 2 & parstat == 1
* single men, unemployed or inactive
replace pl_dur = 2*52 				if country == "LV" & year == 2011 & pl_eli == 1 ///
									& inlist(econ_status,3,4) & gender == 2 & parstat == 1
							

* BENEFIT (monthly)
/*	-> employed, self-employed: 70%
		-> minimum: €89/month
	-> unemployed, inactive:
		-> child under 1 year: €71/month
		-> child 1-2: €43/month
	
*/	
	
* women, employed or self-employed
replace pl_ben1 = 0.7* earning 		if country == "LV" & year == 2011 & pl_eli == 1 ///
									& inlist(econ_status,1,2) & gender == 1
replace pl_ben1 = 89			if country == "LV" & year == 2011 & pl_eli == 1 ///
									& inlist(econ_status,1,2) & gender == 1 ///
									& pl_ben1 < 89
									
* women, unemployed/inactive
replace pl_ben1 = ((71 * (1/2)) + (43 * (1/2))) 	if country == "LV" & year == 2011 & pl_eli == 1 ///
									& inlist(econ_status,1,2) & gender == 1
* single men, employed or self-employed
replace pl_ben1 = 0.7* earning 		if country == "LV" & year == 2011 & pl_eli == 1 ///
									& inlist(econ_status,1,2) & gender == 2 & parstat == 1
replace pl_ben1 = 89			if country == "LV" & year == 2011 & pl_eli == 1 ///
									& inlist(econ_status,1,2) & gender == 2 & parstat == 1 ///
									& pl_ben1 < 89
replace pl_ben1 = ((71 * (1/2)) + (43 * (1/2))) 	if country == "LV" & year == 2011 & pl_eli == 1 ///
									& inlist(econ_status,1,2) & gender == 2 & parstat == 1
											
replace pl_ben2 = pl_ben1 			if country == "LV" & year == 2011 & pl_eli == 1 ///
									& inlist(econ_status,1,2) 
replace pl_ben2 = 71				if country == "LV" & year == 2011 & pl_eli == 1 ///
									& inlist(econ_status,3,4) & gender == 1
replace pl_ben2 = 71				if country == "LV" & year == 2011 & pl_eli == 1 ///
									& inlist(econ_status,3,4) & gender == 2 & parstat == 1									
								
					
foreach x in 1 2 {
	replace pl_ben`x' = 0 	if pl_eli == 0 & country == "LV" & year == 2011
}
replace pl_dur = 0 	if pl_eli == 0 & country == "LV" & year == 2011
