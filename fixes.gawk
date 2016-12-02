#!/bin/gawk -f

# This runs line by line, preparing for tomd.gawk, which runs
# paragraph by paragraph

/MALA MEA/ {
    intable = 1
}

$1 == "50." {
    intable = 0
}

{
    sub(/156\. He moralizes/, "156 He moralizes")
    if (!intable)
        $0 = gensub(/([0-9]+\.)/, "\n\n\\1", "g")
    gsub(/n̄/, "n")
    sub(/ὄρυγας/, "\\textgreek{ὄρυγας}")
    print
}
