# sed script for partial conversion of Word filtered HTML to ReST text
# run as sed -f <this file> -i.bkp <file to process>
s/&amp;/\&/g
s/&nbsp;/ /g
