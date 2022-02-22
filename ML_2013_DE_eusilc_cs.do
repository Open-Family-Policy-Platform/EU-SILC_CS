/* ML_2013_DE_eusilc_cs */


* GERMANY - 2013

* ELIGIBILITY
/*	-> employed
	-> self-employed if voluntarily insured (not coded)
	-> unemployed 
	-> the leave is not transferable to father => 
		it is assumed that single fathers are not entitled to this portion of leave
*/
	
replace ml_eli = 1 			if country == "DE" & year == 2013 & gender == 1 ///
							& inlist(econ_status,1,3)
replace ml_eli = 0 			if ml_eli == . & country == "DE" & year == 2013 & gender == 1


* DURATION (weeks)
/*	-> total leave: 14 weeks
	-> prenatal: 6 weeks
	-> postnatal: 8 weeks
	-> postnatal if multiple births, premature births, child's disability: 12 weeks (not coded) 
	*/
	
replace ml_dur1 = 6 		if country == "DE" & year == 2013 & ml_eli == 1

replace ml_dur2 = 8 		if country == "DE" & year == 2013 & ml_eli == 1


* BENEFIT (monthly)
/*	-> 100% earnings, no ceiling (LP&R 2013)
	-> use net earnings (coded with gross earnings!)
	-> unemployed: 100% unemployment benefits (not coded) 
*/
	
replace ml_ben1 = earning 		if country == "DE" & year == 2013 & ml_eli == 1

replace ml_ben2 = ml_ben1 		if country == "DE" & year == 2013 & ml_eli == 1


foreach x in 1 2 {
    replace ml_dur`x' = 0 	if ml_eli == 0 & country == "DE" & year == 2013
	replace ml_ben`x' = 0 	if ml_eli == 0 & country == "DE" & year == 2013
}

