*** FEMALE COHABITING RESPONDENTS ***

* delete single respondents
keep if parstat == 2 // keeps cohabiting respondents

* delete men
drop if gender == 2

* delete observations with missing values on partner_id
drop if partner_id == "."

* add prefix "p_"
rename gender p_gender
rename earning p_earning
rename rx010 p_age
rename econ_status p_econ_status
rename duremp p_duremp
rename dursemp p_duredu
rename duredu p_dursemp
rename unemp_dur p_unemp_dur

* rename "partner_id" variable into "person_id" for linking purposes
gen partner_id_new = person_id
gen person_id_new = partner_id

drop partner_id person_id

rename partner_id_new partner_id
rename person_id_new person_id

* keeps only crucial variables necessary for the OFPP
keep year country hh_id person_id partner_id p_gender p_earning p_age ///
p_econ_status p_duremp p_dursemp p_earning


