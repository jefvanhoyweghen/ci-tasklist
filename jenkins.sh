sudo docker-compose exec -T workspace rm $JOB_NAME/.env
sudo docker-compose exec -T workspace cp $JOB_NAME/.env.jenkins $JOB_NAME/.env
sudo docker-compose exec -T workspace cp $JOB_NAME/phpunit.xml.jenkins $JOB_NAME/phpunit.xml
sudo docker-compose exec -T mysql mysql -e "CREATE USER 'root'@'localhost';"
sudo docker-compose exec -T mysql mysql -e "GRANT ALL PRIVILEGES ON * . * TO 'root'@'localhost';"
sudo docker-compose exec -T mysql mysql -e "DROP DATABASE test;"
sudo docker-compose exec -T mysql mysql -e "CREATE DATABASE test;"
sudo docker-compose exec -T workspace $JOB_NAME/composer self-update
sudo docker-compose exec -T workspace $JOB_NAME/composer install --no-interaction
sudo docker-compose exec -T workspace $JOB_NAME/php artisan key:generate
sudo docker-compose exec -T workspace $JOB_NAME/php artisan migrate --seed
sudo docker-compose exec -T workspace $JOB_NAME/vendor/bin/phpunit