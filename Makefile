OUT_FILE = out/main.pdf
LATEX_FILES := $(shell find src -name '*.tex')

all: ${OUT_FILE}
DEFAULT: all

${OUT_FILE}: ${LATEX_FILES}
	mkdir -p out
	[ -f ${OUT_FILE} ] || pdflatex -output-directory=out -interaction=nonstopmode src/main.tex
	pdflatex -output-directory=out -interaction=nonstopmode src/main.tex

open: ${OUT_FILE}
	bash -c 'atril ${OUT_FILE} &> /dev/null &'

watch:
	fd '\.tex$$' src | entr bash -c 'clear ; make'

clean:
	rm -rf out

.PHONY: clean open watch
