.PHONY: all data-preparation analysis report clean help

# Run everything (data-prep then analysis)
all: data-preparation analysis report

# Run the data-preparation Makefile
data-preparation:
	$(MAKE) -C src/data-preparation

# Run the analysis Makefile
analysis:
	$(MAKE) -C src/analysis
	
report:
	$(MAKE) -C src/reporting

# Clean generated files from both pipelines
clean:
	-$(MAKE) -C src/data-preparation clean
	-$(MAKE) -C src/analysis clean
	-$(MAKE) -C src/reporting