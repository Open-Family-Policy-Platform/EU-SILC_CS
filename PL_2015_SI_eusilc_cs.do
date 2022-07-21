/* PL_2015_SI_eusilc_cs */


* SLOVENIA - 2015

* ELIGIBILITY
/*	-> employed, self-employed			
	-> individual entitlement 	
*/
	
replace pl_eli = 1 			if country == "SI" & year == 2015 & inlist(econ_status,1,2) 
replace pl_eli =  0			if pl_eli == . & country == "SI" & year == 2015


* DURATION (weeks)
/*	-> 130 calendar days/parent (LP&R 2015)
	-> mother can transfer 100 days to the father (not coded)
	-> father can transfer 130 days to the mother (not coded) 	
*/
	
replace pl_dur = 130/7 		if country == "SI" & year == 2015 & pl_eli == 1 ///
							& inlist(econ_status,1,2)


* BENEFIT (monthly)
/*	-> employed, self-employed: 90% earning
	-> ceiling: €3,080/month (LP&R 2015)
	-> minimum: €763.06/month 
*/

replace pl_ben1 = 0.9*earning 		if country == "SI" & year == 2015 & pl_eli == 1 ///
									& inlist(econ_status,1,2)

replace pl_ben1 = 763.06 			if country == "SI" & year == 2015 & pl_eli == 1 ///
									& inlist(econ_status,1,2) & pl_ben1 < 763.06
									
replace pl_ben1 = 3080	 			if country == "SI" & year == 2015 & pl_eli == 1 ///
									& inlist(econ_status,1,2) & pl_ben1 >= 3080
									


									
replace pl_ben2 = pl_ben1			if country == "SI" & year == 2015 & pl_eli == 1


foreach x in 1 2 {
	replace pl_ben`x' = 0 	if pl_eli == 0 & country == "SI" & year == 2015
}

replace pl_dur = 0 	if pl_eli == 0 & country == "SI" & year == 2015
