/* PL_2017_ES_eusilc_cs */


* SPAIN - 2017

* ELIGIBILITY
/*	-> employed
	-> self-employed
*/

replace pl_eli = 1 			if country == "ES" & year == 2017 & inlist(econ_status,1,2)
replace pl_eli =  0			if pl_eli == . & country == "ES" & year == 2017


* DURATION (weeks)
/*	-> until child is 3 years old => family entitlement, in couples all assigned to women
	-> unclear whether there is a regional variation in duration of benefit payment => not coded 	
*/
	
replace pl_dur = (3*52) - ml_dur2 		if country == "ES" & year == 2017 & pl_eli == 1 ///
										& gender == 1 & ml_eli == 1

* single men										
replace pl_dur = (3*52) - pt_dur 		if country == "ES" & year == 2017 & pl_eli == 1 ///
										& gender == 2 & pt_eli == 1 & parstat == 1

* BENEFIT (monthly)
/*	-> unpaid
	-> regional variation (LP&R 2017):
		- Basque country: €271.25/month if earning < €20,000/year
						  €228/month if earning > €20,000/year
						  NUTS2 region code ES21
		- La Rioja: €250/month if family income < €40,000/year
					NUTS2 region code ES23 
	

*/
		
		
replace pl_ben1 = 0 		if country == "ES" & year == 2017 & pl_eli == 1

* Basque country
replace pl_ben1 = 271.25	if country == "ES" & year == 2017 & pl_eli == 1 ///
							& region == "ES21" & earning * 12 < 20000
replace pl_ben1 = 228		if country == "ES" & year == 2017 & pl_eli == 1 ///
							& region == "ES21" & earning * 12 >= 20000	

* La Rioja							
replace pl_ben1 = 250		if country == "ES" & year == 2017 & pl_eli == 1 ///
							& region == "ES23" & earning * 12 < 40000							

							
replace pl_ben2 = pl_ben1		if country == "ES" & year == 2017 & pl_eli == 1



foreach x in 1 2 {
	replace pl_ben`x' = 0 	if country == "ES" & year == 2017 & pl_eli == 0
}

replace pl_dur = 0 	if country == "ES" & year == 2017 & pl_eli == 0
