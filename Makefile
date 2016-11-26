NAME = rebilius
SRC = ${NAME}.md
VIEWER = zathura

all: ${NAME}.pdf

view: ${NAME}.pdf
	${VIEWER} $<

clean:
	rm -f *.pdf *.md *.log

${NAME}.pdf: template.latex ${SRC}
	pandoc -s --smart --latex-engine=lualatex --template=template -o $@ ${SRC}

rebilius.md: 50732-0.txt tomd.gawk
	dos2unix < $< | sed -r "s/[0-9]+\./\n\n\0/g" | ./tomd.gawk > $@

.PHONY: all view clean
