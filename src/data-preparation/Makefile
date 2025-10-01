# Final target: cleaned and merged dataset
all: gen_data/final_dataset.csv

# Step 1: Download data (creates basics.csv and ratings.csv in gen_data/)
gen_data/basics.csv gen_data/ratings.csv: download.R
	Rscript download.R

# Step 2: Clean and merge datasets (depends on downloaded CSVs)
gen_data/final_dataset.csv: clean_and_merge.R gen_data/basics.csv gen_data/ratings.csv
	Rscript clean_and_merge.R

# Optional Step 3: Data exploration (adjust paths if needed)
.PHONY: explore
results/exploration.png: ../analysis/data\ exploration.R gen_data/final_dataset.csv
	cd ../analysis && Rscript "data exploration.R"

# Utility to clean all generated files
clean:
	rm -f gen_data/basics.csv \
	      gen_data/ratings.csv \
	      gen_data/final_dataset.csv \
	      ../results/*.png

