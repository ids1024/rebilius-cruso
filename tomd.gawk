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
    section="contents"
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
    if (section!="chapter")
        print "\\mainmatter\n"
    a=1
    section="chapter"
    print "\\chapter{}\n"
    # http://tex.stackexchange.com/questions/328008/how-to-add-description-to-toc
    print "\\addtocontents{toc}{\\medskip\\noindent\\detokenize{"contentsdescs[chapnum++]"}\\leavevmode\\par\\medskip}\n"
    next
}

/GLOSSARY/ {
    section="glossary"
    print "\\backmatter\n\n#Glossary\n"
    next
}

/FOOTNOTES/ {
    section="footnotes"
    next
}

# This appears once in the book
/+--------------------------------+/ {
    gsub(/\+-+\+/, "")
    gsub(/\|/, "")
    gsub(/\n/, "\\\\\n")
    $0 = gensub(/_([^_]*)_/, "\\\\textit{\\1}", "g")
    print "\\begin{center}"
    print "\\minibox[frame,c]{" $0 "}"
    print "\\end{center}"
    print "\\noindent"
    next
}

/Among WORKS by F. W. NEWMAN, are/ {
    exit
}

section=="contents" {
    gsub(/\s+/, " ")
    $0 = gensub(/_(.*)_/, "\\\\textit{\\1}", "g")
    gsub(/[0-9]+/, "\\textbf{&}")
    contentsdescs[contentsdescnum++] = $0
}

section=="chapter" {
    $1 = gensub(/([0-9]+)\./, "\\\\paragraph{\\1}\n", 1)
}

a==1 {
    if (section=="footnotes")
        $0 = gensub(/\[([A-Z])\]/, "[^\\1]:", "g")
    else
        $0 = gensub(/\[([A-Z])\]/, "[^\\1]", "g")
    if (section=="glossary")
        $0 = gensub(" *(.*)", "\\\\noindent \\1", 1)
    print $0"\n"
}
