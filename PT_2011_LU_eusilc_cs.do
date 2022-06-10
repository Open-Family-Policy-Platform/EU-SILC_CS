/* PT_2011_LU_eusilc_cs */


* LUXEMBOURG - 2011

* NO STATUTORY ENTITLEMENT FOR PATERNITY LEAVE!
	
* ELIGIBILITY
/*	-> no statutory entitlement to paternity leave
	-> available 'leave due to exraordinary circumstances', paid by the employer 
*/

replace pt_eli = 1 		if country == "LU" & year == 2011 & gender == 2 & econ_status == 1
replace pt_eli = 0 		if pt_eli == . & country == "LU" & year == 2011 & gender == 2


* DURATION (weeks)
/*	-> 2 days */
replace pt_dur = 2/5 	if country == "LU" & year == 2011 & pt_eli == 1


* BENEFIT (monthly)
/*	-> 100% 	*/
	
replace pt_ben1 = earning 	if country == "LU" & year == 2011 & pt_eli == 1


replace pt_ben2 = pt_ben1 	if country == "LU" & year == 2011 & pt_eli == 1

foreach x in 1 2 {
	replace pt_ben`x' = 0 	if pt_eli == 0 & country == "LU" & year == 2011
}

replace pt_dur = 0 if pt_eli == 0 & country == "LU" & year == 2011
