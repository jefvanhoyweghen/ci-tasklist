#!/bin/bash
FOLDER=$1
cd $FOLDER
cp .env.jenkins .env
cp phpunit.xml.jenkins phpunit.xml
composer self-update
composer install --no-interaction
php artisan key:generate
vendor/bin/phpunit
