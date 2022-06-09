/* ML_2010_CZ_eusilc_cs */


* Czechia - 2010

* ELIGIBILITY
/*	-> employed: 270 days of compulsory insurance (coded) during 2 years before childbirth (not coded)
	-> self-employed: 180 days of sickness insurance contribution during 1 year before 
			ML + total 270 days of contribution over 2 years period before ML 	
		-> voluntary participation in sickness insurance (not coded)
	-> time spent in education counts towards the qualifying period of 270 days
		

	-> transfer to father: after 6 weeks, mother's consent => assumed that single father is not
		automatically entitled to the benefit
*/


 
replace ml_eli = 1 		if country == "CZ" & year == 2010 & gender == 1 ///
						& econ_status == 1 & (duremp + duredu) >= 12

replace ml_eli = 0 		if ml_eli == . & country == "CZ" & year == 2010 & gender == 1



* DURATION (weeks)
/*	-> total: 28 weeks
	-> prenatal: 6 weeks 
*/

replace ml_dur1 = 6 	if country == "CZ" & year == 2010 & gender == 1 & ml_eli == 1

replace ml_dur2 = 28-6 	if country == "CZ" & year == 2010 & gender == 1 & ml_eli == 1



* BENEFIT (monthly)
/* 	-> Benefits are not calculated from earnings but from a "daily assessment base" (MISSOC 01/07/2010) 
	-> daily assessment base:
		-> up to €33/day = 100% daily earning
		-> €33 - €50/day = 60% daily earning
		-> €50/day = 30% daily earning  
		-> earnings over €100/day are not taken into account
*/

** DAILY ASSESSMENT BASE:
* daily earning < €33
gen dab = earning/21.7 				if country == "CZ" & year == 2010 & ml_eli == 1 ///
									& earning/21.7 < 33

* daily earning between €33 and €50
gen dab1 = 33					if country == "CZ" & year == 2010 & ml_eli == 1 ///
									& inrange(earning/21.7,33,50)
gen dab2 = ((earning/21.7) - 33)*0.6 	if country == "CZ" & year == 2010 & ml_eli == 1 ///
										& inrange(earning/21.7,33,50)
replace dab = dab1 + dab2 				if country == "CZ" & year == 2010 & ml_eli == 1 ///
										& inrange(earning/21.7,33,50) & dab == .
drop dab1 dab2
										
* daily earning between €50 and €100										
gen dab1 = 33 						if country == "CZ" & year == 2010 & ml_eli == 1 ///
									& inrange(earning/21.7,50,100)
gen dab2 = (50 - 33)*0.6 			if country == "CZ" & year == 2010 & ml_eli == 1 ///
									& inrange(earning/21.7,50,100)
gen dab3 = ((earning/21.7) - 50)*0.3 	if country == "CZ" & year == 2010 & ml_eli == 1 ///
										& inrange(earning/21.7,50,100)

replace dab = dab1 + dab2 + dab3  	if country == "CZ" & year == 2010 & ml_eli == 1 ///
									& inrange(earning/21.7,50,100) & dab == .									
drop dab1 dab2 dab3 

* daily earning over €100
gen dab1 = 33 						if country == "CZ" & year == 2010 & ml_eli == 1 ///
									& earning/21.7 > 100
gen dab2 = (50 - 33)*0.6 			if country == "CZ" & year == 2010 & ml_eli == 1 ///
									& earning/21.7 > 100
										
gen dab3 = (100 - 50)*0.3 			if country == "CZ" & year == 2010 & ml_eli == 1 ///
									& earning/21.7 > 100

replace dab = dab1 + dab2 + dab3 	if country == "CZ" & year == 2010 & ml_eli == 1 ///
									& earning/21.7 > 100 & dab == . 										
										
										


/*	-> 70% of daily assessment base, ceiling: €41/day */

replace ml_ben1 = (dab*0.7) * 21.7 		if country == "CZ" & year == 2010 & gender == 1 & ml_eli == 1
replace ml_ben1 = 41*21.7 				if ml_ben1 >= 41*21.7


replace ml_ben2 = ml_ben1 		if country == "CZ" & year == 2010 & gender == 1 & ml_eli == 1



foreach x in 1 2 {
    replace ml_dur`x' = 0 	if ml_eli == 0 & country == "CZ" & year == 2010
	replace ml_ben`x' = 0 	if ml_eli == 0 & country == "CZ" & year == 2010
}



drop dab1 dab2 dab3
