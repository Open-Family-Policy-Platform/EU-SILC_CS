/* PT_2010_SE_eusilc_cs */

/*	Sweden doesn't distinguish between ML and PT but only recognizes PARENTAL LEAVE, 
	which is a combination of individual non-transferable and individual transferable
	rights for each parent. 
	The PT data code the share of PARENTAL LEAVE that is individual non-transferable
	right of the father AND paternity leave in connection with childbirth.
*/

* SWEDEN - 2010

* ELIGIBILITY
/*	-> all men are eligible for cash benefits (vary by economic status)
	-> single women: eligible for father's share
*/

replace pt_eli = 1 		if country == "SE" & year == 2010 & gender == 2 

* single women
replace pt_eli = 1		if country == "SE" & year == 2010 & gender == 1 & parstat == 1

replace pt_eli = 0 		if pt_eli == . & country == "SE" & year == 2010 & gender == 2


* DURATION (weeks)
/*	-> total: 60 calendar days 
	-> leave in connection with childbirth: 10 calendar days 	
*/

replace pt_dur = (60/7) + (10/7)		 	if country == "SE" & year == 2010 & pt_eli == 1


* BENEFIT (monthly)
/*	-> 10 days: 80% earning
		- ceiling: €33,119/year - this is earning ceiling NOT benefit ceiling 
		- minimum: not specified, also not specified whether only for working parents => 
			assumed identical with the 60 days 
	-> 90 days: 80% earning
			- minimum: €19/day
			- ceiling: €44,158/year - this is an earning ceiling NOT benefit ceiling (LP&R 2010)
*/


replace pt_ben1 = 0.80 * earning 			if country == "SE" & year == 2010 & pt_eli == 1 ///
										& (earning/21.7) >= 18

replace pt_ben1 = 19 * 21.7				if country == "SE" & year == 2010 & pt_eli == 1 ///
										& (earning/21.7) < 19

replace pt_ben1 = ((0.80 * (33119/12)) * (10/(90+10))) + ((0.80 * earning) * (90/(90+10))) ///
										if country == "SE" & year == 2010 & pt_eli == 1 ///
										& inrange((earning*12),33119,44158)

replace pt_ben1 = ((0.80 * (33119/12)) * (10/(90+10)))	+ ((0.80 * (44158/12)) * (90/(90+10))) ///
											if country == "SE" & year == 2010 & pt_eli == 1 ///
											& earning > 44158/12

	
	
	
replace pt_ben2 = 0.80*earning 			if country == "SE" & year == 2010 & pt_eli == 1 ///
										& (earning/21.7) >= 18

replace pt_ben2 = 19*21.7				if country == "SE" & year == 2010 & pt_eli == 1 ///
										& (earning/21.7) < 19
										
replace pt_ben2 = ((0.80 * (33119/12)) * (10/21.7)) + ((0.80 * earning) * ((21.7-10)/21.7)) ///
										if country == "SE" & year == 2010 & pt_eli == 1 ///
										& inrange((earning*12),33119,44158)
										
replace pt_ben2 = ((0.80 * (33119/12)) * (10/21.7)) + ((0.80 * (44158/12)) * ((21.7-10)/21.7)) ///
										if country == "SE" & year == 2010 & pt_eli == 1 ///
										& earning > 44158/12
								
										




foreach x in 1 2 {
	replace pt_ben`x' = 0 	if country == "SE" & year == 2010 & pt_eli == 0
}

replace pt_dur = 0 		if country == "SE" & year == 2010 & pt_eli == 0 
