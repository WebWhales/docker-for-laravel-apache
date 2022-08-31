# docker-for-laravel-apache

This Docker repository is built to be used by [Web Whales](https://webwhales.nl) developers to develop Laravel application, but any other developer may use our repository as well.


## Using this image

When you're about to use this image, you can use the files you'll find in the templates folder in [the repository on GitHub](https://github.com/WebWhales/docker-for-laravel-apache).

When using our template files, follow these steps to start using this image:
* Copy all files under `/templates` to the root of your project directory
* In the `docker-compose.yml`:
  * Change container names when using multiple docker set ups simultaneously
  * Change the `hostname` directives
    * Tip: the *.localhost tld points to your local machine automatically on Windows
  * Change ports when necessary
  * Change the database details and/or root password when necessary
    * The database root password is used by phpMyAdmin
    * When you change the database user, make sure to also change it in the `.docker/conf/mysql/docker-entrypoint-initdb.d/create_test_database.sql` file
* Run `docker-compose up -d` from the root of your project directory


### Bonus: some tips to help you on your way

* The `web` container contains the following command line tools:
  * `composer`
  * `nano`
  * `nodejs`, `npm`, `yarn` and `n`
  * `@ionic/cli`, `@vue/cli`, `cordova`, `gulp-cli`, `gulp`, `vue-native-cli` and `react-native-cli`
  * `laravel/installer`
  * `supervisor`
* Files you put in the `.docker/data/phpmyadmin/uploads` folder become available for importing within phpMyAdmin