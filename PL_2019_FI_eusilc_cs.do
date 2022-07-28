/* MS_PL_2019_FI_eusilc_cs */


* FINLAND - 2019

* ELIGIBILITY
/*	-> all residents
	-> non-residents: 4 months of employment or self-employment (not coded)
	-> family entitlement
 */
replace pl_eli = 1 			if country == "FI" & year == 2019 
			
replace pl_eli = 0 			if pl_eli == . & country == "FI" & year == 2019


* DURATION (weeks)
/* 	
	-> 158 days 
	-> couples: assigned to women
*/
   
replace pl_dur = 158/6 		if country == "FI" & year == 2019 & pl_eli == 1 ///
								& gender == 1

* single men
replace pl_dur = 158/6 		if country == "FI" & year == 2019 & pl_eli == 1 ///
								& gender == 2 & parstat == 1



* BENEFIT (monthly)
/*	-> € 27.86/day if earnings are less than €11,942/year (income group a; LP&R 2019)
	-> 70% of earnings between €11,942 and €37,861 (IG b)
	-> 40% of earnings between €37,862 and €58,252 (IG c)
	-> 25% of earnings above €58,252 (IG d)
*/

* WOMEN 
* IGa
replace pl_ben1 = 27.86 * 21.7 			if country == "FI" & year == 2019 & gender == 1 ///
										& pl_eli == 1 
									

* IGb
replace pl_ben1 = earning * 0.7 		if country == "FI" & year == 2019 & gender == 1 ///
										& pl_eli == 1 & inrange((earning*12),11942,37861)

									
* IGc 
gen pl_bena = (37862/12) * 0.7 		if country == "FI" & year == 2019 & gender == 1 ///
									& pl_eli == 1 & earning*12 >= 37861
			
gen pl_benb = (earning - (37862/12)) * 0.4 		///
									if country == "FI" & year == 2019	///
									& gender == 1 & pl_eli == 1 ///
									& inrange((earning*12),37862,58252)

replace pl_ben1 = pl_bena + pl_benb 		if country == "FI" ///
												& year == 2019	& gender == 1 ///
												& pl_eli == 1 & inrange((earning*12),37862,58252)			

																								
												
												
* IGd	


gen pl_benc = (58252/12) * 0.4			if country == "FI" & year == 2019	& gender == 1 ///
										& pl_eli == 1 & (earning*12) > 58252
	
gen pl_bend = (earning - (58252/12)) * 0.25  		///
									if country == "FI" & year == 2019	///
									& gender == 1 & pl_eli == 1 ///
									& (earning*12) >= 58252
			

replace pl_ben1 = pl_bena + pl_benc + pl_bend 		if country == "FI" ///
							& year == 2019	& gender == 1 & pl_eli == 1 ///
							& (earning*12) >= 58252


							
* SINGLE MEN
* IGa
replace pl_ben1 = 27.86 * 21.7 			if country == "FI" & year == 2019 & gender == 2 ///
										& pl_eli == 1 & parstat == 1
									

* IGb
replace pl_ben1 = earning * 0.7 		if country == "FI" & year == 2019 & gender == 2 ///
										& pl_eli == 1 & inrange((earning*12),11942,37861) ///
										 & parstat == 1

									
* IGc 
replace pl_bena = (37862/12) * 0.7 		if country == "FI" & year == 2019 & gender == 2 ///
									& pl_eli == 1 & earning*12 >= 37861 & parstat == 1
			
replace pl_benb = (earning - (37862/12)) * 0.4 		///
									if country == "FI" & year == 2019	///
									& gender == 2 & pl_eli == 1 ///
									& inrange((earning*12),37862,58252) & parstat == 1

replace pl_ben1 = pl_bena + pl_benb 		if country == "FI" ///
												& year == 2019	& gender == 2 ///
												& pl_eli == 1 & inrange((earning*12),37862,58252) ///
												& parstat == 1

																								
												
												
* IGd	


replace pl_benc = (58252/12) * 0.4		if country == "FI" & year == 2019	& gender == 2 ///
										& pl_eli == 1 & (earning*12) > 58252 & parstat == 1
	
replace pl_bend = (earning - (58252/12)) * 0.25  		///
									if country == "FI" & year == 2019	///
									& gender == 2 & pl_eli == 1 ///
									& (earning*12) >= 58252 & parstat == 1
			

replace pl_ben1 = pl_bena + pl_benc + pl_bend 		if country == "FI" ///
							& year == 2019	& gender == 2 & pl_eli == 1 ///
							& (earning*12) >= 58252 & parstat == 1

							
							
							
replace pl_ben2 = pl_ben1 	if country == "FI" & year == 2019 & pl_eli == 1
						


foreach x in 1 2 {
	replace pl_ben`x' = 0 	if pl_eli == 0 & country == "FI" & year == 2019
}

replace pl_dur = 0 	if pl_eli == 0 & country == "FI" & year == 2019

drop pl_bena pl_benb pl_benc pl_bend
