.PHONY: all clean prepare chapter-all release

PDFLATEX_FLAGS = -shell-escape -halt-on-error -output-directory ../build/ 

all: prepare chapter-all release

prepare:
	mkdir -p build

chapter-all: build/knot-theory.pdf

build/knot-theory.pdf: src/knot-theory.tex src/*/*.tex
	cd src && pdflatex $(PDFLATEX_FLAGS) knot-theory.tex
	cp src/knot_theory.bib build/knot_theory.bib
	-cd build && bibtex knot-theory
	cd build && makeindex knot-theory
	cd src && pdflatex $(PDFLATEX_FLAGS) knot-theory.tex
	cd src && pdflatex $(PDFLATEX_FLAGS) knot-theory.tex

release:
	cp build/knot-theory.pdf knot-theory.pdf

clean:
	rm -rf build *.pdf
