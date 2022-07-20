/* PL_2013_PL_eusilc_cs */


* POLAND - 2013

* ELIGIBILITY
/*	-> parental leave (urlop rodzicielski) introduced for children born after 31.12.2012 (MISSOC; LP&R 2013 mentions 17.3.2013)
		-> eligibility as for maternity leave (employed)
	
	-> urlop wychowawczy (childcare leave) remains: NOT CODED
		-> employed for at least 6 months 	
		-> family entitlement => all assigned to the woman
*/
	
replace pl_eli = 1 			if country == "PL" & year == 2013 & econ_status == 1
replace pl_eli = 0			if pl_eli == . & country == "PL" & year == 2013



* DURATION (weeks)
/*	
	-> parental leave: 26 weeks for compulsorily insured employed 
	
	-> childcare leave (not coded): 24 months (MISSOC 2013; LP&R 2013 mentions 36 months) after maternity leave until the child is 5 years old (LP&R 2013; not coded)
	
*/

* women  
replace pl_dur = (26/4.3)		if country == "PL" & year == 2013 & pl_eli == 1 ///
								& gender == 1 
																						
* single men
replace pl_dur = (26/4.3) 		if country == "PL" & year == 2013 & pl_eli == 1 ///
								& gender == 2 & parstat == 1 
								


							
* BENEFIT (monthly)
/*	-> if mother choose 80% ML benefit => 80% (coded)
	-> flat-rate benefit: €96/month if household income per capita doesn't exceed €132/month (LP&R 2013; not coded)
 */
 
* women 
replace pl_ben1 = 0.8*earning				if country == "PL" & year == 2013 & pl_eli == 1 & gender == 1 
											


* single men 
replace pl_ben1 = 0.8*earning				if country == "PL" & year == 2013 & pl_eli == 1 & gender == 2 & parstat == 1
																																

replace pl_ben2 = pl_ben1			if country == "PL" & year == 2013 & pl_eli == 1


foreach x in 1 2 {
	replace pl_ben`x' = 0 	if pl_eli == 0 & country == "PL" & year == 2013
}

replace pl_dur = 0 	if pl_eli == 0 & country == "PL" & year == 2013
