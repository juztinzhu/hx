BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS "surgery_ablation" (
	"id"	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	"opTimes"	integer NOT NULL,
	"isLinear"	bool NOT NULL,
	"isLowVolt"	bool NOT NULL,
	"heartRythmAfter"	varchar(2) NOT NULL,
	"cardioversionType"	varchar(2) NOT NULL,
	"surgery_id"	integer NOT NULL,
	FOREIGN KEY("surgery_id") REFERENCES "surgery_insurgery"("patientattribute_ptr_id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "surgery_followtee" (
	"id"	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	"branchRemain"	bool NOT NULL,
	"branchWidth"	integer NOT NULL,
	"hasThrombus"	bool NOT NULL,
	"follow_id"	integer NOT NULL,
	FOREIGN KEY("follow_id") REFERENCES "surgery_surgeryfollow"("patientattribute_ptr_id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "surgery_followtte" (
	"id"	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	"LV"	integer NOT NULL,
	"LA"	integer NOT NULL,
	"RV"	integer NOT NULL,
	"RA"	integer NOT NULL,
	"EF"	integer NOT NULL,
	"MVE"	integer NOT NULL,
	"MVA"	integer NOT NULL,
	"TDIE"	integer NOT NULL,
	"TDIA"	integer NOT NULL,
	"EE"	integer NOT NULL,
	"follow_id"	integer NOT NULL,
	FOREIGN KEY("follow_id") REFERENCES "surgery_surgeryfollow"("patientattribute_ptr_id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "surgery_laa" (
	"id"	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	"xrayLAADiameter"	integer NOT NULL,
	"xrayLAADepth"	integer NOT NULL,
	"teeLAADiameter"	integer NOT NULL,
	"teeLAADepth"	integer NOT NULL,
	"umbrella"	integer NOT NULL,
	"releaseTimes"	integer NOT NULL,
	"succeed"	bool NOT NULL,
	"branchRemain"	bool NOT NULL,
	"surgery_id"	integer NOT NULL,
	FOREIGN KEY("surgery_id") REFERENCES "surgery_insurgery"("patientattribute_ptr_id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "surgery_tee" (
	"id"	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	"hasThrombus"	bool NOT NULL,
	"laa0Diameter"	integer NOT NULL,
	"laa0Depth"	integer NOT NULL,
	"laa45Diameter"	integer NOT NULL,
	"laa45Depth"	integer NOT NULL,
	"laa90Diameter"	integer NOT NULL,
	"laa90Depth"	integer NOT NULL,
	"laa135Diameter"	integer NOT NULL,
	"laa135Depth"	integer NOT NULL,
	"precheck_id"	integer NOT NULL,
	FOREIGN KEY("precheck_id") REFERENCES "surgery_precheck"("patientattribute_ptr_id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "surgery_ucg" (
	"id"	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	"LV"	integer NOT NULL,
	"LA"	integer NOT NULL,
	"RV"	integer NOT NULL,
	"RA"	integer NOT NULL,
	"EF"	integer NOT NULL,
	"precheck_id"	integer NOT NULL,
	FOREIGN KEY("precheck_id") REFERENCES "surgery_precheck"("patientattribute_ptr_id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "surgery_ablation_ablationType" (
	"id"	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	"ablation_id"	integer NOT NULL,
	"ablationtype_id"	integer NOT NULL,
	FOREIGN KEY("ablation_id") REFERENCES "surgery_ablation"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("ablationtype_id") REFERENCES "surgery_ablationtype"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "surgery_patientattribute" (
	"id"	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	"patient_id"	integer NOT NULL,
	FOREIGN KEY("patient_id") REFERENCES "surgery_patientbasic"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "surgery_patientbasic_opMethod" (
	"id"	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	"patientbasic_id"	integer NOT NULL,
	"surgerymethod_id"	integer NOT NULL,
	FOREIGN KEY("patientbasic_id") REFERENCES "surgery_patientbasic"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("surgerymethod_id") REFERENCES "surgery_surgerymethod"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "surgery_surgeryfollow" (
	"patientattribute_ptr_id"	integer NOT NULL,
	"date"	varchar(4) NOT NULL,
	FOREIGN KEY("patientattribute_ptr_id") REFERENCES "surgery_patientattribute"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("patientattribute_ptr_id")
);
CREATE TABLE IF NOT EXISTS "surgery_precheck" (
	"patientattribute_ptr_id"	integer NOT NULL,
	FOREIGN KEY("patientattribute_ptr_id") REFERENCES "surgery_patientattribute"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("patientattribute_ptr_id")
);
CREATE TABLE IF NOT EXISTS "surgery_insurgery" (
	"patientattribute_ptr_id"	integer NOT NULL,
	FOREIGN KEY("patientattribute_ptr_id") REFERENCES "surgery_patientattribute"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("patientattribute_ptr_id")
);
CREATE TABLE IF NOT EXISTS "surgery_hasbledevaluation" (
	"patientattribute_ptr_id"	integer NOT NULL,
	"h"	integer NOT NULL,
	"a"	integer NOT NULL,
	"s"	integer NOT NULL,
	"b"	integer NOT NULL,
	"l"	integer NOT NULL,
	"e"	integer NOT NULL,
	"d"	integer NOT NULL,
	"total"	integer NOT NULL,
	FOREIGN KEY("patientattribute_ptr_id") REFERENCES "surgery_patientattribute"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("patientattribute_ptr_id")
);
CREATE TABLE IF NOT EXISTS "surgery_cha2ds2vacsevaluation" (
	"patientattribute_ptr_id"	integer NOT NULL,
	"c1"	integer NOT NULL,
	"h"	integer NOT NULL,
	"a1"	integer NOT NULL,
	"d"	integer NOT NULL,
	"s"	integer NOT NULL,
	"v"	integer NOT NULL,
	"a2"	integer NOT NULL,
	"c2"	integer NOT NULL,
	"total"	integer NOT NULL,
	FOREIGN KEY("patientattribute_ptr_id") REFERENCES "surgery_patientattribute"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("patientattribute_ptr_id")
);
CREATE TABLE IF NOT EXISTS "surgery_surgerymethod" (
	"id"	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	"name"	varchar(16) NOT NULL
);
CREATE TABLE IF NOT EXISTS "surgery_patientbasic_anticoagulant" (
	"id"	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	"patientbasic_id"	integer NOT NULL,
	"anticoagulant_id"	integer NOT NULL,
	FOREIGN KEY("patientbasic_id") REFERENCES "surgery_patientbasic"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("anticoagulant_id") REFERENCES "surgery_anticoagulant"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "surgery_patientbasic_antiarrhythmic" (
	"id"	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	"patientbasic_id"	integer NOT NULL,
	"antiarrhythmic_id"	integer NOT NULL,
	FOREIGN KEY("patientbasic_id") REFERENCES "surgery_patientbasic"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("antiarrhythmic_id") REFERENCES "surgery_antiarrhythmic"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "surgery_patientbasic" (
	"id"	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	"name"	varchar(20) NOT NULL,
	"idstr"	varchar(20) NOT NULL,
	"registerId"	varchar(20) NOT NULL,
	"gender"	varchar(1) NOT NULL,
	"age"	integer NOT NULL,
	"phone"	varchar(64) NOT NULL,
	"af"	varchar(4) NOT NULL,
	"otherDisease"	varchar(255) NOT NULL,
	"lifeQualityScore"	integer NOT NULL,
	"opDate"	date NOT NULL,
	"opType"	varchar(8) NOT NULL
);
CREATE TABLE IF NOT EXISTS "surgery_anticoagulant" (
	"id"	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	"name"	varchar(64) NOT NULL
);
CREATE TABLE IF NOT EXISTS "surgery_antiarrhythmic" (
	"id"	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	"name"	varchar(64) NOT NULL
);
CREATE TABLE IF NOT EXISTS "surgery_ablationtype" (
	"id"	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	"abType"	varchar(8) NOT NULL
);
CREATE TABLE IF NOT EXISTS "django_migrations" (
	"id"	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	"app"	varchar(255) NOT NULL,
	"name"	varchar(255) NOT NULL,
	"applied"	datetime NOT NULL
);
CREATE TABLE IF NOT EXISTS "auth_group" (
	"id"	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	"name"	varchar(80) NOT NULL UNIQUE
);
CREATE TABLE IF NOT EXISTS "auth_group_permissions" (
	"id"	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	"group_id"	integer NOT NULL,
	"permission_id"	integer NOT NULL,
	FOREIGN KEY("group_id") REFERENCES "auth_group"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("permission_id") REFERENCES "auth_permission"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "auth_user_groups" (
	"id"	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	"user_id"	integer NOT NULL,
	"group_id"	integer NOT NULL,
	FOREIGN KEY("group_id") REFERENCES "auth_group"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("user_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "auth_user_user_permissions" (
	"id"	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	"user_id"	integer NOT NULL,
	"permission_id"	integer NOT NULL,
	FOREIGN KEY("permission_id") REFERENCES "auth_permission"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("user_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "django_admin_log" (
	"id"	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	"action_time"	datetime NOT NULL,
	"object_id"	text,
	"object_repr"	varchar(200) NOT NULL,
	"change_message"	text NOT NULL,
	"content_type_id"	integer,
	"user_id"	integer NOT NULL,
	"action_flag"	smallint unsigned NOT NULL,
	FOREIGN KEY("content_type_id") REFERENCES "django_content_type"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("user_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "django_content_type" (
	"id"	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	"app_label"	varchar(100) NOT NULL,
	"model"	varchar(100) NOT NULL
);
CREATE TABLE IF NOT EXISTS "auth_permission" (
	"id"	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	"content_type_id"	integer NOT NULL,
	"codename"	varchar(100) NOT NULL,
	"name"	varchar(255) NOT NULL,
	FOREIGN KEY("content_type_id") REFERENCES "django_content_type"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "auth_user" (
	"id"	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	"password"	varchar(128) NOT NULL,
	"last_login"	datetime,
	"is_superuser"	bool NOT NULL,
	"username"	varchar(150) NOT NULL UNIQUE,
	"first_name"	varchar(30) NOT NULL,
	"email"	varchar(254) NOT NULL,
	"is_staff"	bool NOT NULL,
	"is_active"	bool NOT NULL,
	"date_joined"	datetime NOT NULL,
	"last_name"	varchar(150) NOT NULL
);
CREATE TABLE IF NOT EXISTS "django_session" (
	"session_key"	varchar(40) NOT NULL,
	"session_data"	text NOT NULL,
	"expire_date"	datetime NOT NULL,
	PRIMARY KEY("session_key")
);
INSERT INTO "surgery_ablation" ("id","opTimes","isLinear","isLowVolt","heartRythmAfter","cardioversionType","surgery_id") VALUES (1,1,1,1,'sr','e',3);
INSERT INTO "surgery_followtee" ("id","branchRemain","branchWidth","hasThrombus","follow_id") VALUES (1,1,34,1,5);
INSERT INTO "surgery_followtee" ("id","branchRemain","branchWidth","hasThrombus","follow_id") VALUES (2,1,32,1,6);
INSERT INTO "surgery_followtte" ("id","LV","LA","RV","RA","EF","MVE","MVA","TDIE","TDIA","EE","follow_id") VALUES (1,34,434,34,43,43,43,43,43,34,43,5);
INSERT INTO "surgery_followtte" ("id","LV","LA","RV","RA","EF","MVE","MVA","TDIE","TDIA","EE","follow_id") VALUES (2,32,2332,32,23,32,23,23,32,23,32,6);
INSERT INTO "surgery_laa" ("id","xrayLAADiameter","xrayLAADepth","teeLAADiameter","teeLAADepth","umbrella","releaseTimes","succeed","branchRemain","surgery_id") VALUES (1,54,45,45,45,45,45,1,1,3);
INSERT INTO "surgery_tee" ("id","hasThrombus","laa0Diameter","laa0Depth","laa45Diameter","laa45Depth","laa90Diameter","laa90Depth","laa135Diameter","laa135Depth","precheck_id") VALUES (1,1,76,76,67,67,67,67,67,67,4);
INSERT INTO "surgery_ucg" ("id","LV","LA","RV","RA","EF","precheck_id") VALUES (1,45,45,45,45,45,4);
INSERT INTO "surgery_ablation_ablationType" ("id","ablation_id","ablationtype_id") VALUES (1,1,4);
INSERT INTO "surgery_ablation_ablationType" ("id","ablation_id","ablationtype_id") VALUES (2,1,5);
INSERT INTO "surgery_patientattribute" ("id","patient_id") VALUES (1,1);
INSERT INTO "surgery_patientattribute" ("id","patient_id") VALUES (2,1);
INSERT INTO "surgery_patientattribute" ("id","patient_id") VALUES (3,1);
INSERT INTO "surgery_patientattribute" ("id","patient_id") VALUES (4,1);
INSERT INTO "surgery_patientattribute" ("id","patient_id") VALUES (5,1);
INSERT INTO "surgery_patientattribute" ("id","patient_id") VALUES (6,1);
INSERT INTO "surgery_patientbasic_opMethod" ("id","patientbasic_id","surgerymethod_id") VALUES (1,1,1);
INSERT INTO "surgery_patientbasic_opMethod" ("id","patientbasic_id","surgerymethod_id") VALUES (2,1,2);
INSERT INTO "surgery_surgeryfollow" ("patientattribute_ptr_id","date") VALUES (5,'45d');
INSERT INTO "surgery_surgeryfollow" ("patientattribute_ptr_id","date") VALUES (6,'3m');
INSERT INTO "surgery_precheck" ("patientattribute_ptr_id") VALUES (4);
INSERT INTO "surgery_insurgery" ("patientattribute_ptr_id") VALUES (3);
INSERT INTO "surgery_hasbledevaluation" ("patientattribute_ptr_id","h","a","s","b","l","e","d","total") VALUES (2,1,1,1,11,1,1,1,7);
INSERT INTO "surgery_cha2ds2vacsevaluation" ("patientattribute_ptr_id","c1","h","a1","d","s","v","a2","c2","total") VALUES (1,8,1,1,1,11,1,1,1,8);
INSERT INTO "surgery_surgerymethod" ("id","name") VALUES (1,'Ensite');
INSERT INTO "surgery_surgerymethod" ("id","name") VALUES (2,'Watchman');
INSERT INTO "surgery_surgerymethod" ("id","name") VALUES (3,'ACP');
INSERT INTO "surgery_surgerymethod" ("id","name") VALUES (4,'Carto');
INSERT INTO "surgery_patientbasic_anticoagulant" ("id","patientbasic_id","anticoagulant_id") VALUES (1,1,1);
INSERT INTO "surgery_patientbasic_anticoagulant" ("id","patientbasic_id","anticoagulant_id") VALUES (2,1,2);
INSERT INTO "surgery_patientbasic_antiarrhythmic" ("id","patientbasic_id","antiarrhythmic_id") VALUES (1,1,1);
INSERT INTO "surgery_patientbasic_antiarrhythmic" ("id","patientbasic_id","antiarrhythmic_id") VALUES (2,1,2);
INSERT INTO "surgery_patientbasic" ("id","name","idstr","registerId","gender","age","phone","af","otherDisease","lifeQualityScore","opDate","opType") VALUES (1,'张三','32489324325324324','32423','M',77,'3tfgrre','ps','糖尿病+霍奇金瘤',1,'2018-11-01','RF+LAAC');
INSERT INTO "surgery_anticoagulant" ("id","name") VALUES (1,'华法林');
INSERT INTO "surgery_anticoagulant" ("id","name") VALUES (2,'阿司匹林');
INSERT INTO "surgery_anticoagulant" ("id","name") VALUES (3,'达比加群');
INSERT INTO "surgery_antiarrhythmic" ("id","name") VALUES (1,'心律平');
INSERT INTO "surgery_antiarrhythmic" ("id","name") VALUES (2,'可达龙');
INSERT INTO "surgery_antiarrhythmic" ("id","name") VALUES (3,'倍他乐克');
INSERT INTO "surgery_ablationtype" ("id","abType") VALUES (1,'pvi');
INSERT INTO "surgery_ablationtype" ("id","abType") VALUES (2,'tvi');
INSERT INTO "surgery_ablationtype" ("id","abType") VALUES (3,'mvi');
INSERT INTO "surgery_ablationtype" ("id","abType") VALUES (4,'roof');
INSERT INTO "surgery_ablationtype" ("id","abType") VALUES (5,'top');
INSERT INTO "surgery_ablationtype" ("id","abType") VALUES (7,'bi');
INSERT INTO "surgery_ablationtype" ("id","abType") VALUES (8,'front');
INSERT INTO "surgery_ablationtype" ("id","abType") VALUES (9,'base');
INSERT INTO "surgery_ablationtype" ("id","abType") VALUES (10,'box');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (39,'surgery','0001_initial','2018-12-02 15:56:29.042392');
INSERT INTO "auth_group" ("id","name") VALUES (1,'数据录入人员');
INSERT INTO "auth_group_permissions" ("id","group_id","permission_id") VALUES (1,1,25);
INSERT INTO "auth_group_permissions" ("id","group_id","permission_id") VALUES (2,1,28);
INSERT INTO "auth_group_permissions" ("id","group_id","permission_id") VALUES (3,1,32);
INSERT INTO "auth_group_permissions" ("id","group_id","permission_id") VALUES (4,1,33);
INSERT INTO "auth_group_permissions" ("id","group_id","permission_id") VALUES (5,1,36);
INSERT INTO "auth_group_permissions" ("id","group_id","permission_id") VALUES (6,1,37);
INSERT INTO "auth_group_permissions" ("id","group_id","permission_id") VALUES (7,1,40);
INSERT INTO "auth_group_permissions" ("id","group_id","permission_id") VALUES (8,1,41);
INSERT INTO "auth_group_permissions" ("id","group_id","permission_id") VALUES (9,1,44);
INSERT INTO "auth_group_permissions" ("id","group_id","permission_id") VALUES (10,1,45);
INSERT INTO "auth_group_permissions" ("id","group_id","permission_id") VALUES (11,1,48);
INSERT INTO "auth_group_permissions" ("id","group_id","permission_id") VALUES (12,1,49);
INSERT INTO "auth_group_permissions" ("id","group_id","permission_id") VALUES (13,1,52);
INSERT INTO "auth_group_permissions" ("id","group_id","permission_id") VALUES (14,1,53);
INSERT INTO "auth_group_permissions" ("id","group_id","permission_id") VALUES (15,1,56);
INSERT INTO "auth_group_permissions" ("id","group_id","permission_id") VALUES (16,1,57);
INSERT INTO "auth_group_permissions" ("id","group_id","permission_id") VALUES (17,1,60);
INSERT INTO "auth_group_permissions" ("id","group_id","permission_id") VALUES (18,1,64);
INSERT INTO "auth_group_permissions" ("id","group_id","permission_id") VALUES (19,1,65);
INSERT INTO "auth_group_permissions" ("id","group_id","permission_id") VALUES (20,1,68);
INSERT INTO "auth_group_permissions" ("id","group_id","permission_id") VALUES (21,1,72);
INSERT INTO "auth_group_permissions" ("id","group_id","permission_id") VALUES (22,1,73);
INSERT INTO "auth_group_permissions" ("id","group_id","permission_id") VALUES (23,1,76);
INSERT INTO "auth_group_permissions" ("id","group_id","permission_id") VALUES (24,1,77);
INSERT INTO "auth_group_permissions" ("id","group_id","permission_id") VALUES (25,1,80);
INSERT INTO "auth_group_permissions" ("id","group_id","permission_id") VALUES (26,1,84);
INSERT INTO "auth_group_permissions" ("id","group_id","permission_id") VALUES (27,1,88);
INSERT INTO "auth_group_permissions" ("id","group_id","permission_id") VALUES (28,1,92);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (1,'2018-11-30 05:57:04.651140','1','SurgeryType object (1)','[{"added": {}}]',8,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (2,'2018-11-30 05:57:08.070856','2','SurgeryType object (2)','[{"added": {}}]',8,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (3,'2018-11-30 06:00:17.688068','3','RF','[{"added": {}}]',8,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (4,'2018-11-30 06:00:21.108987','4','LAAC','[{"added": {}}]',8,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (5,'2018-11-30 06:05:12.950362','5','RF','[{"added": {}}]',8,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (6,'2018-11-30 06:05:17.878570','6','LAAC','[{"added": {}}]',8,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (7,'2018-11-30 06:53:09.823973','1','张三|32489324325324324','[{"added": {}}, {"added": {"name": "ch a2d s2va cs evaluation", "object": "CHA2DS2VACsEvaluation object (1)"}}, {"added": {"name": "pre check", "object": "PreCheck object (2)"}}, {"added": {"name": "ucg", "object": "UCG object (1)"}}]',12,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (8,'2018-11-30 15:14:06.195846','1','Antiarrhythmic object (1)','[{"added": {}}]',23,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (9,'2018-11-30 15:15:06.741099','2','可达龙','[{"added": {}}]',23,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (10,'2018-11-30 15:15:22.057585','3','倍他乐克','[{"added": {}}]',23,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (11,'2018-11-30 15:16:54.846878','1','华法林','[{"added": {}}]',22,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (12,'2018-11-30 15:17:08.585714','2','阿司匹林','[{"added": {}}]',22,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (13,'2018-11-30 15:17:23.480736','3','达比加群','[{"added": {}}]',22,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (14,'2018-11-30 15:19:25.254590','1','Ensite','[{"added": {}}]',16,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (15,'2018-11-30 15:19:28.847735','2','Watchman','[{"added": {}}]',16,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (16,'2018-11-30 15:19:32.456256','3','ACP','[{"added": {}}]',16,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (17,'2018-11-30 15:19:47.314350','4','Carto','[{"added": {}}]',16,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (18,'2018-11-30 15:25:55.319124','1','pvi','[{"added": {}}]',21,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (19,'2018-11-30 15:26:00.195106','2','tvi','[{"added": {}}]',21,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (20,'2018-11-30 15:26:04.457272','3','mvi','[{"added": {}}]',21,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (21,'2018-11-30 15:26:09.137655','4','roof','[{"added": {}}]',21,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (22,'2018-11-30 15:26:15.934483','5','top','[{"added": {}}]',21,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (23,'2018-11-30 15:26:41.752436','6','top','[{"added": {}}]',21,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (24,'2018-11-30 15:36:24.643758','6','顶部线','',21,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (25,'2018-11-30 15:36:33.139067','7','二尖瓣峡部线','[{"added": {}}]',21,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (26,'2018-11-30 15:36:36.851585','8','前壁线','[{"added": {}}]',21,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (27,'2018-11-30 15:36:42.071943','9','基质改良','[{"added": {}}]',21,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (28,'2018-11-30 15:37:15.167151','10','BOX','[{"added": {}}]',21,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (29,'2018-11-30 15:42:09.640183','1','张三|32489324325324324','[{"added": {}}, {"added": {"name": "ch a2d s2va cs evaluation", "object": "CHA2DS2VACsEvaluation object (1)"}}, {"added": {"name": "hasbl ed evaluation", "object": "HASBLEdEvaluation object (2)"}}, {"added": {"name": "ucg", "object": "UCG object (3)"}}, {"added": {"name": "tee", "object": "TEE object (4)"}}, {"added": {"name": "in surgery", "object": "InSurgery object (5)"}}, {"added": {"name": "ablation", "object": "Ablation object (1)"}}, {"added": {"name": "laa", "object": "LAA object (1)"}}]',12,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (30,'2018-12-01 03:43:41.693694','1','数据录入人员','[{"added": {}}]',3,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (31,'2018-12-01 03:44:47.826989','2','agent_1','[{"added": {}}]',4,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (32,'2018-12-01 14:40:15.469289','1','张三|32489324325324324','',12,1,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (33,'2018-12-02 15:58:42.456023','1','张三|32489324325324324','[{"added": {}}, {"added": {"name": "CHA2DS2-VACs\u8bc4\u5206", "object": "CHA2DS2VACsEvaluation object (1)"}}, {"added": {"name": "HAS-BLED\u8bc4\u5206", "object": "HASBLEdEvaluation object (2)"}}, {"added": {"name": "\u672f\u4e2d\u4fe1\u606f", "object": "InSurgery object (3)"}}, {"added": {"name": "\u6d88\u878d", "object": "Ablation object (1)"}}, {"added": {"name": "\u5de6\u5fc3\u8033\u5c01\u5835", "object": "LAA object (1)"}}, {"added": {"name": "\u672f\u524d\u68c0\u67e5", "object": "PreCheck object (4)"}}, {"added": {"name": "ucg", "object": "UCG object (1)"}}, {"added": {"name": "tee", "object": "TEE object (1)"}}]',12,1,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (34,'2018-12-02 15:59:10.778643','1','张三|32489324325324324','[{"added": {"name": "\u672f\u540e\u968f\u8bbf", "object": "SurgeryFollow object (5)"}}, {"added": {"name": "TTE", "object": "FollowTTE object (1)"}}, {"added": {"name": "TEE", "object": "FollowTEE object (1)"}}]',12,1,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (35,'2018-12-02 15:59:36.412109','1','张三|32489324325324324','[{"added": {"name": "\u672f\u540e\u968f\u8bbf", "object": "SurgeryFollow object (6)"}}, {"added": {"name": "TTE", "object": "FollowTTE object (2)"}}, {"added": {"name": "TEE", "object": "FollowTEE object (2)"}}]',12,1,2);
INSERT INTO "django_content_type" ("id","app_label","model") VALUES (1,'admin','logentry');
INSERT INTO "django_content_type" ("id","app_label","model") VALUES (2,'auth','permission');
INSERT INTO "django_content_type" ("id","app_label","model") VALUES (3,'auth','group');
INSERT INTO "django_content_type" ("id","app_label","model") VALUES (4,'auth','user');
INSERT INTO "django_content_type" ("id","app_label","model") VALUES (5,'contenttypes','contenttype');
INSERT INTO "django_content_type" ("id","app_label","model") VALUES (6,'sessions','session');
INSERT INTO "django_content_type" ("id","app_label","model") VALUES (7,'surgery','patient');
INSERT INTO "django_content_type" ("id","app_label","model") VALUES (8,'surgery','surgerytype');
INSERT INTO "django_content_type" ("id","app_label","model") VALUES (9,'surgery','patientattribute');
INSERT INTO "django_content_type" ("id","app_label","model") VALUES (10,'surgery','hasbledevaluation');
INSERT INTO "django_content_type" ("id","app_label","model") VALUES (11,'surgery','precheck');
INSERT INTO "django_content_type" ("id","app_label","model") VALUES (12,'surgery','patientbasic');
INSERT INTO "django_content_type" ("id","app_label","model") VALUES (13,'surgery','surgeryinfo');
INSERT INTO "django_content_type" ("id","app_label","model") VALUES (14,'surgery','cha2ds2vacsevaluation');
INSERT INTO "django_content_type" ("id","app_label","model") VALUES (15,'surgery','ucg');
INSERT INTO "django_content_type" ("id","app_label","model") VALUES (16,'surgery','surgerymethod');
INSERT INTO "django_content_type" ("id","app_label","model") VALUES (17,'surgery','tee');
INSERT INTO "django_content_type" ("id","app_label","model") VALUES (18,'surgery','ablation');
INSERT INTO "django_content_type" ("id","app_label","model") VALUES (19,'surgery','laa');
INSERT INTO "django_content_type" ("id","app_label","model") VALUES (20,'surgery','insurgery');
INSERT INTO "django_content_type" ("id","app_label","model") VALUES (21,'surgery','ablationtype');
INSERT INTO "django_content_type" ("id","app_label","model") VALUES (22,'surgery','anticoagulant');
INSERT INTO "django_content_type" ("id","app_label","model") VALUES (23,'surgery','antiarrhythmic');
INSERT INTO "django_content_type" ("id","app_label","model") VALUES (24,'surgery','followtee');
INSERT INTO "django_content_type" ("id","app_label","model") VALUES (25,'surgery','followtte');
INSERT INTO "django_content_type" ("id","app_label","model") VALUES (26,'surgery','surgeryfollow');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (1,1,'add_logentry','Can add log entry');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (2,1,'change_logentry','Can change log entry');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (3,1,'delete_logentry','Can delete log entry');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (4,1,'view_logentry','Can view log entry');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (5,2,'add_permission','Can add permission');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (6,2,'change_permission','Can change permission');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (7,2,'delete_permission','Can delete permission');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (8,2,'view_permission','Can view permission');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (9,3,'add_group','Can add group');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (10,3,'change_group','Can change group');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (11,3,'delete_group','Can delete group');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (12,3,'view_group','Can view group');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (13,4,'add_user','Can add user');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (14,4,'change_user','Can change user');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (15,4,'delete_user','Can delete user');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (16,4,'view_user','Can view user');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (17,5,'add_contenttype','Can add content type');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (18,5,'change_contenttype','Can change content type');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (19,5,'delete_contenttype','Can delete content type');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (20,5,'view_contenttype','Can view content type');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (21,6,'add_session','Can add session');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (22,6,'change_session','Can change session');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (23,6,'delete_session','Can delete session');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (24,6,'view_session','Can view session');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (25,7,'add_patient','Can add patient');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (26,7,'change_patient','Can change patient');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (27,7,'delete_patient','Can delete patient');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (28,7,'view_patient','Can view patient');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (29,8,'add_surgerytype','Can add surgery type');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (30,8,'change_surgerytype','Can change surgery type');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (31,8,'delete_surgerytype','Can delete surgery type');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (32,8,'view_surgerytype','Can view surgery type');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (33,9,'add_patientattribute','Can add patient attribute');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (34,9,'change_patientattribute','Can change patient attribute');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (35,9,'delete_patientattribute','Can delete patient attribute');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (36,9,'view_patientattribute','Can view patient attribute');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (37,10,'add_hasbledevaluation','Can add hasbl ed evaluation');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (38,10,'change_hasbledevaluation','Can change hasbl ed evaluation');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (39,10,'delete_hasbledevaluation','Can delete hasbl ed evaluation');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (40,10,'view_hasbledevaluation','Can view hasbl ed evaluation');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (41,11,'add_precheck','Can add pre check');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (42,11,'change_precheck','Can change pre check');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (43,11,'delete_precheck','Can delete pre check');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (44,11,'view_precheck','Can view pre check');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (45,12,'add_patientbasic','Can add patient basic');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (46,12,'change_patientbasic','Can change patient basic');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (47,12,'delete_patientbasic','Can delete patient basic');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (48,12,'view_patientbasic','Can view patient basic');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (49,13,'add_surgeryinfo','Can add surgery info');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (50,13,'change_surgeryinfo','Can change surgery info');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (51,13,'delete_surgeryinfo','Can delete surgery info');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (52,13,'view_surgeryinfo','Can view surgery info');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (53,14,'add_cha2ds2vacsevaluation','Can add ch a2d s2va cs evaluation');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (54,14,'change_cha2ds2vacsevaluation','Can change ch a2d s2va cs evaluation');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (55,14,'delete_cha2ds2vacsevaluation','Can delete ch a2d s2va cs evaluation');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (56,14,'view_cha2ds2vacsevaluation','Can view ch a2d s2va cs evaluation');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (57,15,'add_ucg','Can add ucg');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (58,15,'change_ucg','Can change ucg');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (59,15,'delete_ucg','Can delete ucg');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (60,15,'view_ucg','Can view ucg');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (61,16,'add_surgerymethod','Can add surgery method');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (62,16,'change_surgerymethod','Can change surgery method');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (63,16,'delete_surgerymethod','Can delete surgery method');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (64,16,'view_surgerymethod','Can view surgery method');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (65,17,'add_tee','Can add tee');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (66,17,'change_tee','Can change tee');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (67,17,'delete_tee','Can delete tee');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (68,17,'view_tee','Can view tee');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (69,18,'add_ablation','Can add ablation');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (70,18,'change_ablation','Can change ablation');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (71,18,'delete_ablation','Can delete ablation');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (72,18,'view_ablation','Can view ablation');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (73,19,'add_laa','Can add laa');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (74,19,'change_laa','Can change laa');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (75,19,'delete_laa','Can delete laa');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (76,19,'view_laa','Can view laa');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (77,20,'add_insurgery','Can add in surgery');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (78,20,'change_insurgery','Can change in surgery');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (79,20,'delete_insurgery','Can delete in surgery');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (80,20,'view_insurgery','Can view in surgery');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (81,21,'add_ablationtype','Can add ablation type');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (82,21,'change_ablationtype','Can change ablation type');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (83,21,'delete_ablationtype','Can delete ablation type');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (84,21,'view_ablationtype','Can view ablation type');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (85,22,'add_anticoagulant','Can add anticoagulant');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (86,22,'change_anticoagulant','Can change anticoagulant');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (87,22,'delete_anticoagulant','Can delete anticoagulant');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (88,22,'view_anticoagulant','Can view anticoagulant');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (89,23,'add_antiarrhythmic','Can add antiarrhythmic');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (90,23,'change_antiarrhythmic','Can change antiarrhythmic');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (91,23,'delete_antiarrhythmic','Can delete antiarrhythmic');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (92,23,'view_antiarrhythmic','Can view antiarrhythmic');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (93,24,'add_followtee','Can add TEE');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (94,24,'change_followtee','Can change TEE');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (95,24,'delete_followtee','Can delete TEE');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (96,24,'view_followtee','Can view TEE');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (97,25,'add_followtte','Can add TTE');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (98,25,'change_followtte','Can change TTE');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (99,25,'delete_followtte','Can delete TTE');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (100,25,'view_followtte','Can view TTE');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (101,26,'add_surgeryfollow','Can add 术后随访');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (102,26,'change_surgeryfollow','Can change 术后随访');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (103,26,'delete_surgeryfollow','Can delete 术后随访');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (104,26,'view_surgeryfollow','Can view 术后随访');
INSERT INTO "auth_user" ("id","password","last_login","is_superuser","username","first_name","email","is_staff","is_active","date_joined","last_name") VALUES (1,'pbkdf2_sha256$120000$nKRgfBQC06TA$7XorksYz5N5QgefHcPpFN+A8gDkYQRDfYIImXzMsB74=','2018-12-01 02:56:33.743593',1,'admin','','',1,1,'2018-11-30 01:40:10.107777','');
INSERT INTO "auth_user" ("id","password","last_login","is_superuser","username","first_name","email","is_staff","is_active","date_joined","last_name") VALUES (2,'pbkdf2_sha256$120000$rS7irL2Zk31t$e/EtmsTqV1i9pPpKwSAZEj7t1y+CIVOyOb3iBcwfaCU=',NULL,0,'agent_1','','',0,1,'2018-12-01 03:44:47.664380','');
INSERT INTO "django_session" ("session_key","session_data","expire_date") VALUES ('isu211nfl2vl1mz72m6rr4hv5ducsphb','ODI1MjJjNDE4Y2E2YmY3NmQ1MjEyOWZiZTQ5YzUzYTNiYTExNDhmNjp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI3ODdmYmMyM2JlYTc2MDdlZTkyYTFlMzgzOTc5NTQxODA2OTM1MDUyIn0=','2018-12-14 13:51:27.753486');
INSERT INTO "django_session" ("session_key","session_data","expire_date") VALUES ('u6xt22y3is7zoshcyer95xwsfg8tyb43','ODI1MjJjNDE4Y2E2YmY3NmQ1MjEyOWZiZTQ5YzUzYTNiYTExNDhmNjp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI3ODdmYmMyM2JlYTc2MDdlZTkyYTFlMzgzOTc5NTQxODA2OTM1MDUyIn0=','2018-12-15 02:56:33.852794');
CREATE INDEX IF NOT EXISTS "surgery_ablation_surgery_id_3338d338" ON "surgery_ablation" (
	"surgery_id"
);
CREATE INDEX IF NOT EXISTS "surgery_followtee_follow_id_abcfc1c0" ON "surgery_followtee" (
	"follow_id"
);
CREATE INDEX IF NOT EXISTS "surgery_followtte_follow_id_41d12d65" ON "surgery_followtte" (
	"follow_id"
);
CREATE INDEX IF NOT EXISTS "surgery_laa_surgery_id_e16d1e3d" ON "surgery_laa" (
	"surgery_id"
);
CREATE INDEX IF NOT EXISTS "surgery_tee_precheck_id_7086969a" ON "surgery_tee" (
	"precheck_id"
);
CREATE INDEX IF NOT EXISTS "surgery_ucg_precheck_id_b626fcaa" ON "surgery_ucg" (
	"precheck_id"
);
CREATE INDEX IF NOT EXISTS "surgery_ablation_ablationType_ablationtype_id_678a158a" ON "surgery_ablation_ablationType" (
	"ablationtype_id"
);
CREATE INDEX IF NOT EXISTS "surgery_ablation_ablationType_ablation_id_b24fd544" ON "surgery_ablation_ablationType" (
	"ablation_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "surgery_ablation_ablationType_ablation_id_ablationtype_id_7ef42e87_uniq" ON "surgery_ablation_ablationType" (
	"ablation_id",
	"ablationtype_id"
);
CREATE INDEX IF NOT EXISTS "surgery_patientattribute_patient_id_621613b4" ON "surgery_patientattribute" (
	"patient_id"
);
CREATE INDEX IF NOT EXISTS "surgery_patientbasic_opMethod_surgerymethod_id_1dac2a5a" ON "surgery_patientbasic_opMethod" (
	"surgerymethod_id"
);
CREATE INDEX IF NOT EXISTS "surgery_patientbasic_opMethod_patientbasic_id_8b0069e7" ON "surgery_patientbasic_opMethod" (
	"patientbasic_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "surgery_patientbasic_opMethod_patientbasic_id_surgerymethod_id_348f4261_uniq" ON "surgery_patientbasic_opMethod" (
	"patientbasic_id",
	"surgerymethod_id"
);
CREATE INDEX IF NOT EXISTS "surgery_patientbasic_anticoagulant_anticoagulant_id_317283a3" ON "surgery_patientbasic_anticoagulant" (
	"anticoagulant_id"
);
CREATE INDEX IF NOT EXISTS "surgery_patientbasic_anticoagulant_patientbasic_id_9867065a" ON "surgery_patientbasic_anticoagulant" (
	"patientbasic_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "surgery_patientbasic_anticoagulant_patientbasic_id_anticoagulant_id_b177c2f8_uniq" ON "surgery_patientbasic_anticoagulant" (
	"patientbasic_id",
	"anticoagulant_id"
);
CREATE INDEX IF NOT EXISTS "surgery_patientbasic_antiarrhythmic_antiarrhythmic_id_0b722b92" ON "surgery_patientbasic_antiarrhythmic" (
	"antiarrhythmic_id"
);
CREATE INDEX IF NOT EXISTS "surgery_patientbasic_antiarrhythmic_patientbasic_id_7e63c2b9" ON "surgery_patientbasic_antiarrhythmic" (
	"patientbasic_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "surgery_patientbasic_antiarrhythmic_patientbasic_id_antiarrhythmic_id_9b383004_uniq" ON "surgery_patientbasic_antiarrhythmic" (
	"patientbasic_id",
	"antiarrhythmic_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "auth_group_permissions_group_id_permission_id_0cd325b0_uniq" ON "auth_group_permissions" (
	"group_id",
	"permission_id"
);
CREATE INDEX IF NOT EXISTS "auth_group_permissions_group_id_b120cbf9" ON "auth_group_permissions" (
	"group_id"
);
CREATE INDEX IF NOT EXISTS "auth_group_permissions_permission_id_84c5c92e" ON "auth_group_permissions" (
	"permission_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "auth_user_groups_user_id_group_id_94350c0c_uniq" ON "auth_user_groups" (
	"user_id",
	"group_id"
);
CREATE INDEX IF NOT EXISTS "auth_user_groups_user_id_6a12ed8b" ON "auth_user_groups" (
	"user_id"
);
CREATE INDEX IF NOT EXISTS "auth_user_groups_group_id_97559544" ON "auth_user_groups" (
	"group_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "auth_user_user_permissions_user_id_permission_id_14a6b632_uniq" ON "auth_user_user_permissions" (
	"user_id",
	"permission_id"
);
CREATE INDEX IF NOT EXISTS "auth_user_user_permissions_user_id_a95ead1b" ON "auth_user_user_permissions" (
	"user_id"
);
CREATE INDEX IF NOT EXISTS "auth_user_user_permissions_permission_id_1fbb5f2c" ON "auth_user_user_permissions" (
	"permission_id"
);
CREATE INDEX IF NOT EXISTS "django_admin_log_content_type_id_c4bce8eb" ON "django_admin_log" (
	"content_type_id"
);
CREATE INDEX IF NOT EXISTS "django_admin_log_user_id_c564eba6" ON "django_admin_log" (
	"user_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "django_content_type_app_label_model_76bd3d3b_uniq" ON "django_content_type" (
	"app_label",
	"model"
);
CREATE UNIQUE INDEX IF NOT EXISTS "auth_permission_content_type_id_codename_01ab375a_uniq" ON "auth_permission" (
	"content_type_id",
	"codename"
);
CREATE INDEX IF NOT EXISTS "auth_permission_content_type_id_2f476e4b" ON "auth_permission" (
	"content_type_id"
);
CREATE INDEX IF NOT EXISTS "django_session_expire_date_a5c62663" ON "django_session" (
	"expire_date"
);
COMMIT;
