/* PL_2011_FI_eusilc_cs */


* FINLAND - 2011

* ELIGIBILITY
/*	-> all residents
	-> non-residents: 4 months of employment or self-employment (not coded)
	-> family entitlement
 */
replace pl_eli = 1 			if country == "FI" & year == 2011 
			
replace pl_eli = 0 			if pl_eli == . & country == "FI" & year == 2011


* DURATION (weeks)
/* 
	-> 158 days 
	-> couples: assigned to women
*/
   
replace pl_dur = 158/21.7 		if country == "FI" & year == 2011 & pl_eli == 1 ///
								& gender == 1

* single men
replace pl_dur = 158/21.7 		if country == "FI" & year == 2011 & pl_eli == 1 ///
								& gender == 2 & parstat == 1



* BENEFIT (monthly)
/*	-> €22.13/day if unemployed (income group a; LP&R 2011)
	-> 70% on earnings between €9,447/year and €33,479/year (IGb)
	-> 40% on earnings between €33,480/year and € 51,510/year (IGc)
	-> 25% on earnings above € 51,510/year   (IGd)  		*/


* WOMEN 
* IGa
replace pl_ben1 = 22.13 * 21.7 			if country == "FI" & year == 2011 & gender == 1 ///
										& pl_eli == 1 & inrange(econ_status,3,4)
									
replace pl_ben1 = 22.13 * 21.7 			if country == "FI" & year == 2011 & gender == 1 ///
										& pl_eli == 1 & inrange(econ_status,9477,2) & (earning*12) < 9447
									
									
* IGb
replace pl_ben1 = earning * 0.7 		if country == "FI" & year == 2011 & gender == 1 ///
										& pl_eli == 1 & inrange((earning*12),9447,33479)

									
* IGc 
gen pl_bena = (33480/12) * 0.7 		if country == "FI" & year == 2011 & gender == 1 ///
									& pl_eli == 1 & earning*12 >= 33480
			
gen pl_benb = (earning - (33480/12)) * 0.4 		///
									if country == "FI" & year == 2011	///
									& gender == 1 & pl_eli == 1 ///
									& inrange((earning*12),33480,51510)

replace pl_ben1 = pl_bena + pl_benb 		if country == "FI" ///
												& year == 2011	& gender == 1 ///
												& pl_eli == 1 & inrange((earning*12),33480,51510)			

																								
												
												
* IGd	


gen pl_benc = (51510/12) * 0.4			if country == "FI" & year == 2011	& gender == 1 ///
										& pl_eli == 1 & (earning*12) > 51510
	
gen pl_bend = (earning - (51510/12)) * 0.25  		///
									if country == "FI" & year == 2011	///
									& gender == 1 & pl_eli == 1 ///
									& (earning*12) >= 51510
			

replace pl_ben1 = pl_bena + pl_benc + pl_bend 		if country == "FI" ///
							& year == 2011	& gender == 1 & pl_eli == 1 ///
							& (earning*12) >= 51510


							
* SINGLE MEN
* IGa
replace pl_ben1 = 22.13 * 21.7 			if country == "FI" & year == 2011 & gender == 2 ///
										& pl_eli == 1 & parstat == 1
									

* IGb
replace pl_ben1 = earning * 0.7 		if country == "FI" & year == 2011 & gender == 2 ///
										& pl_eli == 1 & inrange((earning*12),9447,33479) ///
										 & parstat == 1

									
* IGc 
replace pl_bena = (33480/12) * 0.7 		if country == "FI" & year == 2011 & gender == 2 ///
									& pl_eli == 1 & earning*12 >= 33480 & parstat == 1
			
replace pl_benb = (earning - (33480/12)) * 0.4 		///
									if country == "FI" & year == 2011	///
									& gender == 2 & pl_eli == 1 ///
									& inrange((earning*12),33480,51510) & parstat == 1

replace pl_ben1 = pl_bena + pl_benb 		if country == "FI" ///
												& year == 2011	& gender == 2 ///
												& pl_eli == 1 & inrange((earning*12),33480,51510) ///
												& parstat == 1

																								
												
												
* IGd	


replace pl_benc = (51510/12) * 0.4		if country == "FI" & year == 2011	& gender == 2 ///
										& pl_eli == 1 & (earning*12) > 51510 & parstat == 1
	
replace pl_bend = (earning - (51510/12)) * 0.25  		///
									if country == "FI" & year == 2011	///
									& gender == 2 & pl_eli == 1 ///
									& (earning*12) >= 51510 & parstat == 1
			
			
replace pl_ben1 = pl_bena + pl_benc + pl_bend 		if country == "FI" ///
							& year == 2011	& gender == 2 & pl_eli == 1 ///
							& (earning*12) >= 51510 & parstat == 1			
			
			
			



replace pl_ben2 = pl_ben1 			if country == "FI" & year == 2011 & pl_eli == 1

foreach x in 1 2 {
	replace pl_ben`x' = 0 	if pl_eli == 0 & country == "FI" & year == 2011
}

replace pl_dur = 0 	if pl_eli == 0 & country == "FI" & year == 2011
