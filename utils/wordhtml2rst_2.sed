# sed script for partial conversion of Word filtered HTML to ReST text
# run as sed -z -f <this file> -i.bkp <file to process>
s/<\/*em>/*/g
s/<\/*i>/*/g
s/<\/*strong>/**/g
s/<\/*b>/**/g
s!<a[^>]*href="\([^"]*\)"[^>]*>\([^<]*\)</a>!`\2 <\1>`_!g

