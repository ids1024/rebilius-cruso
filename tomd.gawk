#!/bin/gawk -f

BEGIN {
    RS="\n\n+"
}

/PREFACE/ {
    a=1
    print "#Preface\n"
    next
}
/CONTENTS/ {
    a=0
    incontents=1
    print "\\clearpage\\tableofcontents"
    next
}
/CHAPTER/ {
    next
}
/ERRATA/ {
    # Gutenberg text has errata corrected
    a=0
    next
}
/CAPUT/ {
    if (inchap!=1)
        print "\\mainmatter\n"
    a=1
    inchap=1
    incontents=0
    print "\\chapter{}\n"
    # http://tex.stackexchange.com/questions/328008/how-to-add-description-to-toc
    print "\\addtocontents{toc}{\\medskip\\noindent\\detokenize{"contentsdescs[chapnum++]"}\\leavevmode\\par\\medskip}\n"
    next
}
/GLOSSARY/ {
    inchap=0
    print "\\backmatter\n\n#Glossary\n"
    next
}
/FOOTNOTES/ {
    print "#Footnotes\n"
    next
}
/End of the Project Gutenberg EBook/ {
    a=0
}
{
    if (incontents==1) {
        gsub(/\n/, " ")
        gsub(/ +/, " ")
        gsub(/_/, "")
	gsub(/[0-9]+/, "\\textbf{&}")
        contentsdescs[contentsdescnum++] = $0
    }

    if (a==1) {
    	if (inchap==1) {
            sub(/\./, "", $1)
            print "\\paragraph{"$1"}\n"
            $1 = ""
        }
        print $0"\n"
    }
}
