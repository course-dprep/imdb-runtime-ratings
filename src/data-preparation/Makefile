.PHONY: all install clean

# 0) Run everything
all: ../gen/output/data-exploration-figures/plots.done

install:
	Rscript install_packages_for_data_preparation.R

# 1) download → ROOT/gen/temp/*
../gen/temp/basics.csv ../gen/temp/ratings.csv: download.R | install
	mkdir -p ../gen/temp
	Rscript download.R

# 2) clean & merge → ROOT/gen/output/final_dataset.csv
../gen/output/final_dataset.csv: clean_and_merge.R ../gen/temp/basics.csv ../gen/temp/ratings.csv | install
	mkdir -p ../gen/output
	Rscript clean_and_merge.R

# 3) exploration → runs once and drops a stamp
../gen/output/data-exploration-figures/plots.done: data_exploration.R ../gen/output/final_dataset.csv | install
	mkdir -p ../gen/output/data-exploration-figures
	Rscript data_exploration.R
	touch $@

clean:
	rm -f ../gen/temp/basics.csv \
	      ../gen/temp/ratings.csv \
	      ../gen/output/final_dataset.csv \
	      ../gen/output/data-exploration-figures/plots.done \
	      ../gen/output/data-exploration-figures/runtime_by_year.png \
	      ../gen/output/data-exploration-figures/runtime_by_genre.png \
	      ../gen/output/data-exploration-figures/runtime_by_vote.png \
	      ../gen/output/data-exploration-figures/runtime_by_rating.png




