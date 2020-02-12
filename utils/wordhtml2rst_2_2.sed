# sed script for partial conversion of Word filtered HTML to ReST text
# run as sed -z -f <this file> -i.bkp <file to process>
# Get rid of anchors that are just reference targets.
s!<a[ \n][ \n]*name="_Ref[0-9]*"[^>]*>\([^<]*\)</a>!\1!g

