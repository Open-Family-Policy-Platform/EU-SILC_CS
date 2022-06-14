/* PT_2012_DE_eusilc_cs */

* GERMANY - 2012

* ELIGIBILITY
/* No statutory right to paternity leave (LP&R 2012) */

//replace pt_eli = 1 		if country == "DE" & year == 2012 & gender == 2 
replace pt_eli = 0 		if  country == "DE" & year == 2012 & gender == 2

* DURATION (weeks)
replace pt_dur = .a 	if country == "DE" & year == 2012 & pt_eli == 1


* BENEFIT (monthly)
replace pt_ben1 = .a 	if country == "DE" & year == 2012 & pt_eli == 1
replace pt_ben2 = .a 	if country == "DE" & year == 2012 & pt_eli == 1


foreach x in 1 2 {
	replace pt_ben`x' = 0 	if pt_eli == 0 & country == "DE" & year == 2012
}

replace pt_dur = 0 if pt_eli == 0 & country == "DE" & year == 2012
