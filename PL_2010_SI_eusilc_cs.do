/* PL_2010_SI_eusilc_cs */


* SLOVENIA - 2010

* ELIGIBILITY
/*	-> employed, self-employed	
	-> family right => assigned to the women (in couples)	
*/
	
replace pl_eli = 1 			if country == "SI" & year == 2010 & inlist(econ_status,1,2)
 
replace pl_eli =  0			if pl_eli == . & country == "SI" & year == 2010


* DURATION (weeks)
/*	-> 260 calendar days
 */

* women
replace pl_dur = 260/7 		if country == "SI" & year == 2010 & pl_eli == 1 ///
							& inlist(econ_status,1,2) & gender == 1

* single men
replace pl_dur = 260/7 		if country == "SI" & year == 2010 & pl_eli == 1 ///
							& inlist(econ_status,1,2) & gender == 2 & parstat == 1


* BENEFIT (monthly)
/*	-> employed, self-employed: 100% earning
	-> ceiling: €3,876/month (LP&R 2010) 	
	-> minimum: €404/month (LP&R 2010)
*/

* women
replace pl_ben1 = earning 			if country == "SI" & year == 2010 & pl_eli == 1 ///
									& inlist(econ_status,1,2) & gender == 1
									
replace pl_ben1 = 3876 				if country == "SI" & year == 2010 & pl_eli == 1 ///
									& inlist(econ_status,1,2) & pl_ben1 > 3876 & gender == 1

replace pl_ben1 = 404				if country == "SI" & year == 2010 & pl_eli == 1 ///
									& inlist(econ_status,1,2) & pl_ben1 < 404 & gender == 1

* single men
replace pl_ben1 = earning 			if country == "SI" & year == 2010 & pl_eli == 1 ///
									& inlist(econ_status,1,2) & gender == 2 & parstat == 1
									
replace pl_ben1 = 3876 				if country == "SI" & year == 2010 & pl_eli == 1 ///
									& inlist(econ_status,1,2) & pl_ben1 > 3876 & gender == 2 & parstat == 1

replace pl_ben1 = 404				if country == "SI" & year == 2010 & pl_eli == 1 ///
									& inlist(econ_status,1,2) & pl_ben1 < 404 & gender == 2 & parstat == 1

									
replace pl_ben2 = pl_ben1			if country == "SI" & year == 2010 & pl_eli == 1


foreach x in 1 2 {
	replace pl_ben`x' = 0 	if pl_eli == 0 & country == "SI" & year == 2010
}

replace pl_dur = 0 	if pl_eli == 0 & country == "SI" & year == 2010
