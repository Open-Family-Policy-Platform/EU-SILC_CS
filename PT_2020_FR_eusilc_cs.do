/* PT_2020_FR_eusilc_cs */


* FRANCE - 2020

* ELIGIBILITY
/*	-> employed
	-> self-employed 
*/

replace pt_eli = 1 		if country == "FR" & year == 2020 & gender == 2 ///
						& inlist(econ_status,1,2) 
replace pt_eli = 0 		if pt_eli == . & country == "FR" & year == 2020 & gender == 2


* DURATION (weeks)
/*	-> 11 days
	-> multiple births: 18 days  (not coded)
	-> must be taken within 4 months after childbirth (not coded)	*/ 
	
replace pt_dur = 11/5 	if country == "FR" & year == 2020 & pt_eli == 1


* BENEFIT (monthly)
/*	
	-> 100%
	-> minimum: €9.63/day
	-> ceiling: €89.03/ day
	-> no ceiling in public sector (not coded; LP&R 2020)
	-> source: MISSOC 01/07/2020	*/ 

replace pt_ben1 = earning 		if country == "FR" & year == 2020 & pt_eli == 1 ///
								& pt_ben1 == .
	
* ceiling
replace pt_ben1 = ((89.03 * 11) * (11/21.7)) + (earning * ((21.7-11)/21.7)) ///
											if country == "FR" & year == 2020  ///
											& pt_eli == 1 & pt_ben1/21.7 >= 89.03
	

* minimum
replace pt_ben1 = ((9.63 * 11) * (11/21.7)) + (earning * ((21.7-11)/21.7)) ///
											if country == "FR" & year == 2020  ///
											& pt_eli == 1 & pt_ben1/21.7 < 9.63

											

replace pt_ben2 = pt_ben1 		if country == "FR" & year == 2020 & pt_eli == 1


foreach x in 1 2 {
	replace pt_ben`x' = 0 	if pt_eli == 0 & country == "FR" & year == 2020
}

replace pt_dur = 0 if pt_eli == 0 & country == "FR" & year == 2020
	
	
