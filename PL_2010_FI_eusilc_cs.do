/* PL_2010_FI_eusilc_cs */


* FINLAND - 2010

* ELIGIBILITY
/*	-> all residents
	-> non-residents: 4 months of employment or self-employment (not coded)
	-> family entitlement
 */
replace pl_eli = 1 			if country == "FI" & year == 2010 
			
replace pl_eli = 0 			if pl_eli == . & country == "FI" & year == 2010


* DURATION (weeks)
/* 	
	-> 158 days 
	-> couples: assigned to women
*/
   
replace pl_dur = 158/21.7 		if country == "FI" & year == 2010 & pl_eli == 1 ///
								& gender == 1

* single men
replace pl_dur = 158/21.7 		if country == "FI" & year == 2010 & pl_eli == 1 ///
								& gender == 2 & parstat == 1



* BENEFIT (monthly)
/*	-> €22.04/day if unemployed and those with earnings below €9,447 (income group a; LP&R 2010)
	-> 70% on earnings between €9,447 and €32,892/year (IGb)
	-> 40% on earnings between €32,893/year and €50,606/year (IGc)
	-> 25% on earnings above €50,606/year   (IGd) 		*/


* WOMEN 
* IGa
replace pl_ben1 = 22.04 * 21.7 			if country == "FI" & year == 2010 & gender == 1 ///
										& pl_eli == 1 & inlist(econ_status,3,4)

replace pl_ben1 = 22.04 * 21.7 			if country == "FI" & year == 2010 & gender == 1 ///
										& pl_eli == 1 & inlist(econ_status,1,2) & (earning*12) < 9477

* IGb
replace pl_ben1 = earning * 0.7 		if country == "FI" & year == 2010 & gender == 1 ///
										& pl_eli == 1 & inrange((earning*12),9477,32892)

									
* IGc 
gen pl_bena = (32893/12) * 0.7 		if country == "FI" & year == 2010 & gender == 1 ///
									& pl_eli == 1 & earning*12 >= 32893
			
gen pl_benb = (earning - (32893/12)) * 0.4 		///
									if country == "FI" & year == 2010	///
									& gender == 1 & pl_eli == 1 ///
									& inrange((earning*12),32893,5606)

replace pl_ben1 = pl_bena + pl_benb 		if country == "FI" ///
												& year == 2010	& gender == 1 ///
												& pl_eli == 1 & inrange((earning*12),32893,5606)			

																								
												
												
* IGd	


gen pl_benc = (5606/12) * 0.4			if country == "FI" & year == 2010	& gender == 1 ///
										& pl_eli == 1 & (earning*12) > 5606
	
gen pl_bend = (earning - (5606/12)) * 0.25  		///
									if country == "FI" & year == 2010	///
									& gender == 1 & pl_eli == 1 ///
									& (earning*12) >= 5606
			

replace pl_ben1 = pl_bena + pl_benc + pl_bend 		if country == "FI" ///
							& year == 2010	& gender == 1 & pl_eli == 1 ///
							& (earning*12) >= 5606


							
* SINGLE MEN
* IGa
replace pl_ben1 = 22.04 * 21.7 			if country == "FI" & year == 2010 & gender == 2 ///
										& pl_eli == 1 & parstat == 1
									

* IGb
replace pl_ben1 = earning * 0.7 		if country == "FI" & year == 2010 & gender == 2 ///
										& pl_eli == 1 & inrange((earning*12),9477,32892) ///
										 & parstat == 1

									
* IGc 
replace pl_bena = (32893/12) * 0.7 		if country == "FI" & year == 2010 & gender == 2 ///
									& pl_eli == 1 & earning*12 >= 32893 & parstat == 1
			
replace pl_benb = (earning - (32893/12)) * 0.4 		///
									if country == "FI" & year == 2010	///
									& gender == 2 & pl_eli == 1 ///
									& inrange((earning*12),32893,5606) & parstat == 1

replace pl_ben1 = pl_bena + pl_benb 		if country == "FI" ///
												& year == 2010	& gender == 2 ///
												& pl_eli == 1 & inrange((earning*12),32893,5606) ///
												& parstat == 1

																								
												
												
* IGd	


replace pl_benc = (5606/12) * 0.4		if country == "FI" & year == 2010	& gender == 2 ///
										& pl_eli == 1 & (earning*12) > 5606 & parstat == 1
	
replace pl_bend = (earning - (5606/12)) * 0.25  		///
									if country == "FI" & year == 2010	///
									& gender == 2 & pl_eli == 1 ///
									& (earning*12) >= 5606 & parstat == 1
			
			
replace pl_ben1 = pl_bena + pl_benc + pl_bend 		if country == "FI" ///
							& year == 2010	& gender == 2 & pl_eli == 1 ///
							& (earning*12) >= 5606 & parstat == 1			
			
			
			



replace pl_ben2 = pl_ben1 			if country == "FI" & year == 2010 & pl_eli == 1

foreach x in 1 2 {
	replace pl_ben`x' = 0 	if pl_eli == 0 & country == "FI" & year == 2010
}

replace pl_dur = 0 	if pl_eli == 0 & country == "FI" & year == 2010
