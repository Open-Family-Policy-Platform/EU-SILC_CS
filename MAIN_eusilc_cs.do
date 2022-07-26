***********************************************
*** 	OPEN FAMILY POLICY PROGRAM (OFPP) 	***
***********************************************

clear all

*** Data directory
global DATA "/Users/alzbeta/Documents/Data/EU-SILC/eusilc_merged_files" 


cd "$DATA"


*** Code directory
global CODE "/Users/alzbeta/Dropbox/WORK/Open Family Policy Platform/EU-SILC" 

*** Convert original .csv file into .dta & create labels
* !!! THE FILE SHOULD BE CALLED "SETUP" AND IT SHOULD NOT BE PART OF THIS CODE - IT SHOULD BE RUN BEFORE! => DELETE
//run "/Users/alzbeta/Dropbox/WORK/Open Family Policy Platform/eu-silc_merge/SD_merge_eusilc_cs.do"

cd "$DATA"

* !!! if you are only interested in specific years rather than the whole period 2010-2019, adjust your selection

foreach x of numlist 10/19 { // <= adjust the selection of years
	
	use SILC20`x'_ver_2021_04, clear // "ver_2021_04" corresponds with Gesis Setup Files
	
	*** Delete Serbia, Cyprus, Malta ***
	drop if country == "RS"
	drop if country == "CY"
	drop if country == "MT"
	drop if country == "CH"


	*** Standardize country codes according to ISO 3166-1 alpha-2 ***
	replace country = "GR" if country == "EL"
	replace country = "GB" if country == "UK"
	
	*** Create Unique ID's ***
	run "$CODE/SD_uid_eusilc.do"
	*** Standardize EU-SILC variables to work with OFPP
	run "$CODE/SD_standard_eusilc.do"

	save SILC20`x'_standard, replace
	
}
	

foreach x of numlist 10/19 {
	
	*** Assign information about partners ***
	
	/* 	Uses only cohabiting respondents. 
		Male and female respondents' data are turned into information about partners.
		Key variables get a prefix "p_" to indicate this is information about the respondent's partner.
		The original "partner_id" is renamed as "person_id" so the "p_" variables can be linked with 
		the cohabiting partner.
	*/
					
	use SILC20`x'_standard, clear
		*** Male partners
		run "/Users/alzbeta/Dropbox/WORK/Open Family Policy Platform/eu-silc_merge/SD_male_partners_test_optimize"
		save eusilc_malepartner_20`x'
		
	use SILC20`x'_standard, clear
		*** Female partners
		run "/Users/alzbeta/Dropbox/WORK/Open Family Policy Platform/eu-silc_merge/SD_female_partners_test_optimize"
		save eusilc_femalepartner_20`x'
}

foreach x of numlist 10/19 {	
		
		*** Merge "malepartner" and "femalepartner" with the main dataset
		/* 	This code merges the "p_" variables with the "person_id" in the "SILC20`x'_standard" datasets
		*/
			use SILC20`x'_standard, clear
			drop _merge
			mer 1:m person_id using eusilc_femalepartner_20`x'.dta 
			drop _merge
			save eusilc_`x'_temp, replace

			duplicates tag person_id, gen(dup)
			drop if dup == 1
			drop dup

			mer 1:m person_id using eusilc_malepartner_20`x'.dta  , update keep(1 3 4)
			drop _merge

			duplicates tag person_id, gen(dup)
			drop if dup == 1
		
		*** Delete same-sex couples *** 
		drop if gender == p_gender
		
		* Create dataset of respondents with key variables about their partners
		save eusilc_partners_20`x'
}

foreach x of numlist 10/19 {	
		
		use eusilc_partners_20`x'
		
		*** Select SAMPLE ***
		/* 	For the purpose of the OFPP a sample needs to be selected covering 
			the population of childbearing age. 
		*/
		run "$CODE/SD_sample_eusilc_cs.do"

		*** Number of children per household ***
		/* 	For the purpose of the OFPP - some countries provide different support 
			depending on the number of children. 
		*/
		run "$CODE/SD_nchild_eusilc_cs.do"

		save eusilc_ofpp_20`x'
 }

foreach x of numlist 10/19 {
	
	* Delete redundant files
	erase eusilc_femalepartner_20`x'.dta
	erase eusilc_malepartner_20`x'.dta
	erase eusilc_`x'_temp.dta
}


**** OFPP - the following code runs the OFPP on the selected EU-SILC sample
foreach x of numlist 10/19 {
	
	*** Create maternity, paternity and parental leave variables (empty)
	use eusilc_ofpp_20`x', clear
	run "$CODE/SD_ML_vars.do" 
	run "$CODE/SD_PT_vars.do"
	run "$CODE/SD_PL_vars.do"
	
			*** Adds values to the maternity, paternity and parental leave variables
			foreach y in "AT" "BE" "BG" "CZ" "DE" "DK" "EE" "ES" "FI" "FR" "GB" "GR" "HR" "HU" "IE" "IS" "IT" "LT" "LU" "LV" "NL" "NO" "PL" "PT" "RO" "SE" "SI" "SK" {
			
			*** MATERNITY LEAVE ***
			run "$CODE/ML_20`x'_`y'_eusilc_cs.do" 
			
			*** PATERNITY LEAVE ***
			run "$CODE/PT_20`x'_`y'_eusilc_cs.do"
			
			*** PARENTAL LEAVE ***
			run "$CODE/PL_20`x'_`y'_eusilc_cs.do"
			
			
		}	
		
		save eusilc_ofpp_20`x', replace
		
		* Delete redundant files 
		erase "$DATA/SILC20`x'_standard.dta"
		erase "$DATA/eusilc_partners_20`x'.dta"
	
}




