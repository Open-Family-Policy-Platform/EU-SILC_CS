/* PT_2019_EE_eusilc_cs */


* ESTONIA - 2019

* ELIGIBILITY
/*	-> employed (coded) fathers with permanent contract (MISSOC 01/07/2019; not coded) */ 

replace pt_eli = 1 		if country == "EE" & year == 2019 & gender == 2 ///
						& econ_status == 1
replace pt_eli = 0 		if pt_eli == . & country == "EE" & year == 2019


* DURATION (weeks)
/*	-> 10 working days 
	-> must be taken within 2 months after childbirth
*/

replace pt_dur = 10/5 	if country == "EE" & year == 2019 & pt_eli == 1


* BENEFIT (monthly)
/*	-> 100% of earning
	-> ceiling: 3x the average gross monthly salary (MISSOC 2019)
	-> average gross monthly salary, 2019: €1,407 (Source: Statistics Estonia, 

	https://www.stat.ee/en/find-statistics/statistics-theme/work-life/wages-and-salaries-and-labour-costs/average-monthly-gross-wages-and-salaries
	accessed 24/03/2021		*/
	
replace pt_ben1 = earning 	if country == "EE" & year == 2019 & pt_eli == 1
							
							
replace pt_ben1 = ((3*1407) * (pt_dur/4.3)) + (earning * ((4.3-pt_dur)/4.3)) ///
							if country == "EE" & year == 2019 & pt_eli == 1 ///
							& pt_ben1 >= 1407*3					
							
							
replace pt_ben2 = pt_ben1 	if country == "EE" & year == 2019 & pt_eli == 1


foreach x in 1 2 {
	replace pt_ben`x' = 0 	if pt_eli == 0 & country == "EE" & year == 2019
}

replace pt_dur = 0 if pt_eli == 0 & country == "EE" & year == 2019
