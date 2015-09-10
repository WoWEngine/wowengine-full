DELETE FROM `rbac_permissions` WHERE `id` IN (795, 796);
INSERT INTO `rbac_permissions` (`id`, `name`) VALUES
(795, 'Command: .instance setbossstate'),
(796, 'Command: .instance getbossstate');

DELETE FROM `rbac_linked_permissions` WHERE `linkedId` IN (795, 796);
INSERT INTO `rbac_linked_permissions` (`id`, `linkedId`) VALUES
(192, 795),
(192, 796);

/* drop then create account_muted table */
DROP TABLE IF EXISTS `account_muted`;

CREATE TABLE `account_muted` (
	`guid` INT(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Global Unique Identifier',
	`mutedate` INT(10) UNSIGNED NOT NULL DEFAULT '0',
	`mutetime` INT(10) UNSIGNED NOT NULL DEFAULT '0',
	`mutedby` VARCHAR(50) NOT NULL,
	`mutereason` VARCHAR(255) NOT NULL,
	PRIMARY KEY (`guid`, `mutedate`)
)
COMMENT='mute List' ENGINE=InnoDB;

/* add rbac permissions to new commands */
DELETE FROM `rbac_permissions` WHERE `id`=632;
INSERT INTO `rbac_permissions` (`id`,`name`) VALUES
(632, 'Command: .mutehistory');
 
/* adds qc to players */
DELETE FROM `rbac_linked_permissions` WHERE `id`=632;
INSERT INTO `rbac_linked_permissions` (`id`,`linkedId`) VALUES
/* add mutehistory to gms */
(194, 632);

DELETE FROM rbac_permissions WHERE id = 797;
INSERT INTO rbac_permissions (`id`, `name`) VALUES
(797, 'Command: pvpstats');

DELETE FROM rbac_linked_permissions WHERE `linkedId` = 797;
INSERT INTO rbac_linked_permissions (`id`, `linkedId`) VALUES
(199, 797);
/* add rbac permissions to new commands */
DELETE FROM `rbac_permissions` WHERE `id`=798;
INSERT INTO `rbac_permissions` (`id`,`name`) VALUES
(798, 'Command: .mod xp');

DELETE FROM `rbac_linked_permissions` WHERE `id`=798;
INSERT INTO `rbac_linked_permissions` (`id`,`linkedId`) VALUES
/* add mod xp to gms */
(194, 798);
-- Add rbac_permissions
DELETE FROM `rbac_permissions` WHERE `id` = 51;
INSERT INTO `rbac_permissions` (`id`,`name`) VALUES
(51, 'Allow trading between factions');

-- Add rbac_linked_permissions
DELETE FROM `rbac_linked_permissions` WHERE `linkedId` = 51;
INSERT INTO `rbac_linked_permissions` (`id`,`linkedId`) VALUES
(194, 51);

-- Update version
UPDATE `version` SET auth_db_version = 2 WHERE auth_db_version = 1;
