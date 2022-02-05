#!/bin/bash

convert() {
  for f in `ls *.xml`
  do
    echo "Converting $f"
    saxon -s:"$f" -xsl:../../xslt/apply-master.xsl -o:"$f"
  done
}

cd articles/arabic
convert
cd ../ottoman
convert
