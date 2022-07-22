/* ML_2020_LT_eusilc_cs */


* LITHUANIA - 2020

* ELIGIBILITY
/*	-> employed, self-employed: for 12 months (coded) during past 2 years (not coded) 

	-> the leave is non-transferable => it is assumed that father is not entitled 
		if mother abandons the child
*/

replace ml_eli = 1 			if country == "LT" & year == 2020 & gender == 1 ///
							& inlist(econ_status,1,2) & (duremp + dursemp) >= 12
							
							
replace ml_eli = 0 			if ml_eli == . & country == "LT" & year == 2020 & gender == 1



* DURATION (weeks)
/*	-> prenatal: 70 calendar days
	-> postnatal: 56 calendar days 	*/
	
replace ml_dur1 = 70/5 		if country == "LT" & year == 2020 & ml_eli == 1

replace ml_dur2 = 56/5 		if country == "LT" & year == 2020 & ml_eli == 1



* BENEFIT (monthly)
/*	-> 77.58% average earnings, no ceiling  (NOTE: according to LP&R 2020 - 100%, no ceiling) 
	-> minimum: 6* Basic Social Benefit 
		-> Basic Social Benefit = €39 (M2020 mentions 6.43*BSB = €250.77)
*/

replace ml_ben1 = 0.7758*earning 		if country == "LT" & year == 2020 & ml_eli == 1

replace ml_ben1 = 6*39					if country == "LT" & year == 2020 & ml_eli == 1 ///
										& ml_ben1 < 6*39

replace ml_ben2 = ml_ben1 			if country == "LT" & year == 2020 & ml_eli == 1



foreach x in 1 2 {
    replace ml_dur`x' = 0 	if ml_eli == 0 & country == "LT" & year == 2020
	replace ml_ben`x' = 0 	if ml_eli == 0 & country == "LT" & year == 2020
}

