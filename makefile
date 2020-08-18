.PHONY: all clean prepare chapter-all release

PDFLATEX_FLAGS = -shell-escape -halt-on-error -output-directory ../build/

define make_pdf
  export max_print_line=$$(tput cols); \
  cd src && pdflatex $(PDFLATEX_FLAGS) knot-theory.tex && cp knot_theory.bib ../build/knot_theory.bib; \
  cd ../build && bibtex knot-theory && makeindex knot-theory; \
  cd ../src && ./merridew/fix_bbl_authors.py ../build/knot-theory.bbl && pdflatex $(PDFLATEX_FLAGS) knot-theory.tex && pdflatex $(PDFLATEX_FLAGS) knot-theory.tex; \
  cd ..;
endef

all: prepare chapter-all release
draft: prepare chapter-draft release

prepare:
	mkdir -p build

precommit:
	./src/merridew/bibliography_sort.py src/knot_theory.bib
	for i in $$(find src -type f -iname '*.tex'); do sed '$$a\' $$i > file && mv file $$i; perl -p -i -e 's/\t/    /g' "$$i"; done
	find src -type f \
		| xargs awk -F ';' '/^% DICTIONARY/ {print "\\item \\textbf{" $$2 "} " $$3}' \
		| sort > src/90-appendix/dictionary.tex

chapter-all: build/knot-theory.pdf

chapter-draft: build/draft-knot-theory.pdf

build/knot-theory.pdf: src/knot-theory.tex src/*/*.tex
	$(call make_pdf)

build/draft-knot-theory.pdf: src/*/*.tex
	sed 's@\(\\includecomment\)@% \1@g' src/include/head.tex > src/include/head.tex.bak
	mv src/include/head.tex.bak src/include/head.tex
	$(call make_pdf)
	sed 's@%.*\(\\includecomment.*\)@\1@g' src/include/head.tex > src/include/head.tex.bak
	mv src/include/head.tex.bak src/include/head.tex
	mv build/knot-theory.pdf build/draft-knot-theory.pdf

release:
	cp build/*knot-theory.pdf ./

clean:
	rm -rf build *.pdf
