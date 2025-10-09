.PHONY: all install desc_analysis regression results clean

OUTPUT = ../../gen/output
DATA_PREP = ../data-preparation

# run everything here
all: results

install:
	Rscript install_packages_for_analysis.R

# final dataset produced by data-prep (note the ../../ path!)
$(OUTPUT)/final_dataset.csv:
	$(MAKE) -C $(DATA_PREP) $(OUTPUT)/final_dataset.csv

# desc analysis depends on install + the final dataset
desc_analysis: install $(OUTPUT)/final_dataset.csv
	Rscript desc_analysis.R

# produce the model file (regression.R writes $(OUTPUT)/regression_model.rds)
$(OUTPUT)/regression_model.rds: regression.R desc_analysis
	Rscript regression.R

# results depend on the model file (not the script)
results: $(OUTPUT)/regression_model.rds
	Rscript make_reg_outputs.R

clean:
	rm -f $(OUTPUT)/desc-analysis-figures/*.png || true
	rm -f $(OUTPUT)/regression_model.rds || true
