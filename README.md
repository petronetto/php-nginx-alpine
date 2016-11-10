Dockerized PHP for Laravel development
==============================================
This image contains:
- PHP-FPM 7.0
- Nginx 1.10
- Alpine Linux (Edge)
- NodeJS
- Git
- Composer

Usage
-----
Start the Docker containers:

`sudo docker run -p 80:80 petronetto/php-nginx`

Creating a Laravel project
-----
From `src` folder, run:

Create=ing a new Laravel project:
```
# Create a Laravel application
docker run -it --rm \
    -v $(pwd):/opt \
    -w /opt \
    --network=phpapp_appnet \
    petronetto/php-nginx \
    composer create-project laravel/laravel application
```

See the PHP info on http://localhost, or the static html page on http://localhost/test.html
