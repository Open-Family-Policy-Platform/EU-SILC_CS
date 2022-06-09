/* PT_2010_IT_eusilc_cs */


* ITALY - 2010

* ELIGIBILITY
/*	no statutory right to paternity leave  		*/
		
replace pt_eli = . 		if country == "IT" & year == 2010 & gender == 2 


* DURATION (weeks)


replace pt_dur = .a 	if country == "IT" & year == 2010 & pt_eli == 1


* BENEFIT (monthly)

replace pt_ben1 = .a 	if country == "IT" & year == 2010 & pt_eli == 1
replace pt_ben2 = .a 	if country == "IT" & year == 2010 & pt_eli == 1


foreach x in 1 2 {
	replace pt_ben`x' = 0 	if pt_eli == 0 & country == "IT" & year == 2010
}

replace pt_dur = 0 if pt_eli == 0 & country == "IT" & year == 2010
