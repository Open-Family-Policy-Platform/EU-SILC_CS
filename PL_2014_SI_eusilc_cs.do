/* PL_2014_SI_eusilc_cs */


* SLOVENIA - 2014

* ELIGIBILITY
/*	
	-> employed, self-employed	
	-> family entitlement => assigned to women
	
	-> from 1.9.2014: individual entitlement, 130 days/parent (coded in 2015; LP&R 2014)
		
*/
	
replace pl_eli = 1 			if country == "SI" & year == 2014 & inlist(econ_status,1,2)
replace pl_eli =  0			if pl_eli == . & country == "SI" & year == 2014
	

							
* DURATION (weeks)
/*	-> 260 calendar days */
	
* women
replace pl_dur = 260/7 		if country == "SI" & year == 2014 & pl_eli == 1 ///
							& inlist(econ_status,1,2) & gender == 1

* single men
replace pl_dur = 260/7 		if country == "SI" & year == 2014 & pl_eli == 1 ///
							& inlist(econ_status,1,2) & gender == 2 & parstat == 1					


* BENEFIT (monthly)
/*	-> employed, self-employed: 90% earning
	-> ceiling: €3,050/month (LP&R 2014)
	-> minimum: €763.06/month 
 */

* women
replace pl_ben1 = earning 			if country == "SI" & year == 2014 & pl_eli  == 1 ///
									& inlist(econ_status,1,2) & gender == 1
									
replace pl_ben1 = 3050 				if country == "SI" & year == 2014 & pl_eli == 1 ///
									& inlist(econ_status,1,2) & pl_ben1 > 3050 & gender == 1

replace pl_ben1 = 763.06				if country == "SI" & year == 2014 & pl_eli == 1 ///
									& inlist(econ_status,1,2) & pl_ben1 < 763.06 & gender == 1

* single men
replace pl_ben1 = earning 			if country == "SI" & year == 2014 & pl_eli == 1 ///
									& inlist(econ_status,1,2) & gender == 2 & parstat == 1
									
replace pl_ben1 = 3050 				if country == "SI" & year == 2014 & pl_eli == 1 ///
									& inlist(econ_status,1,2) & pl_ben1 > 3050 & gender == 2 & parstat == 1

replace pl_ben1 = 763.06				if country == "SI" & year == 2014 & pl_eli == 1 ///
									& inlist(econ_status,1,2) & pl_ben1 < 763.06 & gender == 2 & parstat == 1




									
replace pl_ben2 = pl_ben1			if country == "SI" & year == 2014 & pl_eli == 1


foreach x in 1 2 {
	replace pl_ben`x' = 0 	if pl_eli == 0 & country == "SI" & year == 2014
}

replace pl_dur = 0 	if pl_eli == 0 & country == "SI" & year == 2014
