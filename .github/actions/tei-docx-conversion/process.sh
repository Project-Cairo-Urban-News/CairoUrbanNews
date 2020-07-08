#!/bin/bash

for f in `ls /opt/CairoUrbanNews/docx/*.docx`
do
  OUT1 = $(echo $f | sed 's/\([[:digit:]]*\).docx/\1.xml/')
  OUT2 = $(echo $OUT1 | sed 's/docx\//')
  if [ ! -f $OUT1 ]; then
    /opt/stylesheets/bin/docxtotei $f $OUT1
  fi
  saxon -s:$OUT1 -xsl:/opt/CairoUrbanNews/xslt/process-new.xsl -o:$OUT2
  cp $OUT2 /github/home/$(echo $OUT2 | sed 's/\/opt\/CairoUrbanNews\//')
done