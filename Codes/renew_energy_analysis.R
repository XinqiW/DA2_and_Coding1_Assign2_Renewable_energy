#######################
## Analysis of       ##
##  renewable energy ##
##    and            ##
##    GPD/capita     ##
##                   ##
##      NO. 3        ##
##                   ##
## Analysis of       ##
#       the data     ##
##                   ##
#######################

# Clear memory
rm(list=ls())

# Packeges to use
library(tidyverse)
# For scaling ggplots
require(scales)
# Estimate piecewise linear splines
install.packages("lspline")
library(lspline)
# Estimate robust SE
install.packages("estimatr")
library(estimatr)
# Compare models with robust SE
install.packages("texreg")
library(texreg)
# For different themes
install.packages("ggthemes")
library(ggthemes)
library(gridExtra)
library(moments)
library(jtools)
library(huxtable)
library(stargazer)
library(AER)

#######################################
## 1) Call the clean data set from Github repo

my_url <-'https://raw.githubusercontent.com/XinqiW/DA2_and_Coding1_Assign2_Renewable_energy/main/Data/Clean/WDI_gdppc_growth_clean.csv'
df <- read.csv( my_url )


########################################
## 2) Histogram check all the variables

# Renewable energy consumption (%)
Energy_hist <-  df %>% ggplot() +
  geom_histogram(aes(x = renewable_eng), fill = "orange"
                 ,  alpha = 0.5, bins = 50) +
  labs(x = "Renewable energy consumption (% of total final energy consumption)",
       y = "") +
  theme_bw() +
  theme(
    axis.title = element_text(size = 7),
    legend.background = element_rect(fill = "white", size = 4, colour = "white"),
    legend.justification = c(0, 1),
    legend.position = c(0, 1),
    axis.ticks = element_line(colour = "grey70", size = 0.2),
    panel.grid.major = element_line(colour = "grey70", size = 0.2),
    panel.grid.minor = element_blank()
  )


# GDP per capita growth (annual %)
GDPPC_hist <-  df %>% ggplot() +
  geom_histogram(aes(x = gdppc_growth), fill = "darkgreen"
                 , alpha = 0.5,  bins = 50) +
  labs(x = "GDP per capita growth (annual %)",
       y = "") +
  theme_bw() +
  theme(
    axis.title = element_text(size = 7),
    legend.background = element_rect(fill = "white", size = 4, colour = "white"),
    legend.justification = c(0, 1),
    legend.position = c(0, 1),
    axis.ticks = element_line(colour = "grey70", size = 0.2),
    panel.grid.major = element_line(colour = "grey70", size = 0.2),
    panel.grid.minor = element_blank()
  )


# Gross capital formation (annual % growth)
Capital_hist <-  df %>% ggplot() +
  geom_histogram(aes(x = capital_formation), fill = "dodgerblue3"
                 , alpha = 0.5,  bins = 50) +
  labs(x = "Gross capital formation (annual % growth)",
       y = "") +
  theme_bw() +
  theme(
    axis.title = element_text(size = 7),
    legend.background = element_rect(fill = "white", size = 4, colour = "white"),
    legend.justification = c(0, 1),
    legend.position = c(0, 1),
    axis.ticks = element_line(colour = "grey70", size = 0.2),
    panel.grid.major = element_line(colour = "grey70", size = 0.2),
    panel.grid.minor = element_blank()
  )


# Population growth (annual %)
Population_hist <-  df %>% ggplot() +
  geom_histogram(aes(x = pop_growth), fill = "chocolate4"
                 , alpha = 0.5,  bins = 50) +
  labs(x = "Population growth (annual %)",
       y = "") +
  theme_bw() +
  theme(
    axis.title = element_text(size = 7),
    legend.background = element_rect(fill = "white", size = 4, colour = "white"),
    legend.justification = c(0, 1),
    legend.position = c(0, 1),
    axis.ticks = element_line(colour = "grey70", size = 0.2),
    panel.grid.major = element_line(colour = "grey70", size = 0.2),
    panel.grid.minor = element_blank()
  )


