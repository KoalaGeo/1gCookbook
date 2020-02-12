# sed script for partial conversion of Word filtered HTML to ReST text
# run as sed -f <this file> -i.bkp <file to process>
s/&lt;/</g
s/&gt;/>/g
s/&quot;/"/g
