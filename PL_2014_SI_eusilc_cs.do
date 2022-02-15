/* PL_2014_SI_eusilc_cs */


* SLOVENIA - 2014

* ELIGIBILITY
/*	-> employed, self-employed	
	-> all other residents (different benefits) 		
	-> individual right 	
*/
	
replace pl_eli = 1 			if country == "SI" & year == 2014 
replace pl_eli =  0			if pl_eli == . & country == "SI" & year == 2014


* DURATION (weeks)
/*	-> 130 calendar days
	-> mother can transfer 100 days to the father (not coded)
	-> father can transfer 130 days to the mother (not coded) 	
	-> for inactive residents: 365 calendar days */
	
replace pl_dur = 130/7 		if country == "SI" & year == 2014 & pl_eli == 1 ///
							& inlist(econ_status,1,2)
replace pl_dur = 365/7 		if country == "SI" & year == 2014 & pl_eli == 1 ///
							& inlist(econ_status,3,4)							


* BENEFIT (monthly)
/*	-> employed, self-employed: 90% earning
	-> ceiling: €3,050/month (LP&R 2014)
	-> minimum: €763.06/month 
	-> all other residents: €252.04/month 	*/

replace pl_ben1 = 0.9*earning 		if country == "SI" & year == 2014 & pl_eli == 1 ///
									& inlist(econ_status,1,2)

replace pl_ben1 = 763.06 			if country == "SI" & year == 2014 & pl_eli == 1 ///
									& inlist(econ_status,1,2) & pl_ben1 < 763.06
									
replace pl_ben1 = 3050	 			if country == "SI" & year == 2014 & pl_eli == 1 ///
									& inlist(econ_status,1,2) & pl_ben1 >= 3050
									
replace pl_ben1 = 252.04	 		if country == "SI" & year == 2014 & pl_eli == 1 ///
									& inlist(econ_status,3,4)


									
replace pl_ben2 = pl_ben1			if country == "SI" & year == 2014 & pl_eli == 1


foreach x in 1 2 {
	replace pl_ben`x' = 0 	if pl_eli == 0 & country == "SI" & year == 2014
}

replace pl_dur = 0 	if pl_eli == 0 & country == "SI" & year == 2014
