# Epiphyls prevalence
Data and code for the analyses from the study "Prevalencia de epífilos foliícolas en función del microclima y forófito en una selva tropical húmeda" submitted to Acta Botánica Mexicana.

`Code_Epiphylls_Git.R`: R master script including all steps of data handling and analyses. These steps are described below.

## Code is composed of 5 sections:
`1) Data` - Read the database.

`2) Microclimate` - Estimating microclimatic variable differences between sites.

`3) Heatmap Epiphylls dominance` - Creating a Heatmap to visualize the dominance of each epiphyll between microsites and host species.

`4) Microclimate vs host` - Statistical analyses to evaluate differences between groups. 

`5) Outputs` - Exporting Figures and Results (lines 116 - 144): This section exports tables and final figures used for the manuscript. 

## Structure of the Data Folder:
`Data`: This folder contains all files used in the study
`Data/Inputs`: Contains the database ("Data_Epiphylls.csv")
`Data/Outputs`: Cointains the results of statistical analyses and plots:
<br />
  -Fig. 4 - PCA: PCA plot (.pdf), <br />
  -Fig. 5 - Heatmap: Heatmap plot (.pdf), <br />
  -Fig. 6 - Stats_Algas: Boxplots for algae (.pdf), <br />
  -Fig. 6 - Stats_Hepaticas: Boxplots for Liverworts (.pdf), <br />
  -Fig. 6 - Stats_Liquen_Hepatica: Boxplots for L + H (.pdf), <br />
  -Fig. 6 - Stats_Liquen_Hepatica_Alga: Boxplots for L + H + A (.pdf), <br />
  -Fig. 6 - Stats_Liquenes: Boxplots for Lichens (.pdf), <br />
  -meantest_DD: t-test for canopy density (.csv), <br />
  -meantest_HR: t-test for relative humidity (.csv), <br />
  -meantest_Ilum: t-test for luminity (.csv), <br />
  -meantest_Temp: t-test for temperature (.csv), <br />
  -Stats_Algas: t-test for algae prevalence (.csv), <br />
  -Stats_Hepaticas: t-test for liverworts prevalence (.csv), <br />
  -Stats_Liquen_Hepatica: t-test for L+H prevalence (.csv), <br />
  -Stats_Liquen_Hepatica_Alga: t-test for L+H+A prevalence (csv), <br />
  -Stats_Liquenes: t-test for Lichens prevalence (csv), <br />

## Contact
alexvilla5920@gmail.com
