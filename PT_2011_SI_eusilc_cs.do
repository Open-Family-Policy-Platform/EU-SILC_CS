/* PT_2011_SI_eusilc_cs */


* SLOVENIA - 2011

* ELIGIBILITY
/*	-> employed
	-> self-employed
	-> unemployed, inactive if they were compulsorily insured for at least 12 months (coded)
		over the past 3 years (not coded; LP&R 2011)
	-> benefits for unemployed and inactive people are not clearly specified in the sources => not coded
	
*/

replace pt_eli = 1 			if country == "SI" & year == 2011 & gender == 2 ///
							& inlist(econ_status,1,2) 
replace pt_eli = 1 			if country == "SI" & year == 2011 & gender == 2 ///
							& inlist(econ_status,3,4) & (duremp + dursemp) >= 12	
	

* DURATION (weeks)
/*	-> 90 calendar days in total (coded) 
		-> 15 days have to be used before child is 6 months old, remaining 75 days have to be used before child is 3 years old (not coded)
*/

replace pt_dur = 90/7 	if country == "SI" & year == 2011 & pt_eli == 1


* BENEFIT (monthly)
/*	-> 100% earnings for 15 days
	-> ceiling: €3,741/month (LP&R 2011) 	
	-> minimum: €411/month (55% of minimum wage, LP&R 2011)
	-> remaining 75 days: €165/month		*/

replace pt_ben1 = earning * (15/90) + 165 * (75/90)			if country == "SI" & year == 2011 & pt_eli == 1 
replace pt_ben1 = 420 * (15/90) + 169 * (75/90)		  		if country == "SI" & year == 2011 & pt_eli == 1 ///
										& earning < 411
replace pt_ben1 = 3741 + 169 * (75/90)			 	 	if country == "SI" & year == 2011 & pt_eli == 1 ///
										& earning > 3741


replace pt_ben2 = earning * (15/21.7) 			if country == "SI" & year == 2011 & pt_eli == 1
replace pt_ben2 = pt_ben1 				if country == "SI" & year == 2011 & pt_eli == 1 if (earning < 411 | earning > 3741)

foreach x in 1 2 {
	replace pt_ben`x' = 0 	if pt_eli == 0 & country == "SI" & year == 2011
}

replace pt_dur = 0 if pt_eli == 0 & country == "SI" & year == 2011
