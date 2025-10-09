.PHONY: all install clean

# 0) Run everything (to ROOT/gen/output/final_dataset.csv)
all: ../../gen/output/final_dataset.csv

install:
	Rscript install_packages_for_data_preparation.R

# 1) download → ROOT/gen/temp/*
../../gen/temp/basics.csv ../../gen/temp/ratings.csv: download.R | install
	mkdir -p ../../gen/temp
	Rscript download.R

# 2) clean & merge → ROOT/gen/output/final_dataset.csv
../../gen/output/final_dataset.csv: clean_and_merge.R ../../gen/temp/basics.csv ../../gen/temp/ratings.csv | install
	mkdir -p ../../gen/output
	Rscript clean_and_merge.R

clean:
	rm -f ../../gen/temp/basics.csv \
	      ../../gen/temp/ratings.csv \
	      ../../gen/output/final_dataset.csv
	     




