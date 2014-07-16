MD = markdown_py
MDFLAGS = -x fenced_code -x codehilite
H2P = xhtml2pdf
H2PFLAGS = --html
SOURCES := $(wildcard *.md) $(wildcard resume/*.md) $(wildcard articles/*.md)
OBJECTS := $(patsubst %.md,%.html, $(wildcard *.md)) \
           $(patsubst %.md,%.html, $(wildcard resume/*.md)) \
           $(patsubst %.md,%.html, $(wildcard articles/*.md)) 

OBJECTS_PDF := $(patsubst %.md, %.pdf, $(wildcard *.md))

all: build

build: html pdf

pdf: $(OBJECTS_PDF)

html: $(OBJECTS)

$(OBJECTS_PDF): %.pdf: %.html
	$(H2P) $(H2PFLAGS) $< > $@ 

$(OBJECTS): %.html: %.md
	cat header.html > $@
	$(MD) $(MDFLAGS) $< >> $@
	cat footer.html >> $@

clean:
	@rm -f $(OBJECTS)
	@rm -f $(OBJECTS_PDF)

info:
	@echo $(SOURCES)
	@echo $(OBJECTS)
