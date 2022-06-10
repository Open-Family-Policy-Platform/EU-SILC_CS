/* PT_2011_FI_eusilc_cs */


* Finland - 2011

* ELIGIBILITY
/*	-> all residents
	-> non-residents: 4 months of employment or self-employment (not coded)
*/
replace pt_eli = 1 		if country == "FI" & year == 2011 & gender == 2 
						

replace pt_eli = 0 if pt_eli == . & country == "FI" & year == 2011 & gender == 2


* DURATION (weeks)
/* -> 54 days */ 
replace pt_dur = 54/6 if country == "FI" & year == 2011 & pt_eli == 1 


* BENEFIT (monthly)
/*	-> €23.93/day if unemployed or earnings are less than €10,258/year (income group a)
	-> 70% on earnings between €10,258/year and €36,686/year (IG b)
	-> 40% on earnings between €36,687/year and €56,443/year (IG c)
	-> 25% on earnings above €56,443/year   (IG d) 									
*/


* IGa
replace pt_ben1 = 23.93 * 21.7 			if country == "FI" & year == 2011 & gender == 2 ///
									& pt_eli == 1 


									
* IGb
replace pt_ben1 = earning * 0.7 	if country == "FI" & year == 2011 & gender == 2 ///
									& pt_eli == 1 & inrange((earning*12),10258,36686)

									
									
									
* IGc 
gen pt_bena = (36687/12) * 0.7 		if country == "FI" & year == 2011 & gender == 2 ///
									& pt_eli == 1 & (earning*12) > 36687
			
gen pt_benb = (earning - (36687/12)) * 0.4 		///
									if country == "FI" & year == 2011	///
									& gender == 2 & pt_eli == 1 ///
									& inrange((earning*12),36687,56443)
															

replace pt_ben1 = pt_bena + pt_benb 		if country == "FI" ///
												& year == 2011	& gender == 2 ///
												& pt_eli == 1 & inrange((earning*12),36687,56443)			
			


* IGd	
gen pt_benc = (56443/12) * 0.4			if country == "FI" ///
													& year == 2011	& gender == 2 ///
													& pt_eli == 1 & (earning*12) > 56443
	
gen pt_bend = (earning - (56443/12)) * 0.25 		///
									if country == "FI" & year == 2011	///
									& gender == 2 & pt_eli == 1 ///
									& (earning*12) > 56443
									
									

replace pt_ben1 = pt_bena + pt_benc + pt_bend 		if country == "FI" ///
									& year == 2011	& gender == 2 & pt_eli == 1 ///
									& (earning*12) > 56443


replace pt_ben2 = pt_ben1 	if country == "FI" & year == 2011 & gender == 2 & pt_eli == 1
									

foreach x in 1 2 {
	replace pt_ben`x' = 0 	if pt_eli == 0 & country == "FI" & year == 2011
}

replace pt_dur = 0 if pt_eli == 0 & country == "FI" & year == 2011			
			
drop pt_bena pt_benb


