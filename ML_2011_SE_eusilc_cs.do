/* ML_2011_SE_eusilc_cs */

/*	Sweden doesn't distinguish between ML and PT but only recognizes PARENTAL LEAVE, 
	which is a combination of individual non-transferable and individual transferable
	rights for each parent. 
	The ML data code refers to the share of PARENTAL LEAVE that is individual non-transferable
	right of the mother. 
*/

* SWEDEN - 2011

* ELIGIBILITY
/*	-> all women are eligible for cash benefits (vary by economic status)
	-> single fathers are entitled to mother's share of leave (LP&R 2011)
*/
replace ml_eli = 1 			if country == "SE" & year == 2011 & gender == 1

* single men
replace ml_eli = 1 			if country == "SE" & year == 2011 & gender == 2 ///
							& parstat == 1

replace ml_eli = 0 			if ml_eli == . & country == "SE" & year == 2011 & gender == 1


* DURATION (weeks)
/*	-> total: 60 calendar days 
	-> prenatal: non-compulsory 2 weeks 	
	-> single fathers: entitled to the whole share 	
*/

replace ml_dur1 = 0 		if country == "SE" & year == 2011 & ml_eli == 1

replace ml_dur2 = 60/7 		if country == "SE" & year == 2011 & ml_eli == 1


* BENEFIT (monthly)
/*	-> eligible for earning related benefit: min. income €20/day (coded) for 240 calendar days (not coded) before childbirth
		- for 195 calendar days (includes 60 non-transferable leave): 80% earning
			- minimum: €20/day
			- ceiling: €47,340/year 
		- for 45 days: €20/day (only applicable for pl_ben)
		
	-> all others: €20/day
 */

 
replace ml_ben1 = 0.80*earning 		if country == "SE" & year == 2011 & ml_eli == 1 ///
										& (earning/30) >= 20
replace ml_ben1 = 20*30					if country == "SE" & year == 2011 & ml_eli == 1 ///
										& ml_ben1 == . 

		
replace ml_ben1 = 47340/12			if country == "SE" & year == 2011 & ml_eli == 1 ///
										& earning >= 47340/12

									
replace ml_ben2 = ml_ben1 			if country == "SE" & year == 2011 & ml_eli == 1


foreach x in 1 2 {
	replace ml_dur`x' = 0 	if country == "SE" & year == 2011 & ml_eli == 0
	replace ml_ben`x' = 0 	if country == "SE" & year == 2011 & ml_eli == 0
	
}

