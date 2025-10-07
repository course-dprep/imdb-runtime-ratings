here::i_am("src/analysis/install_packages_for_analysis.R")

###INSTALLING REQUIRED PACKAGES 

# Set CRAN mirror
options(repos = c(CRAN = "https://cloud.r-project.org"))

#packages for desc_analysis.R

install.packages("dplyr")
install.packages("tidyr")
install.packages("readr")
install.packages("data.table")
install.packages("stringr")
install.packages("forcats")
install.packages("fs")
install.packages("here")
install.packages("ggplot2")
install.packages("scales")

#packages for regression.R

install.packages("sandwich")
install.packages("lmtest")
install.packages("car")
install.packages("scales")
install.packages("knitr")
install.packages("dplyr")
install.packages("tidyverse")
install.packages("stringr")

