/* PL_2011_PT_eusilc_cs */


* PORTUGAL - 2011

* ELIGIBILITY
/*	-> initial parental leave:
		-> 120 or 150 calendar days
		-> 6 weeks (45 days) individual non-transferable leave for mothers (coded as ML)
		-> the rest is a family right that can be shared by the parents as they please
	-> additional parental leave:
		-> individual non-transferable right


	-> compulsorily social insurance for employed and self-employed 
		- 6 months of work before childbirth	
		
	-> includes the portion of the intitial parental period that is a family right, and 
		additional parental leave period that is a family right
		
	-> family right => in couples leave assigned to woman */
		
replace pl_eli = 1 			if country == "PT" & year == 2011 & inlist(econ_status,1,2) ///
							& (duremp+dursemp) >= 6

							
replace pl_eli =  0			if pl_eli == . & country == "PT" & year == 2011


* DURATION (weeks)
/*	-> initial parental leave: 120 days (coded) or 150 days (not coded)
	-> additional parental leave: 3 months/parent/child
	
	-> single parents are not entitled to the share of the other parent*/

gen pl_init = (120 - 45)/5 		if country == "PT" & year == 2011
gen pl_exte = 3*4.3						if country == "PT" & year == 2011
	
* women
replace pl_dur = pl_init + pl_exte  	if country == "PT" & year == 2011 ///
										& pl_eli == 1 & gender == 1
										
* single men											
replace pl_dur = pl_init + pl_exte  	if country == "PT" & year == 2011 ///
										& pl_eli == 1 & gender == 2 & parstat == 1

* cohabiting men
replace pl_dur = pl_exte  			if country == "PT" & year == 2011 ///
										& pl_eli == 1 & gender == 2 
										


* BENEFIT (monthly)
/*	
	-> initial parental leave:
		-> influenced by parents' choice of duration (120 or 150 days) and whether leave is shared 
		-> 120 days: 100% earning (coded)
		-> 150 days, not shared: 80% earning
		-> 150 days, shared: 100% earning
		-> 180 days, shared: 83% earning 
		-> minimum: €419.22/month 

	-> aadditional parental leave: 25% earning	 	*/
	
	* women
replace pl_ben1 =  (earning*(pl_init/pl_dur)) + ((earning*0.25)*(pl_exte/pl_dur))	///
												if country == "PT" & year == 2011 & pl_eli == 1 ///
												& gender == 1
												
replace pl_ben1 =  (419.22 * (pl_init/pl_dur)) + ((earning*0.25)*(pl_exte/pl_dur))		if country == "PT" & year == 2011 & pl_eli == 1	///
																						& pl_ben1 < 419.22 & gender == 1
								
	* single men
replace pl_ben1 =  (earning*(pl_init/pl_dur)) + ((earning*0.25)*(pl_exte/pl_dur))	///
												if country == "PT" & year == 2011 & pl_eli == 1 ///
												& gender == 2 & parstat == 1
												
replace pl_ben1 =  (419.22 * (pl_init/pl_dur)) + ((earning*0.25)*(pl_exte/pl_dur))		if country == "PT" & year == 2011 & pl_eli == 1	///
																						& pl_ben1 < 419.22 & gender == 2 & parstat == 1
								

* cohabiting men
replace pl_ben1 = (earning*0.25)				if country == "PT" & year == 2011 & pl_eli == 1 ///
												& gender == 2 


* women												
replace pl_ben2 = earning 		if country == "PT" & year == 2011 & pl_eli == 1 & gender == 1

* single men
replace pl_ben2 = earning 		if country == "PT" & year == 2011 & pl_eli == 1 & gender == 2 & parstat == 1

* cohabiting men
replace pl_ben2 = (earning*0.25)				if country == "PT" & year == 2011 & pl_eli == 1 ///
												& gender == 2 


foreach x in 1 2 {
	replace pl_ben`x' = 0 	if pl_eli == 0 & country == "PT" & year == 2011
}

replace pl_dur = 0 	if pl_eli == 0 & country == "PT" & year == 2011

drop pl_init pl_exte
