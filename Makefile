OUT_FILE = out/main.pdf
LATEX_FILES := $(shell fd '\.tex$$' src)

all: ${OUT_FILE}
DEFAULT: all

${OUT_FILE}: ${LATEX_FILES}
	mkdir -p out
	pdflatex -output-directory=out -interaction=nonstopmode src/main.tex

open: ${OUT_FILE}
	bash -c 'atril ${OUT_FILE} &> /dev/null &'

clean:
	${RM} out/*.aux out/*.bit out/*.blg out/*.bbl out/*.lof out/*.log out/*.lot out/*.glo out/*.glx out/*.gxg out/*.gxs out/*.idx out/*.ilg out/*.ind out/*.out out/*.url out/*.svn out/*.toc out/*.pdf
	rmdir out

.PHONY: clean open
