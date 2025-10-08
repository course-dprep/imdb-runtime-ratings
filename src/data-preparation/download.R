
###REQUIRED PACKAGES 
library(fs)
library(data.table)
library(here)

# Create folders (in main repo)
fs::dir_create(here::here("gen", "temp"))

### DATA PULLING SCRIPT

base_url <- "https://datasets.imdbws.com/"                 # Base URL for IMDb datasets
files <- c("title.basics.tsv.gz", "title.ratings.tsv.gz")  # The two datasets we want to download

# Set up output directory (for raw IMDb downloads)
fs::dir_create(out_dir)             # Create the directory if it doesn't already exist
out_dir <- here::here("data")       # store downloads in /data

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

dir_create(here("gen", "temp"))
write.csv(basics,  here("gen", "temp", "basics.csv"),  row.names = FALSE)
write.csv(ratings, here("gen", "temp", "ratings.csv"), row.names = FALSE)

message("Data preparation complete. Files saved in folder: ", here::here("gen", "temp"))