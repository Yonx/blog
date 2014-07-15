MD = markdown_py
MDFLAGS = 
H2P = xhtml2pdf
H2PFLAGS = --html
SOURCES := $(wildcard *.md)
OBJECTS := $(patsubst %.md, %.html, $(wildcard *.md))
OBJECTS_PDF := $(patsubst %.md, %.pdf, $(wildcard *.md))

all: build

build: html pdf

pdf: $(OBJECTS_PDF)

html: $(OBJECTS)

$(OBJECTS_PDF): %.pdf: %.html
	$(H2P) $(H2PFLAGS) $< > $@ 

$(OBJECTS): %.html: %.md
	$(MD) $(MDFLAGS) $< > $@

clean:
	rm -f $(OBJECTS)
	rm -f $(OBJECTS_PDF)
