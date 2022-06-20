/* PT_2019_CZ_eusilc_cs */


* Czechia - 2019

* ELIGIBILITY
/*	-> 	employed (insured) */
replace pt_eli = 1 		if country == "CZ" & year == 2019 & gender == 2 ///
						& econ_status == 1
replace pt_eli = 0 		if pt_eli == . & country == "CZ" & year == 2019 & gender == 2


* DURATION (weeks)
/*	-> 1 week 
	-> can be taken within 6 months from the childbirth
*/
replace pt_dur = 1  	if country == "CZ" & year == 2019 & gender == 2 & pt_eli == 1 // MISSOC 01/07/2019


* BENEFIT (monthly)
/*	-> daily assessment base:
		-> Benefits are not calculated from earnings but from a "daily assessment base" (MISSOC 01/07/2019) 
		-> up to €43/day = 100% daily earning
		-> €43 - €64/day = 60% daily earning
		-> €64/day = 30% daily earning  
		-> earning overe €129/day are not taken into account
	
	-> 70% of daily assessment base, ceiling: €47/day 
*/

** DAILY ASSESSMENT BASE
* daily earning < €43
gen dab = earning/21.7 				if country == "CZ" & year == 2019 & pt_eli == 1 ///
									& earning/21.7 < 43

* daily earning between €43 and €64
gen dab1 = 43 						if country == "CZ" & year == 2019 & pt_eli == 1 ///
									& inrange(earning/21.7,43,57)
gen dab2 = ((earning/21.7) - 43)*0.6 	if country == "CZ" & year == 2019 & pt_eli == 1 ///
										& inrange(earning/21.7,43,57)
replace dab = dab1 + dab2 				if country == "CZ" & year == 2019 & pt_eli == 1 ///
										& inrange(earning/21.7,43,57) & dab == .
drop dab1 dab2
										
* daily earning between €64 adn €129										
gen dab1 = 43 						if country == "CZ" & year == 2019 & pt_eli == 1 ///
									& inrange(earning/21.7,64,129)
gen dab2 = (64 - 43)*0.6 			if country == "CZ" & year == 2019 & pt_eli == 1 ///
									& inrange(earning/21.7,64,129)
gen dab3 = ((earning/21.7) - 64)*0.3 	if country == "CZ" & year == 2019 & pt_eli == 1 ///
										& inrange(earning/21.7,64,129)

replace dab = dab1 + dab2 + dab3  	if country == "CZ" & year == 2019 & pt_eli == 1 ///
									& inrange(earning/21.7,64,129) & dab == .									
drop dab1 dab2 dab3 

* daily earning over €129
gen dab1 = 43 						if country == "CZ" & year == 2019 & pt_eli == 1 ///
									& earning/21.7 > 129
gen dab2 = (64 - 43)*0.6 			if country == "CZ" & year == 2019 & pt_eli == 1 ///
									& earning/21.7 > 129
										
gen dab3 = (129 - 64)*0.3 			if country == "CZ" & year == 2019 & pt_eli == 1 ///
									& earning/21.7 > 129

replace dab = dab1 + dab2 + dab3 	if country == "CZ" & year == 2019 & pt_eli == 1 ///
									& earning/21.7 > 129 & dab == . 		

									
* Benefits
replace pt_ben1 = ((dab * 0.7) * 7) + (earning * ((4.3 - 1)/4.3))	///
							if country == "CZ" & year == 2019 & pt_eli == 1

replace pt_ben1 = (47 * 7) + (earning * ((4.3 - 1)/4.3)) ///
							if country == "CZ" & year == 2019 & pt_eli == 1 ///
							& dab*0.7 > 47 & pt_eli == 1


replace pt_ben2 = pt_ben1 	if country == "CZ" & year == 2019 & pt_eli == 1


foreach x in 1 2 {
	replace pt_ben`x' = 0 	if pt_eli == 0 & country == "CZ" & year == 2019
}

replace pt_dur = 0 if pt_eli == 0 & country == "CZ" & year == 2019

drop dab dab1 dab2 dab3 
