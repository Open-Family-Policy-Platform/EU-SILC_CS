/* PL_2011_FI_eusilc_cs */


* FINLAND - 2011

* ELIGIBILITY
/*	-> all residents
	-> non-residents: 4 months of employment or self-employment (not coded)
 */
replace pl_eli = 1 			if country == "FI" & year == 2011 
			
replace pl_eli = 0 			if pl_eli == . & country == "FI" & year == 2011


* DURATION (weeks)
/* 	-> family entitlement 
	-> 158 days 
	-> couples: assigned to women
*/
   
replace pl_dur = 158/21.7 		if country == "FI" & year == 2011 & pl_eli == 1 ///
								& gender == 1

* single men
replace pl_dur = 158/21.7 		if country == "FI" & year == 2011 & pl_eli == 1 ///
								& gender == 2 & parstat == 1



* BENEFIT (monthly)
/*	-> €23.93/day if unemployed or earnings are less than €10,258/year (income group a)
	-> 70% on earnings between €10,258/year and €36,686/year (IG b)
	-> 40% on earnings between €36,687/year and €56,443/year (IG c)
	-> 25% on earnings above €56,443/year   (IG d) 		*/


* WOMEN 
* IGa
replace pl_ben1 = 23.93 * 21.7 			if country == "FI" & year == 2011 & gender == 1 ///
										& pl_eli == 1 
									

* IGb
replace pl_ben1 = earning * 0.7 		if country == "FI" & year == 2011 & gender == 1 ///
										& pl_eli == 1 & inrange((earning*12),10258,36686)

									
* IGc 
gen pl_bena = (36687/12) * 0.7 		if country == "FI" & year == 2011 & gender == 1 ///
									& pl_eli == 1 & earning*12 >= 36687
			
gen pl_benb = (earning - (36687/12)) * 0.4 		///
									if country == "FI" & year == 2011	///
									& gender == 1 & pl_eli == 1 ///
									& inrange((earning*12),36687,56443)

replace pl_ben1 = pl_bena + pl_benb 		if country == "FI" ///
												& year == 2011	& gender == 1 ///
												& pl_eli == 1 & inrange((earning*12),36687,56443)			

																								
												
												
* IGd	


gen pl_benc = (56443/12) * 0.4			if country == "FI" & year == 2011	& gender == 1 ///
										& pl_eli == 1 & (earning*12) > 56443
	
gen pl_bend = (earning - (56443/12)) * 0.25  		///
									if country == "FI" & year == 2011	///
									& gender == 1 & pl_eli == 1 ///
									& (earning*12) >= 56443
			

replace pl_ben1 = pl_bena + pl_benc + pl_bend 		if country == "FI" ///
							& year == 2011	& gender == 1 & pl_eli == 1 ///
							& (earning*12) >= 56443


							
* SINGLE MEN
* IGa
replace pl_ben1 = 23.93 * 21.7 			if country == "FI" & year == 2011 & gender == 2 ///
										& pl_eli == 1 & parstat == 1
									

* IGb
replace pl_ben1 = earning * 0.7 		if country == "FI" & year == 2011 & gender == 2 ///
										& pl_eli == 1 & inrange((earning*12),10258,36686) ///
										 & parstat == 1

									
* IGc 
replace pl_bena = (36687/12) * 0.7 		if country == "FI" & year == 2011 & gender == 2 ///
									& pl_eli == 1 & earning*12 >= 36687 & parstat == 1
			
replace pl_benb = (earning - (36687/12)) * 0.4 		///
									if country == "FI" & year == 2011	///
									& gender == 2 & pl_eli == 1 ///
									& inrange((earning*12),36687,56443) & parstat == 1

replace pl_ben1 = pl_bena + pl_benb 		if country == "FI" ///
												& year == 2011	& gender == 2 ///
												& pl_eli == 1 & inrange((earning*12),36687,56443) ///
												& parstat == 1

																								
												
												
* IGd	


replace pl_benc = (56443/12) * 0.4		if country == "FI" & year == 2011	& gender == 2 ///
										& pl_eli == 1 & (earning*12) > 56443 & parstat == 1
	
replace pl_bend = (earning - (56443/12)) * 0.25  		///
									if country == "FI" & year == 2011	///
									& gender == 2 & pl_eli == 1 ///
									& (earning*12) >= 56443 & parstat == 1
			
			
replace pl_ben1 = pl_bena + pl_benc + pl_bend 		if country == "FI" ///
							& year == 2011	& gender == 2 & pl_eli == 1 ///
							& (earning*12) >= 56443 & parstat == 1			
			
			
			



replace pl_ben2 = pl_ben1 			if country == "FI" & year == 2011 & pl_eli == 1

foreach x in 1 2 {
	replace pl_ben`x' = 0 	if pl_eli == 0 & country == "FI" & year == 2011
}

replace pl_dur = 0 	if pl_eli == 0 & country == "FI" & year == 2011
