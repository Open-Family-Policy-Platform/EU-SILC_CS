/* PL_2017_PL_eusilc_cs */


* POLAND - 2017

* ELIGIBILITY
/*	-> parental leave (urlop rodzicielski) introduced for children born after 31.12.2012 (MISSOC; LP&R 2013 mentions 17.3.2013)
		-> eligibility as for maternity leave (employed)
		-> ML must be taken before
		-> family entitlement => couples - leave assigned to mother 
	 
	-> urlop wychowawczy (childcare leave) remains: NOT CODED
		-> employed for at least 6 months 	
		-> family entitlement => all assigned to the woman 	*/
	
replace pl_eli = 1 			if country == "PL" & year == 2017 & econ_status == 1 
replace pl_eli = 0			if pl_eli == . & country == "PL" & year == 2017


* DURATION (weeks)
/*	
	-> parental leave: 32 weeks for compulsorily insured employed 
	
	-> childcare leave (not coded): 24 months (MISSOC 2016; LP&R 2016 mentions 36 months) after maternity leave until the child is 5 years old (LP&R 2016; not coded)	
			
*/

* women
replace pl_dur = 32 		if country == "PL" & year == 2017 & pl_eli == 1 ///
							& gender == 1 & econ_status == 1

						
* single men
replace pl_dur = 32 		if country == "PL" & year == 2017 & pl_eli == 1 ///
							& gender == 2 & parstat == 1 & econ_status == 1


							
* BENEFIT (monthly)
/*	-> proportional benefits: 
		- woman choose 100% ML benefit (not coded): 100% earning for 6 weeks, 60% for 26 weeks (not coded)
		- woman choose 80% ML benefit (coded): 80% earning for the whole period
	-> flat-rate benefit (not coded): €235/month
 */

* women
replace pl_ben1 = earning*0.8		if country == "PL" & year == 2017 & pl_eli == 1 ///
									& econ_status == 1 & pl_dur != . & gender == 1
										
* single men 
replace pl_ben1 = earning*0.8		if country == "PL" & year == 2017 & pl_eli == 1 ///
									& econ_status == 1 & pl_dur != . & gender == 2 & parstat == 1


									
replace pl_ben2 = pl_ben1			if country == "PL" & year == 2017 & pl_eli == 1 ///
										& econ_status == 1 & pl_dur != . 


foreach x in 1 2 {
	replace pl_ben`x' = 0 	if pl_eli == 0 & country == "PL" & year == 2017
}

replace pl_dur = 0 	if pl_eli == 0 & country == "PL" & year == 2017
