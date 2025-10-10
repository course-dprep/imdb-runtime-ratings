.PHONY: all data-preparation analysis report clean
SHELL := bash

# Default: run everything
all: data-preparation analysis report

# 1) data-prep
data-preparation:
	"$(MAKE)" -C src/data-preparation

# 2) analysis (runs after data-prep)
analysis: data-preparation
	"$(MAKE)" -C src/analysis

# 3) reporting (runs after analysis)
report: analysis
	"$(MAKE)" -C src/reporting report   # specify 'report' target in sub-Makefile
                                        # (or ensure that sub-Makefile has `all: report`)

# Clean all
clean:
	-"$(MAKE)" -C src/data-preparation clean
	-"$(MAKE)" -C src/analysis clean
	-"$(MAKE)" -C src/reporting clean
