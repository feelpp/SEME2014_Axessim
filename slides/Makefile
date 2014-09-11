MAIN=slides.tex
BIB=seme2014_axessim.bib

all:
	mkdir -p tmp
	pdflatex -output-directory=tmp ${MAIN}
	cp ${BIB} tmp/
	cd tmp;\
	bibtex $(basename ${MAIN}).aux;\

clean:
	rm -rf ./tmp
