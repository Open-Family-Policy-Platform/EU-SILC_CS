/* PT_2017_GB_eusilc_cs

date created: 29/09/2021

*/

* UK - 2017

* ELIGIBILITY
/*	-> employed if:
		- employed by the same employer (not coded)
		- for 26 weeks 
		- average weekly earning at least €137
*/	

replace pt_eli = 1 		if country == "GB" & year == 2017 & gender == 2 ///
						& econ_status == 1 & duremp >= 26/4.3 & earning/4.3 >= 137
						
replace pt_eli = 0 		if pt_eli == . & country == "GB" & year == 2017 & gender == 2


* DURATION (weeks)
/*	-> father can choose between 1 or 2 weeks (coded) */

replace pt_dur = 2 	if country == "GB" & year == 2017 & pt_eli == 1


* BENEFIT (monthly)
/*	-> 90% earning 
	-> ceiling: €171/week			*/

gen ceiling = 0.9*earning


replace pt_ben1 = (((0.9*earning)/4.3) * pt_dur) + ((earning/4.3)*(4.3-pt_dur)) ///
								if country == "GB" & year == 2017 & pt_eli == 1
								
* above ceiling
replace pt_ben1 = (171 * pt_dur) + ((earning/4.3)*(4.3-pt_dur)) ///
								if country == "GB" & year == 2017 & pt_eli == 1 ///
								& ((0.9*earning)/4.3) > 171

	

replace pt_ben2 = pt_ben1 	if country == "GB" & year == 2017 & pt_eli == 1



foreach x in 1 2 {
	replace pt_ben`x' = 0 	if country == "GB" & year == 2017 & pt_eli == 0
}

replace pt_dur = 0 		if country == "GB" & year == 2017 & pt_eli == 0 

foreach x in 1 2 {
	replace pt_ben`x' = 0 	if pt_eli == 0 & country == "GB" & year == 2017
}

replace pt_dur = 0 if pt_eli == 0 & country == "GB" & year == 2017

drop ceiling
