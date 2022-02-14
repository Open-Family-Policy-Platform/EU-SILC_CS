/* PL_2016_PL_eusilc_cs */


* POLAND - 2016

* ELIGIBILITY
/*	-> proportional benefits: compulsorily insured employed parents
			- voluntarily insured self-employed (not coded)
	-> flat-rate benefits: everyone else 	*/
	
replace pl_eli = 1 			if country == "PL" & year == 2016 
replace pl_eli = 0			if pl_eli == . & country == "PL" & year == 2016


* DURATION (weeks)
/*	-> family entitlement => couples - leave assigned to mother 
	-> 32 weeks for compulsorily insured employed
	-> 52 weeks for everyon else 		
*/

replace pl_dur = 32 		if country == "PL" & year == 2016 & pl_eli == 1 ///
							& gender == 1 & econ_status == 1
replace pl_dur = 52 		if country == "PL" & year == 2016 & pl_eli == 1 ///
							& gender == 1 & inrange(econ_status,2,4)
							

* single men
replace pl_dur = 32 		if country == "PL" & year == 2016 & pl_eli == 1 ///
							& gender == 2 & parstat == 1 & econ_status == 1
replace pl_dur = 52 		if country == "PL" & year == 2016 & pl_eli == 1 ///
							& gender == 2 & parstat == 1 & inrange(econ_status,2,4)

							
* BENEFIT (monthly)
/*	-> proportional benefits: 
		- woman choose 100% ML benefit: 100% earning for 6 weeks, 60% for 26 weeks (not coded)
		- woman choose 80% ML benefit: 80% earning for the whole period
	-> flat-rate benefit: €226/month
 */
 
replace pl_ben1 = earning*0.8 		if country == "PL" & year == 2016 & pl_eli == 1 ///
									& econ_status == 1 & pl_dur != .
replace pl_ben1 = 226				if country == "PL" & year == 2016 & pl_eli == 1 ///
									& inrange(econ_status,2,4) & pl_dur != .
									
replace pl_ben2 = pl_ben1			if country == "PL" & year == 2016 & pl_eli == 1


foreach x in 1 2 {
	replace pl_ben`x' = 0 	if pl_eli == 0 & country == "PL" & year == 2016
}

replace pl_dur = 0 	if pl_eli == 0 & country == "PL" & year == 2016
