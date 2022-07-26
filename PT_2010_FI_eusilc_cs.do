/* PT_2010_FI_eusilc_cs */


* Finland - 2010

* ELIGIBILITY
/*	-> all residents (at least 180 days of residency - not coded)
	-> non-residents: 4 months of employment or self-employment (not coded)
*/
replace pt_eli = 1 		if country == "FI" & year == 2010 & gender == 2 
						

replace pt_eli = 0 if pt_eli == . & country == "FI" & year == 2010 & gender == 2


* DURATION (weeks)
/* 	-> 18 days 
	-> if he uses at least 12 of parental leave, then he is also entitled to 'daddy's month' (1-24 days; not coded)
*/ 
replace pt_dur = 18/6 if country == "FI" & year == 2010 & pt_eli == 1 


* BENEFIT (monthly)
/*	-> €22.04/day if unemployed and those with earnings below €9,447 (income group a; LP&R 2010)
	-> 70% on earnings between €9,447 and €32,892/year (IGb)
	-> 40% on earnings between €32,893/year and €50,606/year (IGc)
	-> 25% on earnings above €50,606/year   (IGd)  									
*/


* IGa
replace pt_ben1 = 22.04 * 21.7 		if country == "FI" & year == 2010 & gender == 2 ///
									& pt_eli == 1 & inlist(econ_status,3,4)

replace pt_ben1 = 22.04 * 21.7 		if country == "FI" & year == 2010 & gender == 2 ///
									& pt_eli == 1 & inlist(econ_status,1,2) & (earning * 12) < 9447
									
* IGb
replace pt_ben1 = earning * 0.7 	if country == "FI" & year == 2010 & gender == 2 ///
									& pt_eli == 1 & inrange((earning*12),9447,32892) & pt_ben1 == .

									
									
									
* IGc 
gen pt_bena = (32893/12) * 0.7 		if country == "FI" & year == 2010 & gender == 2 ///
									& pt_eli == 1 & (earning*12) >= 32893
			
gen pt_benb = (earning - (32893/12)) * 0.4 		///
									if country == "FI" & year == 2010	///
									& gender == 2 & pt_eli == 1 ///
									& inrange((earning*12),32893,50606)
															

replace pt_ben1 = pt_bena + pt_benb 		if country == "FI" ///
												& year == 2010	& gender == 2 ///
												& pt_eli == 1 & inrange((earning*12),32893,50606)			
			


* IGd	
gen pt_benc = (50606/12) * 0.4			if country == "FI" ///
													& year == 2010	& gender == 2 ///
													& pt_eli == 1 & (earning*12) > 50606
	
gen pt_bend = (earning - (50606/12)) * 0.25 		///
									if country == "FI" & year == 2010	///
									& gender == 2 & pt_eli == 1 ///
									& (earning*12) > 50606
									
									

replace pt_ben1 = ((pt_bena + pt_benc + pt_bend) * (18/21.7)) + (earning * ((21.7-18)/21.7)) 		if country == "FI" ///
									& year == 2010	& gender == 2 & pt_eli == 1 ///
									& (earning*12) > 50606


replace pt_ben2 = pt_ben1 	if country == "FI" & year == 2010 & gender == 2 & pt_eli == 1
									

foreach x in 1 2 {
	replace pt_ben`x' = 0 	if pt_eli == 0 & country == "FI" & year == 2010
}

replace pt_dur = 0 if pt_eli == 0 & country == "FI" & year == 2010			
			
drop pt_bena pt_benb pt_benc pt_bend


