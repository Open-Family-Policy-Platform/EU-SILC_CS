/* PL_2018_LT_eusilc_cs */


* LITHUANIA - 2018

* ELIGIBILITY
/*	-> employed, self-employed for 12 months (coded) in past 2 years (not coded)
	-> family entitlement => in couples assigned to women
*/

replace pl_eli = 1 			if country == "LT" & year == 2018 & inlist(econ_status,1,2) ///
							& (duremp+dursemp) >= 12

							
replace pl_eli =  0			if pl_eli == . & country == "LT" & year == 2018


* DURATION (weeks)
/*	-> parents can choose the duration of leave:
		-> until child is 1 year old (coded)
		-> until child is 2 years old
		-> until child is 3 
		-> the choice affects the benefit payment (see "BENEFIT")
	-> more generous option coded (until child is 1)	*/

* women	
replace pl_dur = 52-ml_dur2 		if country == "LT" & year == 2018 & pl_eli == 1 ///
									& gender == 1

* single men
replace pl_dur = 52-pt_dur 			if country == "LT" & year == 2018 & pl_eli == 1 ///
									& gender == 2 & parstat == 1
									

									


* BENEFIT (monthly)
/* 	-> choice of leave until child is 1: 100%
		-> ceiling: €1,617.40/month (coded)
	-> choice of leave until child is 2: not coded
		- 70% earnings until child is 1, ceiling: €1,132.18/month
		- 40% of earnings for the rest of the leave, ceiling: €646.98/month 
	-> between 2nd and 3rd year: unpaid
*/

* women		
replace pl_ben1 = earning 		if country == "LT" & year == 2018 & pl_eli == 1 & gender ==1
								
replace pl_ben1 = 1617.40 		if country == "LT" & year == 2018 & pl_eli == 1 ///
								& pl_ben1 >= 1617.40 & gender == 1

* single men
replace pl_ben1 = earning 		if country == "LT" & year == 2018 & pl_eli == 1 & gender == 2 & parstat == 1
								
replace pl_ben1 = 1617.40 		if country == "LT" & year == 2018 & pl_eli == 1 ///
								& pl_ben1 >= 1617.40 & gender == 2 & parstat == 1
								

replace pl_ben2 = pl_ben1		if country == "LT" & year == 2018 & pl_eli == 1

foreach x in 1 2 {
	replace pl_ben`x' = 0 	if pl_eli == 0 & country == "LT" & year == 2018
}

replace pl_dur = 0 	if pl_eli == 0 & country == "LT" & year == 2018
