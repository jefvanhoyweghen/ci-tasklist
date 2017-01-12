rm .env
cp /.env.jenkins /.env
cp phpunit.xml.jenkins phpunit.xml
composer self-update
composer install --no-interaction
php artisan key:generate
php artisan migrate --seed
vendor/bin/phpunit