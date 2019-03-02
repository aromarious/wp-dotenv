#!/bin/bash

# Config file
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do
	DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
	SOURCE="$( readlink "$SOURCE" )"
	[[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE"
done

DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

CONFIG=${DIR%/*/*/*}

# copy sample dot files
SAMPLEDOTFILE_DEV=sample-dev.env.txt
SAMPLEDOTFILE_PRODSTAGE=sample-prodstage.env.txt

cp $DIR/$SAMPLEDOTFILE_DEV $CONFIG
cp $DIR/$SAMPLEDOTFILE_PRODSTAGE $CONFIG

echo COMPLETE: sample dot files were copied into $CONFIG.
