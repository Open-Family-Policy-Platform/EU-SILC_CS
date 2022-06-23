/* PL_2017_FI_eusilc_cs */


* FINLAND - 2017

* ELIGIBILITY
/*	-> all residents
	-> non-residents: 4 months of employment or self-employment (not coded)
	-> family entitlement
 */
replace pl_eli = 1 			if country == "FI" & year == 2017 
			
replace pl_eli = 0 			if pl_eli == . & country == "FI" & year == 2017


* DURATION (weeks)
/* 	 
	-> 158 days 
	-> couples: assigned to women
*/
   
replace pl_dur = 158/21.7 		if country == "FI" & year == 2017 & pl_eli == 1 ///
								& gender == 1

* single men
replace pl_dur = 158/21.7 		if country == "FI" & year == 2017 & pl_eli == 1 ///
								& gender == 2 & parstat == 1



* BENEFIT (monthly)
/*	-> €23.73/day if unemployed or earnings are less than €10,562/year (income group a)
	-> 70% on earnings between €10,425/year and €37,167/year (IG b)
	-> 40% on earnings between €37,168/year and €56,443/year (IG c)
	-> 25% on earnings above €56,443/year   (IG d) 		*/


* WOMEN 
* IGa
replace pl_ben1 = 23.73 * 21.7 			if country == "FI" & year == 2017 & gender == 1 ///
										& pl_eli == 1 
									

* IGb
replace pl_ben1 = earning * 0.7 		if country == "FI" & year == 2017 & gender == 1 ///
										& pl_eli == 1 & inrange((earning*12),10425,37167)

									
* IGc 
gen pl_bena = (37168/12) * 0.7 		if country == "FI" & year == 2017 & gender == 1 ///
									& pl_eli == 1 & earning*12 >= 37167
			
gen pl_benb = (earning - (37168/12)) * 0.4 		///
									if country == "FI" & year == 2017	///
									& gender == 1 & pl_eli == 1 ///
									& inrange((earning*12),37168,56443 )

replace pl_ben1 = pl_bena + pl_benb 		if country == "FI" ///
												& year == 2017	& gender == 1 ///
												& pl_eli == 1 & inrange((earning*12),37167,56443 )			

																								
												
												
* IGd	


gen pl_benc = (56443 /12) * 0.4			if country == "FI" & year == 2017	& gender == 1 ///
										& pl_eli == 1 & (earning*12) > 56443 
	
gen pl_bend = (earning - (56443 /12)) * 0.25  		///
									if country == "FI" & year == 2017	///
									& gender == 1 & pl_eli == 1 ///
									& (earning*12) >= 56443 
			

replace pl_ben1 = pl_bena + pl_benc + pl_bend 		if country == "FI" ///
							& year == 2017	& gender == 1 & pl_eli == 1 ///
							& (earning*12) >= 56443 


							
* SINGLE MEN
* IGa
replace pl_ben1 = 23.73 * 21.7 			if country == "FI" & year == 2017 & gender == 2 ///
										& pl_eli == 1 & parstat == 1
									

* IGb
replace pl_ben1 = earning * 0.7 		if country == "FI" & year == 2017 & gender == 2 ///
										& pl_eli == 1 & inrange((earning*12),10425,37167) ///
										 & parstat == 1

									
* IGc 
replace pl_bena = (37168/12) * 0.7 		if country == "FI" & year == 2017 & gender == 2 ///
									& pl_eli == 1 & earning*12 >= 37167 & parstat == 1
			
replace pl_benb = (earning - (37168/12)) * 0.4 		///
									if country == "FI" & year == 2017	///
									& gender == 2 & pl_eli == 1 ///
									& inrange((earning*12),37168,56443 ) & parstat == 1

replace pl_ben1 = pl_bena + pl_benb 		if country == "FI" ///
												& year == 2017	& gender == 2 ///
												& pl_eli == 1 & inrange((earning*12),37168,56443 ) ///
												& parstat == 1

																								
												
												
* IGd	


replace pl_benc = (56443 /12) * 0.4		if country == "FI" & year == 2017	& gender == 2 ///
										& pl_eli == 1 & (earning*12) > 56443  & parstat == 1
	
replace pl_bend = (earning - (56443 /12)) * 0.25  		///
									if country == "FI" & year == 2017	///
									& gender == 2 & pl_eli == 1 ///
									& (earning*12) >= 56443  & parstat == 1
			
			
replace pl_ben1 = pl_bena + pl_benc + pl_bend 		if country == "FI" ///
							& year == 2017	& gender == 2 & pl_eli == 1 ///
							& (earning*12) >= 56443  & parstat == 1			
			
			
			



replace pl_ben2 = pl_ben1 			if country == "FI" & year == 2017 & pl_eli == 1

foreach x in 1 2 {
	replace pl_ben`x' = 0 	if pl_eli == 0 & country == "FI" & year == 2017
}

replace pl_dur = 0 	if pl_eli == 0 & country == "FI" & year == 2017

drop pl_bena pl_benb pl_benc pl_bend 
