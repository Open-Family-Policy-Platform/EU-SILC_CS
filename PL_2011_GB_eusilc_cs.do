/* PL_2011_GB_eusilc_cs */

/*	Great Britain provides shared parental leave and parental leave.
	
	Shared parental leave is a share of mother's maternity leave
	that can be transferred to father. This is coded in ML_2011_GB_eusilc_cs.
	
	Parental leave is an individual non-transferable right to 18 weeks of 
	unpaid leave. Each parent can draw maximum of 4 weeks of parental leave 
	per year (LP&R 2011). Parental leave has a character of an "emergency" leave
	=> not coded. 
*/


* UK - 2011

* ELIGIBILITY
replace pl_eli = .a 			if country == "GB" & year == 2011 
replace pl_eli = .a			if pl_eli == . & country == "GB" & year == 2011


* DURATION (weeks)
replace pl_dur = .a 		if country == "GB" & year == 2011 & pl_eli == 1


* BENEFIT (monthly)
replace pl_ben1 = .a 		if country == "GB" & year == 2011 & pl_eli == 1
replace pl_ben2 = .a		if country == "GB" & year == 2011 & pl_eli == 1



foreach x in 1 2 {
	replace pl_ben`x' = .a 	if country == "GB" & year == 2011 & pl_eli == 0	
}

replace pl_dur = .a 	if country == "GB" & year == 2011 & pl_eli == 0
