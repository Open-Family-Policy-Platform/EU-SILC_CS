/* 		

identifies the NUMBER OF CHILDREN PER HOUSEHOLD

-> identify children
-> count children
-> rank household members from the youngest to the oldest

Based on Mack, A. (2016) Data Handling in EU-SILC. GESIS Papers, 2016-10.

*/


* Identify children under 18
gen child = 1 if rx010 < 18

* Count the number of children per household
egen childc = count(child), by(country hh_id)
lab var childc "Number of children <18 in HH"

* generate hhrank variable for descriptives
egen hhrank = rank(rx010), by(hh_id) unique  // hhrank == 1  (the youngest hh member) 