# Trade (% of GDP)
Trade_hist <-  df %>% ggplot() +
  geom_histogram(aes(x = trade), fill = "purple3"
                 , alpha = 0.5,  bins = 50) +
  labs(x = "Trade to GDP Ratio",
       y = "") +
  theme_bw() +
  theme(
    axis.title = element_text(size = 7),
    legend.background = element_rect(fill = "white", size = 4, colour = "white"),
    legend.justification = c(0, 1),
    legend.position = c(0, 1),
    axis.ticks = element_line(colour = "grey70", size = 0.2),
    panel.grid.major = element_line(colour = "grey70", size = 0.2),
    panel.grid.minor = element_blank()
  )

# Take Log of trade to GDP ratio
df <- df %>% mutate( ln_trade = log( trade ) )

ln_Trade_hist <-  df %>% ggplot() +
  geom_histogram(aes(x = ln_trade), fill = "yellowgreen"
                 , alpha = 0.5,  bins = 50) +
  labs(x = "Log of Trade to GDP Ratio",
       y = "") +
  theme_bw() +
  theme(
    axis.title = element_text(size = 7),
    legend.background = element_rect(fill = "white", size = 4, colour = "white"),
    legend.justification = c(0, 1),
    legend.position = c(0, 1),
    axis.ticks = element_line(colour = "grey70", size = 0.2),
    panel.grid.major = element_line(colour = "grey70", size = 0.2),
    panel.grid.minor = element_blank()
  )

################################################
## 3) Create Inputs 5 Summary Statistic Tables

Energy_stats <- df %>% summarise(
  Variable  = "Renewable energy consumption",
  Min       = round(min(renewable_eng,na.rm = T),2),
  Median    = round(median(renewable_eng,na.rm = T),2),
  Max       = round(max(renewable_eng,na.rm = T),2),
  Mean      = round(mean(renewable_eng,na.rm = T),2),
  StDev     = round(sd(renewable_eng,na.rm = T),2),
  Skewness  = round(skewness(renewable_eng, na.rm = T),2),
  Observations = nrow(df))

GDPPC_stats <-   df %>% summarise(
  Variable  = "GDP per capita growth",
  Min       = round(min(gdppc_growth,na.rm = T),2),
  Median    = round(median(gdppc_growth,na.rm = T),2),
  Max       = round(max(gdppc_growth,na.rm = T),2),
  Mean      = round(mean(gdppc_growth,na.rm = T),2),
  StDev     = round(sd(gdppc_growth,na.rm = T),2),
  Skewness  = round(skewness(gdppc_growth, na.rm = T),2),
  Observations = nrow(df))

Capital_stats <-  df %>% summarise(
  Variable  = "Gross capital formation",
  Min       = round(min(capital_formation,na.rm = T),2),
  Median    = round(median(capital_formation,na.rm = T),2),
  Max       = round(max(capital_formation,na.rm = T),2),
  Mean      = round(mean(capital_formation,na.rm = T),2),
  StDev     = round(sd(capital_formation,na.rm = T),2),
  Skewness  = round(skewness(capital_formation, na.rm = T),2),
  Observations = nrow(df))

Population_stats <-  df %>% summarise(
  Variable  = "Population growth",
  Min       = round(min(pop_growth,na.rm = T),2),
  Median    = round(median(pop_growth,na.rm = T),2),
  Max       = round(max(pop_growth,na.rm = T),2),
  Mean      = round(mean(pop_growth,na.rm = T),2),
  StDev     = round(sd(pop_growth,na.rm = T),2),
  Skewness  = round(skewness(pop_growth, na.rm = T),2),
  Observations = nrow(df))

Trade_stats <-  df %>% summarise(
  Variable  = "Trade",
  Min       = round(min(trade,na.rm = T),2),
  Median    = round(median(trade,na.rm = T),2),
  Max       = round(max(trade,na.rm = T),2),
  Mean      = round(mean(trade,na.rm = T),2),
  StDev     = round(sd(trade,na.rm = T),2),
  Skewness  = round(skewness(trade, na.rm = T),2),
  Observations = nrow(df))

