# Turbulent Flows: an Introduction

This GitHub webpage hosts the Data and Code supporting the end-of-chapter sample exercises for the eBook by
**Ian Castro and Christina Vanderwel, 
[_Turbulent Flows: An Introduction,_](https://www.iop.org/) IOP, 2021.**

<img src="logo.jpg" alt="Book cover" width="200" height="200" align="centre">

The examples are also used in the module <b>SESA6061 Turbulence</b> at the University of Southampton. 

Documented MATLAB codes are provided illustrating the solutions to each exercise; however, students are encouraged to try to solve the data analysis exercises on their own, before looking at the worked solutions. We hope to also provide solutions in other programming languagues such as Python in the near future. If you would like to contribute or suggest improvement, please contact the author at c.m.vanderwel@soton.ac.uk. 

All code is shared under the MIT license and you can share and adapt it freely. 

Last updated: 5 August 2021


## Sample Exercises

You may access all the [question sets](questions), [data files](data), [code](code), and [analytical solutions](solutions) directly from their associated repository folders or through the summary table below:

| Sample Exercises |	Data	| Codes	| Analytical Solutions | 
| :----------------| :---: | :----: | :------------: |
| [Ch 1. Overall Introduction](questions/Ch1Exercises.pdf)	| Ex1.1: [WindtunnelSample1.txt](data/WindtunnelSample1.txt)	| [Ex1_1Solution.m](code/Ex1_1Solution.m)	| Coming soon… | 
| Ch 2. The governing equations	| No Data Files	| No Code required	|  | 
| Ch 3. The scales of motion	| No Data Files	| No Code required	| | 
| Ch 4. Statistical functions and tools	| Ex4.3: [WindtunnelSample1.txt](data/WindtunnelSample1.txt) <br> Ex4.4: WindtunnelSample2.txt	| Ex4_3Solution.m <br> Ex4_4Solution.m <br> Ex4_6PdfCode.m <br> Ex4_7SpectraCode.m	|  | 
| [5. Canonical turbulent flows](questions/Ch5Exercises.pdf)	| Ex5.1: [HITData.txt](data/HITData.txt) <br> Ex5.2: [HSFData.txt](data/HSFData.txt) | 	[Ex5_1Solution.m](code/Ex5_1Solution.m) <br> [Ex5_2Solution.m](code/Ex5_2Solution.m)	|  | 
| [6. Free turbulent shear flows](questions/Ch6Exercises.pdf)	| Ex6.1: [MixingLayerData.txt](data/MixingLayerData.txt) <br> Ex6.2: [WakeData.txt](data/WakeData.txt) 	| [Ex6_1Solution.m](code/Ex6_1Solution.m) <br> [Ex6_2Solution.m](code/Ex6_2Solution.m)	|  | 
| [7. Internal wall-bounded flows](questions/Ch7Exercises.pdf)	| Ex7.4: [ChannelData.txt](data/ChannelData.txt) <br> Ex7.5: [PipeData.txt](data/PipeData.txt) 	| [Ex7_4Solution.m](code/Ex7_4Solution.m) <br> [Ex7_5Solution.m](code/Ex7_5Solution.m)	| | 
| [8. Internal wall-bounded flows](questions/Ch8Exercises.pdf)	| Ex8.1-8.2: [TBLData.txt](data/TBLData.txt) <br> Ex8.3: [RoughWallData.txt](data/RoughWallData.txt) | 	[Ex8_1Solution.m](code/Ex8_1Solution.m) <br> [Ex8_2Solution.m](code/Ex8_2Solution.m) <br> [Ex8_3Solution.m](code/Ex8_3Solution.m)	|  | 
| [9. Turbulent mixing](questions/Ch9Exercises.pdf) |	Ex9.4: [PlumeData1.txt](data/PlumeData1.txt) <br> and [PlumeData2.txt](data/PlumeData2.txt)	| [Ex9_4Solution.m](code/Ex9_4Solution.m)	|  | 

## Acknowledgement of Data Sources

| Exercise	| Data | Source | 
| :--------| :---: | :----: | 
| Ex1.1 and 4.3	| WindtunnelSample1.txt	| Data curtesy of Takfarinas Medjnoun acquired from the University of Southampton 3x2 windtunnel | 
| Ex4.4	| WindtunnelSample2.txt	| | 
| Ex5.1  | HITData.txt |  A.A.Wray (1997) [https://torroja.dmt.upm.es/turbdata/agard/chapter3/HOM02/CB512.f_t](https://torroja.dmt.upm.es/turbdata/agard/chapter3/HOM02/CB512.f_t) | 
| Ex5.2  | HSFData.txt |	 Tavoularis & Karnik (1989) J. Fluid Mech, 204:457–478. [https://torroja.dmt.upm.es/turbdata/agard/chapter3/HOM22/HOM22KT/](https://torroja.dmt.upm.es/turbdata/agard/chapter3/HOM22/HOM22KT/) | 
| Ex6.1  | MixingLayerData.txt | 	Delville & Bonnet (1995) [https://torroja.dmt.upm.es/turbdata/agard/chapter6/SHL04](https://torroja.dmt.upm.es/turbdata/agard/chapter6/SHL04) | 
| Ex6.2  | WakeData.txt	| Nakayama (1985) J. Fluid Mech., 160:155-179. [https://turbmodels.larc.nasa.gov/airfoilwake_val.html](https://turbmodels.larc.nasa.gov/airfoilwake_val.html) | 
| Ex7.4  | ChannelData.txt | Hoyas & Jimenez (2006) Phys. of Fluids, vol 18, 011702. [https://torroja.dmt.upm.es/channels/data/statistics/Re2000/profiles/Re2000.prof](https://torroja.dmt.upm.es/channels/data/statistics/Re2000/profiles/Re2000.prof) | 
| Ex7.5  | PipeData.txt | Zagarola & Smits (1997) Physical Review Letters, Vol. 78, No. 1, pp.239-242. [http://www.princeton.edu/~gasdyn/Superpipe_data/1.0238E+06.txt](http://www.princeton.edu/~gasdyn/Superpipe_data/1.0238E+06.txt)| 
| Ex8.1-8.2| TBLData.txt | 	Schlatter & Orlu (2010) J. Fluid Mech., 659. [https://www.mech.kth.se/~pschlatt/DATA/vel_4060_dns.prof](https://www.mech.kth.se/~pschlatt/DATA/vel_4060_dns.prof)| 
| Ex8.3  | RoughWallData.txt	| Data curtesy of Karen Flack from Flack, Schultz, Barros, & Kim (2016). International Journal of Heat and Fluid Flow, 61:21-30.| 
| Ex9.4  | PlumeData1.txt PlumeData2.txt	| Author’s own data from Vanderwel & Tavoularis (2014). J. Fluid Mech., 754:488-514. | 


## License
The code in this repository is provided under [MIT LICENSE](LICENSE) which means you are free to use, copy, and modify the content to help you learn about turbulent flows.
 
 For questions please contact
 [Christina Vanderwel](https://www.southampton.ac.uk/engineering/about/staff/cmv1n13.page).
