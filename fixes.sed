#!/bin/sed -rf

s/[0-9]+\./\n\n\0/g
s/n̄/n/g
s/ὄρυγας/\\textgreek{ὄρυγας}/
