/* ML_2011_IT_eusilc_cs */


* ITALY - 2011

* ELIGIBILITY
/*	-> employed
	-> self-employed: voluntary insurance (not coded)
	-> non-working (inactive, unemployed): 3 months of work in 9 months time frame;
		benefits are means-tested and targeted at low income families. The means-test 
 		is determined by municipalities and varies => not coded 	
*/
		
replace ml_eli = 1 			if country == "IT" & year == 2011 & gender == 1 ///
							& econ_status == 1

							
replace ml_eli = 0 			if ml_eli == . & country == "IT" & year == 2011 & gender == 1


* DURATION (weeks)
/*	-> total: 5 months 
	-> prenatal: 1 month
*/
	
replace ml_dur1 = 4.3			if country == "IT" & year == 2011 & ml_eli == 1 & gender == 1

replace ml_dur2 = (5*4.3)-4.3 	if country == "IT" & year == 2011 & ml_eli == 1 & gender == 1




* BENEFIT (monthly)
/*	-> 80% earning, no ceiling  
*/

replace ml_ben1 = 0.8*earning 		if country == "IT" & year == 2011 & ml_eli == 1


replace ml_ben2 = ml_ben1 			if country == "IT" & year == 2011 & ml_eli == 1


foreach x in 1 2 {
    replace ml_dur`x' = 0 	if ml_eli == 0 & country == "IT" & year == 2011
	replace ml_ben`x' = 0 	if ml_eli == 0 & country == "IT" & year == 2011
}

