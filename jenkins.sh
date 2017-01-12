FOLDER=$1
cd $FOLDER
rm .env
cp .env.jenkins .env
cp phpunit.xml.jenkins phpunit.xml
composer self-update
composer install --no-interaction
php artisan key:generate
mysql -u root -h localhost:33060
cat .env
php artisan migrate --seed
vendor/bin/phpunit