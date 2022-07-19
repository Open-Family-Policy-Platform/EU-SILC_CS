/* PL_2019_LT_eusilc_cs */


* LITHUANIA - 2019

* ELIGIBILITY
/*	-> employed, self-employed for 12 months (coded) in past 2 years (not coded)
	-> family entitlement => in couples assigned to women
*/

replace pl_eli = 1 			if country == "LT" & year == 2019 & inlist(econ_status,1,2) ///
							& (duremp+dursemp) >= 12

							
replace pl_eli =  0			if pl_eli == . & country == "LT" & year == 2019


* DURATION (weeks)
/*	-> parents can choose the duration of leave:
		-> until child is 1 year old (coded)
		-> until child is 2 years old
		-> until child is 3 
		-> the choice affects the benefit payment (s
*/

* women	
replace pl_dur = 52-ml_dur2 		if country == "LT" & year == 2019 & pl_eli == 1 ///
									& gender == 1

* single men
replace pl_dur = 52-pt_dur 			if country == "LT" & year == 2019 & pl_eli == 1 ///
									& gender == 2 & parstat == 1
									

									


* BENEFIT (monthly)
/* 	-> choice of leave until child is 1: 77.58% (MISSOC 2019)
		-> ceiling: €1,617.40/month (coded; LP&R 2019)
	-> choice of leave until child is 2 (not coded) 
		- 54.31% earnings until child is 1, ceiling: €1,132.18/month 
		- 31.03% of earnings for the rest of the leave, ceiling: €646.98/month 
	
	-> Note: 	According to MISSOC there has been a decrease in the replacement rate between 2018 and 2019. 
				This change is not noted in LP&R 2019. The ceiling reported in LP&R 2019 are identical with
				the ceilings reported in 2018. 
*/
		
	* women
replace pl_ben1 = 0.7758*earning 		if country == "LT" & year == 2019 & pl_eli == 1 ///
										& gender == 1 
								
replace pl_ben1 = 1617.40 		if country == "LT" & year == 2019 & pl_eli == 1 ///
								& pl_ben1 >= 1617.40 & gender == 1
								
	* single men
replace pl_ben1 = earning 		if country == "LT" & year == 2019 & pl_eli == 1 ///
								& gender == 2 & parstat == 1 
								
replace pl_ben1 = 1617.40 		if country == "LT" & year == 2019 & pl_eli == 1 ///
								& pl_ben1 >= 1617.40 & gender == 2 & parstat == 1


replace pl_ben2 = pl_ben1		if country == "LT" & year == 2019 & pl_eli == 1

foreach x in 1 2 {
	replace pl_ben`x' = 0 	if pl_eli == 0 & country == "LT" & year == 2019
}

replace pl_dur = 0 	if pl_eli == 0 & country == "LT" & year == 2019
