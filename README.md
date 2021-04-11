# Docker Laravel Project Template

This is simple template image included basic PHP extensions and webserver configuration for Laravel/Lumen PHP projects.

## Start develop Laravel/Lumen App

Get Docker: https://docs.docker.com/get-docker/

Clone repository to your local computer

```
git clone https://github.com/olkitu/docker-laravel-project-template.git
cd docker-php-project-example
```

Start with `docker-compose` Nginx, PHP-FPM and MariaDB database up.

```
docker-compose up -d
```

### Install Laravel

Create new Laravel project and install to `./app` directory.

```
docker-compose exec web composer create-project laravel/laravel .
```

Copy `app/.env` and `app/.env.example` to project root.

Restart the web container

```
docker-compose restart web
```

Now have fun start develop your own app.

### Install Lumen

Create new Lumen project and install to `./app` directory.

```
docker-compose exec web composer create-project --prefer-dist laravel/lumen .
```

Copy `app/.env` and `app/.env.example` to project root.

Restart the web container

```
docker-compose restart web
```

Now have fun start develop your own app.

## Deploy to production

Build your production image. Change `youraccount/project_name` to your own Docker Hub account name and project name what you like to use.

```
docker build -t youraccount/project_name --target=prod .
```

Upload your image to Docker Hub or some other container repository.

### Docker Swarm

Here is example stack template to build to Docker Swarm.

```yaml
version: '3.8'
services:
  web:
    image: youraccount/project_name
    ports:
    - 80:80
    environments:
      DB_HOST: db
      DB_DATABASE: laravel
      DB_USERNAME: laravel
      DB_PASSWORD: laravel
```