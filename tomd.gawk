#!/bin/gawk -f

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
}
/End of the Project Gutenberg EBook/ {
    a=0
}
{
    if (inchap==1)
	$1 = ""
    if (a==1)
        print $0
}
