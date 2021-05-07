# Docker Laravel Project Template

This is simple project template for developing Laravel and Lumen webapps with Docker. You just need Docker and IDE like [Visual Studio Code](https://code.visualstudio.com/) to start developing.

## Start develop Laravel/Lumen App

Get Docker: https://docs.docker.com/get-docker/

Download the latest [release](https://github.com/olkitu/docker-laravel-project-template/releases/latest) and extract it.

Copy `.env.example` to `.env`.

Start with `docker-compose` Nginx, PHP-FPM, Minio (S3-compatible file storage for persistent files) and Phpmyadmin. To use apache-version, uncomment Apache instead, edit `Dockerfile.dev` and `Dockerfile`.

```
docker-compose up -d
```

### Install Laravel

Create new Laravel project and install to `./app` directory.

```
docker-compose exec laravel composer create-project laravel/laravel .
```

Copy `app/.env` and `app/.env.example` to project root. Change the `DB_HOST` variable to `db`. 

Restart the laravel container

```
docker-compose restart laravel
```

Now have fun start develop your own app.

[More instructions](https://github.com/olkitu/docker-laravel-project-template/wiki)

### Install Lumen

Create new Lumen project and install to `./app` directory.

```
docker-compose exec laravel composer create-project --prefer-dist laravel/lumen .
```

Copy `app/.env` and `app/.env.example` to project root. Change the `DB_HOST` variable to `db`. 

Restart the laravel container

```
docker-compose restart laravel
```

Now have fun start develop your own app.

[More instructions](https://github.com/olkitu/docker-laravel-project-template/wiki)

### Move exist Laravel/Lumen project to container

If you have exist Laravel/Lumen project, just create app directory and place Laravel installation in created directory.

Move then `.env` and `.env.example` to project root and change `DB_HOST` variable to `db`. If you have exist database, export it and save it to `sql` directory so it will be automatically imported when container startup.

## Deploy to production

Build your production image. Change `youraccount/project_name` to your own Docker Hub account name and project name you like to use.

```
docker build -t youraccount/project_name .
```

Upload your image to Docker Hub or some other container repository.

### Docker Swarm

Here is example stack template to build to Docker Swarm.

```yaml
version: '3.8'
services:
  laravel:
    image: youraccount/project_name
    ports:
    - 80:80
    environments:
      DB_HOST: db
      DB_DATABASE: laravel
      DB_USERNAME: laravel
      DB_PASSWORD: laravel
      # And other environment variables
```

## License

[MIT](https://github.com/olkitu/docker-laravel-project-template/blob/main/LICENCE)