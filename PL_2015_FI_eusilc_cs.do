/* PL_2015_FI_eusilc_cs */


* FINLAND - 2015

* ELIGIBILITY
/*	-> all residents
	-> non-residents: 4 months of employment or self-employment (not coded)
	-> family entitlement
 */
replace pl_eli = 1 			if country == "FI" & year == 2015 
			
replace pl_eli = 0 			if pl_eli == . & country == "FI" & year == 2015


* DURATION (weeks)
/* 	
	-> 158 days 
	-> couples: assigned to women
*/
   
replace pl_dur = 158/21.7 		if country == "FI" & year == 2015 & pl_eli == 1 ///
								& gender == 1

* single men
replace pl_dur = 158/21.7 		if country == "FI" & year == 2015 & pl_eli == 1 ///
								& gender == 2 & parstat == 1



* BENEFIT (monthly)
/*	-> €24.02/day if unemployed or earnings are less than €10,297/year (IG 24a)
	-> 70% on earnings between €10,297/year and €36,420/year (IG 24b)
	-> 40% on earnings between €36,420/year and €56,032/year (IG 24c)
	-> 25% on earnings above €56,032/year 		*/


* WOMEN 
* IGa
replace pl_ben1 = 24.02 * 21.7 			if country == "FI" & year == 2015 & gender == 1 ///
										& pl_eli == 1 
									

* IGb
replace pl_ben1 = earning * 0.7 		if country == "FI" & year == 2015 & gender == 1 ///
										& pl_eli == 1 & inrange((earning*12),10297,36420)

									
* IGc 
gen pl_bena = (36420/12) * 0.7 		if country == "FI" & year == 2015 & gender == 1 ///
									& pl_eli == 1 & earning*12 >= 36420
			
gen pl_benb = (earning - (36420/12)) * 0.4 		///
									if country == "FI" & year == 2015	///
									& gender == 1 & pl_eli == 1 ///
									& inrange((earning*12),36420,56032)

replace pl_ben1 = pl_bena + pl_benb 		if country == "FI" ///
												& year == 2015	& gender == 1 ///
												& pl_eli == 1 & inrange((earning*12),36420,56032)			

																								
												
												
* IGd	


gen pl_benc = (56032/12) * 0.4			if country == "FI" & year == 2015	& gender == 1 ///
										& pl_eli == 1 & (earning*12) > 56032
	
gen pl_bend = (earning - (56032/12)) * 0.25  		///
									if country == "FI" & year == 2015	///
									& gender == 1 & pl_eli == 1 ///
									& (earning*12) >= 56032
			

replace pl_ben1 = pl_bena + pl_benc + pl_bend 		if country == "FI" ///
							& year == 2015	& gender == 1 & pl_eli == 1 ///
							& (earning*12) >= 56032


							
* SINGLE MEN
* IGa
replace pl_ben1 = 24.02 * 21.7 			if country == "FI" & year == 2015 & gender == 2 ///
										& pl_eli == 1 & parstat == 1
									

* IGb
replace pl_ben1 = earning * 0.7 		if country == "FI" & year == 2015 & gender == 2 ///
										& pl_eli == 1 & inrange((earning*12),10297,36420) ///
										 & parstat == 1

									
* IGc 
replace pl_bena = (36420/12) * 0.7 		if country == "FI" & year == 2015 & gender == 2 ///
									& pl_eli == 1 & earning*12 >= 36420 & parstat == 1
			
replace pl_benb = (earning - (36420/12)) * 0.4 		///
									if country == "FI" & year == 2015	///
									& gender == 2 & pl_eli == 1 ///
									& inrange((earning*12),36420,56032) & parstat == 1

replace pl_ben1 = pl_bena + pl_benb 		if country == "FI" ///
												& year == 2015	& gender == 2 ///
												& pl_eli == 1 & inrange((earning*12),36420,56032) ///
												& parstat == 1

																								
												
												
* IGd	


replace pl_benc = (56032/12) * 0.4		if country == "FI" & year == 2015	& gender == 2 ///
										& pl_eli == 1 & (earning*12) > 56032 & parstat == 1
	
replace pl_bend = (earning - (56032/12)) * 0.25  		///
									if country == "FI" & year == 2015	///
									& gender == 2 & pl_eli == 1 ///
									& (earning*12) >= 56032 & parstat == 1
			
			
replace pl_ben1 = pl_bena + pl_benc + pl_bend 		if country == "FI" ///
							& year == 2015	& gender == 2 & pl_eli == 1 ///
							& (earning*12) >= 56032 & parstat == 1			
			
			
			



replace pl_ben2 = pl_ben1 			if country == "FI" & year == 2015 & pl_eli == 1



foreach x in 1 2 {
	replace pl_ben`x' = 0 	if pl_eli == 0 & country == "FI" & year == 2015
}

replace pl_dur = 0 	if pl_eli == 0 & country == "FI" & year == 2015

drop pl_bena pl_benb pl_benc pl_bend 