ln_Trade_stats <-  df %>% summarise(
  Variable  = "Log of Trade",
  Min       = round(min(ln_trade,na.rm = T),2),
  Median    = round(median(ln_trade,na.rm = T),2),
  Max       = round(max(ln_trade,na.rm = T),2),
  Mean      = round(mean(ln_trade,na.rm = T),2),
  StDev     = round(sd(ln_trade,na.rm = T),2),
  Skewness  = round(skewness(ln_trade, na.rm = T),2),
  Observations = nrow(df))

SummStats <- Energy_stats %>% add_row(GDPPC_stats) %>% add_row(Capital_stats) %>% add_row(Population_stats) %>% 
  add_row(Trade_stats) %>% add_row(ln_Trade_stats)


#######################################
## 4) Checking some scatter-plots:

# Check the pattern of association between Renewable energy consumption and GDP per capita growth

  df %>% ggplot(aes(x = renewable_eng, y = gdppc_growth)) +
  geom_point(color = "dodgerblue3") +
  geom_smooth(method = "loess", color = "orange") +
  labs(title = "Lowess Estimator for Renewable energy consumption and GDP per capita growth", 
       x = "Renewable energy consumption (%)",
       y = "GDP per capita growth (annual %)") +
  theme_bw() +
  theme(
    axis.title = element_text(size = 7),
    legend.background = element_rect(fill = "white", size = 4, colour = "white"),
    legend.justification = c(0, 1),
    legend.position = c(0, 1),
    axis.ticks = element_line(colour = "grey70", size = 0.2),
    panel.grid.major = element_line(colour = "grey70", size = 0.2),
    panel.grid.minor = element_blank())

# Check the pattern of association between Capital Formation and GDP per capita growth
  
  df %>% ggplot(aes(x = capital_formation, y = gdppc_growth)) +
    geom_point(color = "dodgerblue3") +
    geom_smooth(method = "loess", color = "orange") +
    labs(title = "Lowess Estimator for Capital Formation and GDPPC growth", 
         x = "Gross capital formation (annual % growth)",
         y = "GDP per capita growth (annual %)") +
    theme_bw() +
    theme(
      plot.title = element_text(size = 8, face = "bold"),
      axis.title = element_text(size = 7),
      legend.background = element_rect(fill = "white", size = 4, colour = "white"),
      legend.justification = c(0, 1),
      legend.position = c(0, 1),
      axis.ticks = element_line(colour = "grey70", size = 0.2),
      panel.grid.major = element_line(colour = "grey70", size = 0.2),
      panel.grid.minor = element_blank())
  
# Check the pattern of association between Population Growth and GDP per capita growth
  
  df %>% ggplot(aes(x = pop_growth, y = gdppc_growth)) +
    geom_point(color = "dodgerblue3") +
    geom_smooth(method = "loess", color = "orange") +
    labs(title = "Lowess Estimator for Population Growth and GDPPC growth", 
         x = "Population growth (annual %)",
         y = "GDP per capita growth (annual %)") +
    theme_bw() +
    theme(
      plot.title = element_text(size = 8, face = "bold"),
      axis.title = element_text(size = 7),
      legend.background = element_rect(fill = "white", size = 4, colour = "white"),
      legend.justification = c(0, 1),
      legend.position = c(0, 1),
      axis.ticks = element_line(colour = "grey70", size = 0.2),
      panel.grid.major = element_line(colour = "grey70", size = 0.2),
      panel.grid.minor = element_blank())
  
