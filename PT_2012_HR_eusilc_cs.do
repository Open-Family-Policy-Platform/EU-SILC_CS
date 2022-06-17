/* PT_2012_HR_eusilc_cs */

* CROATIA - 2012

/*	Croatia doesn't have a stratutory right to paternity leave.  

	-> 	70 days after the childbirth, mother can transfer the rest of her maternity 
		leave on the father (until the child is 6 months old). Mother forgoes her
		maternity leave => not coded as paternity leave.

*/


* ELIGIBILITY
replace pt_eli = .a if country == "HR" & year == 2012 & gender == 2 


* DURATION (weeks)
replace pt_dur = .a if country == "HR" & year == 2012 & gender == 2


* BENEFIT (monthly)
replace pt_ben1 = .a if country == "HR" & year == 2012 & gender == 2
replace pt_ben2 = .a if country == "HR" & year == 2012 & gender == 2


foreach x in 1 2 {
	replace pt_ben`x' = 0 	if pt_eli == 0 & country == "HR" & year == 2012
}

replace pt_dur = 0 if pt_eli == 0 & country == "HR" & year == 2012
