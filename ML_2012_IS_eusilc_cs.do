/* ML_2012_IS_eusilc_cs */

/*	Iceland doesn't recognise ML and PT but only PL with individual non-transferable and 
	family rights. The individual non-transferable right for mother is coded in here. 
*/

* ICELAND - 2012

* ELIGIBILITY
/*	-> all residents (coded) are entitled to cash benefits - if they were residents for at least 12 months (not coded)
	-> single fathers are entitled to mother's share
*/

replace ml_eli = 1 			if country == "IS" & year == 2012 & gender == 1

* single men
replace ml_eli = 1 			if country == "IS" & year == 2012 & gender == 2 ///
							& parstat == 1

replace ml_eli = 0 			if ml_eli == . & country == "IS" & year == 2012 & gender == 1




* DURATION (weeks)
/*	-> 3 months of individual non-transferable leave
	-> single father: entitled to the mother's 3 months 
*/
replace ml_dur1 = 0	 			if country == "IS" & year == 2012 & ml_eli == 1 

replace ml_dur2 = 3*4.3 		if country == "IS" & year == 2012 & ml_eli == 1 






* BENEFIT (monthly)
/*	-> employed, self-employed: active for 6 months prior to birth
			- employed for at least 25% of full time (10 hours/week for 40 hours/week full-time employment) 
			- 80% of earning up to €1,270 per month, and 75% earning of remuneration beyond €1,270/month 
			- ceiling: €1,905/month 
			- minimum: €584/month 	 if worked between 25% and 49% FT (i.e. 10 and 19.6 hours/week)
					   €809/month  if worked between 50% and 100% FT (i.e. more than 20 hours/week)
					   
	-> those not fulfilling the conditions: 
		- students: €809/month
		- working less than 25% FT and inactive: €353/month
*/


* employed, self-employed working 10-20 hours/week			
replace ml_ben1 = 0.8*earning	 		if country == "IS" & year == 2012 & ml_eli == 1 ///
										& inlist(econ_status,1,2) & inrange(whours,10,19) & earning < 1270
										
replace ml_ben1 = (0.8 * 1270) + (0.75 * (earning-1270)) 	if country == "IS" & year == 2012 & ml_eli == 1 ///
										& inlist(econ_status,1,2) & inrange(whours,10,19) & earning >= 1270	

replace ml_ben1 = 584	 				if country == "IS" & year == 2012 & ml_eli == 1 ///
										& inlist(econ_status,1,2) & inrange(whours,10,19) ///
										& ml_ben1 < 584
										
replace ml_ben1 = 1905	 				if country == "IS" & year == 2012 & ml_eli == 1 ///
										& inlist(econ_status,1,2) & inrange(whours,10,19) ///
										& ml_ben1 >= 1905
										
* employed, self-employed working 20+ hours/week			
replace ml_ben1 = 0.8*earning	 		if country == "IS" & year == 2012 & ml_eli == 1 ///
										& inlist(econ_status,1,2) & whours >= 20 & earning < 1270
										
replace ml_ben1 = (0.8 * 1270) + (0.75 * (earning-1270)) 	if country == "IS" & year == 2012 & ml_eli == 1 ///
										& inlist(econ_status,1,2) & whours >= 20 & earning >= 1270

replace ml_ben1 = 809	 				if country == "IS" & year == 2012 & ml_eli == 1 ///
										& inlist(econ_status,1,2) & whours >= 20 ///
										& ml_ben1 < 809
										
replace ml_ben1 = 1905	 				if country == "IS" & year == 2012 & ml_eli == 1 ///
										& inlist(econ_status,1,2) & whours >= 20 ///
										& ml_ben1 >= 1905
										
* the rest 
replace ml_ben1 = 353					if country == "IS" & year == 2012 & ml_eli == 1 ///
										& inlist(econ_status,1,2) & whours < 10
replace ml_ben1 = 353					if country == "IS" & year == 2012 & ml_eli == 1 ///
										& inlist(econ_status,3,4) 

* students
replace ml_ben1 = 809					if country == "IS" & year == 2012 & ml_eli == 1 ///
										& pl031 == 6

									

replace ml_ben2 = ml_ben1 		if country == "IS" & year == 2012 & ml_eli == 1


foreach x in 1 2 {
	replace ml_dur`x' = 0 	if country == "IS" & year == 2012 & ml_eli == 0
	replace ml_ben`x' = 0 	if country == "IS" & year == 2012 & ml_eli == 0
	
}
