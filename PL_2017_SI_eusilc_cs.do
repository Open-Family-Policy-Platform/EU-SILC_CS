/* PL_2018_SI_eusilc_cs */


* SLOVENIA - 2018

* ELIGIBILITY
/*	-> employed, self-employed	
	-> all other residents (different benefits) 		
	-> individual right 	
*/
	
replace pl_eli = 1 			if country == "SI" & year == 2018 
replace pl_eli =  0			if pl_eli == . & country == "SI" & year == 2018


* DURATION (weeks)
/*	-> 130 calendar days
	-> mother can transfer 100 days to the father (not coded)
	-> father can transfer 130 days to the mother (not coded) 	
	-> for inactive residents: 365 calendar days */
	
replace pl_dur = 130/7 		if country == "SI" & year == 2018 & pl_eli == 1 ///
							& inlist(econ_status,1,2)
replace pl_dur = 365/7 		if country == "SI" & year == 2018 & pl_eli == 1 ///
							& inlist(econ_status,3,4)							


* BENEFIT (monthly)
/*	-> employed, self-employed: 90% earning
	-> ceiling: €2,863/month (LP&R 2018)
	-> minimum: €804.96/month 
	-> all other residents: €323.55/month 	*/

replace pl_ben1 = 0.9*earning 		if country == "SI" & year == 2018 & pl_eli == 1 ///
									& inlist(econ_status,1,2)

replace pl_ben1 = 804.96 			if country == "SI" & year == 2018 & pl_eli == 1 ///
									& inlist(econ_status,1,2) & pl_ben1 < 804.96
									
replace pl_ben1 = 2863	 			if country == "SI" & year == 2018 & pl_eli == 1 ///
									& inlist(econ_status,1,2) & pl_ben1 >= 2863
									
replace pl_ben1 = 323.55	 		if country == "SI" & year == 2018 & pl_eli == 1 ///
									& inlist(econ_status,3,4)


									
replace pl_ben2 = pl_ben1			if country == "SI" & year == 2018 & pl_eli == 1


foreach x in 1 2 {
	replace pl_ben`x' = 0 	if pl_eli == 0 & country == "SI" & year == 2018
}

replace pl_dur = 0 	if pl_eli == 0 & country == "SI" & year == 2018
