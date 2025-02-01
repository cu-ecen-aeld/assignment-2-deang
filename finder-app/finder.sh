#!/bin/bash

# Do we have enough command-line arguments?
if [ $# -lt 2 ]
then
	# No, we don't.
	echo "Usage: $ finder.sh filesdir searchstr"
	echo "Exiting..."
	exit 1
fi

filesdir=$1
searchstr=$2

# Is filesdir a directory on the filesystem?
# Do an ls and examine the exit code after the fact.
# Note that "> /dev/null 2>&1" redirects all of ls's output to /dev/null
# so it does not show up in the user's console.  In this context we only
# care about the exit code.
ls $filesdir > /dev/null 2>&1
if [ $? -gt 0 ]
then
	echo "Error: $filesdir is not a directory on the filesystem"
	echo "Exiting..."
	exit 1
fi
