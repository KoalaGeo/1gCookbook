# sed script for partial conversion of Word HTML to ReST text
# run as sed -f <this file> -i.bkp <file to process>
# run as sed -z -f <this file> -i.bkp <file to process> to process all as one
# line where tags may be split over lines.
s!<span[^>]*>!!g
s!</span[^>]*>!!g
