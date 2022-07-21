/* PL_2012_SI_eusilc_cs */


* SLOVENIA - 2012

* ELIGIBILITY
/*	-> employed, self-employed			
	-> family right => assigned to the women	
*/
	
replace pl_eli = 1 			if country == "SI" & year == 2012 & gender == 1 & inlist(econ_status,1,2)
replace pl_eli =  0			if pl_eli == . & country == "SI" & year == 2012


* DURATION (weeks)
/*	-> 260 calendar days
*/
	
* women
replace pl_dur = 260/7 		if country == "SI" & year == 2012 & pl_eli == 1 ///
							& inlist(econ_status,1,2) & gender == 1

* single men
replace pl_dur = 260/7 		if country == "SI" & year == 2012 & pl_eli == 1 ///
							& inlist(econ_status,1,2) & gender == 2 & parstat == 1

* BENEFIT (monthly)
/*	-> employed, self-employed: 100% earning
	-> ceiling: €3,865/month (LP&R 2012) 	
	-> minimum: €420/month (LP&R 2012) 
*/

* women
replace pl_ben1 = earning 			if country == "SI" & year == 2012 & pl_eli == 1 ///
									& inlist(econ_status,1,2) & gender == 1
									
replace pl_ben1 = 3865 				if country == "SI" & year == 2012 & pl_eli == 1 ///
									& inlist(econ_status,1,2) & pl_ben1 > 3865 & gender == 1

replace pl_ben1 = 420				if country == "SI" & year == 2012 & pl_eli == 1 ///
									& inlist(econ_status,1,2) & pl_ben1 < 420 & gender == 1

* single men
replace pl_ben1 = earning 			if country == "SI" & year == 2012 & pl_eli == 1 ///
									& inlist(econ_status,1,2) & gender == 2 & parstat == 1
									
replace pl_ben1 = 3865 				if country == "SI" & year == 2012 & pl_eli == 1 ///
									& inlist(econ_status,1,2) & pl_ben1 > 3865 & gender == 2 & parstat == 1

replace pl_ben1 = 420				if country == "SI" & year == 2012 & pl_eli == 1 ///
									& inlist(econ_status,1,2) & pl_ben1 < 420 & gender == 2 & parstat == 1



									
replace pl_ben2 = pl_ben1			if country == "SI" & year == 2012 & pl_eli == 1


foreach x in 1 2 {
	replace pl_ben`x' = 0 	if pl_eli == 0 & country == "SI" & year == 2012
}

replace pl_dur = 0 	if pl_eli == 0 & country == "SI" & year == 2012
