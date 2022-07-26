/* PT_2012_FI_eusilc_cs */


* Finland - 2012

* ELIGIBILITY
/*	-> all residents
	-> non-residents: 4 months of employment or self-employment (not coded)
*/
replace pt_eli = 1 		if country == "FI" & year == 2012 & gender == 2 
						

replace pt_eli = 0 if pt_eli == . & country == "FI" & year == 2012 & gender == 2


* DURATION (weeks)
/* -> 18 days 
	-> if he uses at least 12 of parental leave, then he is also entitled to 'daddy's month' (1-24 days; not coded) */ 
	
replace pt_dur = 18/6 if country == "FI" & year == 2012 & pt_eli == 1 


* BENEFIT (monthly)
/*	-> €22.13/day if unemployed or earning under €9,447/year (income group a; LP&R 2012)
	-> 70% on earnings between €9,447/year and €33,479/year (IGb)
	-> 40% on earnings between €33,480/year and € 51,510/year (IGc)
	-> 25% on earnings above € 51,510/year   (IGd) 									
*/


* IGa
replace pt_ben1 = 22.13 * 21.7 		if country == "FI" & year == 2012 & gender == 2 ///
									& pt_eli == 1 & inlist(econ_status,3,4)

replace pt_ben1 = 22.13 * 21.7 		if country == "FI" & year == 2012 & gender == 2 ///
									& pt_eli == 1 & inlist(econ_status,1,2) & (earning*12) < 9447

									
* IGb
replace pt_ben1 = earning * 0.7 	if country == "FI" & year == 2012 & gender == 2 ///
									& pt_eli == 1 & inrange((earning*12),9447,33479) & pt_ben1 == .

									
									
									
* IGc 
gen pt_bena = (33480/12) * 0.7 		if country == "FI" & year == 2012 & gender == 2 ///
									& pt_eli == 1 & (earning*12) > 33480
			
gen pt_benb = (earning - (33480/12)) * 0.4 		///
									if country == "FI" & year == 2012	///
									& gender == 2 & pt_eli == 1 ///
									& inrange((earning*12),33480,51510)
															

replace pt_ben1 = pt_bena + pt_benb 		if country == "FI" ///
												& year == 2012	& gender == 2 ///
												& pt_eli == 1 & inrange((earning*12),33480,51510)			
			


* IGd	
gen pt_benc = (51510/12) * 0.4			if country == "FI" ///
													& year == 2012	& gender == 2 ///
													& pt_eli == 1 & (earning*12) > 51510
	
gen pt_bend = (earning - (51510/12)) * 0.25 		///
									if country == "FI" & year == 2012	///
									& gender == 2 & pt_eli == 1 ///
									& (earning*12) > 51510
									
									

replace pt_ben1 = ((pt_bena + pt_benc + pt_bend) * (18/21.7)) + (earning * ((21.7-18)/21.7)) 		if country == "FI" ///
									& year == 2012	& gender == 2 & pt_eli == 1 ///
									& (earning*12) > 51510


replace pt_ben2 = pt_ben1 	if country == "FI" & year == 2012 & gender == 2 & pt_eli == 1

								
foreach x in 1 2 {
	replace pt_ben`x' = 0 	if pt_eli == 0 & country == "FI" & year == 2012
}

replace pt_dur = 0 if pt_eli == 0 & country == "FI" & year == 2012			
			
drop pt_bena pt_benb


