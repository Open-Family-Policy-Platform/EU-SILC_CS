/* PT_2018_CZ_eusilc_cs */


* Czechia - 2018

* ELIGIBILITY
/*	-> 	employed (insured) */
replace pt_eli = 1 		if country == "CZ" & year == 2018 & gender == 2 ///
						& econ_status == 1
replace pt_eli = 0 		if pt_eli == . & country == "CZ" & year == 2018 & gender == 2


* DURATION (weeks)
/*	-> 1 week 
	-> can be taken within 6 months from the childbirth
*/
replace pt_dur = 1  	if country == "CZ" & year == 2018 & gender == 2 & pt_eli == 1 // MISSOC 01/07/2018


* BENEFIT (monthly)
/*	-> daily assessment base:
		-> Benefits are not calculated from earnings but from a "daily assessment base" (MISSOC 01/07/2018) 
		-> up to €38/day = 100% daily earning
		-> €38 - €58/day = 60% daily earning
		-> €58/day = 30% daily earning  
		-> earning over €115/day are not taken into account
	
	-> 70% of daily assessment base
	-> ceiling: €47/day 
*/

** DAILY ASSESSMENT BASE

* daily earning < €38
gen dab = earning/21.7 				if country == "CZ" & year == 2018 & pt_eli == 1 ///
									& earning/21.7 < 38
									
* daily earning between €38 and €58
gen dab1 = 38 						if country == "CZ" & year == 2018 & pt_eli == 1 ///
									& inrange(earning/21.7,38,57)
gen dab2 = ((earning/21.7) - 38)*0.6 	if country == "CZ" & year == 2018 & pt_eli == 1 ///
										& inrange(earning/21.7,38,57)
replace dab = dab1 + dab2 				if country == "CZ" & year == 2018 & pt_eli == 1 ///
										& inrange(earning/21.7,38,57) & dab == .
drop dab1 dab2
										
* daily earning between €58 adn €115										
gen dab1 = 38 						if country == "CZ" & year == 2018 & pt_eli == 1 ///
									& inrange(earning/21.7,58,115)
gen dab2 = (58 - 38)*0.6 			if country == "CZ" & year == 2018 & pt_eli == 1 ///
									& inrange(earning/21.7,58,115)
gen dab3 = ((earning/21.7) - 58)*0.3 	if country == "CZ" & year == 2018 & pt_eli == 1 ///
										& inrange(earning/21.7,58,115)

replace dab = dab1 + dab2 + dab3  	if country == "CZ" & year == 2018 & pt_eli == 1 ///
									& inrange(earning/21.7,58,115) & dab == .									
drop dab1 dab2 dab3 

* daily earning over €115
gen dab1 = 38 						if country == "CZ" & year == 2018 & pt_eli == 1 ///
									& earning/21.7 > 115
gen dab2 = (58 - 38)*0.6 			if country == "CZ" & year == 2018 & pt_eli == 1 ///
									& earning/21.7 > 115
										
gen dab3 = (115 - 58)*0.3 			if country == "CZ" & year == 2018 & pt_eli == 1 ///
									& earning/21.7 > 115

replace dab = dab1 + dab2 + dab3 	if country == "CZ" & year == 2018 & pt_eli == 1 ///
									& earning/21.7 > 115 & dab == . 		

									
* Benefits

replace pt_ben1 = ((dab * 0.7) * pt_dur) + (earning * ((4.3 - 1)/4.3))	///
							if country == "CZ" & year == 2018 & pt_eli == 1
							
							
replace pt_ben1 = (47 * pt_dur) + (earning * ((4.3 - 1)/4.3))	///
							if country == "CZ" & year == 2018 & pt_eli == 1 ///
							& dab*0.7 >= 47 & pt_eli == 1


replace pt_ben2 = pt_ben1 	if country == "CZ" & year == 2018 & pt_eli == 1


foreach x in 1 2 {
	replace pt_ben`x' = 0 	if pt_eli == 0 & country == "CZ" & year == 2018
}

replace pt_dur = 0 if pt_eli == 0 & country == "CZ" & year == 2018

drop dab dab1 dab2 dab3 
