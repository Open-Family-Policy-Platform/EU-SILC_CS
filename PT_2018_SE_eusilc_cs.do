/* PT_2018_SE_eusilc_cs

date created: 01/04/2021
latest update:

*/

/*	Sweden doesn't distinguish between ML and PT but only recognizes PARENTAL LEAVE, 
	which is a combination of individual non-transferable and individual transferable
	rights for each parent. 
	The PT data code the share of PARENTAL LEAVE that is individual non-transferable
	right of the father AND paternity leave in connection with childbirth.
*/

* SWEDEN - 2018

* ELIGIBILITY
/*	-> all men are eligible for cash benefits (vary by economic status)
	-> single women: eligible for father's share
*/

replace pt_eli = 1 		if country == "SE" & year == 2018 & gender == 2 

* single women
replace pt_eli = 1		if country == "SE" & year == 2018 & gender == 1 & parstat == 1

replace pt_eli = 0 		if pt_eli == . & country == "SE" & year == 2018 & gender == 2


* DURATION (weeks)
/*	-> total: 90 calendar days 
	-> leave in connection with childbirth: 10 calendar days 	
*/

replace pt_dur = (90/7) + (10/7)		 	if country == "SE" & year == 2018 & pt_eli == 1


* BENEFIT (monthly)
/*	-> 10 days: 77.6% earning
		- ceiling: E 35,103/month - this is earning ceiling NOT benefit ceiling 
		- minimum: not specified, also not specified whether only for working parents => 
			assumed minimum as with the parental leave 
	-> 90 days: 77.6% earning
			- minimum: E 26/day
			- ceiling: E 46,803/month - this is an earning ceiling NOT benefit ceiling (LP&R 2018)
*/


replace pt_ben1 = 0.776*earning 		if country == "SE" & year == 2018 & pt_eli == 1 ///
										& (earning/30) >= 26

replace pt_ben1 = 26*30					if country == "SE" & year == 2018 & ml_eli == 1 ///
										& (earning/30) < 26

replace pt_ben1 = [(0.776*35103) * (10/(90+10))] + [(0.776*earning) * (90/(90+10))] ///
										if country == "SE" & year == 2018 & ml_eli == 1 ///
										& inrange(earning,35103,46803)

replace pt_ben2 = [(0.776*35103) * (10/(90+10))] + [(0.776*46803) * (90/(90+10))] ///
										if country == "SE" & year == 2018 & ml_eli == 1 ///
										& earning > 46803

		
		
replace pt_ben2 = 0.776*earning 		if country == "SE" & year == 2018 & pt_eli == 1 ///
										& (earning/30) >= 26

replace pt_ben2 = 26*30					if country == "SE" & year == 2018 & ml_eli == 1 ///
										& (earning/30) < 26
										
replace pt_ben2 = [((0.776*35103)/4.3) * (10/7)] + [((0.776*earning)/4.3) * ((30-10)/7)] ///
										if country == "SE" & year == 2018 & ml_eli == 1 ///
										& inrange(earning,35103,46803)
										
replace pt_ben2 = [((0.776*35103)/4.3) * (10/7)] + [((0.776*46803)/4.3) * ((30-10)/7)] ///
										if country == "SE" & year == 2018 & ml_eli == 1 ///
										& earning > 46803

 										
										




foreach x in 1 2 {
	replace pt_ben`x' = 0 	if country == "SE" & year == 2018 & pt_eli == 0
}

replace pt_dur = 0 		if country == "SE" & year == 2018 & pt_eli == 0 
