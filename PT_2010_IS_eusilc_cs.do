/* PT_2010_IS_eusilc_cs */

/*	Iceland doesn't recognise ML and PT but only PL with individual non-transferable and 
	family rights. The individual non-transferable right for father is coded in here. 
*/

* ICELAND - 2010

* ELIGIBILITY
/*	-> all residents are entitled to cash benefits - if they were residents for at least 12 months (not coded)
	-> single mothers are entitled to father's share
*/

replace pt_eli = 1 		if country == "IS" & year == 2010 & gender == 2 

* single women
replace pt_eli = 1 		if country == "IS" & year == 2010 & gender == 1 ///
						& parstat == 1
replace pt_eli = 0 		if pt_eli == . & country == "IS" & year == 2010 & gender == 2



* DURATION (weeks)
/*	-> 3 months of individual non-transferable leave
	-> single mother: entitled to father's 3 months 
*/

replace pt_dur = 3*4.3 	if country == "IS" & year == 2010 & pt_eli == 1 


* BENEFIT (monthly)
/*	-> employed, self-employed: active for 6 months prior to birth
			- employed for at least 25% of full time (10 hours/week for 40 hours/week full-time employment) 
			- 80% of earning up to €1,265 per month, and 75% earning of remuneration beyond €1,265/month
			- ceiling: €1,898/month 
			- minimum: €520/month 	 if worked between 25% and 49% FT (i.e. 10 and 19.6 hours/week)
					   €720/month  if worked between 50% and 100% FT (i.e. more than 20 hours/week)
					   
	-> those not fulfilling the conditions: 
		- students: €720/month
		- working less than 25% FT: €314/month
*/

* employed, self-employed working 10-20 hours/week			
replace pt_ben1 = 0.8*earning	 				if country == "IS" & year == 2010 & pt_eli == 1 ///
										& inlist(econ_status,1,2) & inrange(whours,10,19) & earning < 1265

replace pt_ben1 = (0.8 * 1265) + (0.75 * (earning-1265)) 	if country == "IS" & year == 2010 & pt_eli == 1 ///
										& inlist(econ_status,1,2) & inrange(whours,10,19) & earning >= 1265
										
replace pt_ben1 = 520	 				if country == "IS" & year == 2010 & pt_eli == 1 ///
										& inlist(econ_status,1,2) & inrange(whours,10,19) ///
										& pt_ben1 < 520
										
replace pt_ben1 = 1898	 				if country == "IS" & year == 2010 & pt_eli == 1 ///
										& inlist(econ_status,1,2) & inrange(whours,10,19) ///
										& pt_ben1 >= 1898
										
* employed, self-employed working 20+ hours/week			
replace pt_ben1 = 0.8*earning	 				if country == "IS" & year == 2010 & pt_eli == 1 ///
										& inlist(econ_status,1,2) & whours >= 20 & earning < 1265
										
replace pt_ben1 = (0.8 * 1270) + (0.75 * (earning-1265)) 	if country == "IS" & year == 2010 & pt_eli == 1 ///
										& inlist(econ_status,1,2) & whours >= 20) & earning >= 1265

replace pt_ben1 = 720	 				if country == "IS" & year == 2010 & pt_eli == 1 ///
										& inlist(econ_status,1,2) & whours >= 20 ///
										& pt_ben1 < 720
										
replace pt_ben1 = 1898	 				if country == "IS" & year == 2010 & pt_eli == 1 ///
										& inlist(econ_status,1,2) & whours >= 20 ///
										& pt_ben1 >= 1898
										
* the rest 
replace pt_ben1 = 314					if country == "IS" & year == 2010 & pt_eli == 1 ///
										& inlist(econ_status,1,2) & whours < 10
replace pt_ben1 = 314					if country == "IS" & year == 2010 & pt_eli == 1 ///
										& inlist(econ_status,3,4) 
										
* students
replace pt_ben1 = 720					if country == "IS" & year == 2010 & pt_eli == 1 ///
										& pl031 == 6



replace pt_ben2 = pt_ben1 	if country == "IS" & year == 2010 & pt_eli == 1



foreach x in 1 2 {
	replace pt_ben`x' = 0 	if country == "IS" & year == 2010 & pt_eli == 0
}

replace pt_dur = 0 		if country == "IS" & year == 2010 & pt_eli == 0 
