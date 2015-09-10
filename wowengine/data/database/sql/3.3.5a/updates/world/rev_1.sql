# fixed garments of quest related to Guard Roberts
UPDATE `creature_template` SET unit_flags = 4104 WHERE entry = 12423;

UPDATE `version` SET world_db_version = 1 WHERE world_db_version = 0;
