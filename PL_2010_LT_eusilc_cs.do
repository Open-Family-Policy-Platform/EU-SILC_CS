/* PL_2010_LT_eusilc_cs */


* LITHUANIA - 2010

* ELIGIBILITY
/*	-> employed, for 12 months (coded) in past 2 years (not coded)
	-> family entitlement => in couples assigned to women
*/

replace pl_eli = 1 			if country == "LT" & year == 2010 & econ_status == 1 ///
							& duremp >= 12

							
replace pl_eli =  0			if pl_eli == . & country == "LT" & year == 2010



* DURATION (weeks)
/*	-> until child is 3 years old		*/

* women	
replace pl_dur = (3*52)-ml_dur2 		if country == "LT" & year == 2010 & pl_eli == 1 ///
									& gender == 1

* single men
replace pl_dur = (3*52)-pt_dur 			if country == "LT" & year == 2010 & pl_eli == 1 ///
									& gender == 2 & parstat == 1
									

									
* BENEFIT (monthly)
/* 	-> until child is 100%
	-> from 1 to 2: 85%  
	-> from 2 to 3 years the leave is unpaid
	-> minimum: 1/3 of the insured income 
	-> ceiling: 5 times the national average insured income - data missing => used data from LP&R 2012
*/

* women		
replace pl_ben1 = earning 		if country == "LT" & year == 2010 & pl_eli == 1 & gender == 1

replace pl_ben1 = 6*38			if country == "LT" & year == 2010 & pl_eli == 1 ///
								& pl_ben1 < 6*38 & gender == 1
								
replace pl_ben1 = 1379	 		if country == "LT" & year == 2010 & pl_eli == 1 ///
								& pl_ben1 >= 1379 & gender == 1
								
* single men
replace pl_ben1 = earning 		if country == "LT" & year == 2010 & pl_eli == 1 & gender == 2 & parstat == 1

replace pl_ben1 = 6*38			if country == "LT" & year == 2010 & pl_eli == 1 ///
								& pl_ben1 < 6*38 & gender == 2 & parstat == 1
								
replace pl_ben1 = 1379	 		if country == "LT" & year == 2010 & pl_eli == 1 ///
								& pl_ben1 >= 1379 & gender == 2 & parstat == 1



replace pl_ben2 = pl_ben1		if country == "LT" & year == 2010 & pl_eli == 1

foreach x in 1 2 {
	replace pl_ben`x' = 0 	if pl_eli == 0 & country == "LT" & year == 2010
}

replace pl_dur = 0 	if pl_eli == 0 & country == "LT" & year == 2010
