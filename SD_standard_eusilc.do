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

foreach x in a b c d e f g h i j k l {
	recode pl211`x' (1 2 = 1 employed) ///
			(3 4 = 2 self-employed) ///
			(5 = 3 unemployed) ///
			(6 7 8 9 10 11 = 4 inactive), ///
			gen(estatus`x') label(estatus`x'l)
}
	
	

* duration of employment (months) 
egen duremp = anycount(estatus*), values(1) 

* duration of education
egen duredu = anycount(pl211*), values(6)  

* duration of unemployment
egen unemp_dur = anycount(estatus*), values(3)			

* duration of self-employment 
egen dursemp = anycount(estatus*), values(2)	
	
replace duremp = . if econ_status == .
replace duredu = . if pl211a == .
replace unemp_dur = . if econ_status == .
replace dursemp = . if econ_status == .

	
* monthly gross earning (labour income) 

gen earning_yg = py010g + py050g  if econ_status != . 	// collapses earning from employment and self-employment

gen dureact = duremp + dursemp 	if econ_status != . // adds of employment and self-employment
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
			

