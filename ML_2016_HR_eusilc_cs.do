/* ML_2016_HR_eusilc_cs */


* CROATIA - 2016

* ELIGIBILITY
/*	-> employed  (maternity leave)
	-> self-employed (maternity leave)
	-> unemployed (exemption from work)
	-> inactive (maternity child care)		
	
	-> 	mother can transfer 3 months to father (father can take maternity leave
		from the 71st day after childbirth until child is 6 months old). 
		The transfer is not automatic, mother needs to agree => it is assumed 
		that single father is not automatically entitled to the leave (not coded)
*/
replace ml_eli = 1 		if country == "HR" & year == 2016 & gender == 1 ///
						& inrange(econ_status,1,4) 
						
replace ml_eli = 0 		if ml_eli == . & country == "HR" & year == 2016 ///
						& gender == 1


* DURATION (weeks)
/*	-> employed, self-employed:	
		-> prenatal: 28 days
		-> postnatal: until child is 6 months old (70 days are compulsory)		
	-> unemployed, inactive:
		-> prenatal: 0 days
		-> postnatal: until child is 6 months old (70 days are compulsory)
*/
	
replace ml_dur1 = 28/5 		if country == "HR" & year == 2016 & ml_eli == 1 ///
							& inlist(econ_status,1,2) & gender == 1
replace ml_dur1 = 0 		if country == "HR" & year == 2016 & ml_eli == 1 ///
							& inlist(econ_status,3,4) & gender == 1
							

replace ml_dur2 = 6*4.3 	if country == "HR" & year == 2016 & ml_eli == 1 & gender == 1


* BENEFIT (monthly)
/*	-> employed, self-employed & insured for  12 consecutive months (coded) or for 18 non-consecutive
		months over the course of 2 years before birth (not coded) = 100%
	-> those who do not fulfill this requirement = €221/month	(MISSOC 1/7/2016) */
	
replace ml_ben1 = earning 		if country == "HR" & year == 2016 & gender == 1 ///
								& ml_eli == 1 & (duremp+dursemp) >= 12 & earning != 0
replace ml_ben1 = 221			if country == "HR" & year == 2016 & gender == 1 ///
								& ml_eli == 1 & ml_ben1 == .
								


replace ml_ben2 = ml_ben1 		if country == "HR" & year == 2016 & gender == 1 & ml_eli == 1

foreach x in 1 2 {
    replace ml_dur`x' = 0 	if ml_eli == 0 & country == "HR" & year == 2016
	replace ml_ben`x' = 0 	if ml_eli == 0 & country == "HR" & year == 2016
}