# Check the pattern of association between Log of Trade to GDP Ratio and GDP per capita growth
  
  df %>% ggplot(aes(x = ln_trade, y = gdppc_growth)) +
    geom_point(color = "dodgerblue3") +
    geom_smooth(method = "loess", color = "orange") +
    labs(title = "Lowess Estimator for log of trade and GDPPC growth", 
         x = "Log of Trade to GDP Ratio",
         y = "GDP per capita growth (annual %)") +
    theme_bw() +
    theme(
      plot.title = element_text(size = 8, face = "bold"),
      axis.title = element_text(size = 7),
      legend.background = element_rect(fill = "white", size = 4, colour = "white"),
      legend.justification = c(0, 1),
      legend.position = c(0, 1),
      axis.ticks = element_line(colour = "grey70", size = 0.2),
      panel.grid.major = element_line(colour = "grey70", size = 0.2),
      panel.grid.minor = element_blank())
  
# Check the pattern of association between Dummy Developed and GDP per capita growth
  
  df %>% ggplot(aes(x = developed, y = gdppc_growth)) +
    geom_point(color = "dodgerblue3") +
    geom_smooth(method = "loess", color = "orange") +
    labs(title = "Lowess Estimator for Developed and GDPPC growth", 
         x = "Dummy Developed",
         y = "GDP per capita growth (annual %)") +
    theme_bw() +
    theme(
      plot.title = element_text(size = 8, face = "bold"),
      axis.title = element_text(size = 7),
      legend.background = element_rect(fill = "white", size = 4, colour = "white"),
      legend.justification = c(0, 1),
      legend.position = c(0, 1),
      axis.ticks = element_line(colour = "grey70", size = 0.2),
      panel.grid.major = element_line(colour = "grey70", size = 0.2),
      panel.grid.minor = element_blank())

  
##########################################
## 5) Comparing explanatory variables 
#
# Check the correlations
#
  numeric_df <- keep( df , is.numeric )
  cT <- cor(numeric_df , use = "complete.obs")
  
  # Check for highly correlated values:
  sum( abs(cT) >= 0.8 & cT != 1 ) / 2
  # Find the correlations which are higher than 0.8
  id_cr <- which( abs(cT) >= 0.8 & cT != 1 )
  pair_names <- expand.grid( variable.names(numeric_df) , variable.names(numeric_df) )
  # Get the pairs:
  high_corr <- pair_names[ id_cr , ]
  high_corr <- mutate( high_corr , corr_val = cT[ id_cr ] )
  high_corr
  
  # Remove the un-needed variables
  rm( numeric_df, id_cr, pair_names )
  
  correlation.matrix <- cor(df[,c("developed","renewable_eng","gdppc_growth","capital_formation","pop_growth","ln_trade")])

