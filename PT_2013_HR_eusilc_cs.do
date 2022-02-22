/* PT_2013_HR_eusilc_cs */

* CROATIA - 2013

/*	Croatia doesn't have a stratutory right to paternity leave.  */


* ELIGIBILITY
replace pt_eli = 0 if country == "HR" & year == 2013 & gender == 2 


* DURATION (weeks)
replace pt_dur = .a if country == "HR" & year == 2013 & gender == 2


* BENEFIT (monthly)
replace pt_ben1 = .a if country == "HR" & year == 2013 & gender == 2
replace pt_ben2 = .a if country == "HR" & year == 2013 & gender == 2


foreach x in 1 2 {
	replace pt_ben`x' = 0 	if pt_eli == 0 & country == "HR" & year == 2013
}

replace pt_dur = 0 if pt_eli == 0 & country == "HR" & year == 2013
