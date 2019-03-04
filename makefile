.PHONY: all clean prepare chapter-01 chapter-02 chapter-03 chapter-04 chapter-05 chapter-99 chapter-all release

PDFLATEX_FLAGS = -shell-escape -halt-on-error -output-directory ../build/ 

all: prepare chapter-all release
draft: prepare chapter-01 chapter-02 chapter-03 chapter-04 chapter-05 chapter-99 release-draft

prepare:
	mkdir -p build

chapter-01: prepare build/draft-01.pdf
chapter-02: prepare build/draft-02.pdf
chapter-03: prepare build/draft-03.pdf
chapter-04: prepare build/draft-04.pdf
chapter-05: prepare build/draft-05.pdf
chapter-99: prepare build/draft-99.pdf
chapter-all: build/knot-theory.pdf
chapter-test: prepare build/draft-test.pdf

build/knot-theory.pdf: src/knot-theory.tex src/*/*.tex
	cd src && pdflatex $(PDFLATEX_FLAGS) knot-theory.tex
	cp src/knot_theory.bib build/knot_theory.bib
	-cd build && bibtex knot-theory
	cd build && makeindex knot-theory
	cd src && pdflatex $(PDFLATEX_FLAGS) knot-theory.tex
	cd src && pdflatex $(PDFLATEX_FLAGS) knot-theory.tex

build/draft-01.pdf: src/draft-01.tex src/10*/*.tex
	cd src && pdflatex $(PDFLATEX_FLAGS) draft-01.tex

build/draft-02.pdf: src/draft-02.tex src/20*/*.tex
	cd src && pdflatex $(PDFLATEX_FLAGS) draft-02.tex

build/draft-03.pdf: src/draft-03.tex src/30*/*.tex
	cd src && pdflatex $(PDFLATEX_FLAGS) draft-03.tex

build/draft-04.pdf: src/draft-04.tex src/40*/*.tex
	cd src && pdflatex $(PDFLATEX_FLAGS) draft-04.tex

build/draft-05.pdf: src/draft-05.tex src/50*/*.tex
	cd src && pdflatex $(PDFLATEX_FLAGS) draft-05.tex

build/draft-99.pdf: src/draft-99.tex src/90*/*.tex
	cd src && pdflatex $(PDFLATEX_FLAGS) draft-99.tex

build/draft-test.pdf: src/draft-test.tex src/include/test.tex
	cd src && pdflatex $(PDFLATEX_FLAGS) draft-test.tex
	cp src/knot_theory.bib build/knot_theory.bib
	-cd build && bibtex draft-test
	cd build && makeindex draft-test
	cd src && pdflatex $(PDFLATEX_FLAGS) draft-test.tex
	cd src && pdflatex $(PDFLATEX_FLAGS) draft-test.tex

release-draft:
	pdfunite build/*.pdf draft.pdf

release:
	cp build/knot-theory.pdf knot-theory.pdf

clean:
	rm -rf build *.pdf
