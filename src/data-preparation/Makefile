.PHONY: all install clean

OUTPUT = ../../gen/output
TEMP = ../../gen/temp
# 0) Run everything (to ROOT/gen/output/final_dataset.csv)
all: $(OUTPUT)/final_dataset.csv

install:
	Rscript install_packages_for_data_preparation.R

# 1) download → ROOT/gen/temp/*
$(TEMP)/basics.csv $(TEMP)/ratings.csv: download.R | install
	mkdir -p $(TEMP)
	Rscript download.R

# 2) clean & merge → ROOT/gen/output/final_dataset.csv
$(OUTPUT)/final_dataset.csv: clean_and_merge.R $(TEMP)/basics.csv $(TEMP)/ratings.csv | install
	mkdir -p $(OUTPUT)
	Rscript clean_and_merge.R

clean:
	rm -f $(TEMP)/basics.csv \
	      $(TEMP)/ratings.csv \
	      $(OUTPUT)/final_dataset.csv
	     




