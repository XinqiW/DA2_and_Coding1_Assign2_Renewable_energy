#######################
## Analysis of       ##
##  renewable energy ##
##    and            ##
##    GPD/capita     ##
##                   ##
##      NO. 1        ##
##                   ##
## Getting the Data  ##
##                   ##
#######################



# Clear memory
rm(list=ls())

# Call packages
install.packages('WDI')
library(WDI)

# Get all the data - Renewable energy consumption (% of total final energy consumption),
# GDP per capita growth (annual %), Gross capital formation (annual % growth), Population growth (annual %),
# Trade (% of GDP)
data_raw <- WDI(indicator=c('EG.FEC.RNEW.ZS','NY.GDP.PCAP.KD.ZG','NE.GDI.TOTL.KD.ZG','SP.POP.GROW','NE.TRD.GNFS.ZS'), 
                country="all", start=2013, end=2013)

# Save the raw data file
my_path <- "../Assignment_2/Data/"
write.csv(data_raw, paste0(my_path,'raw/WDI_gdppc_growth.csv'))


