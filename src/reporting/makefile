.PHONY: all report

# change this if your file is named Paper.Rmd
RMD     := report.Rmd
OUTDIR  := ../../gen/output/reporting
HTML    := $(OUTDIR)/report.html

all: report
report: $(HTML)

$(HTML): $(RMD)
	# ensure output dir exists
	mkdir -p "$(OUTDIR)"
	# render Rmd -> HTML (force HTML regardless of YAML)
	Rscript -e "rmarkdown::render('$(RMD)', \
	  output_format='html_document', \
	  output_file=normalizePath('$(HTML)', winslash='/', mustWork=FALSE), \
	  envir=new.env())"