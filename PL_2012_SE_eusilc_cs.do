/* PL_2012_SE_eusilc_cs */

/*	Sweden doesn't distinguish between ML and PT but only recognizes PARENTAL LEAVE, 
	which is a combination of individual non-transferable and individual transferable
	rights for each parent. 
	The PL data code the individual transferable right to leave for each parent.  
*/


* SWEDEN - 2012

* ELIGIBILITY
/*	-> all parents are entitled to cash benefits (vary by economic status) */

replace pl_eli = 1 			if country == "SE" & year == 2012 
replace pl_eli =  0			if pl_eli == . & country == "SE" & year == 2012


* DURATION (weeks)
/*	-> total duration per parent: 240 calendar days
		- 60 individual non-transferable for mother => coded in ml_dur
		- 60 individual non-transferable for father => coded in pt_dur
		- 180 individual transferable for each parent => coded in pl_dur 
		
	-> single parents are entitled to the other parent's share (sole custody only)
*/

replace pl_dur = 180/7 		if country == "SE" & year == 2012 & pl_eli == 1 

	* single 
replace pl_dur = (180+180)/7	if country == "SE" & year == 2012 & parstat == 1



* BENEFIT (monthly)
/*	-> eligible for earning related benefit: min. income €26/day for 240 calendar days before childbirth

		- for 195 calendar days (includes 60 non-transferable leave): 
			- 77.6% earning => for 135 calendar days
			- minimum: €21/day
			- ceiling: €50,491 for the duration of benefits
		- for 45 days: €20/day
	-> all others: €27/day
 */
 



replace pl_ben1 = (((0.776*earning) * (135/30)) + ((20*30) *  (45/30))) / (180/30)	///	
									if country == "SE" & year == 2012 & pl_eli == 1 ///
									& earning/30 >= 20 & pl_dur != . 

* minimum
replace pl_ben1 = (((21*30) * (135/30)) + ((20*30) *  (45/30))) / (180/30) ///
									if country == "SE" & year == 2012 & pl_eli == 1 ///
									& earning/30 < 21 & earning != 0 & pl_dur != . 

* ceiling
replace pl_ben1 = (((50491/12) * (135/30)) + (((20*30) *  (45/30)))) / (180/30)	///
									if country == "SE" & year == 2012 & pl_eli == 1 ///
									& earning*12 >= 50491 & pl_dur != . 

* all others									
replace pl_ben1 = 21*30				if country == "SE" & year == 2012 & pl_eli == 1 ///
									& earning == 0 & pl_dur != . 
									

								
replace pl_ben2 = 0.776*earning		if country == "SE" & year == 2012 & pl_eli == 1 ///
									& earning/30 >= 26 & pl_dur != .
									
replace pl_ben2 = 50491/12			if country == "SE" & year == 2012 & pl_eli == 1 ///
									& earning*12 >= 50491 & pl_dur != .
									
replace pl_ben2 = 21*30				if country == "SE" & year == 2012 & pl_eli == 1 ///
									& earning == 0 & pl_dur != . 
									



foreach x in 1 2 {
	replace pl_ben`x' = 0 	if country == "SE" & year == 2012 & pl_eli == 0
}

replace pl_dur = 0 	if country == "SE" & year == 2012 & pl_eli == 0
