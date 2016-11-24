NAME = rebilius
SRC = ${NAME}.md
VIEWER = zathura

all: ${NAME}.pdf

view: ${NAME}.pdf
	${VIEWER} $<

${NAME}.pdf: template.latex ${SRC}
	pandoc -s --smart --latex-engine=lualatex --template=template -o $@ ${SRC}

rebilius.md: 50732-0.txt tomd.gawk
	dos2unix < $< | ./tomd.gawk > $@

.PHONY: all view
