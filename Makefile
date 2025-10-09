.PHONY: all data-preparation analysis clean help

# Run everything (data-prep then analysis)
all: data-preparation analysis

# Run the data-preparation Makefile
data-preparation:
	$(MAKE) -C src/data-preparation

# Run the analysis Makefile
analysis:
	$(MAKE) -C src/analysis

# Clean generated files from both pipelines
clean:
	-$(MAKE) -C src/data-preparation clean
	-$(MAKE) -C src/analysis clean