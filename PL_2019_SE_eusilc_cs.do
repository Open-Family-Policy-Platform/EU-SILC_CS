/* PL_2019_SE_eusilc_cs

date created: 21/08/2021

*/

/*	Sweden doesn't distinguish between ML and PT but only recognizes PARENTAL LEAVE, 
	which is a combination of individual non-transferable and individual transferable
	rights for each parent. 
	The PL data code the individual transferable right to leave for each parent.  
*/


* SWEDEN - 2019

* ELIGIBILITY
/*	-> all parents are entitled to cash benefits (vary by economic status) */

replace pl_eli = 1 			if country == "SE" & year == 2019 
replace pl_eli =  0			if pl_eli == . & country == "SE" & year == 2019


* DURATION (weeks)
/*	-> total duration per parent: 240 calendar days
		- 90 individual non-transferable for mother => coded in ml_dur
		- 90 individual non-transferable for father => coded in pt_dur
		- 150 individual transferable for each parent => coded in pl_dur 
*/

replace pl_dur = 150/7 		if country == "SE" & year == 2019 & pl_eli == 1


* BENEFIT (monthly)
/*	-> eligible for earning related benefit: min. income €6/day (coded) for 240 calendar days before childbirth (not coded; LP&R 2019, €26 from MISSOC 2019)

		- for 195 calendar days (includes 90 non-transferable leave = > 105 days transferable): 
			- 77.6% earning => for 105 calendar days
			- minimum: €26/day
			- ceiling: €47,832 for the duration of benefits
		- for 45 days: €19/day
	-> all others: €26/day
 */
 



replace pl_ben1 = (((0.776*earning) * (105/30)) + ((19*30) *  45/30)) / (150/30)	///	
									if country == "SE" & year == 2019 & pl_eli == 1 ///
									& earning/30 >= 26

* minimum									
replace pl_ben1 = 26*30				if country == "SE" & year == 2019 & pl_eli == 1 ///
									& earning/30 < 26

* ceiling
replace pl_ben1 = ((47832 * (105/30)) + ((19*30) *  45/30)) / (150/30)	///
									if country == "SE" & year == 2019 & pl_eli == 1 ///
									& earning >= 47832
						
									

								
									



replace pl_ben2 = 0.776*earning		if country == "SE" & year == 2019 & pl_eli == 1 ///
									& (earning/21.7) >= 26
									
replace pl_ben2 = 26*30				if country == "SE" & year == 2019 & pl_eli == 1 ///
									& earning/30 < 26
									
replace ml_ben1 = 0.776*47832		if country == "SE" & year == 2019 & pl_eli == 1 ///
									& earning >= 47832


foreach x in 1 2 {
	replace pl_ben`x' = 0 	if country == "SE" & year == 2019 & pl_eli == 0
}

replace pl_dur = 0 	if country == "SE" & year == 2019 & pl_eli == 0
