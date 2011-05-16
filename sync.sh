#!/bin/bash
#
# Links files in this directory to the current users home directory.
#
# If the link already exists the file will be skipped unless the -f flag is given.

# BSD's realpath does not have the -f flag
real_path () {
    _=`pwd`
    [ -d $DIR ] && DIR=$1
    [ -f $DIR ] && DIR=`dirname $1`
    cd $DIR && echo `pwd` && cd $_
}

SCRIPT_DIR=$(real_path $0)
SCRIPT_FILE=$(basename $0)
FORCE=0
PREFIX=$HOME

while getopts "fp:" flag; do
    case "$flag" in
	f) FORCE=1 ;;
	p) PREFIX=$OPTARG ;;
    esac
done

PREFIX=${PREFIX%/}

for FILE in $(git ls-files); do
    FILE_PATH=${SCRIPT_DIR}/$FILE
    HOME_PATH=$PREFIX/.${FILE}
    
    # Don't link this script (it's maintained in git)
    if [[ $FILE = $SCRIPT_FILE ]]; then
	continue
    fi
    
    # Don't link a hidden file (.gitignore)
    if [[ $FILE_PATH = $SCRIPT_PATH || ${FILE:0:1} = '.' ]]; then
	continue
    fi

    # Skip if the $HOME file exists (unless forced)
    if [[ $FORCE -eq 0 && -e $HOME_PATH ]]; then
	echo "Skip " $FILE_PATH -- already exists
	continue
    fi

    # Let the user know the type of link (forced or normal)
    if [[ $FORCE -eq 1 && -e $HOME_PATH ]]; then
	echo "Force" $FILE_PATH to $HOME_PATH
	rm -f $HOME_PATH
    else
	echo "Link " $FILE_PATH to $HOME_PATH
    fi

    ln -s $FILE_PATH $HOME_PATH
done
