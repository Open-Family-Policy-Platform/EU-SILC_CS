/* PL_2010_LT_eusilc_cs */


* LITHUANIA - 2010

* ELIGIBILITY
/*	-> employed, for 12 months (coded) in past 2 years (not coded)
		-> the condition does not apply for parents younger than 26
	-> family entitlement => in couples assigned to women
*/

replace pl_eli = 1 			if country == "LT" & year == 2010 & econ_status == 1 ///
							& duremp >= 12
							
replace pl_eli = 1			if country == "LT" & year == 2010 & econ_status == 1 ///
							& age <= 26

							
replace pl_eli =  0			if pl_eli == . & country == "LT" & year == 2010


* DURATION (weeks)
/*	-> maximum 2 years from the year of birth		*/

* women	
replace pl_dur = 104-ml_dur2 		if country == "LT" & year == 2010 & pl_eli == 1 ///
									& gender == 1

* single men
replace pl_dur = 104-pt_dur 			if country == "LT" & year == 2010 & pl_eli == 1 ///
									& gender == 2 & parstat == 1
									

									


* BENEFIT (monthly)
/* 	-> choice of leave until child is 1: 100%
	-> choice of leave until child is 2: 
		- 85% for the 2nd year 
	-> minimum: 1/3 of the insured income
	-> ceiling: 5 times the national average insured income
*/
		
replace pl_ben1 = earning 		if country == "LT" & year == 2010 & pl_eli == 1
								
//replace pl_ben1 = 1379	 		if country == "LT" & year == 2010 & pl_eli == 1 ///
								& pl_ben1 >= 1379


replace pl_ben2 = pl_ben1		if country == "LT" & year == 2010 & pl_eli == 1

foreach x in 1 2 {
	replace pl_ben`x' = 0 	if pl_eli == 0 & country == "LT" & year == 2010
}

replace pl_dur = 0 	if pl_eli == 0 & country == "LT" & year == 2010
