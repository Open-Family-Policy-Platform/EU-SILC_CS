/* PT_2020_CZ_eusilc_cs */


* Czechia - 2020

* ELIGIBILITY
/*	-> 	employed (insured) */
replace pt_eli = 1 		if country == "CZ" & year == 2020 & gender == 2 ///
						& econ_status == 1
replace pt_eli = 0 		if pt_eli == . & country == "CZ" & year == 2020 & gender == 2


* DURATION (weeks)
/*	-> 1 week 
	-> can be taken within 6 weeks from the childbirth
*/
replace pt_dur = 1  	if country == "CZ" & year == 2020 & gender == 2 & pt_eli == 1 


* BENEFIT (monthly)
/*	-> daily assessment base:
		-> Benefits are not calculated from earnings but from a "daily assessment base" (MISSOC 01/07/2020) 
		-> up to €44/day = 100% daily earning
		-> €44 - €66/day = 60% daily earning
		-> €66/day = 30% daily earning  
		-> earning overe €133/day are not taken into account
	
	-> 70% of daily assessment base, ceiling: €54/day 
*/

** DAILY ASSESSMENT BASE
* daily earning < €44
gen dab = earning/21.7 				if country == "CZ" & year == 2020 & pt_eli == 1 ///
									& earning/21.7 < 44

* daily earning between €44 and €66
gen dab1 = 44 						if country == "CZ" & year == 2020 & pt_eli == 1 ///
									& inrange(earning/21.7,44,57)
gen dab2 = ((earning/21.7) - 44)*0.6 	if country == "CZ" & year == 2020 & pt_eli == 1 ///
										& inrange(earning/21.7,44,57)
replace dab = dab1 + dab2 				if country == "CZ" & year == 2020 & pt_eli == 1 ///
										& inrange(earning/21.7,44,57) & dab == .
drop dab1 dab2
										
* daily earning between €66 adn €133										
gen dab1 = 44 						if country == "CZ" & year == 2020 & pt_eli == 1 ///
									& inrange(earning/21.7,66,133)
gen dab2 = (66 - 44)*0.6 			if country == "CZ" & year == 2020 & pt_eli == 1 ///
									& inrange(earning/21.7,66,133)
gen dab3 = ((earning/21.7) - 66)*0.3 	if country == "CZ" & year == 2020 & pt_eli == 1 ///
										& inrange(earning/21.7,66,133)

replace dab = dab1 + dab2 + dab3  	if country == "CZ" & year == 2020 & pt_eli == 1 ///
									& inrange(earning/21.7,66,133) & dab == .									
drop dab1 dab2 dab3 

* daily earning over €133
gen dab1 = 44 						if country == "CZ" & year == 2020 & pt_eli == 1 ///
									& earning/21.7 > 133
gen dab2 = (66 - 44)*0.6 			if country == "CZ" & year == 2020 & pt_eli == 1 ///
									& earning/21.7 > 133
										
gen dab3 = (133 - 66)*0.3 			if country == "CZ" & year == 2020 & pt_eli == 1 ///
									& earning/21.7 > 133

replace dab = dab1 + dab2 + dab3 	if country == "CZ" & year == 2020 & pt_eli == 1 ///
									& earning/21.7 > 133 & dab == . 		

									
* Benefits
replace pt_ben1 = ((dab * 0.7) * 7) + (earning * ((4.3 - 1)/4.3))	///
							if country == "CZ" & year == 2020 & pt_eli == 1

replace pt_ben1 = (54 * 7) + (earning * ((4.3 - 1)/4.3)) ///
							if country == "CZ" & year == 2020 & pt_eli == 1 ///
							& dab*0.7 > 54 & pt_eli == 1


replace pt_ben2 = pt_ben1 	if country == "CZ" & year == 2020 & pt_eli == 1


foreach x in 1 2 {
	replace pt_ben`x' = 0 	if pt_eli == 0 & country == "CZ" & year == 2020
}

replace pt_dur = 0 if pt_eli == 0 & country == "CZ" & year == 2020

drop dab dab1 dab2 dab3 
