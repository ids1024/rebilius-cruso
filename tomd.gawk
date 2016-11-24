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
    a=1
    print "#"$0
    next
}
/End of the Project Gutenberg EBook/ {
    a=0
}
{
    if (a==1)
        print $0
}
