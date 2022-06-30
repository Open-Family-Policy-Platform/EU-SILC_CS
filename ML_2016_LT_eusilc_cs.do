/* ML_2016_LT_eusilc_cs */


* LITHUANIA - 2016

* ELIGIBILITY
/*	-> insured employed: for 12 months (coded) during past 2 years (not coded) 
		-> the condition of 12 months is not required for mothers under 26 (MISSOC 07/2016)
	-> self-employed may join the insurance voluntarily => not coded
	-> the leave is non-transferable => it is assumed that father is not entitled 
		if mother abandons the child
*/

replace ml_eli = 1 			if country == "LT" & year == 2016 & gender == 1 ///
							& econ_status == 1 & duremp >= 12 & age >= 26
							
replace ml_eli = 1 			if country == "LT" & year == 2016 & gender == 1 ///
							& econ_status == 1 & age < 26


						
replace ml_eli = 0 			if ml_eli == . & country == "LT" & year == 2016 & gender == 1


* DURATION (weeks)
/*	-> prenatal: 70 calendar days
	-> postnatal: 56 calendar days 	*/
	
replace ml_dur1 = 70/5 		if country == "LT" & year == 2016 & ml_eli == 1

replace ml_dur2 = 56/5 		if country == "LT" & year == 2016 & ml_eli == 1


* BENEFIT (monthly)
/*	-> 100% average earninngs
	-> ceiling: 3.2 times average insured monthly income, €1,380/month. (source: LP&R 2016)
	-> minimum: 1/3 of the insured income of the current year (not coded; contains code from 2018)
*/

replace ml_ben1 = earning 		if country == "LT" & year == 2016 & ml_eli == 1

replace ml_ben1 = 6*38			if country == "LT" & year == 2016 & ml_eli == 1 ///
								& ml_ben1 < 6*38
replace ml_ben1 = 1380			if country == "LT" & year == 2016 & ml_eli == 1 ///
								& ml_ben1 >= 1380
										
replace ml_ben2 = ml_ben1 		if country == "LT" & year == 2016 & ml_eli == 1


foreach x in 1 2 {
    replace ml_dur`x' = 0 	if ml_eli == 0 & country == "LT" & year == 2016
	replace ml_ben`x' = 0 	if ml_eli == 0 & country == "LT" & year == 2016
}

