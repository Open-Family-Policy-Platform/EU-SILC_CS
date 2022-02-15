/* PL_2015_HU_eusilc_cs */


* HUNGARY - 2015

* ELIGIBILITY
/*	-> all parents are eligible to some parental leave benefits 	
	-> family entitlement 
*/

replace pl_eli = 1 			if country == "HU" & year == 2015 
replace pl_eli = 0 			if pl_eli == . & country == "HU" & year == 2015


* DURATION (weeks)
/*	-> until child is 3 years old		*/

* mothers eligible for ML
replace pl_dur = (3*52) - ml_dur2 		if country == "HU" & year == 2015 & pl_eli == 1 ///
										& gender == 1 & ml_eli == 1

* women not eligible for ML
replace pl_dur = 3*52 					if country == "HU" & year == 2015 & pl_eli == 1 ///
										& pl_dur == . & gender == 1

* single men eligible for PT
replace pl_dur = (3*52) - pt_dur 		if country == "HU" & year == 2015 & pl_eli == 1 ///
										& gender == 2 & parstat == 1 & pl_dur == . & pt_eli == 1
										
* single men not eligible for PT
replace pl_dur = (3*52)					if country == "HU" & year == 2015 & pl_eli == 1 ///
										& gender == 2 & parstat == 1 & pl_dur == .
							

* BENEFIT (monthly)
/*	-> employed, self-employed compulsorily insured for at least 365 days (coded)
		in past 2 years (not coded) with the same employer (not coded): 
		-> for 2 years: 70% earning, ceiling: €668/month (MISSOC 2015; GYED)
		-> for 1 year: €91/month (GYES)
		
	-> female tertiary education students or women who completed at least 2 semesters
		of tertiary education in past 2 years:
		-> undergraduate, for 1 year: €334/monthly
		-> MA, PhD, for 1 year: €276/month
		-> not coded (EU-SILC doesn't recognise)
	
	-> all other parents: €91/month 
	
	-> family entitlement: all assigned to women
*/

* GYES
gen pl_gyes = 91		if country == "HU" & year == 2015 & pl_eli == 1
replace pl_gyes = . 	if country == "HU" & year == 2015 & pl_eli == 1 ///
						& parstat == 2 & gender == 2 			// family entitlement => in couples assign all to women


* GYED
	* women
gen pl_gyed = 0.7*earning 		if country == "HU" & year == 2015 & pl_eli == 1 ///
								& ml_eli == 1 & inlist(econ_status,1,2) ///
								& earning < 668 & gender == 1
							
replace pl_gyed = 668		 	if country == "HU" & year == 2015 & pl_eli == 1 ///
								& ml_eli == 1 & inlist(econ_status,1,2) ///
								& earning >= 668 & gender == 1
								
	* single men
replace pl_gyed = 0.7*earning 	if country == "HU" & year == 2015 & pl_eli == 1 ///
								& inlist(econ_status,1,2) & earning < 668 ///
								& gender == 2 & parstat == 1
							
replace pl_gyed = 668		 	if country == "HU" & year == 2015 & pl_eli == 1 ///
								& inlist(econ_status,1,2) & earning >= 668 ///
								& gender == 2 & parstat == 1

replace pl_gyed = 0 			if pl_gyed == . & gender == 1 & country == "HU" & year == 2015
replace pl_gyed = 0 			if pl_gyed == . & gender == 2 & parstat == 1 & country == "HU" & year == 2015

	
	

* Benefits
	* women, employed & self-employed
replace pl_ben1 = (pl_gyed * ((2*52)/(3*52))) + (pl_gyes * (52/(3*52))) 		if country == "HU" ///
										& year == 2015 & gender == 1 & pl_eli == 1 & inlist(econ_status,1,2)
										
	* women, unemployed, inactive
replace pl_ben1 = pl_gyes 		if country == "HU" & year == 2015 & gender == 1 & pl_eli == 1 & inlist(econ_status,3,4)										
										
	* single men, employed & self-employed
replace pl_ben1 = (pl_gyed * ((2*52)/(3*52))) + (pl_gyes * (52/(3*52))) 		if country == "HU" ///
										& year == 2015 & gender == 2 & pl_eli == 1 & parstat == 1 ///
										& inlist(econ_status,1,2)
										
	* single men, unemployed & inactive
replace pl_ben1 = pl_gyes				if country == "HU" & year == 2015 & gender == 2 ///
										& pl_eli == 1 & parstat == 1 & inlist(econ_status,3,4)
										
										
	
	* women
replace pl_ben2 = pl_gyed 		if country == "HU" & year == 2015 & pl_eli == 1 ///
								& inlist(econ_status,1,2) & gender == 1

replace pl_ben2 = pl_gyes 		if country == "HU" & year == 2015 & pl_eli == 1 ///
								& inlist(econ_status,3,4) & gender == 1
								
	* single men
replace pl_ben2 = pl_gyed 		if country == "HU" & year == 2015 & pl_eli == 1 ///
								& inlist(econ_status,1,2) & gender == 2 & parstat == 1

replace pl_ben2 = pl_gyes 		if country == "HU" & year == 2015 & pl_eli == 1 ///
								& inlist(econ_status,3,4) & gender == 2 & parstat == 1
	
	
								
foreach x in 1 2 {
	replace pl_ben`x' = 0 	if pl_eli == 0 & country == "SI" & year == 2015
}

replace pl_dur`x' = 0 	if pl_eli == 0 & country == "HU" & year == 2015

drop pl_gyes pl_gyed
