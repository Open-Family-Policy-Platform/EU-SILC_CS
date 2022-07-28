/* PL_2014_FR_eusilc_cs */


* FRANCE - 2014

* ELIGIBILITY
/*	-> employed if they worked ...
		-> 1st child: 2 years (coded) prior the childbirth
		-> 2nd child: 2 years (coded) in the 4 years prior the childbirth (not coded)
		-> 3rd+ child: 2 years (coded) in the 5 years prior the childbirth (not coded)
		
		-> 2 types of benefits:
			-> childrearing benefit (CLCA) 
			-> COLCA: families with at least 3 chidlren can opt for COLCA - higher benefit for 12 months (not coded)
		
		-> benefit is a family entitlement	

		-> NOTE: 	the EU-SILC cross-sectional file doesn't contain data on duration of employment for more 
					than 12 months in the income reference period => the 24 months condition cannot be fulfilled.
					The code is written for employment of at least 12 months. 
*/
	
replace pl_eli = 1 			if country == "FR" & year == 2014 & duremp >= 12 
replace pl_eli = 0 			if pl_eli == . & country == "FR" & year == 2014


* DURATION (weeks)
/*	
	-> first child: 6 months of benefits
	-> 2+ children: until child is 3 years old
	-> assigned to mother
*/

* men and women with one hypothetical child										
replace pl_dur = 6*4.3 						if country == "FR" & year == 2014 ///
										& childc == 0 & pl_dur == . & gender == 1


* women with at least one child, eligible for ML	
replace pl_dur = (3*52) - ml_dur2 		if country == "FR" & year == 2014 ///
										& pl_eli == 1 & gender == 1 & ml_eli == 1 ///
										& childc >= 1

* women with at least one child, not eligible for ML										
replace pl_dur = 3*52 			if country == "FR" & year == 2014 & gender == 1 ///
								& pl_eli == 1 & pl_dur == . & childc >= 1
										
										
* single men, at least one child
replace pl_dur = 3*52	 				if country == "FR" & year == 2014 ///
										& pl_eli == 1 & gender == 2 & childc >= 1 ///
										& parstat == 1 & pl_dur == .


				

* BENEFIT (monthly)
/*	-> CLCA: €390.52/month 
		-> reduced flat-rate benefits depending on the amount of working hours while using the benefit
	-> COLCA: €638.34/month (not coded)
	
*/

replace pl_ben1 = 390.52 		if country == "FR" & year == 2014 & pl_eli == 1
replace pl_ben2 = pl_ben1 		if country == "FR" & year == 2014 & pl_eli == 1


foreach x in 1 2 {
	replace pl_ben`x' = 0 	if pl_eli == 0 & country == "FR" & year == 2014
}

 replace pl_dur = 0 	if pl_eli == 0 & country == "FR" & year == 2014
