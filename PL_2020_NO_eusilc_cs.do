/* PL_2020_NO_eusilc_cs */

/*	Norway doesn't recognise ML and PT but only PL with individual entitlements for mother
	and father, and family entitlement. 
	The information here refers to the joint entitlement for parents (family right).
	Additional source: https://familie.nav.no/om-foreldrepenger#hvor-lenge-kan-du-fa-foreldrepenger
	Accessed: 01/04/2021
*/

* NORWAY - 2020

* ELIGIBILITY
/*	-> employed, self-employed: worked for at least 6 months (coded) during 10 months (not coded) before birth
	-> inactive women: maternity grant 
*/

replace pl_eli = 1 			if country == "NO" & year == 2020 & (duremp + dursemp) >= 6
replace pl_eli = 0			if pl_eli == . & country == "NO" & year == 2020


* DURATION (weeks)
/*	-> parents can choose between 2 options for the whole parental leave:
		- 49 weeks on 100% earning (coded)
		- 59 weeks on 80% earning
	-> joint right share: 19 weeks (remainder from 15 weeks reserved for mother and 15 weeks for father) 
		-> assigned to mother
	
*/

	* women
replace pl_dur = 19 		if country == "NO" & year == 2020 & pl_eli == 1 & gender == 1

	* single men
replace pl_dur = 19 		if country == "NO" & year == 2020 & pl_eli == 1 & gender == 2 ///
							& parstat == 1
	


* BENEFIT (monthly)
/*	-> 100% earning
	-> ceiling: €54,961/year 
	-> maternity grant - €7,772 for the whole period (11 months) 
*/

	* women
replace pl_ben1 = earning 		if country == "NO" & year == 2020 & pl_eli == 1 & gender ==1
replace pl_ben1 = 54961/12		if country == "NO" & year == 2020 & pl_eli == 1 ///
								& pl_ben1 >= 54961/12 & gender == 1
replace pl_ben1 = 7772/11		if country == "NO" & year == 2020 & pl_eli == 1 ///
								& pl_ben1 < 7772/11 & gender == 1

	* single men
replace pl_ben1 = earning 		if country == "NO" & year == 2020 & pl_eli == 1 & gender == 2 & parstat == 1
replace pl_ben1 = 54961/12		if country == "NO" & year == 2020 & pl_eli == 1 ///
								& pl_ben1 >= 54961/12 & gender == 2 & parstat == 1
replace pl_ben1 = 7772/11		if country == "NO" & year == 2020 & pl_eli == 1 ///
								& pl_ben1 < 7772/11 & gender == 2 & parstat == 1


replace pl_ben2 = pl_ben1		if country == "NO" & year == 2020 & pl_eli == 1



foreach x in 1 2 {
	replace pl_ben`x' = 0 	if country == "NO" & year == 2020 & pl_eli == 0	
}

replace pl_dur = 0 	if country == "NO" & year == 2020 & pl_eli == 0
