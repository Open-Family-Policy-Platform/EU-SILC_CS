/* PT_2010_NO_eusilc_cs */

/*	Norway doesn't recognise ML and PT but only PL with individual entitlements for mother
	and father, and family entitlement. 
	The information here refers to the individual entitlement for fathers (father's quota).
	Additional source: https://familie.nav.no/om-foreldrepenger#hvor-lenge-kan-du-fa-foreldrepenger
	Accessed: 01/04/2021
*/

* NORWAY - 2010

* ELIGIBILITY
/*	-> any economic activity if they were employed or self-employed for at least 6 months
		during 10 months before birth (compulsory social insurance for employed & self-employed) 
		- receipt of sickness, unemployment or parental leave benefit counts towards the 6 months
			but EU-SILC collects this information on a HH level => not coded 
		- applies to: fathers, mothers whose male partner doesn't fulfill the conditions, single mother
*/

* only man is eligibile
replace pt_eli = 1 			if country == "NO" & year == 2010 & gender == 2 ///
							& (duremp + dursemp) >= 6  & (p_duremp + p_dursemp) < 6

* both partners are eligible
replace pt_eli = 1 			if country == "NO" & year == 2010 & gender == 2 ///
							& (duremp + dursemp) >= 6  & (p_duremp + p_dursemp) >= 6

* only woman is eligible							
replace pt_eli = 1 			if country == "NO" & year == 2010 & gender == 1 ///
							& (duremp + dursemp) >= 6  & (p_duremp + p_dursemp) < 6

* single woman							
replace pt_eli = 1			if country == "NO" & year == 2010 & gender == 1 ///
							& (duremp + dursemp) >= 6  & parstat == 1

replace pt_eli = 0 			if pt_eli == . & country == "NO" & year == 2010 & gender == 2


* DURATION (weeks)
/*	-> 10 weeks
	-> mother, when father is not eligible: 10 weeks
	-> single mother: 10 weeks
	-> parents can choose between 2 options for the whole parental leave:
		- 46 weeks on 100% earning
		- 56 weeks on 80% earning
*/


replace pt_dur = 10 		if country == "NO" & year == 2010 & pt_eli == 1 



* BENEFIT (monthly)
/*	-> 100% earning
	-> ceiling: €56,413/year 
	-> minimum: maternity grant - €4,383 for the whole period (11 months)
*/

replace pt_ben1 = earning 		if country == "NO" & year == 2010 & pt_eli == 1

* ceiling
replace pt_ben1 = 56413/12			if country == "NO" & year == 2010 & pt_eli == 1 ///
									& pt_ben1 >= 56413/12

* minimum
replace pt_ben1 = 4383/11			if country == "NO" & year == 2010 & pt_eli == 1 ///
									& pt_ben1 < 4383/11


replace pt_ben2 = ml_ben1 		if country == "NO" & year == 2010 & pt_eli == 1





foreach x in 1 2 {
	replace pt_ben`x' = 0 	if country == "NO" & year == 2010 & pt_eli == 0
}

replace pt_dur = 0 		if country == "NO" & year == 2010 & pt_eli == 0 