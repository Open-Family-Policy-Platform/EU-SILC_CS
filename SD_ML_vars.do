/* 

Creates MATERNITY LEAVE variables 

*/

gen ml_eli = . 		// eligibility for ML
lab var ml_eli "ML eligibility"
lab def ml_elil 0 "not eligible" 1 "eligible"
lab val ml_eli ml_elil

gen ml_dur1 = . 	// prenatal ML duration (compulsory, weeks)
lab var ml_dur1 "Prenatal ML duration (weeks)"

gen ml_dur2 = . 	// postnatal ML duration (maximum, weeks)
lab var ml_dur2 "Postnatal ML duration (weeks)"



gen ml_ben1 = . 	// average monthly ML benefit 
lab var ml_ben1 "ML benefit: average"

gen ml_ben2 = . 	// monthly ML benefit, 1st month
lab var ml_ben2 "ML benefit: 1st month"



