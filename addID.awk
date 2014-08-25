# addId  -- substitutes fields 2 and 3 of ARGC[1] with the corresponding id in ARGC[2] (the lookup file)
# Usage: addId nodesWithId.csv > output.csv
# AUTHOR: Walter Vannini (github:@gordonway)
# WARNING: assumes semicolon-separated fields. USE awk -F\;
# format for nodesWithId.csv: Id;Label 			# with first line a header


#say hello, /dev/tty is where the command was sent from
BEGIN { print "FILLING LOOKUP TABLE" > "/dev/tty" }

#fill an in-memory lookup table (unnamed)
FILENAME == "nodesWithId.csv" {
	map[$2]=$1
	next
}

# first line of input goes unchanged, used to print starting message
FNR == 1 {
	print "STARTING MAPPING"  > "/dev/tty"
	print $0 
}

#perform on lines from 2 to end, FNR is current Record Number in file
FNR > 1 {  print $1 ";" map[$2] ";" map[$3] ";" $4 }


# give a sign of life by printing a dot to screen every 1000 lines
(FNR % 1000) == 0 { printf("%s", ".") >"/dev/tty" }

# say goodbye
END {
	print FNR, "records processed" > "/dev/tty"
	print "DONE." > "/dev/tty"
}
