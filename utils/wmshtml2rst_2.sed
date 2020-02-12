# sed script for partial conversion of WMS Cookbook HTML to ReST text
# run as sed -f <this file> -i.bkp <file to process>
s/<\/*em>/*/g
s/<\/*strong>/**/g
s!<a [^>]*href="\([^"]*\)"[^>]*>\([^<]*\)</a>!`\2 <\1>`_!g

