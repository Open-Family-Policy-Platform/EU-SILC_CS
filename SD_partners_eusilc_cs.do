/* 			*** PARTNER DATASETS ***

-> create dataset of male partners
-> create dataset of female partners
-> merge with the master data file 				

*/


use eusilc_cs.dta, clear 

*** MALE PARTNERS ***

* delete single and missing values
keep if parstat == 2

* delete women
drop if gender == 1

* delete observations with missing values on partner_id
drop if partner_id == "."


rename gender p_gender
rename earning p_earning
rename rx010 p_age
rename econ_status p_econ_status
rename estatus* p_estatus*

gen partner_id_new = person_id
gen person_id_new = partner_id

drop partner_id person_id

rename partner_id_new partner_id
rename person_id_new person_id

* partner's duration of employment
egen p_duremp = anycount(p_estatus*), values(1) // own calculation depending on the dataset; in months

* duration of partner's self-employment 
egen p_dursemp = anycount(p_estatus*), values(2)	

* collapse earning from employment and self-employment
gen p_earning_yg = py010g + py050g 	


keep year country hh_id person_id partner_id p_gender p_earning p_age ///
 p_econ_status p_estatus* p_duremp p_dursemp p_earning_yg 

save eusilc_fempartner.dta, replace



*** FEMALE PARTNERS ***

use eusilc_cs.dta, clear

* delete single and missing values
keep if parstat == 2

* delete women
drop if gender == 2

* delete observations with missing values on partner_id
drop if partner_id == "."


rename gender p_gender
rename earning p_earning
rename rx010 p_age
rename econ_status p_econ_status
rename estatus* p_estatus*

gen partner_id_new = person_id
gen person_id_new = partner_id

drop partner_id person_id

rename partner_id_new partner_id
rename person_id_new person_id


* partner's duration of employment
egen p_duremp = anycount(p_estatus*), values(1) // own calculation depending on the dataset; in months

* duration of partner's self-employment 
egen p_dursemp = anycount(p_estatus*), values(2)	

* collapse earning from employment and self-employment
gen p_earning_yg = py010g + py050g 	


keep year country hh_id person_id partner_id p_gender p_earning p_age ///
p_econ_status p_estatus* p_duremp p_dursemp p_earning_yg 

save eusilc_malepartner.dta, replace




*** Merge with the main dataset ***

use eusilc_cs.dta, clear
drop _merge
mer 1:m person_id using eusilc_fempartner.dta 
drop _merge
save eusilc_temp, replace

duplicates tag person_id, gen(dup)
drop if dup == 1
drop dup

mer 1:m person_id using eusilc_malepartner.dta , update keep(1 3 4)
drop _merge


save eusilc_partners.dta, replace 

erase "$DATA/eusilc_fempartner.dta"
erase "$DATA/eusilc_malepartner.dta"
erase "$DATA/eusilc_temp.dta"
erase "$DATA/eusilc_cs.dta"
