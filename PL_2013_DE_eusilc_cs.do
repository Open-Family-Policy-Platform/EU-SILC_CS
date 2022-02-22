/* PL_2013_DE_eusilc_cs */


* GERMANY - 2013

* ELIGIBILITY
/*	-> all parents are eligible for benefits */

replace pl_eli = 1 			if country == "DE" & year == 2013 
replace pl_eli = 0 			if pl_eli == . & country == "DE" & year == 2013

* DURATION (weeks)
/*	-> benefits are family entitlement (in couples assigned to women)
	-> if parents interrupt their work: 12 months/parent 
	-> the maximum duration of leave is 12 months in total for both parents 
	-> bonus months if both parents take some leave: 2 months (coded as father's right')
	*/
replace pl_dur = 12 		if country == "DE" & year == 2013 & pl_eli == 1 ///
							& gender == 1 
replace pl_dur = 2 			if country == "DE" & year == 2013 & pl_eli == 1 ///
							& gender == 2 & pl_dur == .

* single men
replace pl_dur = 12			if country == "DE" & year == 2013 & pl_eli == 1 ///
							& gender == 2 & parstat == 1 & pl_dur == . 


* BENEFIT (monthly)
/*	-> employed, self-employed: 65%
	-> minimum: €300/month 
	-> maximum: €1,800/month
	-> non-working: €300/month
	-> source: LP&R 2013
	*/

replace pl_ben1 = 0.65 * earning	if country == "DE" & year == 2013 & pl_eli == 1 ///
									& pl_ben1 == . & inlist(econ_status,1,2)

* minimum
replace pl_ben1 = 300		if country == "DE" & year == 2013 & pl_eli == 1 ///
							& inrange(econ_status,1,2) & pl_ben1 < 300 

* ceiling
replace pl_ben1 = 1800		if country == "DE" & year == 2013 & pl_eli == 1 ///
							& inrange(econ_status,1,2) & pl_ben1 >= 1800 
							
* inactive, unemployed	
replace pl_ben1 = 300 		if country == "DE" & year == 2013 & pl_eli == 1 ///
							& inlist(econ_status,3,4) 
							
							





replace pl_ben2 = pl_ben1 		if country == "DE" & year == 2013 & pl_eli == 1


foreach x in 1 2 {
	replace pl_ben`x' = 0 	if pl_eli == 0 & country == "DE" & year == 2013
}

replace pl_dur = 0 	if pl_eli == 0 & country == "DE" & year == 2013
