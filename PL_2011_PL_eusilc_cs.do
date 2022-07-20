/* PL_2011_PL_eusilc_cs */


* POLAND - 2011

* ELIGIBILITY
/*	-> urlop wychowawczy (childcare leave)
		-> compulsorily insured employed parents with at least 6 months employment
		-> voluntarily insured self-employed (not coded)
		
	-> family entitlement: in couples assigned to women
	
	-> NOT CODED: 	parental leave was introduced in 2013, the LP&R starts report on this
					type of leave as "childcare leave". Similar type of leave is available 
					in Finland but is not coded in OFPP. For the sake of consistency, this
					type of leave was not coded for Poland.
*/
replace pl_eli = 0			if country == "PL" & year == 2011


* DURATION (weeks)

replace pl_dur = .a			if country == "PL" & year == 2011						

							
* BENEFIT (monthly)
 
replace pl_ben1 = .a		if country == "PL" & year == 2011	
									
replace pl_ben2 = .a		if country == "PL" & year == 2011	


foreach x in 1 2 {
	replace pl_ben`x' = 0 	if pl_eli == 0 & country == "PL" & year == 2011
}

replace pl_dur = 0 	if country == "PL" & year == 2011	
