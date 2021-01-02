# DA2_and_Coding1_Assign2_Renewable_energy

This is the GitHub repo for the joint assignment for DA2 and Coding1 on the assoiation between the consumption of renewable energy and country’s economic growth in
year 2013.

The repo contains:

- **Data folder**: 

1. The clean data set “WDI_gdppc_growth_clean” is the main data set we use in our analysis. It is a cross-sectional data set that includes growth rate of GDP per capita (gdppc_growth), percentage of renewable energy consumption (renewable_eng), growth rate of gross capital formation (capital_formation), growth rate of population (pop_growth), percentage of trade (trade), and a dummy variable developed from 161 countries in year 2013.

2. The clean data set “Robustness_2014_WDI_gdppc_growth” is also a cross-sectional data set that includes all the same variables from 160 countries in year 2014. This data set is included for robustness check.

Short explanations of variable used:

1. renewable_eng: renewable energy consumption (% of total final energy consumption)
2. gdppc_growth: GDP per capita growth (annual %)
3. capital_formation: gross capital formation (annual % growth)
4. pop_growth: population growth (annual %)
5. trade: trade (% of GDP)
6. Developed: dummy variable, equals to 1 if country is developed, 0 otherwise.

This data set is taken from the World Bank- World Development Indicators, with the following indicator code: 
1. EG.FEC.RNEW.ZS: Renewable energy consumption
2. NY.GDP.PCAP.KD.ZG: GDP per capita growth
3. NE.GDI.TOTL.KD.ZG: Gross capital formation
4. SP.POP.GROW: Population growth
5. NE.TRD.GNFS.ZS: Trade

link: https://data.worldbank.org/indicator

 
 
- **Codes folder**:The codes folder includes the following:

1. renew_energy_getdata.R: this is the R script that collects all the data used in this analysis.
2. renew_energy_clean.R: this is the R script that contains the steps of cleaning the data set before doing analysis.
3. renew_energy_analysis.R: this is the R script with all the analysis part of this project. 
4. robustness_get_clean.R: this is the R script for getting and cleaning data for 2014 for checking external validity.
5. renew_energy_analysis.Rmd: same as renew_energy_analysis.R but in .Rmd. You should be able to replicate my results by running this Rmd file.
6. Assignment_2.Rproj: Project file is also included so you should be able to open all the R scripts and Rmd file in this project. 
 
 
 
- **Docs folder**: it contains both html and pdf files generated from rmd.



