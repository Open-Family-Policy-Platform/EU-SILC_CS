/* PT_2017_NL_eusilc_cs

date created: 01/03/2021

*/

* NETHERLANDS - 2017

* ELIGIBILITY (LP&R 2018)

replace pt_eli = 1 		if country == "NL" & year == 2017 & gender == 2 ///
						& econ_status == 1
replace pt_eli = 0 		if pt_eli == . & country == "NL" & year == 2017 & gender == 2


* DURATION (weeks)
/* Can be up to 5 days long but 3 days have to be taken from parental leave 
=> coded as 2 days of leave */

replace pt_dur = 2/5 if country == "NL" & year == 2017 & pt_eli == 1  // LP&R 2018


* BENEFIT (monthly)
/* 100% of earning (paid by the employer) */
replace pt_ben1 = earning if country == "NL" & year == 2017 & pt_eli == 1
replace pt_ben2 = earning if country == "NL" & year == 2017 & pt_eli == 1


foreach x in 1 2 {
	replace pt_ben`x' = 0 	if pt_eli == 0 & country == "NL" & year == 2017
}

replace pt_dur = 0 if pt_eli == 0 & country == "NL" & year == 2017
