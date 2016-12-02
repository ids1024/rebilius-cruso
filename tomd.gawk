#!/bin/gawk -f


# Changes _text_ to \textit{text}
function italic(str) {
    return gensub(/_([^_]*)_/, "\\\\textit{\\1}", "g", str)
}


BEGIN {
    RS = "\n\n+"
}

/PREFACE/ {
    section = "preface"
    print "#Preface\n"
    next
}

/CONTENTS/ {
    section = "contents"
    print "\\clearpage\\tableofcontents"
    next
}

/CHAPTER/ {
    next
}

/ERRATA/ {
    # Gutenberg text has errata corrected
    section=""
    next
}

/CAPUT/ {
    if (section != "chapter")
        print "\\mainmatter\n"
    section="chapter"
    print "\\chapter{}\n"
    # http://tex.stackexchange.com/questions/328008/how-to-add-description-to-toc
    print "\\addtocontents{toc}{\\medskip\\noindent\\detokenize{" contentsdescs[chapnum++] "}\\leavevmode\\par\\medskip}\n"
    next
}

/GLOSSARY/ {
    section = "glossary"
    print "\\backmatter\n\n#Glossary\n"
    next
}

/FOOTNOTES/ {
    section = "footnotes"
    next
}

# This appears once in the book
/\+-+\+/ {
    gsub(/\+-+\+/, "")
    gsub(/\|/, "")
    gsub(/\n/, "\\\\\n")
    $0 = italic($0)
    print "\\begin{center}"
    print "\\minibox[frame,c]{" $0 "}"
    print "\\end{center}"
    print "\\noindent"
    next
}

# This appears once
/MALA MEA/ {
    intable = 1
    print $0
    print "  ---------                              ------------------"
    next
}

$1 == "50." {
    intable = 0
}

/Among WORKS by F. W. NEWMAN, are/ {
    exit
}

section == "contents" {
    gsub(/\s+/, " ")
    $0 = italic($0)
    gsub(/[0-9]+/, "\\textbf{&}")
    contentsdescs[contentsdescnum++] = $0
    next
}

section == "chapter" && !intable {
    $1 = gensub(/([0-9]+)\./, "\\\\paragraph{\\1}\n", 1, $1)
    $0 = gensub(/\[([A-Z])\]/, "[^\\1]", "g")
}

section == "glossary" {
    $0 = gensub(" *(.*)", "\\\\noindent \\1", 1)
}

section == "footnotes" {
    $0 = gensub(/\[([A-Z])\]/, "[^\\1]:", "g")
}

section != "" {
    print $0"\n"
}
