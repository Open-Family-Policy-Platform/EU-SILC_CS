/*	

STANDARDISE variables 	

Prepares the original variables for the Program. 

*/

* country
// rename oldvar country	// 

* identify household units (single, diff-sex couples, same-sex couples)

* gender
recode rb090 (2 = 1 woman) ///
			(1 = 2 man), ///
			gen(gender) label(genderl)

			
* economic status 
recode pl031 (1 2 = 1 employed) ///
			(3 4 = 2 self-employed) ///
			(5 = 3 unemployed) ///
			(6 7 8 9 10 11 = 4 inactive), ///
			gen(econ_status) label(econ_statusl)  
			
lab var econ_status "Self-defined current economic status"



* duration of employment (months) 
gen duremp = pl073 + pl074
replace duremp = 12 if duremp > 12 & duremp != .

lab var duremp "Number of months spent in employment"


* duration of education
gen duredu = pl087

lab var duredu "Number of months spent in education"  


* duration of unemployment
gen unemp_dur = pl080

lab var unemp_dur "Number of months spent in unemployment"		

* duration of self-employment 
gen dursemp = pl075 + pl076
replace dursemp = 12 if dursemp > 13 & dursemp != .

lab var dursemp "Number of months spent in self-employment"	

	
replace duremp = . if econ_status == .
replace duredu = . if pl211a == .
replace unemp_dur = . if econ_status == .
replace dursemp = . if econ_status == .

	
* monthly gross earning (labour income) 

gen earning_yg = py010g + py050g  if econ_status != . 	// collapses earning from employment and self-employment

gen dureact = duremp + dursemp 	if econ_status != . // adds of employment and self-employment
replace dureact = 12 if dureact > 12 & dureact != .

gen earning = earning_yg/dureact 
replace earning = earning_yg/12 if (dureact == 0 | dureact == .) 


* self-employed are allowed negative "income"
replace earning = 0 if earning < 0

replace earning = 0 if econ_status == 4 & earning == .  // inactive earning = . (if not recoded, deletes observations from the sample)

drop dureact


* age (at the time of interview)
gen age = rx010
			

* region
gen region = db040 		


* partnership status
recode pb200 (3 = 1 single) ///
			(1 2 = 2 "married/cohabiting"), ///
			gen(parstat) label(parstatl)	
			

* working hours
gen whours = pl060 	
			

