OUT_FILE = out/main.pdf
LATEX_FILES := $(shell fd '\.tex$$' src)

all: ${OUT_FILE}
DEFAULT: all

${OUT_FILE}: ${LATEX_FILES}
	mkdir -p out
	pdflatex -output-directory=out -interaction=nonstopmode src/main.tex

open: ${OUT_FILE}
	bash -c 'atril ${OUT_FILE} &> /dev/null &'

watch:
	fd '\.tex$$' src | entr bash -c 'clear ; make'

clean:
	rm -rf out

.PHONY: clean open watch
