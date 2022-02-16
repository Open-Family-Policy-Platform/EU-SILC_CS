/* PT_2017_FR_eusilc_cs

date created: 27/09/2021

*/

* FRANCE - 2017

* ELIGIBILITY
/*	-> employed
	-> self-employed 
*/

replace pt_eli = 1 		if country == "FR" & year == 2017 & gender == 2 ///
						& inlist(econ_status,1,2) 
replace pt_eli = 0 		if pt_eli == . & country == "FR" & year == 2017 & gender == 2


* DURATION (weeks)
/*	-> 11 days
	-> multiple births: 18 days  (not coded)
	-> must be taken within 4 months after childbirth (not coded)	*/ 
	
replace pt_dur = 11/5 	if country == "FR" & year == 2017 & pt_eli == 1


* BENEFIT (monthly)
/*	-> 100%
	-> minimum: €9.29/day
	-> ceiling: €84.9/ day
	-> no ceiling in public sector (not coded; LP&R 2017)
	-> source: MISSOC 01/07/2017	*/ 

replace pt_ben1 = earning 		if country == "FR" & year == 2017 & pt_eli == 1 ///
								& pt_ben1 == .
	
* ceiling
replace pt_ben1 = ((84.9*5)* pt_dur) + (earning*(4.3-pt_dur)) ///
											if country == "FR" & year == 2017  ///
											& pt_eli == 1 & pt_ben1/4.3 >= (84.9*5)
	

* minimum
replace pt_ben1 = ((9.29*5)* pt_dur) + (earning*(4.3-pt_dur)) ///
											if country == "FR" & year == 2017  ///
											& pt_eli == 1 & pt_ben1/4.3 < (9.29*5)

											

replace pt_ben2 = pt_ben1 		if country == "FR" & year == 2017 & pt_eli == 1


foreach x in 1 2 {
	replace pt_ben`x' = 0 	if pt_eli == 0 & country == "FR" & year == 2017
}

replace pt_dur = 0 if pt_eli == 0 & country == "FR" & year == 2017
	
	
