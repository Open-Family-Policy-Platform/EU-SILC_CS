/* PL_2010_NO_eusilc_cs */

/*	Norway doesn't recognise ML and PT but only PL with individual entitlements for mother
	and father, and family entitlement. 
	The information here refers to the joint entitlement for parents (family right).
	Additional source: https://familie.nav.no/om-foreldrepenger#hvor-lenge-kan-du-fa-foreldrepenger
	Accessed: 01/04/2021
*/

* NORWAY - 2010

* ELIGIBILITY
/*	-> employed, self-employed: worked for at least 6 months (coded) during 10 months (not coded) before birth
	-> inactive women: maternity grant
*/

replace pl_eli = 1 			if country == "NO" & year == 2010 & (duremp + dursemp) >= 6
replace pl_eli = 0			if pl_eli == . & country == "NO" & year == 2010


* DURATION (weeks)
/*	-> parents can choose between 2 options for the whole parental leave:
		- 46 weeks on 100% earning (coded)
		- 56 weeks on 80% earning
	-> joint right share: 27 weeks (remainder from 9 weeks reserved for mother and 10 weeks for father) 
			-> assigned to mother
*/

	* women
replace pl_dur = 27 		if country == "NO" & year == 2010 & pl_eli == 1 & gender == 1

	* single men
replace pl_dur = 27 		if country == "NO" & year == 2010 & pl_eli == 1 & gender == 2 & parstat == 1




* BENEFIT (monthly)
/*	-> 100% earning
	-> ceiling: €56,413/year  
	-> maternity grant - €4,383 for the whole period (11 months)
*/

	* women
replace pl_ben1 = earning 		if country == "NO" & year == 2010 & pl_eli == 1 & gender ==1
replace pl_ben1 = 56413/12		if country == "NO" & year == 2010 & pl_eli == 1 ///
								& pl_ben1 >= 56413/12 & gender == 1
replace pl_ben1 = 4383/11		if country == "NO" & year == 2010 & pl_eli == 1 ///
								& pl_ben1 < 4383/11 & gender == 1

	* single men
replace pl_ben1 = earning 		if country == "NO" & year == 2010 & pl_eli == 1 & gender == 2 & parstat == 1
replace pl_ben1 = 56413/12		if country == "NO" & year == 2010 & pl_eli == 1 ///
								& pl_ben1 >= 56413/12 & gender == 2 & parstat == 1
replace pl_ben1 = 4383/11		if country == "NO" & year == 2010 & pl_eli == 1 ///
								& pl_ben1 < 4383/11 & gender == 2 & parstat == 1


replace pl_ben2 = pl_ben1		if country == "NO" & year == 2010 & pl_eli == 1




foreach x in 1 2 {
	replace pl_ben`x' = 0 	if country == "NO" & year == 2010 & pl_eli == 0	
}

replace pl_dur = 0 	if country == "NO" & year == 2010 & pl_eli == 0
