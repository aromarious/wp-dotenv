# WP Dotenv

*This is a private revised version of WP Dotenv of [scottjs/wp-dotenv](https://github.com/scottjs/wp-dotenv).* Thanks scottjs.

Inspired by Laravel 5, WP Dotenv enables WordPress to use .env files for its configuration instead of wp-config.php.
The original is useful if you're planning on using [scottjs/db-sync](https://github.com/scottjs/db-sync) or [scottjs/helper-scripts](https://github.com/scottjs/helper-scripts) with WordPress, but this version omits the function.

## Requirements

* Composer
* PHP >= 5.3.9
* A local development environment, such as Vagrant.

## Notes

* These scripts require a .env config file to be created in the project root, this file will be used to configure WordPress.
* Running this script will replace the existing `wp-config.php` with a modified version to use the .env file.

## Installation

Run `composer require "aromarious/wp-dotenv:1.*"` from the root of your project.

Alternatively, you can manually add `"aromarious/wp-dotenv": "1.*"` to your `composer.json` file:

```
"require": {
	"aromarious/wp-dotenv": "1.*"
},
```

Then add the following scripts to your `composer.json` file:

```
"scripts": {
	"generate-config" : [
		"vendor/aromarious/wp-dotenv/generate-config.sh"
	],
	"generate-config-with-salts" : [
		"vendor/aromarious/wp-dotenv/generate-config.sh salts"
	],
	"generate-index" : [
		"vendor/aromarious/wp-dotenv/generate-index.sh"
	]
}
```

Run the `composer update` command from the root of your project. 

Create a `.env` file in the root of your project and add/update the following configuration options:

```
APP_DOCROOT=
APP_CORE=
APP_DEBUG=false
APP_HOSTNAME=example.local
APP_SSL=false

DB_HOST=localhost
DB_DATABASE=example
DB_USERNAME=root
DB_PASSWORD=password

DISABLE_AUTOMATIC_UPDATER=true
```

## Usage

From the root of your project, you will be able to run the following composer commands:

* ***composer generate-config*** - This command will generate a modified wp-config.php file to allow WordPress to use the .env file. This requires `APP_DOCROOT` to be set in the .env file.

* ***composer generate-config-with-salts*** - As above, but will also generate the salts automatically. This is a handy  command to use when starting a new project, but it can be used at any time.

* ***composer generate-index** - This command will locate index.php file to `APP_DOCROOT`. This requires `APP_DOCROOT` and `APP_CORE` to be set in the .env file.

## Config

See below for an explanation of each configuration option used within the .env file.

* ***APP_ENV*** - When set to `local`, the WordPress admin panel will display buttons in the admin panel to upgrade plugins and WordPress files. When set to `production` (except `local`), the ability to plugins/software through the admin panel is disabled. 

* ***APP_DOCROOT*** - Required by ***composer generate-config***, it should be relative to your project root folder and point to where the document root is configured. It should start with a slash and not include a trailing slash. Leave blank if not applicable. Example: `/public`.

* ***APP_CORE*** - Required if WP core files are located in a subdirectory relative to `APP_DOCROOT`. It should point to the directory where WP core is installed. It should start with a slash and not include a trailing slash. Leave blank if not applicable. Example: `/wp`.

* ***APP_DEBUG*** - Allows you to enable or disable WP debugging. Options: `true` or `false`.

* ***APP_HOSTNAME*** - Required. Provides The hostname part of URL. (Auto configuration makes wp-cli not to work)

* ***APP_SSL*** - Allows you to force WordPress to use the SSL protocol and handle redirection. Options: `true` or `false`.

* ***DB_...*** - Provides options to set the local database connection details.

* ***DISABLE_AUTOMATIC_UPDATER*** - Disables auto-updater. This affects Wordpress core, themes and plugins. Options: `true` or `false`.

* ***DISABLE_WP_CRON*** - Disables WP_CRON feature. Options: `true` or `false`. Default: `false`