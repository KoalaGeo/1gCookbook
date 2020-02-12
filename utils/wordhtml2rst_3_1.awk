# Make sure all headings are on one line
# Invoke with awk -f _this file_ _source file_ > _temp output file_
{hp=0}
/<h[1-4]/, /<\/h[1-4]>/ {printf "%s", $0; hp=1}
/<\/h[1-4]>/ {print ""; hp=1}
hp==0 {print}
