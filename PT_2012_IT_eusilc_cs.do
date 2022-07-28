/* PT_2012_IT_eusilc_cs */


* ITALY - 2012

* ELIGIBILITY
/*	no statutory right to paternity leave  		*/
		
replace pt_eli = .a 		if country == "IT" & year == 2012 & gender == 2 


* DURATION (weeks)


replace pt_dur = .a 	if country == "IT" & year == 2012 & pt_eli == 1


* BENEFIT (monthly)

replace pt_ben1 = .a 	if country == "IT" & year == 2012 & pt_eli == 1
replace pt_ben2 = .a 	if country == "IT" & year == 2012 & pt_eli == 1


foreach x in 1 2 {
	replace pt_ben`x' = 0 	if pt_eli == 0 & country == "IT" & year == 2012
}

replace pt_dur = 0 if pt_eli == 0 & country == "IT" & year == 2012
