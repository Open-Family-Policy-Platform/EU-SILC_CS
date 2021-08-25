/* PT_2019_SI_eusilc_cs

date created: 12/08/2021

*/

* SLOVENIA - 2019

* ELIGIBILITY
/*	-> employed
	-> self-employed
	-> unemployed, inactive if they were compulsorily insured for at least 12 months (coded)
		over the past 3 years (not coded; LP&R 2019)
	-> benefits for unemployed and inactive people are not clearly specified in the sources => not coded	
*/

replace pt_eli = 1 			if country == "SI" & year == 2019 & gender == 2 ///
							& inlist(econ_status,1,2) 
replace pt_eli = 1 			if country == "SI" & year == 2019 & gender == 2 ///
							& inlist(econ_status,3,4) & duremp + dursemp >= 12	
	

* DURATION (weeks)
/*	-> 30 calendar days */

replace pt_dur = 30/7 	if country == "SI" & year == 2019 & pt_eli == 1


* BENEFIT (monthly)
/*	-> 100% earnings
	-> ceiling: 2.5x monthly average wages (M2019)
		-> €2,900 (net; LP&R 2019)
	-> minimum: 55% of the minimum wage (M2019)
		-> €323.55/month (LP&R 2019)		
*/

replace pt_ben1 = 0.9*earning 	 	if country == "SI" & year == 2019 & pt_eli == 1 
replace pt_ben1 = 323.55	 	 	if country == "SI" & year == 2019 & pt_eli == 1 ///
									& pt_ben1 < 323.55
replace pt_ben1 = 2900		 	 	if country == "SI" & year == 2019 & pt_eli == 1 ///
									& pt_ben1 >= 2900


replace pt_ben2 = pt_ben1 	if country == "SI" & year == 2019 & pt_eli == 1

foreach x in 1 2 {
	replace pt_ben`x' = 0 	if pt_eli == 0 & country == "SI" & year == 2019
}

replace pt_dur = 0 if pt_eli == 0 & country == "SI" & year == 2019
