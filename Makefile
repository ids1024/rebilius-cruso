NAME = rebilius
SRC = ${NAME}.md
VIEWER = zathura

all: ${NAME}.pdf

view: ${NAME}.pdf
	${VIEWER} $<

clean:
	rm -f *.pdf *.md *.log

${NAME}.pdf: template.latex ${SRC}
	pandoc -s --smart --template=template -o $@ ${SRC}

rebilius.md: 50732-0.txt tomd.gawk fixes.gawk
	dos2unix < $< | ./fixes.gawk | ./tomd.gawk > $@

.PHONY: all view clean
