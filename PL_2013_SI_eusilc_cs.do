/* PL_2013_SI_eusilc_cs */


* SLOVENIA - 2013

* ELIGIBILITY
/*	-> employed, self-employed			
	-> family right => assigned to the women		
*/
	
replace pl_eli = 1 			if country == "SI" & year == 2013 & inlist(econ_status,1,2)
replace pl_eli =  0			if pl_eli == . & country == "SI" & year == 2013


* DURATION (weeks)
/*	-> 260 calendar days */
	
* women
replace pl_dur = 260/7 		if country == "SI" & year == 2013 & pl_eli == 1 ///
							& inlist(econ_status,1,2) & gender == 1

* single men
replace pl_dur = 260/7 		if country == "SI" & year == 2013 & pl_eli == 1 ///
							& inlist(econ_status,1,2) & gender == 2 & parstat == 1		


* BENEFIT (monthly)
/*	-> employed, self-employed: 90% earning
	-> ceiling: €2,863/month (LP&R 2013)
	-> minimum: €323.55/month 
*/

* women
replace pl_ben1 = earning 			if country == "SI" & year == 2013 & pl_eli == 1 ///
									& inlist(econ_status,1,2) & gender == 1
									
replace pl_ben1 = 2863 				if country == "SI" & year == 2013 & pl_eli == 1 ///
									& inlist(econ_status,1,2) & pl_ben1 > 2863 & gender == 1

replace pl_ben1 = 323.55				if country == "SI" & year == 2013 & pl_eli == 1 ///
									& inlist(econ_status,1,2) & pl_ben1 < 323.55 & gender == 1

* single men
replace pl_ben1 = earning 			if country == "SI" & year == 2013 & pl_eli == 1 ///
									& inlist(econ_status,1,2) & gender == 2 & parstat == 1
									
replace pl_ben1 = 2863 				if country == "SI" & year == 2013 & pl_eli == 1 ///
									& inlist(econ_status,1,2) & pl_ben1 > 2863 & gender == 2 & parstat == 1

replace pl_ben1 = 323.55				if country == "SI" & year == 2013 & pl_eli == 1 ///
									& inlist(econ_status,1,2) & pl_ben1 < 323.55 & gender == 2 & parstat == 1



									
replace pl_ben2 = pl_ben1			if country == "SI" & year == 2013 & pl_eli == 1


foreach x in 1 2 {
	replace pl_ben`x' = 0 	if pl_eli == 0 & country == "SI" & year == 2013
}

replace pl_dur = 0 	if pl_eli == 0 & country == "SI" & year == 2013
