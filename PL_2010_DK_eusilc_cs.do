/* PL_2010_DK_eusilc_cs */


* DENMARK - 2010


* ELIGIBILITY
/* 	-> employed (coded): at least 120 hours in 13 weeks before birth 
	-> self-employed: for at least 6 months (coded) during 12 months before birth (not coded)
	-> unemployed (from unemployment insurance)	
	-> students (extra student grant; pl031 == 6; LP&R 2010)
*/

replace pl_eli = 1	 		if country == "DK" & year == 2010 & inlist(econ_status,1,3) 

replace pl_eli = 1			if country == "DK" & year == 2010 & econ_status == 2 & dursemp >= 6

replace pl_eli = 1	 		if country == "DK" & year == 2010 & pl031 == 6
							

replace pl_eli = 0 			if pl_eli == . & country == "DK" & year == 2010


* DURATION (weeks)
/*	-> 32 weeks per parent
	-> until child is 9 years old
	-> maximum duration in total: 32 weeks
		-> couples: all assigned to woman
		-> single men: all assigned to them
*/

* couples => to women	
replace pl_dur = 32 		if country == "DK" & year == 2010 & pl_eli == 1 & gender == 1

* single men
replace pl_dur = 32 		if country == "DK" & year == 2010 & pl_eli == 1 & gender == 2 ///
							& parstat == 1



* BENEFIT (monthly)
/* 	-> employed, self-employed: 100% earning
	-> ceiling: €505/week 	
	-> unemployed: unemployment benefits (not coded)
	-> students: extra 12 months of study grant (not coded) 
	-> the entitlement to benefit is a family entitlement => assigned to women 
	-> assigned to single men
*/
	
replace pl_ben1 = earning 		if country == "DK" & year == 2010 & pl_eli == 1 ///
								& inlist(econ_status,1,2) & gender == 1

replace pl_ben1 = 505*4.3		if country == "DK" & year == 2010 & pl_eli == 1 ///
								& inlist(econ_status,1,2) & earning/4.3 >= 505 ///
								& gender == 1

* single men
replace pl_ben1 = earning 		if country == "DK" & year == 2010 & pl_eli == 1 ///
								& inlist(econ_status,1,2) & gender == 2 & parstat == 1

replace pl_ben1 = 505*4.3		if country == "DK" & year == 2010 & pl_eli == 1 ///
								& inlist(econ_status,1,2) & earning/4.3 >= 505 ///
								& gender == 2 & parstat == 1


replace pl_ben2 = pl_ben1 		if country == "DK" & year == 2010 & pl_eli == 1 ///
								& gender == 1

foreach x in 1 2 {
	replace pl_ben`x' = 0 	if pl_eli == 0 & country == "DK" & year == 2010
}

replace pl_dur = 0 	if pl_eli == 0 & country == "DK" & year == 2010
