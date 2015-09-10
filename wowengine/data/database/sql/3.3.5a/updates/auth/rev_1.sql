ALTER TABLE `rbac_default_permissions` ADD COLUMN `realmId` INT(11) DEFAULT -1 NOT NULL COMMENT 'Realm Id, -1 means all' AFTER `permissionId`, DROP PRIMARY KEY, ADD PRIMARY KEY (`secId`, `permissionId`, `realmId`);

UPDATE `version` SET auth_db_version = 1 WHERE auth_db_version = 0;
