all: SPIE_2014_ebeam.pdf

%.pdf: %.tex
	pdflatex $<
	bash -c " ( grep Rerun $*.log && pdflatex $< ) || echo noRerun "
	bash -c " ( grep Rerun $*.log && pdflatex $< ) || echo noRerun "
	pdflatex $<
	bibtex SPIE_2014_ebeam
	pdflatex SPIE_2014_ebeam
	pdflatex SPIE_2014_ebeam
	mv SPIE_2014_ebeam.pdf final/
	mv SPIE_2014_ebeam.tex final/
	rm -rf *Notes.bib
	rm -rf *.log
	rm -rf *.blg
	rm -rf *.dvi
	latexdiff old/SPIE_2014_ebeam_20140616.tex final/SPIE_2014_ebeam.tex > SPIE_2014_ebeam.tex
	pdflatex SPIE_2014_ebeam
	pdflatex SPIE_2014_ebeam
	bibtex SPIE_2014_ebeam
	pdflatex SPIE_2014_ebeam
	pdflatex SPIE_2014_ebeam
	rm -rf *Notes.bib
	rm -rf *.aux
	rm -rf *.log
	rm -rf *.blg
	rm -rf *.dvi
	mv SPIE_2014_ebeam.pdf diff.pdf
	cp final/SPIE_2014_ebeam.tex .
	mv diff.pdf final/diff.pdf
