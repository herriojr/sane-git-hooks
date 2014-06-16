#!/bin/bash

FROM_DIR=`pwd`/`dirname $0`/hooks
PROJECT=$1
TO_DIR=$1/git
HOOK_DIR=$1/.git/hooks

function print_usage() {
	echo "Usage: `basename $0` <GIT_PROJECT_DIR>"
	echo "    Copies and sets up git hook structure into a project."
	echo "    If it was already set up, only relinks the hooks."
	
}

# If the directory doesn't exist or it isn't a git project
if [ ! -d "$PROJECT" ] || [ ! -d "$PROJECT/.git" ]; then
	echo "Error: Not a git repository"
	print_usage
	exit 1
fi

if [ ! -d "$TO_DIR" ]; then
	# Deploy the hooks if it doesn't exist for the project
	echo "Deploying hooks to $TO_DIR"
	mkdir -p $TO_DIR
	cp -R $FROM_DIR $TO_DIR
	cp $0 $TO_DIR
fi

if [ ! -h "$HOOK_DIR" ]; then
    # Backup the hook dir if it already exists and isn't a symlink
    BACKUP=$HOOK_DIR.BACKUP.`date "+%s"`
    echo "Backing up $HOOK_DIR to $BACKUP" 
    mv $HOOK_DIR $BACKUP

    echo "Linking hooks"
    ln -s ../$TO_DIR/hooks $1/.git/
fi
