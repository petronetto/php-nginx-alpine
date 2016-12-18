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
docker run -p 8080:80 --name <NAME_OF_YOUR_CONTAINER> -d petronetto/php-nginx-alpine
```

Using Composer:
```bash
docker run -it <NAME_OF_YOUR_CONTAINER> composer <command>
```

See the PHP info on http://localhost:8080, or the static html page on http://localhost:8080/test.html
