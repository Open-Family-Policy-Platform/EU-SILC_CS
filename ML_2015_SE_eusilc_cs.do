/* ML_2015_SE_eusilc_cs */

/*	Sweden doesn't distinguish between ML and PT but only recognizes PARENTAL LEAVE, 
	which is a combination of individual non-transferable and individual transferable
	rights for each parent. 
	The ML data code refers to the share of PARENTAL LEAVE that is individual non-transferable
	right of the mother. 
*/

* SWEDEN - 2015

* ELIGIBILITY
/*	-> all women are eligible for cash benefits (vary by economic status)
	-> single fathers are entitled to mother's share of leave (LP&R 2015)
*/
replace ml_eli = 1 			if country == "SE" & year == 2015 & gender == 1

* single men
replace ml_eli = 1 			if country == "SE" & year == 2015 & gender == 2 ///
							& parstat == 1

replace ml_eli = 0 			if ml_eli == . & country == "SE" & year == 2015 & gender == 1


* DURATION (weeks)
/*	-> total: 60 calendar days 
	-> prenatal: non-compulsory 2 weeks 	
	-> single fathers: entitled to the whole share 	
*/

replace ml_dur1 = 0 		if country == "SE" & year == 2015 & ml_eli == 1

replace ml_dur2 = 60/7 		if country == "SE" & year == 2015 & ml_eli == 1


* BENEFIT (monthly)
/*	-> eligible for earning related benefit: min. income €24/day (coded) for 240 calendar days (not coded) before childbirth
		- for 195 calendar days (includes 90 non-transferable leave): 77.6% earning
			- minimum: €24/day
			- ceiling: €48,136/year - this is an earning ceiling NOT benefit ceiling (LP&R 2015)
		- for 45 days: €19/day (only applicable for pl_ben)
	-> all others: €24/day
 */

 
replace ml_ben1 = 0.776*earning 		if country == "SE" & year == 2015 & ml_eli == 1 ///
										& (earning/30) >= 23 /*  Shouldn't it be 24 here? if someone makes 23,80/day for instance, they should get the minimum of 24 instead right?  */
replace ml_ben1 = 24*30					if country == "SE" & year == 2015 & ml_eli == 1 ///
										& ml_ben1 < 24*30
replace ml_ben1 = 48136/12			if country == "SE" & year == 2015 & ml_eli == 1 ///
										& earning >= (48136/12)

									
replace ml_ben2 = ml_ben1 			if country == "SE" & year == 2015 & ml_eli == 1


foreach x in 1 2 {
	replace ml_dur`x' = 0 	if country == "SE" & year == 2015 & ml_eli == 0
	replace ml_ben`x' = 0 	if country == "SE" & year == 2015 & ml_eli == 0
	
}

