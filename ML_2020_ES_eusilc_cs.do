/* ML_2020_ES_eusilc_cs */


* SPAIN - 2020

* ELIGIBILITY
/*	-> all employed and self-employed are entitled to some maternity leave (see section DURATION)
	-> conditions apply for duration and benefits:
		-> under 21 years old: no qualifying condition 
		-> 21-26 years: 90 days of compulsory contribution to social security system (coded) in past 7 years (not coded)
					or 180 days during work life (not coded)
		-> 26+ years: 180 days of s.s. contribution (coded) in past 7 years (not coded) or 360 days over the whole working life (not coded)
		-> employed, self-employed who don't fulfill the conditions (flat-rate benefits)
	
	-> mother can transfer 4 weeks to father if both parents work => coded for single men
*/

replace ml_eli = 1 			if country == "ES" & year == 2020 & gender == 1 ///
							& inlist(econ_status,1,2) 

* single men							
replace ml_eli = 1 		if country == "ES" & year == 2020 & gender == 2 ///
							& inlist(econ_status,1,2) & parstat == 1
														
													
replace ml_eli = 0 			if ml_eli == . & country == "ES" & year == 2020 & gender == 1



* DURATION (weeks)
/*	-> employed, self-employed who didn't fulfill the contribution requirements: 42 days
	-> employed, self-employed: 16 weeks 
	
	-> fathers: 4 weeks of transfered leave
	-> no obligatory prenatal leave => coded 0
*/

replace ml_dur1 = 0 		if country == "ES" & year == 2020 & ml_eli == 1

replace ml_dur2 = 16 		if country == "ES" & year == 2020 & ml_eli == 1 ///
							& inlist(econ_status,1,2) & age < 21

replace ml_dur2 = 16 		if country == "ES" & year == 2020 & ml_eli == 1 ///
							& inlist(econ_status,1,2) & inrange(age,21,26) ///
							& (duremp+dursemp) >= 90/21.7

replace ml_dur2 = 16 		if country == "ES" & year == 2020 & ml_eli == 1 ///							
							& inlist(econ_status,1,2) & age > 26 ///
							& (duremp+dursemp) >= 180/21.7
							
replace ml_dur2 = 42/5		if country == "ES" & year == 2020 & ml_eli == 1 ///
							& ml_dur2 == .

* single men
replace ml_dur2 = 10 		if country == "ES" & year == 2020 &  ml_eli == 1 ///
							& gender == 2 & parstat == 1
							
							
							
* BENEFIT (monthly)
/*	-> employed, self-employed who didn't fulfill the contribution requirements: €537.84/month (LP&R 2020)
	-> employed, self-employed: 100%
	-> ceiling: €4,070.10/month	
*/

replace ml_ben1 = earning 		if country == "ES" & year == 2020 & ml_eli == 1 ///
								& inlist(econ_status,1,2) & age < 21

replace ml_ben1 = earning 		if country == "ES" & year == 2020 & ml_eli == 1 ///
								& inlist(econ_status,1,2) & inrange(age,21,26) ///
								& (duremp+dursemp) >= 90/21.7

replace ml_ben1 = earning 		if country == "ES" & year == 2020 & ml_eli == 1 ///
								& inlist(econ_status,1,2) & age > 26 ///
								& (duremp+dursemp) >= 180/21.7
								
replace ml_ben1 = 4070.10 		if country == "ES" & year == 2020 & ml_eli == 1 ///
								& ml_ben1 >= 4070.10

replace ml_ben1 = 537.84		if country == "ES" & year == 2020 & ml_eli == 1 ///
								& ml_ben1 == .


replace ml_ben2 = ml_ben1 		if country == "ES" & year == 2020 & ml_eli == 1


foreach x in 1 2 {
	replace ml_dur`x' = 0 	if country == "ES" & year == 2020 & ml_eli == 0
	replace ml_ben`x' = 0 	if country == "ES" & year == 2020 & ml_eli == 0
	
}
