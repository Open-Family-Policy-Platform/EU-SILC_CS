/* PL_2018_HU_eusilc_cs

date created: 26/03/2021

*/

* HUNGARY - 2018

* ELIGIBILITY
/*	-> all parents are eligible to some parental leave benefits 	
	-> family entitlement 
*/

replace pl_eli = 1 			if country == "HU" & year == 2018 
replace pl_eli = 0 			if pl_eli == . & country == "HU" & year == 2018


* DURATION (weeks)
/*	-> until child is 3 years old		*/

* mothers eligible for ML
replace pl_dur = (3*52) - ml_dur2 		if country == "HU" & year == 2018 & pl_eli == 1 ///
										& gender == 1 & ml_eli == 1

* women not eligible for ML
replace pl_dur = 3*52 		if country == "HU" & year == 2018 & pl_eli == 1 ///
							& pl_dur == . 

* single men eligible for PT
replace pl_dur = (3*52) - pt_dur 		if country == "HU" & year == 2018 & pl_eli == 1 ///
										& gender == 2 & parstat == 1 & pl_dur == . & pt_eli == 1
										
* single men not eligible for PT
replace pl_dur = (3*52)		if country == "HU" & year == 2018 & pl_eli == 1 ///
										& gender == 2 & parstat == 1 & pl_dur == .
							

* BENEFIT (monthly)
/*	-> employed, self-employed compulsorily insured for at least 365 days (coded)
		in past 2 years (not coded) with the same employer (not coded): 
		-> for 2 years: 70% earning, ceiling: €842/month (MISSOC 2018; GYED)
		-> for 1 year: €87/month (GYES)
		
	-> female tertiary education students or women who completed at least 2 semesters
		of tertiary education in past 2 years:
		-> undergraduate, for 1 year: €432.64/monthly
		-> MA, PhD, for 1 year: €302.85/month
		-> for 2 years: €87/month
		-> not coded (EU-SILC doesn't recognise)
	
	-> all other parents: €87/month 
	
	-> family entitlement: all assigned to women
*/

* GYES
gen pl_gyes = 87 		if country == "HU" & year == 2018 & pl_eli == 1
replace pl_gyes = . 	if country == "HU" & year == 2018 & pl_eli == 1 ///
						& parstat == 2 & gender == 2 			// family entitlement => in couples assign all to women


* GYED
gen pl_gyed = 0.7*earning 		if country == "HU" & year == 2018 & pl_eli == 1 ///
								& ml_eli == 1 & earning < 842 & gender == 1
							
replace pl_gyed = 842		 	if country == "HU" & year == 2018 & pl_eli == 1 ///
								& ml_eli == 1 & earning >= 842 & gender == 1

replace pl_gyed = 0.7*earning 	if country == "HU" & year == 2018 & pl_eli == 1 ///
								& inlist(econ_status,1,2) & earning < 842 ///
								& gender == 2 & parstat == 1
							
replace pl_gyed = 842		 	if country == "HU" & year == 2018 & pl_eli == 1 ///
								& inlist(econ_status,1,2) & earning >= 842 ///
								& gender == 2 & parstat == 1

							

replace pl_ben1 = (pl_gyed/((2*52)/3*52)) + (pl_gyes/(52/(3*52))) ///
								if country == "HU" & year == 2018 & pl_eli == 1 ///
								& ml_eli == 1 & earning < 842 & gender == 1

replace pl_ben1 = (842/((2*52)/3*52)) + (pl_gyes/(52/(3*52))) ///
								if country == "HU" & year == 2018 & pl_eli == 1 ///
								& ml_eli == 1 & earning >= 842 & gender == 1 & pl_ben1 == .
								
replace pl_ben1 = (pl_gyed/((2*52)/3*52)) + (pl_gyes/(52/(3*52))) ///
								if country == "HU" & year == 2018 & pl_eli == 1 ///
								& inlist(econ_status,1,2) & duremp >= 12 & earning < 842 ///
								& gender == 2 & parstat == 1 & pl_ben1 == .

replace pl_ben1 = (842/((2*52)/3*52)) + (pl_gyes/(52/(3*52))) ///
								if country == "HU" & year == 2018 & pl_eli == 1 ///
								& inlist(econ_status,1,2) & earning >= 842 ///
								& gender == 2 & parstat == 1 & pl_ben1 == . 

replace pl_ben1 = pl_gyes 		if country == "HU" & year == 2018 & pl_eli == 1 ///
								& parstat == 1 & pl_ben1 == .
								
replace pl_ben1 = pl_gyes 		if country == "HU" & year == 2018 & pl_eli == 1 ///
								& parstat == 2 & gender == 1 & pl_ben1 == . 
								

								

replace pl_ben2 = pl_gyed  		if country == "HU" & year == 2018 & pl_eli == 1 ///
								& inlist(econ_status,1,2) & duremp >= 12 & earning < 842 ///
								& parstat == 1

replace pl_ben2 = pl_gyed  		if country == "HU" & year == 2018 & pl_eli == 1 ///
								& inlist(econ_status,1,2) & duremp >= 12 & earning < 842 ///
								& parstat == 2 & gender == 1 & pl_ben2 == .
								
replace pl_ben2 = 842  			if country == "HU" & year == 2018 & pl_eli == 1 ///
								& inlist(econ_status,1,2) & duremp >= 12 & earning >= 842 ///
								& parstat == 1 & pl_ben2 == .

replace pl_ben2 = 842  			if country == "HU" & year == 2018 & pl_eli == 1 ///
								& inlist(econ_status,1,2) & duremp >= 12 & earning >= 842 ///
								& parstat == 2 & gender == 1 & pl_ben2 == .
								
replace pl_ben2 = pl_gyes 		if country == "HU" & year == 2018 & pl_eli == 1 ///
								& parstat == 1 & pl_ben2 == .
								
replace pl_ben2 = pl_gyes 		if country == "HU" & year == 2018 & pl_eli == 1 ///
								& parstat == 2 & gender == 1 & pl_ben2 == .

								
foreach x in 1 2 {
	replace pl_ben`x' = 0 	if pl_eli == 0 & country == "SI" & year == 2018
}

replace pl_dur`x' = 0 	if pl_eli == 0 & country == "HU" & year == 2018

drop pl_gyes pl_gyed
