 /* PT_2017_BG_eusilc_cs

date created: 27/09/2021

*/

* BULGARIA - 2017

* ELIGIBILITY
/*	-> Employed: at least 12 months of insurance.
	-> self-employed: voluntarily insured => not coded! 
	
	-> 	from the 6th month of the child's age, the mother can transfer her maternity
		leave to the father (until the child is 1); mother's permission is required => not coded
*/
   
replace pt_eli = 1 if country == "BG" & year == 2017 & gender == 2 ///
				& econ_status == 1 & duremp >= 12
replace pt_eli = 0 if pt_eli == . & country == "BG" & year == 2017 & gender == 2



* DURATION (weeks)
/*	-> 15 days */
replace pt_dur = 15/5 if country == "BG" & year == 2017 & pt_eli == 1



* BENEFIT (monthly)
/*	-> 90% earning 
	-> minimum: statutory minimum wage; € 235.20(source: Eurostat, Minimum wages, code: EARN_MW_CUR) 
	-> ceiling: average net income; annual net earnings = €2,566.37 (source: Eurostat, Annual net earnings, code: EARN_NT_NET)
*/

	
replace pt_ben1 = (((0.9*earning)/4.3) * pt_dur) + ((earning/4.3)*(4.3-pt_dur)) ///
										if country == "BG" & year == 2017 ///
										& pt_eli == 1 & pt_ben1 == .
	
 
* minimum
replace pt_ben1 = (235.20 * (15/21.7)) + ((earning/4.3)*(4.3-pt_dur)) 	if country == "BG" & year == 2017 ///
															& pt_eli == 1 & (0.9*earning)/4.3) < 235.20/pt_dur
 
* maximum 
replace pt_ben1 = ((2566.37/12) * (15/21.7)) + ((earning/4.3)*(4.3-pt_dur)) 	if country == "BG" & year == 2017 ///
															& pt_eli == 1 & (0.9*earning) >= (2566.37/12)
										



replace pt_ben2 = pt_ben1 if country == "BG" & year == 2017 & pt_eli == 1



foreach x in 1 2 {
	replace pt_ben`x' = 0 	if pt_eli == 0 & country == "BG" & year == 2017
}

replace pt_dur = 0 if pt_eli == 0 & country == "BG" & year == 2017



