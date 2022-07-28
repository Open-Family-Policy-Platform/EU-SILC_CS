/* PL_2020_HU_eusilc_cs */


* HUNGARY - 2020

* ELIGIBILITY
/*	-> all parents are eligible for parental leave benefits 
	-> 2 types of benefits (LP&R 2010):
		-> GYES: for non-insured parents 
		-> GYED: for insured parents (same eligibility as for ML)
	-> family entitlement 
*/

replace pl_eli = 1 			if country == "HU" & year == 2020 
replace pl_eli = 0 			if pl_eli == . & country == "HU" & year == 2020


* DURATION (weeks)
/*	-> GYED: until child is 2 years old
	-> GYES: 
		-> until child is 3 years old
		-> from the end of GYED until child is 3 years old		*/

* mothers eligible for ML
replace pl_dur = (3*52) - ml_dur2 		if country == "HU" & year == 2020 & pl_eli == 1 ///
										& gender == 1 & ml_eli == 1

* women not eligible for ML
replace pl_dur = 3*52 		if country == "HU" & year == 2020 & pl_eli == 1 ///
							& pl_dur == . & gender == 1

* single men eligible for PT
replace pl_dur = (3*52) - pt_dur 		if country == "HU" & year == 2020 & pl_eli == 1 ///
										& gender == 2 & parstat == 1 & pl_dur == . & pt_eli == 1
										
* single men not eligible for PT
replace pl_dur = (3*52)					if country == "HU" & year == 2020 & pl_eli == 1 ///
										& gender == 2 & parstat == 1 & pl_dur == .
							

* BENEFIT (monthly)
/*	-> employed, self-employed compulsorily insured for at least 365 days (coded)
		in past 2 years (not coded) with the same employer (not coded): 
		-> for 2 years: 70% earning
			-> ceiling: €905/month (MISSOC 2020; GYED)
		-> for 1 year: €80/month (GYES)
		
	-> female tertiary education students or women who completed at least 2 semesters
		of tertiary education in past 2 years:
		-> undergraduate, for 1 year: €452/monthly
		-> MA, PhD, for 1 year: €592/month
		-> for 2 years: €80/month
		-> not coded (EU-SILC doesn't recognise)
	
	-> all other parents: €80/month 
	
	-> family entitlement: in couples all assigned to women
*/

* GYES
gen pl_gyes = 80 		if country == "HU" & year == 2020 & pl_eli == 1
replace pl_gyes = . 	if country == "HU" & year == 2020 & pl_eli == 1 ///
						& parstat == 2 & gender == 2 			// family entitlement => in couples assign all to women


* GYED
	* women
gen pl_gyed = 0.7*earning 		if country == "HU" & year == 2020 & pl_eli == 1 ///
								& ml_eli == 1 & inlist(econ_status,1,2) ///
								& earning < 905 & gender == 1
							
replace pl_gyed = 905		 	if country == "HU" & year == 2020 & pl_eli == 1 ///
								& ml_eli == 1 & inlist(econ_status,1,2) ///
								& earning >= 905 & gender == 1
								
	* single men
replace pl_gyed = 0.7*earning 	if country == "HU" & year == 2020 & pl_eli == 1 ///
								& inlist(econ_status,1,2) & earning < 905 ///
								& gender == 2 & parstat == 1
							
replace pl_gyed = 905		 	if country == "HU" & year == 2020 & pl_eli == 1 ///
								& inlist(econ_status,1,2) & earning >= 905 ///
								& gender == 2 & parstat == 1

replace pl_gyed = 0 			if pl_gyed == . & gender == 1 & country == "HU" & year == 2020
replace pl_gyed = 0 			if pl_gyed == . & gender == 2 & parstat == 1 & country == "HU" & year == 2020

						

* Benefits
	* women, employed & self-employed
replace pl_ben1 = (pl_gyed * ((2*52)/(3*52))) + (pl_gyes * (52/(3*52))) 		if country == "HU" ///
										& year == 2020 & gender == 1 & pl_eli == 1 & inlist(econ_status,1,2)
										
	* women, unemployed, inactive
replace pl_ben1 = pl_gyes 		if country == "HU" & year == 2020 & gender == 1 & pl_eli == 1 & inlist(econ_status,3,4)										
										
	* single men, employed & self-employed
replace pl_ben1 = (pl_gyed * ((2*52)/(3*52))) + (pl_gyes * (52/(3*52))) 		if country == "HU" ///
										& year == 2020 & gender == 2 & pl_eli == 1 & parstat == 1 ///
										& inlist(econ_status,1,2)
										
	* single men, unemployed & inactive
replace pl_ben1 = pl_gyes				if country == "HU" & year == 2020 & gender == 2 ///
										& pl_eli == 1 & parstat == 1 & inlist(econ_status,3,4)
										
										
	
	* women
replace pl_ben2 = pl_gyed 		if country == "HU" & year == 2020 & pl_eli == 1 ///
								& inlist(econ_status,1,2) & gender == 1

replace pl_ben2 = pl_gyes 		if country == "HU" & year == 2020 & pl_eli == 1 ///
								& inlist(econ_status,3,4) & gender == 1
								
	* single men
replace pl_ben2 = pl_gyed 		if country == "HU" & year == 2020 & pl_eli == 1 ///
								& inlist(econ_status,1,2) & gender == 2 & parstat == 1

replace pl_ben2 = pl_gyes 		if country == "HU" & year == 2020 & pl_eli == 1 ///
								& inlist(econ_status,3,4) & gender == 2 & parstat == 1
	
								

							

								
foreach x in 1 2 {
	replace pl_ben`x' = 0 	if pl_eli == 0 & country == "SI" & year == 2020
}

replace pl_dur`x' = 0 	if pl_eli == 0 & country == "HU" & year == 2020

drop pl_gyes pl_gyed