/* ML_2010_HR_eusilc_cs */


* CROATIA - 2010

* ELIGIBILITY
/*	-> employed  (maternity leave)
	-> self-employed (maternity leave)
	-> unemployed (exemption from work)
	-> inactive (maternity child care)		
	
	
*/
replace ml_eli = 1 		if country == "HR" & year == 2010 & gender == 1 ///
						& inrange(econ_status,1,4) 
						
replace ml_eli = 0 		if ml_eli == . & country == "HR" & year == 2010 ///
						& gender == 1


* DURATION (weeks)
/*	-> employed, self-employed:	
		-> prenatal: 28 days
		-> postnatal: until child is 6 months old		
	-> unemployed, inactive:
		-> prenatal: 0 days
		-> postnatal: until child is 6 months old
*/
	
replace ml_dur1 = 28/5 		if country == "HR" & year == 2010 & ml_eli == 1 ///
							& inlist(econ_status,1,2)
replace ml_dur1 = 0 		if country == "HR" & year == 2010 & ml_eli == 1 ///
							& inlist(econ_status,3,4)
							

replace ml_dur2 = 6*4.3 	if country == "HR" & year == 2010 & ml_eli == 1


* BENEFIT (monthly)
/*	-> employed, self-employed & insured for  12 consecutive months (coded) or for 18 non-consecutive
		months over the course of 2 years before birth (not coded): 100% earnings, no ceiling
	-> those who do not fulfill this requirement: half of the budgetary base rate, which was €460 (LP&R 2010) 	*/
	
replace ml_ben1 = earning 		if country == "HR" & year == 2010 & gender == 1 ///
								& ml_eli == 1 & (duremp+dursemp) >= 12 & earning != 0
replace ml_ben1 = 460/2			if country == "HR" & year == 2010 & gender == 1 ///
								& ml_eli == 1 & ml_ben1 == .
								


replace ml_ben2 = ml_ben1 		if country == "HR" & year == 2010 & gender == 1 & ml_eli == 1

foreach x in 1 2 {
    replace ml_dur`x' = 0 	if ml_eli == 0 & country == "HR" & year == 2010
	replace ml_ben`x' = 0 	if ml_eli == 0 & country == "HR" & year == 2010
}

