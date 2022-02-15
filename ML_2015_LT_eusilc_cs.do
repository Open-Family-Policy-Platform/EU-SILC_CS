/* ML_2015_LT_eusilc_cs */


* LITHUANIA - 2015

* ELIGIBILITY
/*	-> employed, self-employed: for 12 months (coded) during past 2 years (not coded) 
	-> the leave is non-transferable => it is assumed that father is not entitled 
		if mother abandons the child
*/

replace ml_eli = 1 			if country == "LT" & year == 2015 & gender == 1 ///
							& inlist(econ_status,1,2) & (duremp+dursemp) >= 12

						
replace ml_eli = 0 			if ml_eli == . & country == "LT" & year == 2015 & gender == 1


* DURATION (weeks)
/*	-> prenatal: 70 calendar days
	-> postnatal: 56 calendar days 	*/
	
replace ml_dur1 = 70/5 		if country == "LT" & year == 2015 & ml_eli == 1

replace ml_dur2 = 56/5 		if country == "LT" & year == 2015 & ml_eli == 1


* BENEFIT (monthly)
/*	-> 100% average earninngs
	-> ceiling: €1,380/month (LP&R 2015)
	-> minimum: 1/3 of the insured income of the current year (not coded; contains code from 2018)
*/

replace ml_ben1 = earning 		if country == "LT" & year == 2015 & ml_eli == 1

replace ml_ben1 = 1380			if country == "LT" & year == 2015 & ml_eli == 1 ///
								& ml_ben1 >= 1380
										
replace ml_ben2 = ml_ben1 		if country == "LT" & year == 2015 & ml_eli == 1


foreach x in 1 2 {
    replace ml_dur`x' = 0 	if ml_eli == 0 & country == "LT" & year == 2015
	replace ml_ben`x' = 0 	if ml_eli == 0 & country == "LT" & year == 2015
}

