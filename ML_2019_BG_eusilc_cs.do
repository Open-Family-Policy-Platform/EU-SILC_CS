/* ML_2019_BG_eusilc_cs */


* BULGARIA - 2019

* ELIGIBILITY
/*	-> employed (compulsorily insured): 12 months of insurance
	-> Self-employed can be insured voluntarily => not coded
	
	-> mother can transfer the leave to father after 6 months
		- can be used until child is 1 year old
		- father must be employed for at least 12 months (cnot coded)
		- single father is not automatically entitled since the mother's consent is required => not coded
*/

replace ml_eli = 1 		if country == "BG" & year == 2019 & gender == 1 ///
						& econ_status == 1 & duremp >= 12
						
						
replace ml_eli = 0 		if ml_eli == . & country == "BG" & year == 2019 & gender == 1


* DURATION (weeks)
/* 	-> total leave = 410 days
	-> prenatal leave = 45 days				*/
	
replace ml_dur1 = 45/5 			if country == "BG" & year == 2019 & gender == 1 & ml_eli == 1

replace ml_dur2 = (410-45)/7 	if country == "BG" & year == 2019 & gender == 1 & ml_eli == 1


* BENEFIT (monthly)
/*	-> 90% earning 
	-> minimum: statutory minimum wage => €286.33/month (source: Eurostat, EARN_MW_CUR, 2019-S2; minimum wage)
	-> ceiling: average net renumeration =>  €1,329.36/month

	-> the minimum and maximum values of benefit are sourced from LP&R 2019. 
*/ 

replace ml_ben1 = earning * 0.9 		if country == "BG" & year == 2019 ///
										& gender == 1 & ml_eli == 1 
replace ml_ben1 = 286.33 				if country == "BG" & year == 2019 ///
										& gender == 1 & ml_eli == 1 ///
										& ml_ben1 < 286.33
replace ml_ben1 = 1329.36 				if country == "BG" & year == 2019 /// 
										& gender == 1 & ml_eli == 1 ///
										& ml_ben1 > 1329.36
				
				
replace ml_ben2 = ml_ben1 	if country == "BG" & year == 2019 & gender == 1 & ml_eli == 1


foreach x in 1 2 {
    replace ml_dur`x' = 0 	if ml_eli == 0 & country == "BG" & year == 2019
	replace ml_ben`x' = 0 	if ml_eli == 0 & country == "BG" & year == 2019
}

