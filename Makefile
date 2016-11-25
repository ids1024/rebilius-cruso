NAME = rebilius
SRC = ${NAME}.md
VIEWER = zathura

all: ${NAME}.pdf

view: ${NAME}.pdf
	${VIEWER} $<

clean:
	rm -f *.pdf *.md *.log

${NAME}.pdf: template.latex ${SRC}
	#pandoc -s --smart --latex-engine=lualatex --template=template -o $@ ${SRC}
	pandoc -s --smart --latex-engine=xelatex --template=template -o $@ ${SRC}
	#pandoc -s --smart --template=template -o $@ ${SRC}

rebilius.md: 50732-0.txt tomd.gawk
	dos2unix < $< | ./tomd.gawk > $@

.PHONY: all view clean
