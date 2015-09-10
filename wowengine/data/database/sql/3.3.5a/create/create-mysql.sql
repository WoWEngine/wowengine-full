GRANT USAGE ON * . * TO 'wowengine'@'localhost' IDENTIFIED BY 'wowengine' WITH MAX_QUERIES_PER_HOUR 0 MAX_CONNECTIONS_PER_HOUR 0 MAX_UPDATES_PER_HOUR 0 ;

CREATE DATABASE `wowengine-335a-world` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;

CREATE DATABASE `wowengine-335a-chars` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;

CREATE DATABASE `wowengine-335a-auth` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;

GRANT ALL PRIVILEGES ON `wowengine-335a-world` . * TO 'wowengine'@'localhost' WITH GRANT OPTION;

GRANT ALL PRIVILEGES ON `wowengine-335a-chars` . * TO 'wowengine'@'localhost' WITH GRANT OPTION;

GRANT ALL PRIVILEGES ON `wowengine-335a-auth` . * TO 'wowengine'@'localhost' WITH GRANT OPTION;
