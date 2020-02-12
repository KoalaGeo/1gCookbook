# sed script for partial conversion of Word filtered HTML to ReST text
# run as sed -z -f <this file> -i.bkp <file to process>
# Get rid of anchors that are just TOC targets.
s!<a[\s\n][\s\n]*name="_Toc[0-9]*"[^>]*>\([^<]*\)</a>!\1!g

