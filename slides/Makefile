all:
	mkdir -p tmp
	pdflatex -output-directory=tmp core.tex

clean:
	rm -rf ./tmp

view:
	evince tmp/core.pdf
