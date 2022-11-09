# MBIH-HCOBE
A toolbox for multicenter brain images harmonization  

## Requirements
* matlab 2020a or later
* SPM12 (https://www.fil.ion.ucl.ac.uk/spm/)

## Function
Eliminate center effect and preserve biological heterogeneity in multicenter brain imaging data of healthy subjects and patients.

## Theory
When using HCOBE to harmonize the multicenter data, the COBE was firstly used to decompose inter-center data, the decomposed heterogeneity space contained biological heterogeneity and center effect. 
To precisely remove the center effect while preserving biological heterogeneity, the center effect and biological heterogeneity should be further separated. In order to do that, we further decomposed the
 intra-center data using COBE. Since intra-center data were acquired on the same scanner and acquisition protocol, the decomposed heterogeneity space only contained biological heterogeneity. Finally, we
can accurately obtain the center effect by calculating the differences between inter-center and intra-center heterogeneity space.

## Usage
   1. Please change the folder name to MBIH, then add the folder MBIH to the path of matlab, and make sure you have already install SPM12 correctly, enter.
   2. At matlab prompt: type MBIH (Menu options appear) , enter.
   3. Click 'HCOBE'.
   4. Click 'Add a New Site' and select the normalized images of a new site. If it is necessary to delete the image of last site, we can click 'Delete the Latest Site'.
   5. Select 'Reference Site'.
   6. Select brain mask or threshold (default = 0.2 for MRI; threshold mask is determined by the routine by combining individual masks determined by evaluating the lower threshold for ach image as the fraction of the volume max;)  
   7. Give a prefix of the harmonized image name (default 'h') in 'Filename Prefix'.
   8. Select the save path for harmonized images. 'Previous Dir' stands for storing in the original path; 'Custom Dir ' stands for custom save path; 'Re-Custom Dir ' stands for re-custom save path.
   9. Choose whether to keep the brain mask.
   10. Click 'Run' to start harmonizing multi-site brain images.

## Date
2022.7.27
