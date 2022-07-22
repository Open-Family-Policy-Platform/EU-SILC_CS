/* ML_2020_GR_eusilc_cs */


* GREECE - 2020

/* NOTE: 	Maternity leave is different for employees in private and public sector. 
			The following code refers to maternity leave for private sector employees.
*/

* ELIGIBILITY
/*	-> employed
	-> self-employed (LP&R 2020)
	
	-> not transferable => assumed that single fathers are not eligible for this share of leave (M2020)		*/
	
replace ml_eli = 1 			if country == "GR" & year == 2020 & gender == 1 ///
							& inlist(econ_status,1,2)	
							
replace ml_eli = 0 			if ml_eli == . & country == "GR" & year == 2020 & gender == 1


* DURATION (weeks)
/*	-> total: 119 days
	-> prenatal: 56 days
	-> postnatal: 63 days 	*/
	
replace ml_dur1 = 56/5 		if country == "GR" & year == 2020 & ml_eli == 1

replace ml_dur2 = 63/5 		if country == "GR" & year == 2020 & ml_eli == 1


* BENEFIT (monthly)
/*	Due to considerable differences in the information provided by MISSOC and LP&R,
	the maternity leave benefits are not coded. 
*/
	
	
replace ml_ben1 = . 		if country == "GR" & year == 2020 & ml_eli == 1

replace ml_ben2 = . 		if country == "GR" & year == 2020 & ml_eli == 1


foreach x in 1 2 {
    replace ml_dur`x' = 0 	if ml_eli == 0 & country == "GR" & year == 2020
	replace ml_ben`x' = 0 	if ml_eli == 0 & country == "GR" & year == 2020
}

