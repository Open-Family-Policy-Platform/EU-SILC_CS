/* PL_2011_IE_eusilc_cs */

* IRELAND - 2011

* ELIGIBILITY
/*	-> employed
	-> who completed at least 12 months (coded) with their current employer (not coded; LP&R 2011)
*/
replace pl_eli = 1 			if country == "IE" & year == 2011 & econ_status == 1 ///
							& duremp >= 12
replace pl_eli = 0 			if pl_eli == . & country == "IE" & year == 2011


* DURATION (weeks)
/*	-> 14 weeks
	-> before child's 8th birthday (not coded)
*/
replace pl_dur = 14 		if country == "IE" & year == 2011 & pl_eli == 1


* BENEFIT (monthly)
/*	-> unpaid */

replace pl_ben1 = 0 		if country == "IE" & year == 2011 & pl_eli == 1
replace pl_ben2 = 0 		if country == "IE" & year == 2011 & pl_eli == 1


foreach x in 1 2 {
	replace pl_ben`x' = 0 	if pl_eli == 0 & country == "IE" & year == 2011
}

replace pl_dur = 0 	if pl_eli == 0 & country == "IE" & year == 2011
