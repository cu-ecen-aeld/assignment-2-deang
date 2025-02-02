#!/bin/bash

# Do we have enough command-line arguments?
if [ $# -lt 2 ]
then
	# No, we don't.
	echo "Usage: $ writer.sh writefile writestr"
	echo "Exiting..."
	exit 1
fi

writefile=$1
writestr=$2

# Use the dirname command to get the path without the filename.
writefilepath=$(dirname "$writefile")

# Does the path already exist?
ls $writefilepath > /dev/null 2>&1
if [ $? -gt 0 ]
then
	# No.  Create it.
	# Note that the -p flag requests that all directories in the path are created.
	mkdir -p $writefilepath
fi

# Touch the file to see if it can be created.
# This is intended to capture both cases:
#   1) Where we don't have proper permissions to create the file.
#   2) Where the path doesn't exist and the mkdir couldn't create it (probably due to permissions).

touch writefile
if [ $? -gt 0 ]
then
	echo "$writefile could not be created"
	exit 1       
fi

# Write writestr to the file, overwriting existing content.
echo "$writestr" > $writefile
