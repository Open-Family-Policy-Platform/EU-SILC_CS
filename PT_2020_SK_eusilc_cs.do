/* PT_2020_SK_eusilc_cs */

/*
*** NOTE: No statutory right to paternity leave. The individual entitlement 
		  for fathers is a hybrid between individual transferable right (mother) 
		  and individual entitlement (father). Father can use the entitlement 
		  when the mother of the child agrees with him providing full-time care 
		  for the child, when the mother dies, cannot provide care, or abandons
		  the child. Father can use the right after mother's entitlement to maternity
		  leave expires.
		  Source: z.c. 461/2003 z.z., zakon o socialnom poisteni 				
		  (https://www.zakonypreludi.sk/zz/2003-461/znenie-20210101#cast1-hlava2-diel5)
		  accessed: 30/03/2021
*/

* SLOVAKIA - 2020

* ELIGIBILITY
/*	-> employed, self-employed
	-> 270 calendar days (coded) 
		of work during the past 2 years	(not coded) 	
	-> single fathers can also claim "ML" - already coded in ml_eli!	*/
	
replace pt_eli = 1 		if country == "SK" & year == 2020 & gender == 2 ///
						& inlist(econ_status,1,2) & (duremp + dursemp) >= 270/30 & parstat == 2

replace pt_eli = 0 		if pt_eli == . & country == "SK" & year == 2020 & gender == 2



* DURATION (weeks)
/*	-> 28 weeks
	-> single fathers: 31 weeks (coded in ml_eli) */
	
replace pt_dur = 28 	if country == "SK" & year == 2020 & pt_eli == 1 


* BENEFIT (monthly)
/*	-> 75% average earnings
	-> ceiling: 2x national average monthly wage
		-> average monthly wage = €1,245 
			(Source: Statistical Office of the Slovak Republic, article: "Average monthly
			wae of employee in economy of the SR in the 4th quarter of 2020", accessed 12.8.2021	*/
	
replace pt_ben1 = 0.75*earning 		if country == "SK" & year == 2020 & pt_eli == 1
replace pt_ben1 = 1177*2		 	if country == "SK" & year == 2020 & pt_eli == 1 ///
									& pt_ben1 >= 1177*2


replace pt_ben2 = pt_ben1 	if country == "SK" & year == 2020 & pt_eli == 1

foreach x in 1 2 {
	replace pt_ben`x' = 0 	if pt_eli == 0 & country == "SK" & year == 2020
}

replace pt_dur = 0 if pt_eli == 0 & country == "SK" & year == 2020
