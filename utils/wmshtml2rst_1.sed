# sed script for partial conversion of WMS Cookbook HTML to ReST text
# run as sed -f <this file> -i.bkp <file to process>
s/&#039;/'/g
# 145 and 146 are actuall private use chars but seem to come out
# as same as 8216 and 8217 in existing pages
s/&#145;/‘/g
s/&#146;/’/g
s/&#224;/à/g
s/&#233;/é/g
s/&#34;/"/g
s/&#8212;/—/g
s/&#8216;/‘/g
s/&#8217;/’/g
s/&#8220;/“/g
s/&#8221;/”/g
s/&#x2014;/—/g
s/&amp;/\&/g
s/&eacute;/é/g
s/&lt;/</g
s/&gt;/>/g
s/&nbsp;/ /g
