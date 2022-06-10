/* PL_2011_RO_eusilc_cs */

* ROMANIA - 2011

* ELIGIBILITY
/*	-> all residents: 12 months taxable personal income (coded) within the last 2 years (not coded)
			-> or 12 months of unemployment benefits, invalidity pension, temporary working incapacity benefit, etc. - 
					such data is provided at HH level in EU-SILC => not coded
*/

replace pl_eli = 1 			if country == "RO" & year == 2011 & duremp + dursemp >= 12

replace pl_eli =  0			if pl_eli == . & country == "RO" & year == 2011


* DURATION (weeks)
/*	-> benefit is a family entitlement => in couples, all is assigned to the woman
	-> until child is 2 years old 	*/

* women	
replace pl_dur =  (2*52) - ml_dur2		if country == "RO" & year == 2011 & pl_eli == 1 ///
										& gender == 1 

* single men
replace pl_dur = 2*52 - pt_dur - ml_dur2 		if country == "RO" & year == 2011 & pl_eli == 1 ///
												& gender == 2 & parstat == 1


* BENEFIT (monthly)
/*	-> 75% earning (net, but coded gross)
	-> ceiling until child is 1 year old: €802/month (6.8*RSI (RSI = €118.33), MISSOC 2011)
	-> ceiling until child is 2 years old: €283/month (2.4*RSI)
		-> the age of the child is ignored, ceiling coded as for the first year
	-> minimum: €142/month (1.2*RSI)
*/
	
	* women
replace pl_ben1 = 0.75*earning 		if country == "RO" & year == 2011 & pl_eli == 1 ///
									& gender == 1

replace pl_ben1 = 142		 		if country == "RO" & year == 2011 & pl_eli == 1 ///
									& pl_ben1 < 142 & gender == 1
replace pl_ben1 = 802				if country == "RO" & year == 2011 & pl_eli == 1 ///
									& pl_ben1 >= 802 & gender == 1 


	* single men
replace pl_ben1 = 0.75*earning 		if country == "RO" & year == 2011 & pl_eli == 1 ///
									& gender == 2 & parstat == 1

replace pl_ben1 = 142		 		if country == "RO" & year == 2011 & pl_eli == 1 ///
									& pl_ben1 < 142 & gender == 2 & parstat == 1
									
replace pl_ben1 = 802				if country == "RO" & year == 2011 & pl_eli == 1 ///
									& pl_ben1 >= 802 & gender == 2 & parstat == 1
			

replace pl_ben2 = pl_ben1		if country == "RO" & year == 2011 & pl_eli == 1





foreach x in 1 2 {
    
	replace pl_ben`x' = 0 	if pl_eli == 0 & country == "RO" & year == 2014
}

replace pl_dur = 0 	if country == "RO" & year == 2014 & pl_eli == 0
