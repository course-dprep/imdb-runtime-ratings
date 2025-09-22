###INSTALLING NECESSARY PACKAGES 

install.packages("dplyr")
install.packages("readr")
install.packages("fs")
install.packages("data.table")
install.packages("R.utils")
install.packages("stringr")
install.packages("ggplot2")
install.packages("forcats")
install.packages("tidyr")
install.packages("tinytex")
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

###DATA PULLING SCRIPT

base_url <- "https://datasets.imdbws.com/"                 # Base URL for IMDb datasets
files <- c("title.basics.tsv.gz", "title.ratings.tsv.gz")  # The two datasets we want to download

# Set up output directory 
out_dir <- "data/imdb"              # Folder to store the downloaded files
dir_create(out_dir)                 # Create the directory if it doesn't already exist

# Download IMDb files if not already present locally
for (f in files) {
  dest <- file.path(out_dir, f)           # Full local path for each file
  if (!file_exists(dest)) {               # Only download if file is missing
    download.file(paste0(base_url, f),    # Construct the full URL
                  destfile = dest,                      # Where to save it locally
                  mode = "wb",                          # Write in binary mode (important for .gz files)
                  quiet = TRUE)                         # Suppress download messages
    
  }
}

# Load IMDb datasets into R
# fread() from data.table is used for fast reading of large .tsv files

basics   <- fread(file.path(out_dir, "title.basics.tsv.gz"),
                  sep = "\t", na.strings = "\\N", quote = "")
ratings  <- fread(file.path(out_dir, "title.ratings.tsv.gz"),
                  sep = "\t", na.strings = "\\N", quote = "")