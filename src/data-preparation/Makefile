.PHONY: all install clean

OUTPUT = ../../gen/output
TEMP   = ../../gen/temp

# 0) Run everything: data + report
all: $(OUTPUT)/final_dataset.csv $(OUTPUT)/DataExploration.html

install:
	Rscript --vanilla install_packages_for_data_preparation.R

# 1) download → ROOT/gen/temp/*
$(TEMP)/basics.csv $(TEMP)/ratings.csv: download.R | install
	mkdir -p $(TEMP)
	Rscript --vanilla download.R

# 2) clean & merge → ROOT/gen/output/final_dataset.csv
$(OUTPUT)/final_dataset.csv: clean_and_merge.R $(TEMP)/basics.csv $(TEMP)/ratings.csv | install
	mkdir -p $(OUTPUT)
	Rscript --vanilla clean_and_merge.R

# 3) render the Rmd (HTML if Pandoc; fallback to Markdown if not)
$(OUTPUT)/DataExploration.html: DataExploration.Rmd $(OUTPUT)/final_dataset.csv | install
	mkdir -p $(OUTPUT)
	Rscript --vanilla -e "if (!rmarkdown::pandoc_available()) { \
	                       message('⚠️ Pandoc not found → writing Markdown instead'); \
	                       knitr::knit('DataExploration.Rmd', output='$(OUTPUT)/DataExploration.md'); \
	                     } else { \
	                       rmarkdown::render('DataExploration.Rmd', output_format='html_document', \
	                                         output_file='$(OUTPUT)/DataExploration.html'); \
	                     }"

# 4) clean
clean:
	rm -f $(TEMP)/basics.csv \
	      $(TEMP)/ratings.csv \
	      $(OUTPUT)/final_dataset.csv \
	      $(OUTPUT)/DataExploration.html \
	      $(OUTPUT)/DataExploration.md
	     




