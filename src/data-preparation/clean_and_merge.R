# Set CRAN mirror
options(repos = c(CRAN = "https://cloud.r-project.org"))


###REQUIRED PACKAGES
install.packages("stringr")
install.packages("readr")
library(dplyr)
library(stringr)
library(readr)

basics  <- read.csv("gen-data/basics.csv")
ratings <- read.csv("gen-data/ratings.csv")

# Convert columns stored as character to numeric for easier analysis
basics$startYear <- as.numeric(basics$startYear)
basics$runtimeMinutes <- as.numeric(basics$runtimeMinutes)

# Selecting Only Relevant Columns from DataSet
basics <- basics %>%
  select(
    tconst,           # Unique title identifier (key for merging)
    titleType,        # Type of the title (movie, short, tvSeries, etc.)
    primaryTitle,     # Main title
    startYear,        # Release year
    runtimeMinutes,   # Duration in minutes
    genres            # List of genres
  ) %>%
  filter(
    titleType == "movie",          # Keep only feature films
    startYear >= 2011,             # Released from 2011 onwards
    startYear <= 2020              # Up to 2020
  )

###MERGING TWO DATASETS and CLEANING

merged_df <- merge(basics, ratings, by = "tconst")

# Creating New Columns for Better Analysis
merged_df <- merged_df %>%
  mutate(
    runtime_missing = is.na(runtimeMinutes),
    log10_numVotes = log10(numVotes)
  )

# Filtering 3 Selected Genres, RunTime and Number of Votes

merged_df <- merged_df %>%
  filter(str_detect(genres, "Comedy|Adventure|Action")) %>%
  filter(is.na(runtimeMinutes) |
           runtimeMinutes >= 30) %>%      # Keep NA run times, exclude very short films
  filter(numVotes >= 50) %>%              # Keep NA and films with few votes
  
  # Take the FIRST occurrence of one of the target genres in the string
  mutate(
    Genre = str_extract(genres, "Comedy|Adventure|Action"),
    Genre = factor(Genre, levels = c("Comedy","Adventure","Action")))


# Impute missing runtimes by Genre x YearGroup and Create RunTime Imputed Column
merged_df <- merged_df %>%
  mutate(
    year_group = case_when(
      startYear >= 2011 & startYear <= 2015 ~ "2011-2015",
      startYear >= 2016 & startYear <= 2020 ~ "2016-2020"
    )
  ) %>%
  group_by(genres, year_group) %>%
  mutate(runtimeMinutes_imputed = if_else(
    is.na(runtimeMinutes),
    median(runtimeMinutes, na.rm = TRUE),
    runtimeMinutes
  )) %>%
  ungroup()

# Compute RunTime 10 for Analysis and Remove RunTime Column
merged_df <- merged_df %>%
  mutate(Runtime10 = (runtimeMinutes_imputed - mean(runtimeMinutes_imputed, na.rm = TRUE)) / 10)

###SAVING FINAL MERGED DATASET FOR ANALYSIS

write.csv(merged_df, "gen-data/final_dataset.csv", row.names = FALSE)
