/* PT_2014_IS_eusilc_cs */

/*	Iceland doesn't recognise ML and PT but only PL with individual non-transferable and 
	family rights. The individual non-transferable right for father is coded in here. 
*/

* ICELAND - 2014

* ELIGIBILITY
/*	-> all residents are entitled to cash benefits - if they were residents for at least 12 months (not coded)
	-> single mothers are entitled to father's share
*/

replace pt_eli = 1 		if country == "IS" & year == 2014 & gender == 2 

* single women
replace pt_eli = 1 		if country == "IS" & year == 2014 & gender == 1 ///
						& parstat == 1
replace pt_eli = 0 		if pt_eli == . & country == "IS" & year == 2014 & gender == 2



* DURATION (weeks)
/*	-> 3 months of individual non-transferable leave
	-> single mother: entitled to father's 3 months 
*/

replace pt_dur = 3*4.3 	if country == "IS" & year == 2014 & pt_eli == 1 


* BENEFIT (monthly)
/*	-> employed, self-employed: active for 6 months prior to birth
			- employed for at least 25% of full time (10 hours/week for 40 hours/week full-time employment) 
			- 80% earning

			- ceiling: €2,389/month 
			- minimum: €631/month 	 if worked between 25% and 49% FT (i.e. 10 and 19.6 hours/week)
					   €1,108/month  if worked between 50% and 100% FT (i.e. more than 20 hours/week)
					   
	-> those not fulfilling the conditions: 
		- students: €1,108/month
		- working less than 25% FT: €382/month
*/

* employed, self-employed working 10-20 hours/week			
replace pt_ben1 = 0.8*earning	 		if country == "IS" & year == 2014 & pt_eli == 1 ///
										& inlist(econ_status,1,2) & inrange(whours,10,19)


replace pt_ben1 = 631	 				if country == "IS" & year == 2014 & pt_eli == 1 ///
										& inlist(econ_status,1,2) & inrange(whours,10,19) ///
										& pt_ben1 < 631
										
replace pt_ben1 = 2389	 				if country == "IS" & year == 2014 & pt_eli == 1 ///
										& inlist(econ_status,1,2) & inrange(whours,10,19) ///
										& pt_ben1 >= 2389

										
* employed, self-employed working 20+ hours/week			
replace pt_ben1 = 0.8*earning	 		if country == "IS" & year == 2014 & pt_eli == 1 ///
										& inlist(econ_status,1,2) & whours >= 20

replace pt_ben1 = 945	 				if country == "IS" & year == 2014 & pt_eli == 1 ///
										& inlist(econ_status,1,2) & whours >= 20 ///
										& pt_ben1 < 945
										

replace pt_ben1 = 2389	 				if country == "IS" & year == 2014 & pt_eli == 1 ///
										& inlist(econ_status,1,2) & whours >= 20 ///
										& pt_ben1 >= 2389
										
* the rest 
replace pt_ben1 = 382					if country == "IS" & year == 2014 & pt_eli == 1 ///
										& inlist(econ_status,1,2) & whours < 10
replace pt_ben1 = 382					if country == "IS" & year == 2014 & pt_eli == 1 ///
										& inlist(econ_status,3,4) 
										
* students
replace pt_ben1 = 945					if country == "IS" & year == 2014 & pt_eli == 1 ///
										& pl031 == 6



replace pt_ben2 = pt_ben1 	if country == "IS" & year == 2014 & pt_eli == 1



foreach x in 1 2 {
	replace pt_ben`x' = 0 	if country == "IS" & year == 2014 & pt_eli == 0
}

replace pt_dur = 0 		if country == "IS" & year == 2014 & pt_eli == 0 
