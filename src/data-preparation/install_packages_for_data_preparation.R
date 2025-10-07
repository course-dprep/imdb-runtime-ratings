here::i_am("src/data-preparation/install_packages_for_data_preparation.R")

###INSTALLING REQUIRED PACKAGES 

# Set CRAN mirror
options(repos = c(CRAN = "https://cloud.r-project.org"))

#packages for download.R

install.packages("fs")
install.packages("data.table")
install.packages("here")           ### is required for every script

#packages for clean_and_merge.R

install.packages("stringr")
install.packages("readr")
install.packages("dplyr")          ### is required for data_exploration.R as well

#packages for data_exploration.R
install.packages("tidyr")
install.packages("forcats")
install.packages("ggplot2")

