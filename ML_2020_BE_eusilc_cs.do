/* ML_2020_BE_eusilc_cs */


* BELGIUM - 2020


* ELIGIBILITY
/*	-> compulsory social insurance for employed and self-employed:
		-> employed
		-> self-emloyed (separate system)
		-> conditions: 120 days of paid contributions
	
	-> unemployed with unemployment benefit
	
	-> ML is not transferable but can be turned into parental leave if mother dies 
		or during woman's hospitalization => it is assumed that this does not apply 
		to a child being abandoned by the mother (not coded)
*/

replace ml_eli = 1 		if country == "BE" & year == 2020 & gender == 1 ///
						& inrange(econ_status,1,3) & (duremp+dursemp) >= 120/21.7 
replace ml_eli = 0 		if ml_eli == . & country == "BE" & year == 2020 & gender == 1


* DURATION (weeks)
/*	-> employed, unemployed:
		-> total: 15 weeks
		-> prenatal: 1 (compulsory)
	-> self-employed: 
		-> total: 12 weeks
*/

replace ml_dur1 = 1 	if country == "BE" & year == 2020 & gender == 1 ///
						& ml_eli == 1



			
replace ml_dur2 = 15-1 	if country == "BE" & year == 2020 & gender == 1 ///
						& ml_eli == 1
			
replace ml_dur2 = 12-1 	if country == "BE" & year == 2020 & gender == 1 ///
						& econ_status == 2 & ml_eli == 1




* BENEFIT (monthly)
/* 	
	-> public sector: 100% earning (LP&R 2020)
	-> private sector: 
		-> first 30 days = 82% earnings, no ceiling 
		-> rest of leave = 75% earnings, ceiling € 110.23/day.
		
	-> unemployed (M2020): 
		-> first month = unemployment benefit + 19% of previous earnings with a ceiling €116.85/day
		-> rest = unemployment benefit + 15% with a ceiling € 110.23/day
		-> not coded (EU-SILC unemployment benefit - household level data)
		
	-> self-employed (LP&R 2020):
		-> €485/week
*/

gen ceiling = (0.75*earning) 		// for the purpose of ceiling calculation

* the average for a mothly benefit (accounting for the change in rate)
replace ml_ben1 = (((((0.82*earning) / 4.3) * (30/5)) + (((0.75*earning)/4.3) * (15 - (30/5)))) / 15) * 4.3 /// 
						if country == "BE" & year == 2020 & gender == 1 ///
						& econ_status == 1 & ml_ben1 == . & ml_eli == 1 ///
						& ceiling <= 110.23*21.7


						
* above ceiling						
replace ml_ben1 = (((((0.82*earning) / 4.3) * (30/5)) + (((110.23 * 5) * (15 - (30/5))))) / 15) * 4.3 ///
						if country == "BE" & year == 2020 & gender == 1 ///
						& econ_status == 1 & ml_ben1 == . & ml_eli == 1 ///
						& ceiling > 110.23*21.7
				

	
* self-employed
replace ml_ben1 = 485 * 4.3 		if country == "BE" & year == 2020 ///
									& gender == 1 & econ_status == 2 ///
									& ml_ben1 == . & ml_eli == 1


* ML benefit in the first month
replace ml_ben2 = 0.82 * earning ///
						if country == "BE" & year == 2020 & gender == 1 ///
						& econ_status == 1 & ml_ben2 == . & ml_eli == 1
			

replace ml_ben2 = 485*4.3 ///
						if country == "BE" & year == 2020 & gender == 1 ///
						& econ_status == 2 & ml_ben2 == . & ml_eli == 1



foreach x in 1 2 {
    replace ml_dur`x' = 0 	if ml_eli == 0 & country == "BE" & year == 2020
	replace ml_ben`x' = 0 	if ml_eli == 0 & country == "BE" & year == 2020
}


drop ceiling 
