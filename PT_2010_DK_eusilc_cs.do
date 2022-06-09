/* PT_2010_DK_eusilc_cs */


* DENMARK - 2010


* ELIGIBILITY
/* -> employed
	-> self-employed
	-> unemployed (from unemployment insurance)	
	-> students (extra student grant; pl031 == 6; LP&R 2010)
	
*/
replace pt_eli = 1 		if country == "DK" & year == 2010 & gender == 2 ///
						& inlist(econ_status,1,2,3) 
						
replace pt_eli = 1	 	if country == "DK" & year == 2010 & gender == 2 ///
						& pl031 == 6						
						
replace pt_eli = 0 		if pt_eli == . & country == "DK" & year == 2010 & gender == 2


* DURATION (weeks)
/*	-> combined entitlement for mother and father (MISSOC 01/07/2010)
	-> 2 weeks (coded) within 14 weeks after birth (not coded)			*/

replace pt_dur = 2 		if country == "DK" & year == 2010 & pt_eli == 1


* BENEFIT (monthly)
/* 	-> employed, self-employed: 100% earning
	-> ceiling: €561/week 	
	-> unemployed: unemployment benefits (not coded; LP&R 2010)
	-> students: extra 12 months of study grant (not coded; LP&R 2010) */
	
replace pt_ben1 = earning 		if country == "DK" & year == 2010 & pt_eli == 1 ///
								& inlist(econ_status,1,2) 
								
replace pt_ben1 = (561*pt_dur) + ((earning/4.3)*(4.3-pt_dur)) ///
								if country == "DK" & year == 2010 & pt_eli == 1 ///
								& inlist(econ_status,1,2) & pt_ben1/4.3 >= 561 ///
								

replace pt_ben2 = pt_ben1 		if country == "DK" & year == 2010 & pt_eli == 1


foreach x in 1 2 {
	replace pt_ben`x' = 0 	if pt_eli == 0 & country == "DK" & year == 2010
}

replace pt_dur = 0 if pt_eli == 0 & country == "DK" & year == 2010
