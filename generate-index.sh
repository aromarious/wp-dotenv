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

# Import config settings
source "$CONFIG/.env"

# Generate only if $APP_CORE is not empty
if [ -z "$APP_CORE" ]; then
	echo "DID NOTHING: it is not necessary to move index.php"
	exit
fi

sed 's!/wp-blog-header!'${APP_CORE}/wp-blog-header'!' "$CONFIG$APP_DOCROOT$APP_CORE/index.php" > "$CONFIG$APP_DOCROOT/index.php"

echo COMPLETE: WordPress index file generated $CONFIG$APP_DOCROOT/index.php
