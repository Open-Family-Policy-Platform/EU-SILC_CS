/* PL_2011_SE_eusilc_cs */

/*	Sweden doesn't distinguish between ML and PT but only recognizes PARENTAL LEAVE, 
	which is a combination of individual non-transferable and individual transferable
	rights for each parent. 
	The PL data code the individual transferable right to leave for each parent.  
*/


* SWEDEN - 2011

* ELIGIBILITY
replace pl_eli = 1 			if country == "SE" & year == 2011 
replace pl_eli =  0			if pl_eli == . & country == "SE" & year == 2011


* DURATION (weeks)
/*	-> total duration per parent: 240 calendar days
		- 60 individual non-transferable for mother => coded in ml_dur
		- 60 individual non-transferable for father => coded in pt_dur
		- 180 individual transferable for each parent => coded in pl_dur 
		
	-> single parents are entitled to the other parent's share (sole custody only)
*/

replace pl_dur = 180/7 		if country == "SE" & year == 2011 & pl_eli == 1 

	* single 
replace pl_dur = (180+180)/7	if country == "SE" & year == 2011 & parstat == 1



* BENEFIT (monthly)
/*	-> eligible for earning related benefit: min. income €26/day for 240 calendar days before childbirth

		- for 195 calendar days (includes 60 non-transferable leave = > 180 days transferable): 
			- 80% earning => for 105 calendar days
			- minimum: €20/day
			- ceiling: €47,340 for the duration of benefits
		- for 45 days: €20/day
	-> all others: €20/day
 */
 



replace pl_ben1 = (((0.80*earning) * (105/30)) + ((20*30) *  (45/30))) / (150/30)	///	
									if country == "SE" & year == 2011 & pl_eli == 1 ///
									& earning/30 >= 19 & pl_dur != . 

* minimum
replace pl_ben1 = (((20*30) * (105/30)) + ((20*30) *  (45/30))) / (150/30) ///
									if country == "SE" & year == 2011 & pl_eli == 1 ///
									& earning/30 < 20 & earning != 0 & pl_dur != . 

* ceiling
replace pl_ben1 = (((47340/12) * (105/30)) + (((20*30) *  (45/30)))) / (150/30)	///
									if country == "SE" & year == 2011 & pl_eli == 1 ///
									& earning*12 >= 47340 & pl_dur != . 

* all others									
replace pl_ben1 = 20*30				if country == "SE" & year == 2011 & pl_eli == 1 ///
									& earning == 0 & pl_dur != . 
									

								
replace pl_ben2 = 0.80*earning		if country == "SE" & year == 2011 & pl_eli == 1 ///
									& earning/30 >= 19 & pl_dur != .
									
replace pl_ben2 = 47340/12			if country == "SE" & year == 2011 & pl_eli == 1 ///
									& earning*12 >= 47340 & pl_dur != .
									
replace pl_ben2 = 20*30				if country == "SE" & year == 2011 & pl_eli == 1 ///
									& earning == 0 & pl_dur != . 
									



foreach x in 1 2 {
	replace pl_ben`x' = 0 	if country == "SE" & year == 2011 & pl_eli == 0
}

replace pl_dur = 0 	if country == "SE" & year == 2011 & pl_eli == 0
