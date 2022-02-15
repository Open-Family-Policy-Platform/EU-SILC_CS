/* PL_2014_FR_eusilc_cs */


* FRANCE - 2014

* ELIGIBILITY
/*	-> employed (parental leave)
	-> benefits are available to all parents 	*/
	
replace pl_eli = 1 			if country == "FR" & year == 2014 
replace pl_eli = 0 			if pl_eli == . & country == "FR" & year == 2014


* DURATION (weeks)
/*	-> each parent is entitled to  30 months of benefit payment
	-> the total leave per child cannot exceed their 3rd birthday => larger share of leave assigned to woman 
	-> first child: 6 months of benefits/parent 
	-> 2+ children: 30 months/parent, max. total period 36 months
		=> mother assigned 24 months, father 12 months 
*/

* men and women with one hypothetical child										
replace pl_dur = 6 						if country == "FR" & year == 2014 ///
										& childc == 0 & pl_dur == .


* women with at least one child, eligible for ML	
replace pl_dur = (30/4.3) - ml_dur2 		if country == "FR" & year == 2014 ///
										& pl_eli == 1 & gender == 1 & ml_eli == 1 ///
										& childc >= 1

* women with at least one child, not eligible for ML										
replace pl_dur = 30/4.3 			if country == "FR" & year == 2014 & gender == 1 ///
								& pl_eli == 1 & pl_dur == . & childc >= 1
										
* men, cohabiting, at least one child
replace pl_dur = 36-30	 					if country == "FR" & year == 2014 ///
										& pl_eli == 1 & gender == 2 & childc >= 1 ///
										& parstat == 2 & pl_dur == .
										
* single men, at least one child
replace pl_dur = 30/4.3	 				if country == "FR" & year == 2014 ///
										& pl_eli == 1 & gender == 2 & childc >= 1 ///
										& parstat == 1 & pl_dur == .


								

* BENEFIT (monthly)
/*	-> €572.81/month for full-time leave
	
*/

replace pl_ben1 = 572.81 		if country == "FR" & year == 2014 & pl_eli == 1
replace pl_ben2 = pl_ben1 		if country == "FR" & year == 2014 & pl_eli == 1


foreach x in 1 2 {
	replace pl_ben`x' = 0 	if pl_eli == 0 & country == "FR" & year == 2014
}

 replace pl_dur = 0 	if pl_eli == 0 & country == "FR" & year == 2014
