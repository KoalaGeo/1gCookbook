# sed script for partial conversion of WMS Cookbook HTML to ReST text
# run as sed -f <this file> -i.bkp <file to process>
# Don't change any p's that have attributes
s!^ *<p>!\n!
s!</p> *$!!
