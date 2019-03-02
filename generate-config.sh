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

CONFIG_SAMPLE="$CONFIG/vendor/aromarious/wp-dotenv/wp-config-sample.php"
CONFIG_TO_DEPLOY="$CONFIG$APP_DOCROOT$APP_CORE/wp-config.php"
NO_SALTS_TXT="$CONFIG/vendor/aromarious/wp-dotenv/no-salts.txt"

if [[ $1 = "salts" ]]; then
	SALT_COMMAND="curl -L https://api.wordpress.org/secret-key/1.1/salt/"
else
	SALT_COMMAND="cat $NO_SALTS_TXT"
fi

LINE=$(cat $CONFIG_SAMPLE | grep -n '\/\* put your salts here \*\/' | awk -F: '{print $1}')
${SALT_COMMAND} | sed "${LINE}r /dev/stdin" $CONFIG_SAMPLE > $CONFIG_TO_DEPLOY

echo COMPLETE: WordPress config file generated: $CONFIG_TO_DEPLOY
