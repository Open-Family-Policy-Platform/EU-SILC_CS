/* PL_2012_IT_eusilc_cs */


* ITALY - 2012

* ELIGIBILITY
/*	-> employed
	-> self-employed (LP&R 2012) 	
*/
replace pl_eli = 1 			if country == "IT" & year == 2012 & inlist(econ_status,1,2)
replace pl_eli =  0			if pl_eli == . & country == "IT" & year == 2012


* DURATION (weeks)
/*	-> employed: 6 months/parent/child
	-> between the two parents no longer than 10 months (not coded) => in couples 6 months assigned to woman,
		4 month to man
		-> when mother is not entitled, the whole leave is assigned to the cohabiting man
		-> if partner is self-employed, the eligible partner is assigned 7 months
	-> fathers who take at least 3 months of PL are entitled to extra 1 month of PL (not coded)
	-> self-employed: 3 months/parent/child
	-> single parents: 10 months 
	-> until child is 12 years old
*/


* single
replace pl_dur = 10 	if country == "IT" & year == 2012 & pl_eli == 1 ///
						& parstat == 1
						
* self-employed
replace pl_dur = 3 		if country == "IT" & year == 2012 & pl_eli == 1 ///
						& econ_status == 2 
							
* couples
	* woman employed
replace pl_dur = 6 		if country == "IT" & year == 2012 & pl_eli == 1 ///
						& econ_status == 1 & parstat == 2 & gender == 1 

	* woman employed (above) & man employed (code)
replace pl_dur = 4 		if country == "IT" & year == 2012 & pl_eli == 1 ///
						& p_econ_status == 1 & parstat == 2 & gender == 2 ///
						& econ_status == 1
						
	* woman employed (code) & man not eligible
replace pl_dur = 10		if country == "IT" & year == 2012 & pl_eli == 1 ///
						& econ_status == 1 & parstat == 2 & gender == 1 ///
						& !inlist(p_econ_status,1,2)						

	* woman employed (code) & man self-employed
replace pl_dur = 7		if country == "IT" & year == 2012 & pl_eli == 1 ///
						& econ_status == 1 & parstat == 2 & gender == 1 ///
						& p_econ_status == 2

	* woman self-employed (above) & man employed (code)						
replace pl_dur = 7		if country == "IT" & year == 2012 & pl_eli == 1 ///
						& econ_status == 1 & parstat == 2 & gender == 2 ///
						& p_econ_status == 2					

	* woman not eligible & man employed (man)
replace pl_dur = 10		if country == "IT" & year == 2012 & pl_eli == 1 ///
						& econ_status == 1 & parstat == 2 & gender == 2 ///
						& !inlist(p_econ_status,1,2)
						

						
						
						
* BENEFIT (monthly)
/*	-> 30% of earnings (coded) if the child is under 3 years old (not coded)
	-> unpaid if the child is between 3 and 8 years old (not coded) 	*/
	
replace pl_ben1 = 0.3*earning 		if country == "IT" & year == 2012 & pl_eli == 1
replace pl_ben2 = pl_ben1			if country == "IT" & year == 2012 & pl_eli == 1


foreach x in 1 2 {
	replace pl_ben`x' = 0 	if pl_eli == 0 & country == "IT" & year == 2012
}

replace pl_dur = 0 	if pl_eli == 0 & country == "IT" & year == 2012
