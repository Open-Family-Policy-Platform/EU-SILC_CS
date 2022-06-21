/* ML_2010_DK_eusilc_cs */


* DENMARK - 2010

* ELIGIBILITY
/*	-> employed (coded): at least 120 hours in 13 weeks before birth 
	-> self-employed: for at least 6 months (coded) during 12 months before birth (not coded)
	-> unemployed (from unemployment insurance)	
	-> students (extra student grant; pl031 == 6; LP&R 2010)
	
	-> it is unclear whether the leave can be transferred between parents, 
		the sources provide no indication that this is the case => not coded for single fathers
*/
replace ml_eli = 1	 	if country == "DK" & year == 2010 & gender == 1 ///
						& inlist(econ_status,1,3)
						
replace ml_eli = 1 		if country == "DK" & year == 2010 & gender == 1 ///
						& econ_status == 2 & dursemp >= 6
						
replace ml_eli = 1	 	if country == "DK" & year == 2010 & gender == 1 ///
						& pl031 == 6
						
replace ml_eli = 0 		if ml_eli == . & country == "DK" & year == 2010 & gender == 1


* DURATION (weeks)
/*	-> combined entitlement for mother and father (MISSOC 01/07/2010) covering 
		maternity, paternity and parental leave
	-> prenatal: 4 weeks
	-> postnatal: 14 weeks 	*/
	
replace ml_dur1 = 4 	if country == "DK" & year == 2010 & ml_eli == 1

replace ml_dur2 = 14 	if country == "DK" & year == 2010 & ml_eli == 1


* BENEFIT (monthly)
/* 	-> employed, self-employed: 100% earning
	-> ceiling: €505/week 	
	-> unemployed: unemployment benefits (not coded; LP&R 2010)
	-> students: extra 12 months of study grant (not coded; LP&R 2010) */
	
replace ml_ben1 = earning 		if country == "DK" & year == 2010 & ml_eli == 1 ///
								& inlist(econ_status,1,2) & earning < 505*4.3

replace ml_ben1 = 505*4.3		if country == "DK" & year == 2010 & ml_eli == 1 ///
								& inlist(econ_status,1,2) & ml_ben1 >= 505*4.3
								

replace ml_ben2 = ml_ben1 if country == "DK" & year == 2010 & ml_eli == 1


foreach x in 1 2 {
    replace ml_dur`x' = 0 	if ml_eli == 0 & country == "DK" & year == 2010
	replace ml_ben`x' = 0 	if ml_eli == 0 & country == "DK" & year == 2010
}

