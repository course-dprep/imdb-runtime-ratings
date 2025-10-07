# Makefile for data-preparation (run from src/data-preparation)

.PHONY: all install clean

# run everything (install → download → clean/merge → explore)
all: \
  ../gen/output/data-exploration-figures/runtime_by_year.png \
  ../gen/output/data-exploration-figures/runtime_by_genre.png \
  ../gen/output/data-exploration-figures/runtime_by_vote.png \
  ../gen/output/data-exploration-figures/runtime_by_rating.png

install:
	Rscript install_packages_for_data_preparation.R

# Step 1: download → ROOT/gen/temp/*
../gen/temp/basics.csv ../gen/temp/ratings.csv: download.R | install
	mkdir -p ../gen/temp
	Rscript download.R

# Step 2: clean & merge → ROOT/gen/output/final_dataset.csv
../gen/output/final_dataset.csv: clean_and_merge.R ../gen/temp/basics.csv ../gen/temp/ratings.csv | install
	mkdir -p ../gen/output
	Rscript clean_and_merge.R

# Step 3: exploration → ROOT/gen/output/data-exploration-figures/*.png
../gen/output/data-exploration-figures/runtime_by_year.png \
../gen/output/data-exploration-figures/runtime_by_genre.png \
../gen/output/data-exploration-figures/runtime_by_vote.png \
../gen/output/data-exploration-figures/runtime_by_rating.png: data_exploration.R ../gen/output/final_dataset.csv | install
	mkdir -p ../gen/output/data-exploration-figures
	Rscript data_exploration.R

clean:
	rm -f ../gen/temp/basics.csv \
	      ../gen/temp/ratings.csv \
	      ../gen/output/final_dataset.csv \
	      ../gen/output/data-exploration-figures/runtime_by_year.png \
	      ../gen/output/data-exploration-figures/runtime_by_genre.png \
	      ../gen/output/data-exploration-figures/runtime_by_vote.png \
	      ../gen/output/data-exploration-figures/runtime_by_rating.png




