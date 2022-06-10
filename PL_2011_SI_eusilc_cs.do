/* PL_2011_SI_eusilc_cs */


* SLOVENIA - 2011

* ELIGIBILITY
/*	-> employed, self-employed			
	-> family right => assigned to the woman	
*/
	
replace pl_eli = 1 			if country == "SI" & year == 2011 & gender == 1
replace pl_eli =  0			if pl_eli == . & country == "SI" & year == 2011


* DURATION (weeks)
/*	-> 260 calendar days
*/
	
replace pl_dur = 260/7 		if country == "SI" & year == 2011 & pl_eli == 1 ///
							& inlist(econ_status,1,2) 


* BENEFIT (monthly)
/*	-> employed, self-employed: 100% earning
	-> ceiling: €3,741/month (LP&R 2011)
	-> minimum: €411/month (55% - 105% of minimum wage based on period insured in the past 3 years. No insured period at all, --> 55%) 
*/

replace pl_ben1 = earning 			if country == "SI" & year == 2011 & pl_eli == 1 ///
									& inlist(econ_status,1,2)

replace pl_ben1 = 411				if country == "SI" & year == 2011 & pl_eli == 1 ///
									& inlist(econ_status,1,2) & pl_ben1 < 411

replace pl_ben1 = 3741				if country == "SI" & year == 2011 & pl_eli == 1 ///
									& inlist(econ_status,1,2) & pl_ben1 > 3741




									
replace pl_ben2 = pl_ben1			if country == "SI" & year == 2011 & pl_eli == 1


foreach x in 1 2 {
	replace pl_ben`x' = 0 	if pl_eli == 0 & country == "SI" & year == 2011
}

replace pl_dur = 0 	if pl_eli == 0 & country == "SI" & year == 2011
