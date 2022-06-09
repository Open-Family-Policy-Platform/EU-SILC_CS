/* PL_2010_IS_eusilc_cs */

/*	Iceland doesn't recognise ML and PT but only PL with individual non-transferable and 
	family rights. The family right for leave is coded in here. In case of couples, the 
	entitlement is assigned to women. 
*/

* ICELAND - 2010

* ELIGIBILITY
/*	-> all residents are entitled to cash benefits 
*/

replace pl_eli = 1 			if country == "IS" & year == 2010 
replace pl_eli =  0			if pl_eli == . & country == "IS" & year == 2010


* DURATION (weeks)
/*	-> 3 months of leave - family entitlement
	-> family entitlement => in couples all assigned to women 
*/
replace pl_dur = 3*4.3 		if country == "IS" & year == 2010 & pl_eli == 1 ///
							& gender == 1 
							
replace pl_dur = 3*4.3		if country == "IS" & year == 2010 & pl_eli == 1 ///
							& gender == 2 & parstat == 1


* BENEFIT (monthly)
/*	-> employed, self-employed: active for 6 months prior to birth
			- employed for at least 25% of full time (10 hours/week for 40 hours/week full-time employment) 
			- 80% of earning up to €1,265 per month, and 75% earning of remuneration beyond €1,265/month
			- ceiling: €1,898/month 
			- minimum: €520/month 	 if worked between 25% and 49% FT (i.e. 10 and 19.6 hours/week)
					   €720/month if worked between 50% and 100% FT (i.e. more than 20 hours/week)
					   
	-> those not fulfilling the conditions: 
		- students: €720/month
		- working less than 25% FT: €314/month
*/

* employed, self-employed working 10-20 hours/week - women			
replace pl_ben1 = 0.8*earning	 				if country == "IS" & year == 2010 & pl_eli == 1 ///
										& inlist(econ_status,1,2) & inrange(whours,10,19) ///
										& gender == 1 & earning < 1265
										
replace pl_ben1 = (0.8 * 1265) + (0.75 * (earning-1265)) 	if country == "IS" & year == 2010 & pl_eli == 1 ///
										& inlist(econ_status,1,2) & inrange(whours,10,19) & earning >= 1265	
										
replace pl_ben1 = 520	 				if country == "IS" & year == 2010 & pl_eli == 1 ///
										& inlist(econ_status,1,2) & inrange(whours,10,19) ///
										& pl_ben1 < 520 & gender == 1
										
replace pl_ben1 = 1898	 				if country == "IS" & year == 2010 & pl_eli == 1 ///
										& inlist(econ_status,1,2) & inrange(whours,10,19) ///
										& pl_ben1 >= 1898 & gender == 1
										
* employed, self-employed working 20+ hours/week - women			
replace pl_ben1 = 0.8*earning	 		if country == "IS" & year == 2010 & pl_eli == 1 ///
										& inlist(econ_status,1,2) & whours >= 20 & gender == 1 & earning < 1265
										
replace pl_ben1 = (0.8 * 1265) + (0.75 * (earning-1265)) 	if country == "IS" & year == 2010 & pl_eli == 1 ///
										& inlist(econ_status,1,2) & whours >= 20 & gender == 1 & earning >= 1265

replace pl_ben1 = 720	 				if country == "IS" & year == 2010 & pl_eli == 1 ///
										& inlist(econ_status,1,2) & whours >= 20 ///
										& pl_ben1 < 720 & gender == 1
										
replace pl_ben1 = 1898	 				if country == "IS" & year == 2010 & pl_eli == 1 ///
										& inlist(econ_status,1,2) & whours >= 20 ///
										& pl_ben1 >= 1898 & gender == 1
										
* the rest - women
replace pl_ben1 = 314					if country == "IS" & year == 2010 & pl_eli == 1 ///
										& inlist(econ_status,1,2) & whours < 10 & gender == 1
										
replace pl_ben1 = 314					if country == "IS" & year == 2010 & pl_eli == 1 ///
										& inlist(econ_status,3,4) & gender == 1 
										
replace pl_ben1 = 720					if country == "IS" & year == 2010 & pl_eli == 1 ///
										& pl031 == 6 & gender == 1


					
* employed, self-employed working 10-20 hours/week - single men			
replace pl_ben1 = 0.8*earning	 				if country == "IS" & year == 2010 & pl_eli == 1 ///
										& inlist(econ_status,1,2) & inrange(whours,10,19) ///
										& gender == 2 & parstat == 1 & earning < 1265
										
replace pl_ben1 = (0.8 * 1265) + (0.75 * (earning-1265)) 	if country == "IS" & year == 2010 & pl_eli == 1 ///
										& inlist(econ_stutus,1,2) & inrange(whours,10,19) & gender == 2 & parstat == 1 & earning >= 1265

replace pl_ben1 = 520	 				if country == "IS" & year == 2010 & pl_eli == 1 ///
										& inlist(econ_status,1,2) & inrange(whours,10,19) ///
										& pl_ben1 < 520 & gender == 2 & parstat == 1
										
replace pl_ben1 = 1898	 				if country == "IS" & year == 2010 & pl_eli == 1 ///
										& inlist(econ_status,1,2) & inrange(whours,10,19) ///
										& pl_ben1 >= 1898 & gender == 2 & parstat == 1
										
* employed, self-employed working 20+ hours/week - single men			
replace pl_ben1 = 0.8*earning	 				if country == "IS" & year == 2010 & pl_eli == 1 ///
										& inlist(econ_status,1,2) & whours >= 20 ///
										& gender == 2 & parstat == 1 & earning < 1265

replace pl_ben1 = (0.8 * 1265) + (0.75 * (earning-1265)) 	if country == "IS" & year == 2010 & pl_eli == 1 ///
										& inlist(econ_status,1,2) & whours >= 20 & gender == 2 & parstat == 1 & earning >= 1265

replace pl_ben1 = 720	 				if country == "IS" & year == 2010 & pl_eli == 1 ///
										& inlist(econ_status,1,2) & whours >= 20 ///
										& pl_ben1 < 720 & gender == 2 & parstat == 1
										
replace pl_ben1 = 1898	 				if country == "IS" & year == 2010 & pl_eli == 1 ///
										& inlist(econ_status,1,2) & whours >= 20 ///
										& pl_ben1 >= 1898 & gender == 2 & parstat == 1
										
* the rest - single men
replace pl_ben1 = 314					if country == "IS" & year == 2010 & pl_eli == 1 ///
										& inlist(econ_status,1,2) & whours < 10 ///
										& gender == 2 & parstat == 1
										
replace pl_ben1 = 314					if country == "IS" & year == 2010 & pl_eli == 1 ///
										& inlist(econ_status,3,4) & gender == 2 & parstat == 1
										
replace pl_ben1 = 720					if country == "IS" & year == 2010 & pl_eli == 1 ///
										& pl031 == 6 & gender == 2 & parstat == 1


replace pl_ben2 = pl_ben1		if country == "IS" & year == 2010 & pl_eli == 1



foreach x in 1 2 {
	replace pl_ben`x' = 0 	if country == "IS" & year == 2010 & pl_eli == 0	
}

replace pl_dur = 0 	if country == "IS" & year == 2010 & pl_eli == 0
