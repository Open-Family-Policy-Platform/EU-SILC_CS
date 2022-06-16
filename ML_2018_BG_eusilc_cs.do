/* ML_2018_BG_eusilc_cs */


* BULGARIA - 2018

* ELIGIBILITY
/*	-> employed (compulsorily insured): 12 months of insurance
	-> Self-employed can be insured voluntarily => not coded
	
	-> mother can transfer the leave to father after 6 months
		- can be used until child is 1 year old
		- father must be employed for at least 12 months (not coded)
		- single father is not automatically entitled since the mother's consent is required => not coded
*/

replace ml_eli = 1 		if country == "BG" & year == 2018 & gender == 1 ///
						& econ_status == 1 & duremp >= 12
					
						
replace ml_eli = 0 		if ml_eli == . & country == "BG" & year == 2018 & gender == 1


* DURATION (weeks)
/* 	-> total leave = 410 days
	-> prenatal leave = 45 days				*/
	
replace ml_dur1 = 45/5 			if country == "BG" & year == 2018 & gender == 1 & ml_eli == 1

replace ml_dur2 = (410-45)/7 	if country == "BG" & year == 2018 & gender == 1 & ml_eli == 1


* BENEFIT (monthly)
/*	-> 90% earning 
	-> minimum: statutory minimum wage => €260.76/month (source: Eurostat, EARN_MW_CUR, 2018-S2; minimum wage)
	-> ceiling: average net renumeration =>  € 2,723.55/year (Eurostat: Annual net earnings, online data code: EARN_NT_NET)
	
	-> the minimum and maximum values of benefit are sourced from LP&R 2018. 
*/ 

replace ml_ben1 = earning * 0.9 		if country == "BG" & year == 2018 ///
										& gender == 1 & ml_eli == 1 
replace ml_ben1 = 260.76 				if country == "BG" & year == 2018 ///
										& gender == 1 & ml_eli == 1 ///
										& ml_ben1 < 260.76
replace ml_ben1 = 2723.55/12				if country == "BG" & year == 2018 /// 
										& gender == 1 & ml_eli == 1 ///
										& ml_ben1 >= (2723.55/12)
				
				
replace ml_ben2 = ml_ben1 	if country == "BG" & year == 2018 & gender == 1 & ml_eli == 1


foreach x in 1 2 {
    replace ml_dur`x' = 0 	if ml_eli == 0 & country == "BG" & year == 2018
	replace ml_ben`x' = 0 	if ml_eli == 0 & country == "BG" & year == 2018
}

