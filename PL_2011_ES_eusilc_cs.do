/* PL_2011_ES_eusilc_cs */


* SPAIN - 2011

* ELIGIBILITY
/*	-> employed
	-> self-employed
*/

replace pl_eli = 1 			if country == "ES" & year == 2011 & inlist(econ_status,1,2)
replace pl_eli =  0			if pl_eli == . & country == "ES" & year == 2011


* DURATION (weeks)
/*	-> until child is 3 years old => family entitlement, in couples all assigned to women
	-> unclear whether there is a regional variation in duration of benefit payment => not coded 	
*/
	
replace pl_dur = (3*52) - ml_dur2 		if country == "ES" & year == 2011 & pl_eli == 1 ///
										& gender == 1 & ml_eli == 1

* single men										
replace pl_dur = (3*52) - pt_dur 		if country == "ES" & year == 2011 & pl_eli == 1 ///
										& gender == 2 & pt_eli == 1 & parstat == 1

* BENEFIT (monthly)
/*	-> unpaid
	-> regional variation (LP&R 2011):
		- Basque country: €291/month if earning 
						  NUTS2 region code ES21
		- La Rioja: €250/month if family income < €40,000/year
					NUTS2 region code ES23 
		- Castilla-León: €532.51/month if family income < €30,000/year
		- Navarre: €417.27 for second child for one year 
		- Castilla-La Mancha: €600/month for women up to €3,000/year; men €900/month up to €7,000/year

*/
		
		
replace pl_ben1 = 0 		if country == "ES" & year == 2011 & pl_eli == 1

* Basque country
replace pl_ben1 = 291		if country == "ES" & year == 2011 & pl_eli == 1 ///
							& region == "ES21" & gender == 1						
							
* La Rioja							
replace pl_ben1 = 250		if country == "ES" & year == 2011 & pl_eli == 1 ///
							& region == "ES23" & (earning_yg + p_earning) < 40000 & gender == 1
							
* Castilla-León
replace pl_ben1 = 532.51		if country == "ES" & year == 2011 & pl_eli == 1 ///
							& region == "ES41" & (earning_yg + p_earning) < 30000 & gender == 1
							
* Navarre
replace pl_ben1 = 417.27		if country == "ES" & year == 2011 & pl_eli == 1 ///
							& region == "ES22" & gender == 1 & childc >= 2
							
* Castilla-La Mancha
replace pl_ben1 = 600	if country == "ES" & year == 2011 & pl_eli == 1 ///
							& region == "ES42" & gender == 1
						
replace pl_ben2 = pl_ben1		if country == "ES" & year == 2011 & pl_eli == 1



foreach x in 1 2 {
	replace pl_ben`x' = 0 	if country == "ES" & year == 2011 & pl_eli == 0
}

replace pl_dur = 0 	if country == "ES" & year == 2011 & pl_eli == 0
