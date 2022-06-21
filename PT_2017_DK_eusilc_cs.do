/* PT_2017_DK_eusilc_cs */

* DENMARK - 2017


* ELIGIBILITY
/* 	-> employed (coded): at least 120 hours in 13 weeks before birth 
	-> self-employed: for at least 6 months (coded) during 12 months before birth (not coded)
	-> unemployed (from unemployment insurance)	
	-> students (extra student grant; pl031 == 6; LP&R 2017)
	
*/
replace pt_eli = 1 		if country == "DK" & year == 2017 & gender == 2 ///
						& inlist(econ_status,1,3)
						
replace pt_eli = 1 		if country == "DK" & year == 2017 & gender == 2 ///
						& econ_status == 2 & dursemp >= 6
						
replace pt_eli = 1	 	if country == "DK" & year == 2017 & gender == 2 ///
						& pl031 == 6						
										
replace pt_eli = 0 		if pt_eli == . & country == "DK" & year == 2017 & gender == 2



* DURATION (weeks)
/*	-> combined entitlement for mother and father (MISSOC 01/07/2018)
	-> 2 weeks within 14 weeks after birth			*/

replace pt_dur = 2 		if country == "DK" & year == 2017 & pt_eli == 1


* BENEFIT (monthly)
/* 	-> employed, self-employed: 100% earning
	-> ceiling: €571/week 	
	-> unemployed: unemployment benefits (not coded; LP&R 2017)
	-> students: extra 12 months of study grant (not coded; LP&R 2017) */
	
replace pt_ben1 = earning 		if country == "DK" & year == 2017 & pt_eli == 1 ///
								& inlist(econ_status,1,2) & earning/4.3 < 571
								
replace pt_ben1 = (571*pt_dur) + ((earning/4.3)*(4.3-pt_dur)) ///
								if country == "DK" & year == 2017 & pt_eli == 1 ///
								& inlist(econ_status,1,2) & pt_ben1/4.3 >= 571 ///
								& pt_ben1 == .								


replace pt_ben2 = pt_ben1 		if country == "DK" & year == 2017 & pt_eli == 1


foreach x in 1 2 {
	replace pt_ben`x' = 0 	if pt_eli == 0 & country == "DK" & year == 2017
}

replace pt_dur = 0 if pt_eli == 0 & country == "DK" & year == 2017
