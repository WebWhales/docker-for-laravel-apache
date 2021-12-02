# Updating the docker-for-laravel-apache images

## Building the "latest" tag

* `docker build --no-cache .`
* `docker push webwhales/for-laravel-apache`

## Building a specific tag

*Replace [tag] with an actual tag, like `php8.1`*

* `docker build --no-cache -t webwhales/for-laravel-apache:[tag] .`
* `docker push webwhales/for-laravel-apache:[tag]`
