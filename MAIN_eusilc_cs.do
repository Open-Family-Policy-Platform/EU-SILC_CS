/* 

This code runs the OPEN FAMILY POLICY PROGRAM (OFPP)

 */

 /*
*** Merge raw EU-SILC data
run "$CODE/SD_merge_eusilc_cs.do"

clear 
*/

*** Data directory
//global DATA "[enter your directory]" 

global DATA "/Users/alzbeta/Documents/Data/EU-SILC_merged" 

cd "$DATA"


*** Code directory
//global CODE "[enter your directory]" 

global CODE "/Users/alzbeta/Dropbox/WORK/Open Family Policy Platform/EU-SILC" 


use SILC2014_ver_2021_04, clear 
append using SILC2015_ver_2021_04
append using SILC2016_ver_2021_04
//append using SILC2017_ver_2021_04
append using SILC2018_ver_2021_04
append using SILC2019_ver_2021_04


*** Delete Serbia, Cyprus, Malta ***
drop if country == "RS"
drop if country == "CY"
drop if country == "MT"
drop if country == "CH"


*** Standardize country codes according to ISO 3166-1 alpha-2 ***
replace country = "GR" if country == "EL"
replace country = "GB" if country == "UK"

save eusilc_merged, replace

*** Generate unique household and personal identifiers ***
run "$CODE/SD_uid_eusilc.do"



*** Standardize variables for OFPP ***
run "$CODE/SD_standard_eusilc.do"



save eusilc_cs, replace
drop _merge


*** Assign information about partners ***
run "$CODE/SD_partners_eusilc_cs.do"




*** Delete same-sex couples *** 
drop if gender == p_gender




*** Number of children per household ***
run "$CODE/SD_nchild_eusilc_cs.do"




*** Select SAMPLE ***
run "$CODE/SD_sample_eusilc_cs.do"



* a "doorstop" before running the estimation of family policy entitlements 
save eusilc_ofpp, replace




*** Run policy coding for MATERNITY LEAVE (ML) ***

* Create ML variables
run "$CODE/SD_ML_vars.do"  

* Run ML_year_country_eusilc_cs.do 
foreach x in "AT" "BE" "BG" "CZ" "DE" "DK" "EE" "ES" "FI" "FR" "GB" "GR" "HR" "HU" "IE" "IS" "IT" "LT" "LU" "LV" "NL" "NO" "PL" "PT" "RO" "SE" "SI" "SK" {
	run "$CODE/ML_2014_`x'_eusilc_cs.do"
	run "$CODE/ML_2015_`x'_eusilc_cs.do"
	run "$CODE/ML_2016_`x'_eusilc_cs.do"
	//run "$CODE/ML_2017_`x'_eusilc_cs.do"
	run "$CODE/ML_2018_`x'_eusilc_cs.do"
	run "$CODE/ML_2019_`x'_eusilc_cs.do"
}


*** Run policy coding for PATERNITY LEAVE (PT) ***

* Create PT variables
run "$CODE/SD_PT_vars.do"

* Run PT_year_country_eusilc_cs.do
foreach x in "AT" "BE" "BG" "CZ" "DE" "DK" "EE" "ES" "FI" "FR" "GB" "GR" "HR" "HU" "IE" "IS" "IT" "LT" "LU" "LV" "NL" "NO" "PL" "PT" "RO" "SE" "SI" "SK" {
	run "$CODE/PT_2014_`x'_eusilc_cs.do"
	run "$CODE/PT_2015_`x'_eusilc_cs.do"
	run "$CODE/PT_2016_`x'_eusilc_cs.do"
	//run "$CODE/PT_2017_`x'_eusilc_cs.do"
	run "$CODE/PT_2018_`x'_eusilc_cs.do"
	run "$CODE/PT_2019_`x'_eusilc_cs.do"
}




*** Run policy coding for PARENTAL LEAVE (PL) ***

* Create PL variables
run "$CODE/SD_PL_vars.do"

* Run PL_year_country_eusilc_cs.do
foreach x in "AT" "BE" "BG" "CZ" "DE" "DK" "EE" "ES" "FI" "FR" "GB" "GR" "HR" "HU" "IE" "IS" "IT" "LT" "LU" "LV" "NL" "NO" "PL" "PT" "RO" "SE" "SI" "SK" {
	run "$CODE/PL_2014_`x'_eusilc_cs.do"
	run "$CODE/PL_2015_`x'_eusilc_cs.do"
	run "$CODE/PL_2016_`x'_eusilc_cs.do"
	//run "$CODE/PL_2017_`x'_eusilc_cs.do"
	run "$CODE/PL_2018_`x'_eusilc_cs.do"
	run "$CODE/PL_2019_`x'_eusilc_cs.do"
}


