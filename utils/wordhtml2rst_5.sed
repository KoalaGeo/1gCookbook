# sed script for partial conversion of Word filtered HTML to ReST text
# run as sed -f <this file> -i.bkp <file to process>
# Don't change any p's that have attributes unless they are "normal"
s!<p class=MsoNormal[^>]*>!<p>!g
s!^ *<p>!\n!
s!</p> *$!!
