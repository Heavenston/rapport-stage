OUT_FILE = out/main.pdf
PRESENTATION_FILE = out/presentation.pdf
INDEX_FILE = out/index.html
LATEX_FILES := $(shell find src -name '*.tex')
PRESENTATION_FILES := $(shell find src-presentation -name '*.tex')

all: ${OUT_FILE} ${PRESENTATION_FILE} ${INDEX_FILE}
DEFAULT: all

${OUT_FILE}: ${LATEX_FILES}
	mkdir -p out
	[ -f ${OUT_FILE} ] || pdflatex -output-directory=out -interaction=nonstopmode src/main.tex
	pdflatex -output-directory=out -interaction=nonstopmode src/main.tex

${PRESENTATION_FILE}: ${PRESENTATION_FILES}
	mkdir -p out
	cd src-presentation && [ -f ../out/presentation.pdf ] || pdflatex -output-directory=../out -interaction=nonstopmode presentation-simple.tex
	cd src-presentation && pdflatex -output-directory=../out -interaction=nonstopmode presentation-simple.tex
	cd out && mv presentation-simple.pdf presentation.pdf

${INDEX_FILE}: ${OUT_FILE} ${PRESENTATION_FILE}
	@echo '<!DOCTYPE html>' > ${INDEX_FILE}
	@echo '<html lang="fr">' >> ${INDEX_FILE}
	@echo '<head>' >> ${INDEX_FILE}
	@echo '    <meta charset="UTF-8">' >> ${INDEX_FILE}
	@echo '    <meta name="viewport" content="width=device-width, initial-scale=1.0">' >> ${INDEX_FILE}
	@echo '    <title>Rapport de Stage - Malo Legendre-Lemaire</title>' >> ${INDEX_FILE}
	@echo '    <style>' >> ${INDEX_FILE}
	@echo '        body { font-family: Arial, sans-serif; max-width: 800px; margin: 0 auto; padding: 20px; background-color: #f5f5f5; }' >> ${INDEX_FILE}
	@echo '        .container { background: white; padding: 30px; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }' >> ${INDEX_FILE}
	@echo '        h1 { color: #2c3e50; text-align: center; margin-bottom: 30px; }' >> ${INDEX_FILE}
	@echo '        .file-list { display: grid; gap: 20px; }' >> ${INDEX_FILE}
	@echo '        .file-item { background: #ecf0f1; padding: 20px; border-radius: 8px; transition: background 0.3s; }' >> ${INDEX_FILE}
	@echo '        .file-item:hover { background: #d5dbdb; }' >> ${INDEX_FILE}
	@echo '        .file-item h2 { margin: 0 0 10px 0; color: #34495e; }' >> ${INDEX_FILE}
	@echo '        .file-item p { margin: 0 0 15px 0; color: #7f8c8d; }' >> ${INDEX_FILE}
	@echo '        .file-item a { color: #3498db; text-decoration: none; font-weight: bold; }' >> ${INDEX_FILE}
	@echo '        .file-item a:hover { text-decoration: underline; }' >> ${INDEX_FILE}
	@echo '        .footer { text-align: center; margin-top: 30px; color: #7f8c8d; font-size: 14px; }' >> ${INDEX_FILE}
	@echo '    </style>' >> ${INDEX_FILE}
	@echo '</head>' >> ${INDEX_FILE}
	@echo '<body>' >> ${INDEX_FILE}
	@echo '    <div class="container">' >> ${INDEX_FILE}
	@echo '        <h1>Rapport de Stage - Malo Legendre-Lemaire</h1>' >> ${INDEX_FILE}
	@echo '        <p style="text-align: center; color: #7f8c8d; margin-bottom: 30px;">Stage chez Allaw - Promo 2026 EPITA</p>' >> ${INDEX_FILE}
	@echo '        <div class="file-list">' >> ${INDEX_FILE}
	@echo '            <div class="file-item">' >> ${INDEX_FILE}
	@echo '                <h2>📄 Rapport de Stage</h2>' >> ${INDEX_FILE}
	@echo '                <p>Document principal détaillant mon expérience de stage chez Allaw, startup nantaise de la Legal Tech.</p>' >> ${INDEX_FILE}
	@echo '                <a href="main.pdf" target="_blank">Télécharger le rapport (PDF)</a>' >> ${INDEX_FILE}
	@echo '            </div>' >> ${INDEX_FILE}
	@echo '            <div class="file-item">' >> ${INDEX_FILE}
	@echo '                <h2>🎤 Présentation de Stage</h2>' >> ${INDEX_FILE}
	@echo '                <p>Slideshow de présentation axé sur les aspects humains et l'"'"'expérience vécue durant le stage.</p>' >> ${INDEX_FILE}
	@echo '                <a href="presentation.pdf" target="_blank">Télécharger la présentation (PDF)</a>' >> ${INDEX_FILE}
	@echo '            </div>' >> ${INDEX_FILE}
	@echo '        </div>' >> ${INDEX_FILE}
	@echo '        <div class="footer">' >> ${INDEX_FILE}
	@echo '            <p>Généré automatiquement • EPITA Promo 2026</p>' >> ${INDEX_FILE}
	@echo '        </div>' >> ${INDEX_FILE}
	@echo '    </div>' >> ${INDEX_FILE}
	@echo '</body>' >> ${INDEX_FILE}
	@echo '</html>' >> ${INDEX_FILE}

open: ${OUT_FILE}
	bash -c 'atril ${OUT_FILE} &> /dev/null &'

watch:
	fd '\.tex$$' src src-presentation | entr bash -c 'clear ; make'

clean:
	rm -rf out

.PHONY: clean open watch
