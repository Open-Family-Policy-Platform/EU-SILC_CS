 /* PT_2017_BG_eusilc_cs

date created: 27/09/2021

*/

* BULGARIA - 2017

* ELIGIBILITY
/*	-> Employed: at least 12 months of insurance.
	-> self-employed: voluntarily insured => not coded! 
*/
   
replace pt_eli = 1 if country == "BG" & year == 2017 & gender == 2 ///
				& econ_status == 1 & duremp == 12
replace pt_eli = 0 if pt_eli == . & country == "BG" & year == 2017 & gender == 2



* DURATION (weeks)
/*	-> 15 days */
replace pt_dur = 15/5 if country == "BG" & year == 2017 & pt_eli == 1



* BENEFIT (monthly)
/*	-> 90% earning 
	-> minimum: €214.76 for the duration of PT (LP&R 2017)
	-> ceiling: €1,329.48 for the duration of PT (LP&R 2017)
	The minimum and maximum values of benefit are sourced from LP&R 2018. 
*/

	
replace pt_ben1 = (((0.9*earning)/4.3) * pt_dur) + ((earning/4.3)*(4.3-pt_dur)) ///
										if country == "BG" & year == 2017 ///
										& pt_eli == 1 & pt_ben1 == .
	
 
* minimum
replace pt_ben1 = 214.76 + ((earning/4.3)*(4.3-pt_dur)) 	if country == "BG" & year == 2017 ///
															& pt_eli == 1 & ((0.9*earning)/4.3) < 214.76/pt_dur
 
* maximum 
replace pt_ben1 = 1329.48 + ((earning/4.3)*(4.3-pt_dur)) 	if country == "BG" & year == 2017 ///
															& pt_eli == 1 & ((0.9*earning)/4.3) >= 1329.48/pt_dur
										



replace pt_ben2 = pt_ben1 if country == "BG" & year == 2017 & pt_eli == 1



foreach x in 1 2 {
	replace pt_ben`x' = 0 	if pt_eli == 0 & country == "BG" & year == 2017
}

replace pt_dur = 0 if pt_eli == 0 & country == "BG" & year == 2017



