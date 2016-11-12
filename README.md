Dockerized PHP
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

`sudo docker run -p 80:80 --name container_name petronetto/php-nginx-alpine`

Using Composer:
```
# Create a Laravel application
docker run -it container_name composer create-project laravel/laravel application
```

See the PHP info on http://localhost, or the static html page on http://localhost/test.html
