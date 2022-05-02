/* PL_2019_BE_eusilc_cs */


* BELGIUM - 2019

* ELIGIBILITY
/*	-> private sector: employees, 12 months (coded) of employment in last 15 months with the same employer (not 
		coded)
	-> public sector: employees (not coded; LP&R 2019)						
*/
   
replace pl_eli = 1 		if country == "BE" & year == 2019 & pl_eli == . ///
						& econ_status == 1 & duremp >= 12 
replace pl_eli = 0 		if pl_eli == . & country == "BE" & year == 2019


* DURATION (weeks)
/*	-> 4 months/parent/child
	-> non-transferable
	-> until child is 12 years old (not coded) 		*/
	
replace pl_dur = 4 * 4.3 	if country == "BE" & year == 2019 & pl_eli == 1


* BENEFIT (monthly)
/*	-> full-time workers (not single): €834.90/month 
	-> single parent: €1,313.48 /month
*/

* single parent
replace pl_ben1 = 1313.48 		if country == "BE" & year == 2019 & pl_eli == 1 ///
								& parstat == 1
								
* cohabiting, married
replace pl_ben1 = 834.90 		if country == "BE" & year == 2019 & pl_eli == 1 ///
								& parstat == 2 & pl_ben1 == . 
			

replace pl_ben2 = pl_ben1 		if country == "BE" & year == 2019 & pl_eli == 1 



foreach x in 1 2 {
	replace pl_ben`x' = 0 	if pl_eli == 0 & country == "BE" & year == 2019
}

replace pl_dur = 0 	if pl_eli == 0 & country == "BE" & year == 2019
