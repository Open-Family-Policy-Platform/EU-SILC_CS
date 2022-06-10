/* PT_2011_IT_eusilc_cs */


* ITALY - 2011

/* No paternity leave at all! (only under circumstances: mother's death/severe illness, child being left by mother.) 	*/

* ELIGIBILITY
/*	no statutory right to paternity leave  		*/
		
replace pt_eli = 0 		if country == "IT" & year == 2011 & gender == 2 


* DURATION (weeks)


replace pt_dur = .a 	if country == "IT" & year == 2011 & pt_eli == 1


* BENEFIT (monthly)

replace pt_ben1 = .a 	if country == "IT" & year == 2011 & pt_eli == 1
replace pt_ben2 = .a 	if country == "IT" & year == 2011 & pt_eli == 1


foreach x in 1 2 {
	replace pt_ben`x' = 0 	if pt_eli == 0 & country == "IT" & year == 2011
}

replace pt_dur = 0 if pt_eli == 0 & country == "IT" & year == 2011
