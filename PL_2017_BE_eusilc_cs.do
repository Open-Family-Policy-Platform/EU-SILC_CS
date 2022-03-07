/* PL_2017_BE_eusilc_cs */


* BELGIUM - 2017

* ELIGIBILITY
/*	-> private sector: employees, 12 months (coded) of employement in last 15 months with the same employer (not 
		coded)
	-> public sector: employees (not coded; LP&R 2017)						*/
   
replace pl_eli = 1 		if country == "BE" & year == 2017 & pl_eli == . ///
						& econ_status == 1 & duremp >= 12 
replace pl_eli = 0 		if pl_eli == . & country == "BE" & year == 2017


* DURATION (weeks)
/*	-> 4 months 
	-> until child is 12 years old (not coded) 		*/
	
replace pl_dur = 4 * 4.3 	if country == "BE" & year == 2017 & pl_eli == 1


* BENEFIT (monthly)
/*	-> full-time workers (not single): €818.56/month 
	-> single parent: €1,129.61/month
*/

* single parent
replace pl_ben1 = 1129.61 		if country == "BE" & year == 2017 & pl_eli == 1 ///
								& parstat == 1
								
* cohabiting, married
replace pl_ben1 = 818.56 		if country == "BE" & year == 2017 & pl_eli == 1 ///
								& parstat == 2 & pl_ben1 == . 
			

replace pl_ben2 = pl_ben1 		if country == "BE" & year == 2017 & pl_eli == 1
								


foreach x in 1 2 {
	replace pl_ben`x' = 0 	if pl_eli == 0 & country == "BE" & year == 2017
}

replace pl_dur = 0 	if pl_eli == 0 & country == "BE" & year == 2017
