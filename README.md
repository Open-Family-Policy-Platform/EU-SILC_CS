# Open Family Policy Program (OFPP)

The OFPP is a coded maternity, paternity and parental leave legislation in 28 European Countries between 2010 and 2020. It was writtent to be combined with EU-SILC cross-sectional data to create a collection of policy variables: leave eligibility, leave duration, and cash benefits. For more information about the Program see **_Methodology_report_eusilc_cs_v.1.0_** file in this Repository. 

[![DOI](https://zenodo.org/badge/399796332.svg)](https://zenodo.org/badge/latestdoi/399796332)

# To run the Program:
The OFPP is assuming merged EU-SILC CS files. 

If you have your own copy of merged EU-SILC files, don't forget to change the name of the files in "MAIN_eusilc_cs" (app. line 45). Make sure that each file only contains one year and that year is included in the name of that file. This is necessary for the OFPP to function properly. 

Merge files that were used to create the **_SILC20x_ver_2021_04_** files can be found in a separately repository (EU-SILC_setup).  

When you have your EU-SILC files: 
    
    1. open **_MAIN_eusilc_cs.do_**
    
    2. add your DATA and CODE directories
    
    3. if you use your own merged EU-SILC files change the name of the file (app. line 45)
    
    4. run **_MAIN_eusilc_cs.do_**


# License 

The Open Family Policy Program is licensed under the GNU GPL3 license. For details on the condition of the license see the document LICENSE in this repository.


# Funding 

This project has received funding from the European Union’s Horizon 2020 research and innovation programme under grant agreement No 893008.

