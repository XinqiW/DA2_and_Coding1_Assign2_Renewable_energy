#######################
## Analysis of       ##
##  renewable energy ##
##    and            ##
##    GPD/capita     ##
##                   ##
##      NO. 2        ##
##                   ##
## Cleaning the Data ##
##                   ##
#######################

# Clear memory
rm(list=ls())

library(tidyverse)

# Call the data from github
my_url <- "https://raw.githubusercontent.com/XinqiW/DA2_and_Coding1_Assign2_Renewable_energy/main/Data/Raw/WDI_gdppc_growth.csv"
df <- read_csv( my_url )

# Read the raw files
# my_path <- "/Users/xinqi/Desktop/Data Analysis 2/Assignment_2/Data/"
# df <- read_csv(paste0(my_path,'Raw/WDI_gdppc_growth.csv'))



## Check the observations:
#   Lot of grouping observations
#     usually contains a number
d1 <- df %>% filter(grepl("[[:digit:]]", df$iso2c))
d1
# Filter these out
df <- df %>% filter( !grepl("[[:digit:]]", df$iso2c) )

# 1st drop specific values
drop_id <- c("EU","HK","OE")
# Check for filtering
df %>% filter( grepl( paste( drop_id , collapse="|"), df$iso2c ) ) 
# Save the opposite
df <- df %>% filter( !grepl( paste( drop_id , collapse="|"), df$iso2c ) ) 

# 2nd drop values with certain starting char
# Get the first letter from iso2c
fl_iso2c <- substr(df$iso2c, 1, 1)
retain_id <- c("XK","ZA","ZM","ZW")
# Check
d1 <- df %>% filter( grepl( "X", fl_iso2c ) | grepl( "Z", fl_iso2c ) & 
                       !grepl( paste( retain_id , collapse="|"), df$iso2c ) ) 
# Save observations which are the opposite (use of !)
df <- df %>% filter( !( grepl( "X", fl_iso2c ) | grepl( "Z", fl_iso2c ) & 
                          !grepl( paste( retain_id , collapse="|"), df$iso2c ) ) ) 

# Check for missing observations
m <- df %>% filter( !complete.cases( df ) )
# Drop if any variables are missing -> if not complete case except iso2c
df <- df %>% filter( complete.cases( df ) | is.na( df$iso2c ) )

# Rename columns 
df <- df %>% rename(renewable_eng = EG.FEC.RNEW.ZS,
                    gdppc_growth = NY.GDP.PCAP.KD.ZG,
                    capital_formation = NE.GDI.TOTL.KD.ZG,
                    pop_growth = SP.POP.GROW,
                    trade = NE.TRD.GNFS.ZS)

# Drop any unnecessary columns
df <- select(df, -c(X1,iso2c,year))


###
# Check for extreme values
# all HISTOGRAMS
df %>%
  keep(is.numeric) %>% 
  gather() %>% 
  ggplot(aes(value)) +
  facet_wrap(~key, scales = "free") +
  geom_histogram()

# Check for summary as well
summary( df )

# Save the raw data file
my_path <- "/Users/xinqi/Desktop/Data Analysis 2/Assignment_2/Data/"
write_csv( df, paste0(my_path,'Clean/WDI_gdppc_growth_clean.csv'))
