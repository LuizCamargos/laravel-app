cp .env.example .env

docker run --rm \
    -u "$(id -u):$(id -g)" \
    -v "$(pwd):/var/www/html" \
    -w /var/www/html \
    laravelsail/php82-composer:latest \
    composer install --ignore-platform-reqs
  ./vendor/bin/sail up

./vendor/bin/sail php artisan key:generate
./vendor/bin/sail php artisan migrate:fresh --seed

#instalar e rodar Vite
#npm install
#npm run dev

#relacionado: https://laracasts.com/discuss/channels/devops/laravel-10-vite-and-codespaces