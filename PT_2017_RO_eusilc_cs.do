/* PT_2017_RO_eusilc_cs

date created: 28/09/2021

*/

* ROMANIA - 2017

* ELIGIBILITY
/*	-> employed
	-> self-employed 
	
	-> cannot be shared or transferred 
*/

replace pt_eli = 1 		if country == "RO" & year == 2017 & gender == 2 ///
						& inlist(econ_status,1,2)
replace pt_eli = 0 		if pt_eli == . & country == "RO" & year == 2017 & gender == 2



* DURATION (weeks)
/*	-> 5 working days
	-> can be extended of 5 days if father attends a course in childcare (not coded)	*/
	
replace pt_dur = 5/5 	if country == "RO" & year == 2017 & pt_eli == 1


* BENEFIT (monthly)
/*	-> 100% earning */

replace pt_ben1 = earning 	if country == "RO" & year == 2017 & pt_eli == 1

replace pt_ben2 = pt_ben1 	if country == "RO" & year == 2017 & pt_eli == 1


foreach x in 1 2 {
	replace pt_ben`x' = 0 	if pt_eli == 0 & country == "RO" & year == 2017
}

replace pt_dur = 0 if pt_eli == 0 & country == "RO" & year == 2017
