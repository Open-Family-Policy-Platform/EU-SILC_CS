/* PT_2015_SI_eusilc_cs */


* SLOVENIA - 2015

* ELIGIBILITY
/*	-> employed
	-> self-employed
	-> unemployed, inactive if they were compulsorily insured for at least 12 months (coded)
		over the past 3 years (not coded; LP&R 2015)
	-> benefits for unemployed and inactive people are not clearly specified in the sources => not coded
	
*/

replace pt_eli = 1 			if country == "SI" & year == 2015 & gender == 2 ///
							& inlist(econ_status,1,2) 
replace pt_eli = 1 			if country == "SI" & year == 2015 & gender == 2 ///
							& inlist(econ_status,3,4) & (duremp + dursemp) >= 12	

replace pt_eli = 0 			if country == "SI" & year == 2015 & gender == 2 ///
							& pt_eli == .

* DURATION (weeks)
/*	-> 90 calendar days in total
*/

replace pt_dur = 90/7 	if country == "SI" & year == 2015 & pt_eli == 1


* BENEFIT (monthly)
/*	-> 90% earnings for 15 days
	-> 75 days unpaid
	-> ceiling: €3,080/month (LP&R 2015) 	
	-> minimum: €763.06/month (LP&R 2015)		*/

replace pt_ben1 = (0.9*earning) * (15/80) 	 if country == "SI" & year == 2015 & pt_eli == 1 
replace pt_ben1 = 763.06	 	 	if country == "SI" & year == 2015 & pt_eli == 1 ///
									& pt_ben1 < 763.06
replace pt_ben1 = 3080		 	 	if country == "SI" & year == 2015 & pt_eli == 1 ///
									& pt_ben1 > 3080


replace pt_ben2 = (0.9*earning) * (15/21.7) 	if country == "SI" & year == 2015 & pt_eli == 1
replace pt_ben2 = 763.06	 	 	if country == "SI" & year == 2015 & pt_eli == 1 ///
									& pt_ben2 < 763.06
replace pt_ben2 = 3080		 	 	if country == "SI" & year == 2015 & pt_eli == 1 ///
									& pt_ben2 > 3080


foreach x in 1 2 {
	replace pt_ben`x' = 0 	if pt_eli == 0 & country == "SI" & year == 2015
}

replace pt_dur = 0 if pt_eli == 0 & country == "SI" & year == 2015
