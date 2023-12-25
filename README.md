# PCDE
Parameter Combination Driven Estimation

## 1. Installation of Prerequisite Software.
- GPUfit ( https://github.com/gpufit/Gpufit )
(Ref.: Przybylski A, Thiel B, Keller-Findeisen J, Stock B, Bates M. Gpufit: An open-source toolkit for GPU-accelerated curve fitting. Sci Rep. 2017 Nov 16;7(1):15722. doi: 10.1038/s41598-017-15313-9. PMID: 29146965; PMCID: PMC5691161.)
- PETSTEP ( https://github.com/CRossSchmidtlein/PETSTEP )
(Ref.: Berthon B, Häggström I, Apte A, Beattie BJ, Kirov AS, Humm JL, Marshall C, Spezi E, Larsson A, Schmidtlein CR. PETSTEP: Generation of synthetic PET lesions for fast evaluation of segmentation methods. Phys Med. 2015 Dec;31(8):969-980. doi: 10.1016/j.ejmp.2015.07.139. Epub 2015 Aug 28. PMID: 26321409; PMCID: PMC4888783.)
- dPETSTEP ( https://github.com/CRossSchmidtlein/dPETSTEP )
(Ref.: Häggström I, Beattie BJ, Schmidtlein CR. Dynamic PET simulator via tomographic emission projection for kinetic modeling and parametric image studies. Med Phys. 2016 Jun;43(6):3104-3116. doi: 10.1118/1.4950883. PMID: 27277057; PMCID: PMC4884183.)
- XCAT ( https://cvit.duke.edu/resource/xcat-phantom-program )
(Ref.: Segars WP, Sturgeon G, Mendonca S, Grimes J, Tsui BM. 4D XCAT phantom for multimodality imaging research. Med Phys. 2010 Sep;37(9):4902-15. doi: 10.1118/1.3480985. PMID: 20964209; PMCID: PMC2941518.)

## 2. Installation of PCDE.
- Copy the CUDA files (folder: “CUDA_Customized”) and Paste to the GPUfit setup folder.
- Adding the Two folders (folder: “Gen_Dynamic”, “Kinetic_Modeling”) as MATLAB Search Path.

## 3. Generation of Virtual Phantom Images (i.e., noise free) via XCAT software.
- Please refer to the sample XCAT input files in the folder “XCAT_sample”.
- Regarding how to use XCAT, please refer to the XCAT manual.

## 4. Generation of Virtual Dynamic Datasets (i.e., noisy) via dPETSTEP.
- Please refer to the MATLAB files in the folder “Gen_Dynamic”.
- Use/Modify “XCAT_Read.mat” and “XCAT_to_dPETSTEP_main.mat” to convert XCAT binary files into the required input for dPETSTEP.
- Use/Modify the “XCAT_Recon_DPETSTEP.mat” to generate Noisy Dynamic Datasets.

## 5. Kinetic Modeling.
- Please refer to the MATLAB files in the folder “Kinetic_Modeling”.
- Use/Modify the “XCAT_KM_main_Multi.mat” to perform kinetic modeling via PGA, 2TCM, and PCDE.

## 6. Contact
- If you may have some questions, Please Feel Free to email me (i.e., leeronaldo001@gmail.com).


