CREATE DATABASE IF NOT EXISTS `laravel_db`;
GRANT ALL ON `laravel_db`.* TO 'laravel_db_user'@'%';

CREATE DATABASE IF NOT EXISTS `laravel_db_unittest`;
GRANT ALL ON `laravel_db_unittest`.* TO 'laravel_db_user'@'%';