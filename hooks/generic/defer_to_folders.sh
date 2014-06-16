#!/bin/bash

THIS_DIR=`dirname $0`
SUBDIR="$1"

for FILE in `ls -R $SUBDIR`; do
	FILE_PATH=$SUBDIR/$FILE
	if [ -f "$FILE_PATH" ]; then
		$SUBDIR/$FILE
	fi
done
