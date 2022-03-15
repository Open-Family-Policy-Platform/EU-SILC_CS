/* PL_2011_SI_eusilc_cs */


* SLOVENIA - 2011

* ELIGIBILITY
/*	-> employed, self-employed	
	-> all other residents (different benefits) 		
	-> individual right 	
*/
	
replace pl_eli = 1 			if country == "SI" & year == 2011 
replace pl_eli =  0			if pl_eli == . & country == "SI" & year == 2011


* DURATION (weeks)
/*	-> 130 calendar days
	-> mother can transfer 100 days to the father (not coded)
	-> father can transfer 130 days to the mother (not coded) 	
	-> for inactive residents: 365 calendar days */
	
replace pl_dur = 130/7 		if country == "SI" & year == 2011 & pl_eli == 1 ///
							& inlist(econ_status,1,2)
replace pl_dur = 365/7 		if country == "SI" & year == 2011 & pl_eli == 1 ///
							& inlist(econ_status,3,4)							


* BENEFIT (monthly)
/*	-> employed, self-employed: 100% earning, no ceiling
	-> minimum: €411/month (55% - 105% of minimum wage based on period insured in the past 3 years. No insured period at all, --> 55%) 
	-> all other residents: €252.04/month 	*/

replace pl_ben1 = earning 			if country == "SI" & year == 2011 & pl_eli == 1 ///
									& inlist(econ_status,1,2)

replace pl_ben1 = 411				if country == "SI" & year == 2011 & pl_eli == 1 ///
									& inlist(econ_status,1,2) & pl_ben1 < 411
									
replace pl_ben1 = 252.04	 		if country == "SI" & year == 2011 & pl_eli == 1 ///
									& inlist(econ_status,3,4)


									
replace pl_ben2 = pl_ben1			if country == "SI" & year == 2011 & pl_eli == 1


foreach x in 1 2 {
	replace pl_ben`x' = 0 	if pl_eli == 0 & country == "SI" & year == 2011
}

replace pl_dur = 0 	if pl_eli == 0 & country == "SI" & year == 2011
