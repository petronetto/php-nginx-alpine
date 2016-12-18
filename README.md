Dockerized PHP
==============================================
This image contains:
- PHP-FPM 7.0
- Nginx 1.10
- Alpine Linux (Edge)
- NodeJS
- Git
- Composer

Docker Setup
----
- [Docker for Mac](https://docs.docker.com/docker-for-mac/)
- [Docker for Linux](https://docs.docker.com/engine/installation/linux/)
- [Docker for Windows](https://docs.docker.com/docker-for-windows/)

Usage
-----
Start the Docker containers:

```bash
sudo docker run -p 8080:80 --name container_name -d petronetto/php-nginx-alpine
```

Using Composer:
```bash
# Create a Laravel application
docker run -it container_name composer create-project laravel/laravel application
```

See the PHP info on http://localhost, or the static html page on http://localhost/test.html
