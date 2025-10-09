.PHONY: all install desc_analysis regression results clean

# run everything here
all: results

install:
	Rscript install_packages_for_analysis.R

# final dataset produced by data-prep (note the ../../ path!)
../../gen/output/final_dataset.csv:
	$(MAKE) -C ../data-preparation ../../gen/output/final_dataset.csv

# desc analysis depends on install + the final dataset
desc_analysis: install ../../gen/output/final_dataset.csv
	Rscript desc_analysis.R

# produce the model file (regression.R writes ../../gen/output/regression_model.rds)
../../gen/output/regression_model.rds: regression.R desc_analysis
	Rscript regression.R

# results depend on the model file (not the script)
results: ../../gen/output/regression_model.rds
	Rscript make_reg_outputs.R

clean:
	rm -f ../../gen/output/desc-analysis-figures/*.png || true
	rm -f ../../gen/output/regression_model.rds || true