############################
  # 6) Modelling
  #
  # Main regression: gdppc_growth = b0 + b1*renewable_eng
  #   reg1: NO controls, simple linear
  #   reg2: NO controls, use piecewise linear spline (P.L.S) with a knot at 25
  # Use reg2 and control for:
  #   reg3: developed dummy
  #   reg4: reg3 + capital_formation (lunch with P.L.S, knot: 25; and ln_trade)
  #   reg5: reg4 + pop_growth 
  
  # reg1: NO control, simple linear regression
  reg1 <- lm_robust( gdppc_growth ~ renewable_eng , data = df )
  summary( reg1 )
  
  # reg2: NO controls, use piecewise linear spline(P.L.S) with a knot at 25
  reg2 <- lm_robust( gdppc_growth ~ lspline( renewable_eng , 25 ) , data = df )
  summary( reg2 )
  
  # Extra for reg2: 
  # Now, use interactions for renewable_eng: let a dummy be: renewable_eng > 25, 
  #     and add their interaction as well
  # How it is different from P.L.S? Is the parameter of interest statistically different? 
  # Hint: use 2*Std.Error or CI Lower and CI Upper for comparing intervals!
  reg21 <- lm_robust( gdppc_growth ~ renewable_eng + (renewable_eng > 25) + renewable_eng*(renewable_eng > 25) , data = df )
  summary( reg21 )
  

  
  ###
  # Models with controls:
  #
  # reg3: control for developed country dummy (developed) only. 
  #   Is your parameter different? Is it a confounder?
  
  reg3 <- lm_robust( gdppc_growth ~ lspline( renewable_eng , 25 ) + developed, data = df )
  summary( reg3 )
  
  # Extra for reg3
  # You may wonder: what if the renewable energy consumption is different for those countries, 

  # We can test this hypothesis! use interactions!
  reg31 <- lm_robust( gdppc_growth ~ lspline( renewable_eng , 25 ) + developed +
                        lspline( renewable_eng , 25 ) * developed, data = df )
  summary( reg31 )
  
  # You can look at Pr(>|t|) to check if they are zero or
  # you can use 'linearHypothesis' to test whether these coefficients are zero simultaneously:
  #   in this case you have to use c("beta1=0,beta2=0") format!
  linearHypothesis( reg31 , c("lspline(renewable_eng, 25)1:developed = 0",
                              "lspline(renewable_eng, 25)2:developed = 0") )
  
  
  ##
  # reg4: reg3 + Gross Capital Fomration (with P.L.S, knot: 25; and ln_trade)
  reg4 <- lm_robust( gdppc_growth ~ lspline( renewable_eng , 25 ) + developed 
                     + lspline(capital_formation,25) + ln_trade , data = df )
  summary( reg4 )
  
  linearHypothesis( reg4 , c("lspline(renewable_eng, 25)1 = 0",
                              "lspline(renewable_eng, 25)2 = 0") )
  
  ##
  # Control for: population growth:
  #   reg5: reg4 + population growth
  #
  reg5 <- lm_robust( gdppc_growth ~ lspline( renewable_eng , 25 ) + developed
                     + lspline(capital_formation,25) + ln_trade 
                     + pop_growth , data = df )
  summary( reg5 )
  
  ##
  # Summarize our findings:
  exptbl <- export_summs(reg1, reg2,reg3,reg4,reg5,
                         model.names = c("(1)",
                                         "(2)",
                                         "(3)",
                                         "(4)",
                                         "(5)"))
  
  as_hux(exptbl) %>% set_col_width(rep(c(0.4, 0.2, 0.2, 0.2, 0.2, 0.2), 3)/3)
 
  ############################
  # 7) Robustness Check
  #
  # Call the clean data set from Github repo
  my_url2 <-'https://raw.githubusercontent.com/XinqiW/DA2_and_Coding1_Assign2_Renewable_energy/main/Data/Clean/Robustness_2014_WDI_gdppc_growth.csv'
  df2 <- read.csv( my_url2 )
  
  # Take Log of trade to GDP ratio
  df2 <- df2 %>% mutate( ln_trade = log( trade ) )
  
  # Check the pattern of association between Renewable energy consumption and GDP per capita growth
  
  df2 %>% ggplot(aes(x = renewable_eng, y = gdppc_growth)) +
    geom_point(color = "dodgerblue3") +
    geom_smooth(method = "loess", color = "orange") +
    labs(title = "Lowess Estimator for Renewable energy consumption and GDP per capita growth 2014", 
         x = "2014_Renewable energy consumption (%)",
         y = "2014_GDP per capita growth (annual %)") +
    theme_bw() +
    theme(
      axis.title = element_text(size = 7),
      legend.background = element_rect(fill = "white", size = 4, colour = "white"),
      legend.justification = c(0, 1),
      legend.position = c(0, 1),
      axis.ticks = element_line(colour = "grey70", size = 0.2),
      panel.grid.major = element_line(colour = "grey70", size = 0.2),
      panel.grid.minor = element_blank())
  
  
  # reg6: reg3 + Gross Capital Fomration (with P.L.S, knot: 25; and ln_trade) using 2014 Data
  reg6 <- lm_robust( gdppc_growth ~ lspline( renewable_eng , 25 ) + developed 
                     + lspline(capital_formation,25) + ln_trade , data = df2 )
  summary( reg6 )
  
  # Test hypothesis
  linearHypothesis( reg6 , c("lspline(renewable_eng, 25)1 = 0",
                             "lspline(renewable_eng, 25)2 = 0") )
 
  ##
  # Summarize our findings:
  exptbl2 <- export_summs(reg4,reg6,
                         model.names = c("(4)",
                                         "(6)"))
  
  as_hux(exptbl2)
  