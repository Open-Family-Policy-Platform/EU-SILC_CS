/* ML_2010_HU_eusilc_cs */


* HUNGARY - 2010

* ELIGIBILITY
/*	-> employed
	-> self-employed
	-> compulsorily insured for at least 365 days (coded) over the past 2 years (not coded)
	-> father is eligible in case of mother's death or when she is not present 
		in the household due to health reason => assumed this doesn't apply to 
		fathers when the mother abandoned the child
*/
	
replace ml_eli = 1 			if country == "HU" & year == 2010 & gender == 1 ///
							& inlist(econ_status,1,2) & (duremp+dursemp) >= 12
						

replace ml_eli = 0 			if ml_eli == . & country == "HU" & year == 2010 & gender == 1


* DURATION (weeks)
/*	-> prenatal: up to 4 weeks (from 2014, 2 obligatory prenatal weeks are mentioned but not in earlier years)
	-> total: 24 weeks 		*/
	
replace ml_dur1 = 4 		if country == "HU" & year == 2010 & ml_eli == 1

replace ml_dur2 = 24-4 		if country == "HU" & year == 2010 & ml_eli == 1


* BENEFIT (monthly)
/*	-> 70% earnings
	-> no ceiling			*/

replace ml_ben1 = 0.7*earning 		if country == "HU" & year == 2010 & ml_eli == 1
replace ml_ben2 = 0.7*earning 		if country == "HU" & year == 2010 & ml_eli == 1


foreach x in 1 2 {
    replace ml_dur`x' = 0 	if ml_eli == 0 & country == "HU" & year == 2010
	replace ml_ben`x' = 0 	if ml_eli == 0 & country == "HU" & year == 2010
}

