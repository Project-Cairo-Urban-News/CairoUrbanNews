#!/bin/bash

REGEX="[[:digit:]]{4}\.xml"
for f in `ls *.xml`
do
  if [[ $f =~ $REGEX ]]
  then
    saxon -s:"$f" -xsl:xslt/apply-master.xsl -o:"$f"
  fi
done