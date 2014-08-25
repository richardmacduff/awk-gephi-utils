# addId  -- substitutes fields 2 and 3 of ARGC[1 with the corresponding id in ARGC[2] (the lookup file)
# Usage: addId lookup.csv convertMe.csv > output.csv
# AUTHOR: Walter Vannini
# WARNING: assumes semicolon-separated fields. USE awk -F\;
# lookup.csv: Id;Label with first line a header
# convertMe: Weight;Source;Target;Time with first line a header



#say hello

BEGIN { print "FILLING LOOKUP TABLE" > "/dev/tty" }

#fill a lookup table
FILENAME == "nodesWithId.csv" {
	map[$2]=$1
	next
}

# first line of input goes unchanged
FNR == 1 {
	print "STARTING MAPPING"  > "/dev/tty"
	print $0 
}

#perform on lines from 2 to end
FNR > 1 {  print $1 ";" map[$2] ";" map[$3] ";" $4 }


# give a sign of life every 10 lines
(FNR % 1000) == 0 { printf("%s", ".") >"/dev/tty" }

# say goodbye
END {
	print FNR, "records processed" > "/dev/tty"
	print "DONE." > "/dev/tty"
}
