MAIN=report.tex
BIB=seme2014_axessim.bib

all:
	@mkdir -p tmp tmp/chapters
	@pdflatex -output-directory=tmp ${MAIN}
	@cp ../bibliography/${BIB} tmp/
	@cd tmp;\
	bibtex $(basename ${MAIN}).aux;\

clean:
	rm -rf ./tmp
