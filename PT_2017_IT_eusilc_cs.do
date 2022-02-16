/* PT_2017_IT_eusilc_cs

date created: 27/09/2021

*/

* ITALY - 2017

* ELIGIBILITY
/*	-> employed (LP&R 2018; MISSOC 2018 understands paternity leave to also 
		be the maternity leave entitlements that cannot be used by mother) 		*/
		
replace pt_eli = 1 		if country == "IT" & year == 2017 & gender == 2 ///
						& econ_status == 1
replace pt_eli = 0 		if pt_eli == . & country == "IT" & year == 2017 & gender == 2


* DURATION (weeks)
/*	-> 2 days (compulsory)
	-> additional 2 days can be transferred by the mother (not coded)
*/

replace pt_dur = 2/5 	if country == "IT" & year == 2017 & pt_eli == 1


* BENEFIT (monthly)
/*	-> 100% earning */
replace pt_ben1 = earning 	if country == "IT" & year == 2017 & pt_eli == 1
replace pt_ben2 = earning 	if country == "IT" & year == 2017 & pt_eli == 1


foreach x in 1 2 {
	replace pt_ben`x' = 0 	if pt_eli == 0 & country == "IT" & year == 2017
}

replace pt_dur = 0 if pt_eli == 0 & country == "IT" & year == 2017
