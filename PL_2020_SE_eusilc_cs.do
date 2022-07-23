/* PL_2020_SE_eusilc_cs */

/*	Sweden doesn't distinguish between ML and PT but only recognizes PARENTAL LEAVE, 
	which is a combination of individual non-transferable and individual transferable
	rights for each parent. 
	The PL data code the individual transferable right to leave for each parent.  
*/


* SWEDEN - 2020

* ELIGIBILITY
/*	-> all parents are entitled to cash benefits (vary by economic status) */

replace pl_eli = 1 			if country == "SE" & year == 2020 
replace pl_eli =  0			if pl_eli == . & country == "SE" & year == 2020


* DURATION (weeks)
/*	-> total duration per parent: 240 calendar days
		- 90 individual non-transferable for mother => coded in ml_dur
		- 90 individual non-transferable for father => coded in pt_dur
		- 150 individual transferable for each parent => coded in pl_dur 
		
	-> single parents are entitled to the other parent's share (sole custody only)
*/

replace pl_dur = 150/7 		if country == "SE" & year == 2020 & pl_eli == 1  

	* single 
replace pl_dur = (150+150)/7	if country == "SE" & year == 2020 & parstat == 1



* BENEFIT (monthly)
/*	-> eligible for earning related benefit: min. income €23.48/day (coded) for 240 calendar days before childbirth (not coded; LP&R 2020, €23.48 from MISSOC 2020)

		- for 16.915 calendar days (includes 90 non-transferable leave = > 105 days transferable): 
			- 77.6% earning => for 105 calendar days
			- minimum: €23.48/day
			- ceiling: €45,142/year (it is assumed the value refers to annual earnings)
		- for 45 days: €16.91/day
	-> all others: €23.48/day
 */
 



replace pl_ben1 = (((0.776*earning) * (105/30)) + ((16.91*30) *  (45/30))) / (150/30)	///	
									if country == "SE" & year == 2020 & pl_eli == 1 ///
									& earning/30 >= 23.48 & pl_dur != . 

* minimum
replace pl_ben1 = (((23.48*30) * (105/30)) + ((16.91*30) *  (45/30))) / (150/30) ///
									if country == "SE" & year == 2020 & pl_eli == 1 ///
									& earning/30 < 23.48 & earning != 0 & pl_dur != . 

* ceiling
replace pl_ben1 = (((45142/12) * (105/30)) + (((16.91*30) *  (45/30)))) / (150/30)	///
									if country == "SE" & year == 2020 & pl_eli == 1 ///
									& earning*12 >= 45142 & pl_dur != . 

* all others									
replace pl_ben1 = 23.48*30				if country == "SE" & year == 2020 & pl_eli == 1 ///
									& earning == 0 & pl_dur != . 
									

								
replace pl_ben2 = 0.776*earning		if country == "SE" & year == 2020 & pl_eli == 1 ///
									& earning/30 >= 23.48 & pl_dur != .
									
replace pl_ben2 = 45142/12			if country == "SE" & year == 2020 & pl_eli == 1 ///
									& earning*12 >= 45142 & pl_dur != .
									
replace pl_ben2 = 23.48*30				if country == "SE" & year == 2020 & pl_eli == 1 ///
									& earning == 0 & pl_dur != .
									
replace pl_ben2 = 23.48*30				if country == "SE" & year == 2020 & pl_eli == 1 ///
									& earning/30 < 23.48 & earning != 0 & pl_dur != .									
									


foreach x in 1 2 {
	replace pl_ben`x' = 0 	if country == "SE" & year == 2020 & pl_eli == 0
}

replace pl_dur = 0 	if country == "SE" & year == 2020 & pl_eli == 0
