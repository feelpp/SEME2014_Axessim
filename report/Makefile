MAIN=report.tex
BIB=seme2014_axessim.bib

all:
	@mkdir -p tmp tmp/chapters
	@cp ../bibliography/${BIB} tmp/
	@cp ../styles/elsarticle.cls tmp/
	@cp ../styles/elsarticle-num.bst tmp/
	@pdflatex -output-directory=tmp ${MAIN}
	@cd tmp;\
	bibtex $(basename ${MAIN}).aux;

clean:
	rm -rf ./tmp
