REVOKE ALL PRIVILEGES ON * . * FROM 'wowengine'@'localhost';

REVOKE ALL PRIVILEGES ON `wowengine-335a-world` . * FROM 'wowengine'@'localhost';

REVOKE GRANT OPTION ON `wowengine-335a-world` . * FROM 'wowengine'@'localhost';

REVOKE ALL PRIVILEGES ON `wowengine-335a-chars` . * FROM 'wowengine'@'localhost';

REVOKE GRANT OPTION ON `wowengine-335a-chars` . * FROM 'wowengine'@'localhost';

REVOKE ALL PRIVILEGES ON `wowengine-335a-auth` . * FROM 'wowengine'@'localhost';

REVOKE GRANT OPTION ON `wowengine-335a-auth` . * FROM 'wowengine'@'localhost';

DROP USER 'wowengine'@'localhost';

DROP DATABASE IF EXISTS `wowengine-335a-world`;

DROP DATABASE IF EXISTS `wowengine-335a-chars`;

DROP DATABASE IF EXISTS `wowengine-335a-auth`;
