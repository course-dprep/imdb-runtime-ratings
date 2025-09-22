library(dplyr)
library(readr)
library(fs)
library(data.table)
library(R.utils)
library(stringr)
library(tinytex)
library(ggplot2)
library(forcats)
library(tidyr)

# Convert columns stored as character to numeric for easier analysis
basics$startYear <- as.numeric(basics$startYear)
basics$runtimeMinutes <- as.numeric(basics$runtimeMinutes)

# Merge basics and ratings datasets on the common key "tconst"
merged_df <- merge(basics, ratings, by = "tconst")
merged_df$runtime_missing <- is.na(merged_df$runtimeMinutes) #New column called runtime_missing

