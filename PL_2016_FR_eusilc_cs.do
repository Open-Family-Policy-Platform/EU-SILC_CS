/* PL_2016_FR_eusilc_cs */


* FRANCE - 2016

* ELIGIBILITY
/*	-> 1 January 2015 - COLCA replaced by PreParE (LP&R 2015); the eligibility conditions remained the same
	-> employed if they worked ...
		-> 1st child: 2 years (coded) prior the childbirth
		-> 2nd child: 2 years (coded) in the 4 years prior the childbirth (not coded)
		-> 3rd+ child: 2 years (coded) in the 5 years prior the childbirth (not coded)
		
		-> 2 types of benefits:
			-> PreParE - shared provision of child education
			-> COLCA: families with at least 3 chidlren can opt for COLCA - higher benefit for 12 months (not coded)	

			-> NOTE: 	the EU-SILC cross-sectional file doesn't contain data on duration of employment for more 					
						than 12 months in the income reference period => the 24 months condition cannot be fulfilled. 
						The code is written for employment of at least 12 months. 
*/
	
replace pl_eli = 1 			if country == "FR" & year == 2016 & duremp >= 12 
replace pl_eli = 0 			if pl_eli == . & country == "FR" & year == 2016


* DURATION (weeks)
/*	-> 1st child: 6 months of benefits/parent (coded) 
	-> 2nd+ child: 24 months/parent until the child is 3 years old (LP&R 2015)
		=> mother assigned 24 months, father 12 months 
*/

* men and women with one hypothetical child										
replace pl_dur = 6*4.3 						if country == "FR" & year == 2016 ///
										& childc == 0 & pl_dur == .


* women with at least one child, eligible for ML	
replace pl_dur = (2*52) - ml_dur2 		if country == "FR" & year == 2016 ///
										& pl_eli == 1 & gender == 1 & ml_eli == 1 ///
										& childc >= 1

* women with at least one child, not eligible for ML										
replace pl_dur = 2*52 			if country == "FR" & year == 2016 & gender == 1 ///
								& pl_eli == 1 & pl_dur == . & childc >= 1
										
* men, cohabiting, at least one child
replace pl_dur = 52	 					if country == "FR" & year == 2016 ///
										& pl_eli == 1 & gender == 2 & childc >= 1 ///
										& parstat == 2 & pl_dur == .
										
* single men, at least one child
replace pl_dur = 2*52	 				if country == "FR" & year == 2016 ///
										& pl_eli == 1 & gender == 2 & childc >= 1 ///
										& parstat == 1 & pl_dur == .


								

* BENEFIT (monthly)
/*	-> PreParE: €390.92/month for full-time leave
	-> COLCA: €638.96/month (not coded)
	
	
*/

replace pl_ben1 = 390.92		if country == "FR" & year == 2016 & pl_eli == 1
replace pl_ben2 = pl_ben1 		if country == "FR" & year == 2016 & pl_eli == 1


foreach x in 1 2 {
	replace pl_ben`x' = 0 	if pl_eli == 0 & country == "FR" & year == 2016
}

 replace pl_dur = 0 	if pl_eli == 0 & country == "FR" & year == 2016
