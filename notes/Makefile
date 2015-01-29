PDFLATEX = pdflatex
DVILATEX = latex
BIBTEX   = bibtex
INDEX    = makeindex
RM       = rm -f


T_NOTES = note-main


.PHONY: note dvi

all: notes

notes:
	$(PDFLATEX) $(T_NOTES).tex
	$(BIBTEX)   $(T_NOTES)
	$(PDFLATEX) $(T_NOTES).tex
	$(PDFLATEX) $(T_NOTES).tex
	$(INDEX)    $(T_NOTES).glo -s $(T_NOTES).ist -t $(T_NOTES).glg -o $(T_NOTES).gls
	$(PDFLATEX) $(T_NOTES).tex
	$(PDFLATEX) $(T_NOTES).tex

dvi:
	$(DVILATEX) $(T_NOTES).tex
	$(BIBTEX)   $(T_NOTES)
	$(DVILATEX) $(T_NOTES).tex
	$(DVILATEX) $(T_NOTES).tex
	$(INDEX)    $(T_NOTES).glo -s $(T_NOTES).ist -t $(T_NOTES).glg -o $(T_NOTES).gls
	$(DVILATEX) $(T_NOTES).tex
	$(DVILATEX) $(T_NOTES).tex

clean:
	$(RM) $(T_NOTES).out
	$(RM) $(T_NOTES).dvi
	$(RM) $(T_NOTES).pdf
	$(RM) $(T_NOTES).aux
	$(RM) $(T_NOTES).toc
	$(RM) $(T_NOTES).log
	$(RM) $(T_NOTES).bbl
	$(RM) $(T_NOTES).blg
	$(RM) $(T_NOTES).bak
	$(RM) $(T_NOTES).nav
	$(RM) $(T_NOTES).snm
	$(RM) $(T_NOTES).glg
	$(RM) $(T_NOTES).glo
	$(RM) $(T_NOTES).gls
	$(RM) $(T_NOTES).ist
	$(RM) $(T_NOTES).synctex.gz
	$(RM) $(T_NOTES).run.xml
	$(RM) $(T_NOTES)-blx.bib
