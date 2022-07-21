/* PL_2011_SI_eusilc_cs */


* SLOVENIA - 2011

* ELIGIBILITY
/*	-> employed, self-employed			
	-> family right => assigned to the women	
*/
	
replace pl_eli = 1 			if country == "SI" & year == 2011 & gender == 1 & inlist(econ_status,1,2)
replace pl_eli =  0			if pl_eli == . & country == "SI" & year == 2011


* DURATION (weeks)
/*	-> 260 calendar days
*/
	
* women
replace pl_dur = 260/7 		if country == "SI" & year == 2011 & pl_eli == 1 ///
							& inlist(econ_status,1,2) & gender == 1

* single men
replace pl_dur = 260/7 		if country == "SI" & year == 2011 & pl_eli == 1 ///
							& inlist(econ_status,1,2) & gender == 2 & parstat == 1

* BENEFIT (monthly)
/*	-> employed, self-employed: 100% earning
	-> ceiling: €3,741/month (LP&R 2011)
	-> minimum: €411/month (55% - 105% of minimum wage based on period insured in the past 3 years. No insured period at all, --> 55%) 
*/

* women
replace pl_ben1 = earning 			if country == "SI" & year == 2011 & pl_eli == 1 ///
									& inlist(econ_status,1,2) & gender == 1
									
replace pl_ben1 = 3876 				if country == "SI" & year == 2011 & pl_eli == 1 ///
									& inlist(econ_status,1,2) & pl_ben1 > 3876 & gender == 1

replace pl_ben1 = 404				if country == "SI" & year == 2011 & pl_eli == 1 ///
									& inlist(econ_status,1,2) & pl_ben1 < 404 & gender == 1

* single men
replace pl_ben1 = earning 			if country == "SI" & year == 2011 & pl_eli == 1 ///
									& inlist(econ_status,1,2) & gender == 2 & parstat == 1
									
replace pl_ben1 = 3876 				if country == "SI" & year == 2011 & pl_eli == 1 ///
									& inlist(econ_status,1,2) & pl_ben1 > 3876 & gender == 2 & parstat == 1

replace pl_ben1 = 404				if country == "SI" & year == 2011 & pl_eli == 1 ///
									& inlist(econ_status,1,2) & pl_ben1 < 404 & gender == 2 & parstat == 1



									
replace pl_ben2 = pl_ben1			if country == "SI" & year == 2011 & pl_eli == 1


foreach x in 1 2 {
	replace pl_ben`x' = 0 	if pl_eli == 0 & country == "SI" & year == 2011
}

replace pl_dur = 0 	if pl_eli == 0 & country == "SI" & year == 2011
