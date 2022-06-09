/* ML_2010_IT_eusilc_cs */


* ITALY - 2010

* ELIGIBILITY
/*	-> employed
	-> self-employed
	-> non-working (inactive, unemployed): 3 months of work in 9 months time frame;
		benefits are means-tested and targeted at low income families. The means-test 
 		is determined by municipalities and varies => not coded 	
	-> if mother doesn't claim, father can claim up to 3 months => coded for single men  
	
	-> qualifying conditions for self-employed, farming industry employees, domestic workers, 
		professionals and atypical workers: not specified in the sources => not coded
*/
		
replace ml_eli = 1 			if country == "IT" & year == 2010 & gender == 1 ///
							& inrange(econ_status,1,2)

	* single men						
replace ml_eli = 1 			if country == "IT" & year == 2010 & gender == 2 ///
							& inrange(econ_status,1,2) & parstat == 1
							
replace ml_eli = 0 			if ml_eli == . & country == "IT" & year == 2010 & gender == 1


* DURATION (weeks)
/*	-> total: 5 months 
	-> prenatal: 1 month
	-> father if mother doesn't claim: 3 months 			*/
	
replace ml_dur1 = 4.3			if country == "IT" & year == 2010 & ml_eli == 1 & gender == 1

replace ml_dur2 = (5*4.3)-4.3 	if country == "IT" & year == 2010 & ml_eli == 1 & gender == 1

* single men
replace ml_dur2 = 3*4.3			if country == "IT" & year == 2010 & ml_eli == 1 & gender == 2 ///
								& parstat == 1



* BENEFIT (monthly)
/*	-> 80% earning, no ceiling  
	-> public sector employees are entitled to 100% for the first 30 days, no ceiling => not coded */

replace ml_ben1 = 0.8*earning 		if country == "IT" & year == 2010 & ml_eli == 1


replace ml_ben2 = ml_ben1 			if country == "IT" & year == 2010 & ml_eli == 1


foreach x in 1 2 {
    replace ml_dur`x' = 0 	if ml_eli == 0 & country == "IT" & year == 2010
	replace ml_ben`x' = 0 	if ml_eli == 0 & country == "IT" & year == 2010
}

