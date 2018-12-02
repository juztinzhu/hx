BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS "surgery_ablationtype" (
	"id"	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	"abType"	varchar(8) NOT NULL
);
CREATE TABLE IF NOT EXISTS "surgery_anticoagulant" (
	"id"	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	"name"	varchar(64) NOT NULL
);
CREATE TABLE IF NOT EXISTS "surgery_antiarrhythmic" (
	"id"	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	"name"	varchar(64) NOT NULL
);
CREATE TABLE IF NOT EXISTS "surgery_surgerymethod" (
	"id"	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	"name"	varchar(16) NOT NULL
);
INSERT INTO "surgery_ablationtype" ("id","abType") VALUES (1,'pvi');
INSERT INTO "surgery_ablationtype" ("id","abType") VALUES (2,'tvi');
INSERT INTO "surgery_ablationtype" ("id","abType") VALUES (3,'mvi');
INSERT INTO "surgery_ablationtype" ("id","abType") VALUES (4,'roof');
INSERT INTO "surgery_ablationtype" ("id","abType") VALUES (5,'top');
INSERT INTO "surgery_ablationtype" ("id","abType") VALUES (7,'bi');
INSERT INTO "surgery_ablationtype" ("id","abType") VALUES (8,'front');
INSERT INTO "surgery_ablationtype" ("id","abType") VALUES (9,'base');
INSERT INTO "surgery_ablationtype" ("id","abType") VALUES (10,'box');
INSERT INTO "surgery_anticoagulant" ("id","name") VALUES (1,'华法林');
INSERT INTO "surgery_anticoagulant" ("id","name") VALUES (2,'阿司匹林');
INSERT INTO "surgery_anticoagulant" ("id","name") VALUES (3,'达比加群');
INSERT INTO "surgery_antiarrhythmic" ("id","name") VALUES (1,'心律平');
INSERT INTO "surgery_antiarrhythmic" ("id","name") VALUES (2,'可达龙');
INSERT INTO "surgery_antiarrhythmic" ("id","name") VALUES (3,'倍他乐克');
INSERT INTO "surgery_surgerymethod" ("id","name") VALUES (1,'Ensite');
INSERT INTO "surgery_surgerymethod" ("id","name") VALUES (2,'Watchman');
INSERT INTO "surgery_surgerymethod" ("id","name") VALUES (3,'ACP');
INSERT INTO "surgery_surgerymethod" ("id","name") VALUES (4,'Carto');
COMMIT;
