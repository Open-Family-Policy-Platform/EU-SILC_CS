/* PL_2018_RO_eusilc_cs */

* ROMANIA - 2018

* ELIGIBILITY
/*	-> all residents: 12 months taxable personal income (coded) within the last 2 years (not coded)
			-> or 12 months of unemployment benefits, invalidity pension, temporary working incapacity benefit, etc. - 
					such data is provided at HH level in EU-SILC => not coded
*/

replace pl_eli = 1 			if country == "RO" & year == 2018 & duremp + dursemp >= 12

replace pl_eli =  0			if pl_eli == . & country == "RO" & year == 2018


* DURATION (weeks)
/*	-> benefit is a family entitlement => in couples, all is assigned to the woman
	-> until child is 2 years old 	*/

* women	
replace pl_dur =  (2*52) - ml_dur2		if country == "RO" & year == 2018 & pl_eli == 1 ///
										& gender == 1 

* single men
replace pl_dur = 2*52 - pt_dur - ml_dur2 		if country == "RO" & year == 2018 & pl_eli == 1 ///
												& gender == 2 & parstat == 1


* BENEFIT (monthly)
/*	-> 85% earning (net, but coded gross)
	-> minimum: 0.85 * minimum gross wage (€317)
	-> no ceiling	*/
	
	* women
replace pl_ben1 = 0.85*earning 		if country == "RO" & year == 2018 & pl_eli == 1 ///
									& gender == 1
	
replace pl_ben1 = 0.85*317	 			if country == "RO" & year == 2018 & pl_eli == 1 ///
									& pl_ben1 < 0.85*317 & gender == 1
									
	* single men
replace pl_ben1 = 0.85*earning 		if country == "RO" & year == 2018 & pl_eli == 1 ///
									& gender == 2 & parstat == 1

replace pl_ben1 = 0.85*317	 			if country == "RO" & year == 2018 & pl_eli == 1 ///
									& pl_ben1 < 0.85*317 & gender == 2 & parstat == 1							
			

replace pl_ben2 = pl_ben1		if country == "RO" & year == 2018 & pl_eli == 1





foreach x in 1 2 {
    
	replace pl_ben`x' = 0 	if pl_eli == 0 & country == "RO" & year == 2018
}

replace pl_dur = 0 	if country == "RO" & year == 2018 & pl_eli == 0
