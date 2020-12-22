# DA2_and_Coding1_Assign2_Renewable_energy

This is the GitHub repo for the joint assignment for DA2 and Coding1 on the assoiation between the consumption of renewable energy and country’s economic growth in
year 2013.

The repo contains:

- **Data folder**: The clean data set is a cross-sectional data set that includes growth rate of GDP per capita (gdppc_growth_percentage),percentage of renewable 
energy consumption (percentage_renewable_eng_consmp), growth rate of gross capital formation (gross_capital_formation_percentage), growth rate of population (pop_growth_percentage), 
percentage of forest area (forest_area_percentage),and a dummy variable developed from 159 countries in year 2013.

Short explanations of variable used:

1. percentage_renewable_rng_consmp: renewable energy consumption (% of total final energy consumption)
2. gdppc_growth_percentage: GDP per capita growth (annual %)
3. gross_capital_formation_percentage: gross capital formation (annual % growth)
4. pop_growth_percentage: population growth (annual %)
5. forest_area_percentage: forest area (% of land area)
6. Developed: dummy variable, equals to 1 if country is developed, 0 otherwise.

This data set is taken from the World Bank- World Development Indicators, with the following indicator code: 
1. EG.FEC.RNEW.ZS: Renewable energy consumption
2. NY.GDP.PCAP.KD.ZG: GDP per capita growth
3. NE.GDI.TOTL.KD.ZG: Gross capital formation
4. SP.POP.GROW: Population growth
5. AG.LND.FRST.ZS: Forest area

link: https://data.worldbank.org/indicator

 
 
- **Codes folder**:The codes folder includes the following:

1. renew_energy_getdata.R: this is the R script that collects all the data used in this analysis.
2. renew_energy_clean.R: this is the R script that contains the steps of cleaning the data set before doing analysis.
3. renew_energy_analysis.R: this is the R script with all the analysis part of this project. 
4. renew_energy_analysis.Rmd: same as renew_energy_analysis.R but in .Rmd. You should be able to replicate my results by running this Rmd file.
5. Assignment_2.Rproj: Project file is also included so you should be able to open all the R scripts and Rmd file in this project. 
 
 
 
- **Docs folder**: it contains both .html and .pdf generated from .rmd.



- **Output folder**: in this folder, you can find the code generated model summary statistics table in the html format, and also a screenshot of the html result.
