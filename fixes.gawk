#!/bin/gawk -f

# This runs line by line, preparing for tomd.gawk, which runs
# paragraph by paragraph

{
    sub(/156\. He moralizes/, "156 He moralizes")
    $0 = gensub(/([0-9]+\.)/, "\n\n\\1", "g")
    gsub(/n̄/, "n")
    sub(/ὄρυγας/, "\\textgreek{ὄρυγας}")
    print
}
