#!/bin/bash

convert() {
  for f in `ls docx/$1/*.docx`
  do
    OUT1=$(echo $f | sed 's/\([[:digit:]]*\).docx/\1.xml/')
    OUT2=$(echo $OUT1 | sed "s/docx\//articles\//")
    if [ ! -f "$OUT2" ]; then
      /opt/stylesheets/bin/docxtotei $f "$OUT1"
      saxon -s:"$OUT1" -xsl:xslt/process-$1.xsl -o:"$OUT2"
      if [ -f "$OUT1" ]; then
        rm "$OUT1"
      fi
    fi
  done
}

convert "arabic"
convert "ottoman"
