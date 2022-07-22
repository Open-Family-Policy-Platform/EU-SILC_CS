/* ML_2020_LU_eusilc_cs */


* LUXEMBOURG - 2020

* ELIGIBILITY
/*	-> employed, self-employed: working for at least 6 months 

	-> is not transferable => assumed no eligibility for fathers when mother abandoned the child
*/

replace ml_eli = 1 			if country == "LU" & year == 2020 & gender == 1 ///
							& inlist(econ_status,1,2) & (duremp+dursemp) >= 6
							
							
replace ml_eli = 0 			if ml_eli == . & country == "LU" & year == 2020 & gender == 1


* DURATION (weeks)
/*	-> prenatal: 8 weeks
	-> postnatal: 12 weeks		*/
	
replace ml_dur1 = 8 		if country == "LU" & year == 2020 & ml_eli == 1

replace ml_dur2 = 12 		if country == "LU" & year == 2020 & ml_eli == 1


* BENEFIT (monthly)
/*	-> 100% earning
	-> minimum: €2,141.99/month
	-> maximum: €10,709.97/month 		
*/

replace ml_ben1 = earning 		if country == "LU" & year == 2020 & ml_eli == 1

replace ml_ben1 = 2141.99  		if country == "LU" & year == 2020 & ml_eli == 1 ///
								& ml_ben1 < 2141.99
								
replace ml_ben1 = 10709.97 		if country == "LU" & year == 2020 & ml_eli == 1 ///
								& ml_ben1 >= 10709.97

			 
								
replace ml_ben2 = ml_ben1 		if country == "LU" & year == 2020 & ml_eli == 1


foreach x in 1 2 {
    replace ml_dur`x' = 0 	if ml_eli == 0 & country == "LU" & year == 2020
	replace ml_ben`x' = 0 	if ml_eli == 0 & country == "LU" & year == 2020
}

