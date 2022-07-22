/* PT_2020_SI_eusilc_cs */


* SLOVENIA - 2020

* ELIGIBILITY
/*	-> employed
	-> self-employed
	-> unemployed, inactive if they were compulsorily insured for at least 12 months (coded)
		over the past 3 years (not coded; LP&R 2020)
	-> benefits for unemployed and inactive people are not clearly specified in the sources => not coded	
*/

replace pt_eli = 1 			if country == "SI" & year == 2020 & gender == 2 ///
							& inlist(econ_status,1,2) 
replace pt_eli = 1 			if country == "SI" & year == 2020 & gender == 2 ///
							& inlist(econ_status,3,4) & (duremp + dursemp) >= 12
							
replace pt_eli = 0 			if country == "SI" & year == 2020 & gender == 2 ///
							& pt_eli == .
	

* DURATION (weeks)
/*	-> 30 calendar days */

replace pt_dur = 30/7 	if country == "SI" & year == 2020 & pt_eli == 1


* BENEFIT (monthly)
/*	-> 100% earnings
	-> ceiling: 2.5x monthly average wages (M2020)
		-> €3,664.30 (net; LP&R 2020)
	-> minimum: 55% of the minimum wage (M2020)
		-> €323.55/month (LP&R 2020)		
*/

replace pt_ben1 = earning 	 		if country == "SI" & year == 2020 & pt_eli == 1 
replace pt_ben1 = 323.55	 	 	if country == "SI" & year == 2020 & pt_eli == 1 ///
									& inlist(econ_status,1,2) & pt_ben1 < 323.55
replace pt_ben1 = 3664.3		 	 	if country == "SI" & year == 2020 & pt_eli == 1 ///
									& inlist(econ_status,1,2) & pt_ben1 >= 3664.3


replace pt_ben2 = pt_ben1 	if country == "SI" & year == 2020 & pt_eli == 1

foreach x in 1 2 {
	replace pt_ben`x' = 0 	if pt_eli == 0 & country == "SI" & year == 2020
}

replace pt_dur = 0 if pt_eli == 0 & country == "SI" & year == 2020
