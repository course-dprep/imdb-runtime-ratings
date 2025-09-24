# Final target: cleaned and merged dataset
all: final_dataset.csv

# Step 1: Download data (creates basics.csv and ratings.csv)
basics.csv ratings.csv: download.R
	Rscript download.R

# Step 2: Clean and merge datasets (depends on basics.csv and ratings.csv)
final_dataset.csv: clean_and_merge.R basics.csv ratings.csv
	Rscript clean_and_merge.R

# Optional Step 3: Data exploration
.PHONY: explore
explore: results/exploration.png

results/exploration.png: data\ exploration.R final_dataset.csv
	Rscript "data exploration.R"

# Utility to clean all generated files
clean:
	rm -f basics.csv ratings.csv final_dataset.csv results/*.png
