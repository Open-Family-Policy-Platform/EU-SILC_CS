/* PL_2010_CZ_eusilc_cs */


* CZECHIA - 2010

* ELIGIBILITY
/*	-> cash benefits are available to all residents
	-> all employees are entitled to parental leave 
	
	-> parental leave: individual entitlement
	-> benefit: family entitlement
*/
	
replace pl_eli = 1 		if country == "CZ" & year == 2010 
replace pl_eli = 0 		if pl_eli == . & country == "CZ" & year == 2010

* DURATION (weeks)
/*	-> parents choose the monthly benefit amount (determines also the duration of PL):
		-> short: until child is 24 months old, only if eliglbe for ML & earn at least €15/day 
		-> standard: until child is 36 months old, only if eligible for ML
		-> long: until child is 48 months old

	-> the most generous benefit is coded
   
	-> Social insurance is obligatory for employees, voluntary for self-employed (not coded)
	
	-> family entitlement => in couples, all leave is assigned to woman
*/

replace pl_dur = (24/4.3) - ml_dur2 	if country == "CZ" & year == 2010 & pl_eli == 1 & gender == 1 ///
										& ml_eli == 1 & (earning/21.7) >= 15
										
replace pl_dur = (36/4.3) - ml_dur2 	if country == "CZ" & year == 2010 & pl_eli == 1 & gender == 1 ///
										& ml_eli == 1 & pl_dur == . 
										
replace pl_dur = (48/4.3) 				if country == "CZ" & year == 2010 & pl_eli == 1 & gender == 1 ///
										& ml_eli == 0 & pl_dur == . 										
	


* BENEFIT (monthly)
/* 
	-> short: €442/month
	-> standard: €295/month
	-> long: €147/month
	
*/

replace pl_ben1 = 442			if country == "CZ" & year == 2010 & pl_eli == 1 & gender == 1 ///
								& ml_eli == 1 & (earning/21.7) >= 15
								
replace pl_ben1 = 295			if country == "CZ" & year == 2010 & pl_eli == 1 & gender == 1 ///
								& ml_eli == 1 & (earning/21.7) < 15
								
replace pl_ben1 = 147			if country == "CZ" & year == 2010 & pl_eli == 1 & gender == 1 ///
								& ml_eli == 0 & pl_ben1 == . 

replace pl_ben2 = pl_ben1 				if country == "CZ" & year == 2010 & pl_eli == 1 

foreach x in 1 2 {
	replace pl_ben`x' = 0 	if pl_eli == 0 & country == "CZ" & year == 2010
}

replace pl_dur = 0 	if pl_eli == 0 & country == "CZ" & year == 2010


