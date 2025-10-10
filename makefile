SHELL := bash
.PHONY: data-preparation analysis report

data-preparation:
	"$(MAKE)" -C src/data-preparation

analysis:
	"$(MAKE)" -C src/analysis

report:
	"$(MAKE)" -C src/reporting report
