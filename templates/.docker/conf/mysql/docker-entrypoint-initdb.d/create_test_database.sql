CREATE DATABASE IF NOT EXISTS `laravel_db_unittest`;
CREATE DATABASE IF NOT EXISTS `laravel_db_unittest_test_1`;
CREATE DATABASE IF NOT EXISTS `laravel_db_unittest_test_2`;
CREATE DATABASE IF NOT EXISTS `laravel_db_unittest_test_3`;
CREATE DATABASE IF NOT EXISTS `laravel_db_unittest_test_4`;
CREATE DATABASE IF NOT EXISTS `laravel_db_unittest_test_5`;

GRANT ALL ON `laravel_db_%`.* TO 'laravel_db_user'@'%';