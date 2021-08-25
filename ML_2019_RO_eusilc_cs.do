/* ML_2019_RO_eusilc_cs

date created: 12/08/2021

*/

* ROMANIA - 2019

* ELIGIBILITY
/*	-> employed, self-employed: insured for at least 1 month during the past 12 months 
	-> unemployed: if unemployed for less than 9 months 
	-> women with no income
	
	-> mother can transfer her leave after 6 weeks postnatal leave => coded for single fathers
*/
	
replace ml_eli = 1 			if country == "RO" & year == 2019 & gender == 1

* single men
replace ml_eli = 1			if country == "RO" & year == 2019 & gender == 2 ///
							& parstat == 1
											
replace ml_eli = 0 			if ml_eli == . & country == "RO" & year == 2019 & gender == 1



* DURATION (weeks)
/*	-> prenatal: non-compulsory 63 days => added to postnatal
	-> postnatal: 63 days */ 
	
replace ml_dur1 = 0 			if country == "RO" & year == 2019 & ml_eli == 1

replace ml_dur2 = (63+63)/5 	if country == "RO" & year == 2019 & ml_eli == 1 ///
								& gender == 1

replace ml_dur2 = (63+63)-(6*5)/5	if country == "RO" & year == 2019 & ml_eli == 1 ///
									& gender == 2



* BENEFIT (monthly)
/*	-> 85% of average gross earnings 
	-> ceiling: 85% of 12x the minimum gross wage (according to LP&R 2019 - no ceiling)
		-> minimum wage (Eurostat): €439.35
	-> it is unclear how are benefits calculated for unemployed women 
		and w. with no income => not coded */

replace ml_ben1 = 0.85*earning 		if country == "RO" & year == 2019 & ml_eli == 1

replace ml_ben1 = 0.85*(12*439.35)	if country == "RO" & year == 2019 & ml_eli == 1 ///
									& ml_ben1 > 0.85*(12*439.35)

replace ml_ben2 = ml_ben1 			if country == "RO" & year == 2019 & ml_eli == 1


foreach x in 1 2 {
    replace ml_dur`x' = 0 	if ml_eli == 0 & country == "RO" & year == 2019
	replace ml_ben`x' = 0 	if ml_eli == 0 & country == "RO" & year == 2019
}

