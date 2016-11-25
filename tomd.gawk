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
    a=1
    print "#Contents\n"
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
    print "#"
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
    if (a==1) {
    	if (inchap==1) {
            sub(/\./, "", $1)
            print "\\paragraph{"$1"}\n"
            $1 = ""
        }
        print $0"\n"
    }
}
