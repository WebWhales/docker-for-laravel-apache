# Updating the docker-for-laravel-apache images

## Building the "latest" tag

* Check out the `master` branch
* Run: `docker build --no-cache .`
* Run: `docker push webwhales/for-laravel-apache`

## Building a specific tag

*Replace [tag] with an actual tag, like `php8.1`*

* Check out the branch corresponding with the tag, like `php8.1` 
* Run: `docker build --no-cache -t webwhales/for-laravel-apache:[tag] .`
* Run: `docker push webwhales/for-laravel-apache:[tag]`
