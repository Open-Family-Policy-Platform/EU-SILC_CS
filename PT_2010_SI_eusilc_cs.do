/* PT_2010_SI_eusilc_cs */


* SLOVENIA - 2010

* ELIGIBILITY
/*	-> employed
	-> self-employed
	-> unemployed, inactive if they were compulsorily insured for at least 12 months (coded)
		over the past 3 years (not coded; LP&R 2010)
	-> benefits for unemployed and inactive people are not clearly specified in the sources => not coded
	
*/

replace pt_eli = 1 			if country == "SI" & year == 2010 & gender == 2 ///
							& inlist(econ_status,1,2) 
replace pt_eli = 1 			if country == "SI" & year == 2010 & gender == 2 ///
							& inlist(econ_status,3,4) & (duremp + dursemp) >= 12	
	

* DURATION (weeks)
/*	-> 90 calendar days in total
*/

replace pt_dur = 90/7 	if country == "SI" & year == 2010 & pt_eli == 1


* BENEFIT (monthly)
/*	-> 100% earnings for 15 days
	-> 75 days unpaid
	-> ceiling: €3,876/month (LP&R 2010) 	
	-> minimum: €404/month (LP&R 2010)
	-> remaining 75 days: €162/month		*/

replace pt_ben1 = earning * (15/90) + 162 * (75/90)		 if country == "SI" & year == 2010 & pt_eli == 1 
replace pt_ben1 = 404 * (15/90) + 162 * (75/90)	 	 	 if country == "SI" & year == 2010 & pt_eli == 1 ///
									& earning < 404
replace pt_ben1 = 3876 + 162 * (75/90)		 	 	 if country == "SI" & year == 2010 & pt_eli == 1 ///
									& earning > 3876


replace pt_ben2 = earning * (15/21.7) 		if country == "SI" & year == 2010 & pt_eli == 1
replace pt_ben2 = pt_ben1 			if country == "SI" & year == 2010 & pt_eli == 1 if (earning < 404 | earning > 3876)

foreach x in 1 2 {
	replace pt_ben`x' = 0 	if pt_eli == 0 & country == "SI" & year == 2010
}

replace pt_dur = 0 if pt_eli == 0 & country == "SI" & year == 2010
