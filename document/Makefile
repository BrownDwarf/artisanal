all: ms.pdf

%.pdf: %.tex
	pdflatex $<
	bash -c " ( grep Rerun $*.log && pdflatex $< ) || echo noRerun "
	bash -c " ( grep Rerun $*.log && pdflatex $< ) || echo noRerun "
	pdflatex $<
	bibtex ms
	pdflatex ms
	pdflatex ms
	git show HEAD~1:ms.tex >> ms_diff.tex
	mv ms.pdf final/
	mv ms.tex final/
	rm -rf *Notes.bib
	rm -rf *.log
	rm -rf *.blg
	rm -rf *.dvi
	git show HEAD~1:ms.tex >> ms_diff.tex
	latexdiff ms_diff.tex final/ms.tex > ms.tex
	rm -rf ms_diff.tex
	pdflatex ms
	pdflatex ms
	bibtex ms
	pdflatex ms
	pdflatex ms 
	rm -rf *Notes.bib
	rm -rf *.aux
	rm -rf *.log
	rm -rf *.blg
	rm -rf *.dvi
	mv ms.pdf diff.pdf
	cp final/ms.tex .
	mv diff.pdf final/diff.pdf
