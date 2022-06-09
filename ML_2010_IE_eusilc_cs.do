/* ML_2010_IE_eusilc_cs */


* IRELAND - 2010

* ELIGIBILITY
/*	-> employed: at least 39 weeks (9 months) compulsory social insurance contributions in past 12 months
	-> self-employed: at least 52 weeks compulsory social insurance contribution in past 12 months
	-> transferable to the father only in case of mother's death => assumed this does not apply to abandoned 
		children by their mother
*/
	
replace ml_eli = 1 			if country == "IE" & year == 2010 & gender == 1 ///
							& econ_status == 1 & duremp >= 9
							
replace ml_eli = 1 			if country == "IE" & year == 2010 & gender == 1 ///
							& econ_status == 2 & dursemp >= 12
							
replace ml_eli = 0 			if ml_eli == . & country == "IE" & year == 2010 & gender == 1


* DURATION (weeks)
/*	-> 26 weeks paid leave
	-> 16 weeks unpaid leave
	-> prenatal leave: 2 weeks
*/
	
replace ml_dur1 = 2 		if country == "IE" & year == 2010 & ml_eli == 1

replace ml_dur2 = 26+16-2 		if country == "IE" & year == 2010 & ml_eli == 1


* BENEFIT (monthly)
/*	-> 26 weeks: 80% of average weekly earnings.
	-> minimum: €225.80/week
	-> ceiling: €270/week
	-> 16 weeks: unpaid 	*/
	
replace ml_ben1 = ((earning * 0.8) * (26/(26+16))) 	if country == "IE" & year == 2010 & ml_eli == 1

* minimum
replace ml_ben1 = ((225.80 * 4.3) * (26/(26+16)))  	if country == "IE" & year == 2010 & ml_eli == 1 & ((earning * 0.8)/4.3) < 225.80

* maximum
replace ml_ben1 = ((270 * 4.3) * (26/(26+16)))  	if country == "IE" & year == 2010 & ml_eli == 1 & ((earning * 0.8)/4.3) >= 270


replace ml_ben2 = (earning * 0.8) 	if country == "IE" & year == 2010 & ml_eli == 1
replace ml_ben2 = (225.80 * 4.3)		if country == "IE" & year == 2010 & ml_eli == 1 & ((earning * 0.8)/4.3) < 225.80
replace ml_ben2 = (270 * 4.3)		if country == "IE" & year == 2010 & ml_eli == 1 & ((earning * 0.8)/4.3) >= 270


foreach x in 1 2 {
    replace ml_dur`x' = 0 	if ml_eli == 0 & country == "IE" & year == 2010
	replace ml_ben`x' = 0 	if ml_eli == 0 & country == "IE" & year == 2010
}

