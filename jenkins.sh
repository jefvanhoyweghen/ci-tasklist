FOLDER=$1
IP=$2
cd $FOLDER
rm .env
cp .env.jenkins .env
echo "DB_TEST_HOST=$IP" >> .env
cp phpunit.xml.jenkins phpunit.xml
composer self-update
composer install --no-interaction
php artisan key:generate
cat .env
php artisan migrate --seed
vendor/bin/phpunit