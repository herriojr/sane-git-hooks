#!/bin/bash

THIS_DIR=`dirname $0`
SUBDIR="$0-dir"

for FILE in `ls -R $SUBDIR`; do
        FILE_PATH=$SUBDIR/$FILE

        if [ -f "$FILE_PATH" ]; then
                $SUBDIR/$FILE
                result=$?
                if [ result != 0 ]; then
                        exit $result
                fi
        fi
done
