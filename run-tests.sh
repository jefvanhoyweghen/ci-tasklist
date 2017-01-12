cp .env.local .env
cp phpunit.xml.local phpunit.xml
mysql -e 'drop database test;'
mysql -e 'create database test;'
composer self-update
composer install --no-interaction
php artisan key:generate
php artisan config:cache
php artisan migrate --seed
vendor/bin/phpunit
