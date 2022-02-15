 /* PT_2015_BG_eusilc_cs */

 
* BULGARIA - 2015

* ELIGIBILITY
/*	-> Employed: at least 12 months of insurance.
	-> self-employed: voluntarily insured => not coded! 
*/
   
replace pt_eli = 1 if country == "BG" & year == 2015 & gender == 2 ///
				& econ_status == 1 & duremp == 12
replace pt_eli = 0 if pt_eli == . & country == "BG" & year == 2015 & gender == 2



* DURATION (weeks)
/*	-> 15 days */
replace pt_dur = 15/5 if country == "BG" & year == 2015 & pt_eli == 1



* BENEFIT (monthly)
/*	-> 90% earning 
	-> minimum: statutory minimum wage (€184.07/month)
		-> source: Eurostat (2021) Minimum Wages, EARN_MW_CUR, accessed 5/1/2022
	-> ceiling: average net wage (annual net earnings €2,016.86)
		-> source: Eurostat (2021) Annual net earnings, EARN_NT_NET, accessed 5/1/2022

*/

	
replace pt_ben1 = ((earning * 0.9) * (15/21.7)) + (earning * ((21.7-15)/21.7)) ///
										if country == "BG" & year == 2015 ///
										& pt_eli == 1 & pt_ben1 == .
	

* minimum
replace pt_ben1 = 184.07 + (earning * ((21.7-15)/21.7)) 	if country == "BG" & year == 2015 ///
								& pt_eli == 1 & ((earning * 0.9) * (15/21.7)) < 235.16

* maximum 
replace pt_ben1 = (2015.86/12) + (earning * ((21.7-15)/21.7)) 	if country == "BG" & year == 2015 ///
								& pt_eli == 1 & ((earning * 0.9) * (15/21.7)) >= (2015.18/12)




replace pt_ben2 = pt_ben1 if country == "BG" & year == 2015 & pt_eli == 1								



foreach x in 1 2 {
	replace pt_ben`x' = 0 	if pt_eli == 0 & country == "BG" & year == 2015
}

replace pt_dur = 0 if pt_eli == 0 & country == "BG" & year == 2015



