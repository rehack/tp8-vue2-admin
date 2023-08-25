# ************************************************************
# Sequel Ace SQL dump
# 版本号： 20050
#
# https://sequel-ace.com/
# https://github.com/Sequel-Ace/Sequel-Ace
#
# 主机: 127.0.0.1 (MySQL 8.0.33)
# 数据库: bc-business
# 生成时间: 2023-08-25 10:48:59 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
SET NAMES utf8mb4;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE='NO_AUTO_VALUE_ON_ZERO', SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# 转储表 bc_auth_access
# ------------------------------------------------------------

DROP TABLE IF EXISTS `bc_auth_access`;

CREATE TABLE `bc_auth_access` (
  `sys_users_id` int unsigned NOT NULL,
  `auth_role_id` int unsigned NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户-角色表';

LOCK TABLES `bc_auth_access` WRITE;
/*!40000 ALTER TABLE `bc_auth_access` DISABLE KEYS */;

INSERT INTO `bc_auth_access` (`sys_users_id`, `auth_role_id`)
VALUES
	(1,1),
	(2,1),
	(3,1);

/*!40000 ALTER TABLE `bc_auth_access` ENABLE KEYS */;
UNLOCK TABLES;


# 转储表 bc_auth_menu
# ------------------------------------------------------------

DROP TABLE IF EXISTS `bc_auth_menu`;

CREATE TABLE `bc_auth_menu` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(7) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '名称',
  `iconCls` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'icon class',
  `path` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'path',
  `component` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '组件',
  `pid` tinyint NOT NULL DEFAULT '0' COMMENT '父ID',
  `status` tinyint NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='系统菜单';

LOCK TABLES `bc_auth_menu` WRITE;
/*!40000 ALTER TABLE `bc_auth_menu` DISABLE KEYS */;

INSERT INTO `bc_auth_menu` (`id`, `title`, `iconCls`, `path`, `component`, `pid`, `status`)
VALUES
	(1,'巨量引擎','el-icon-phone-outline','/marketing','Layout',0,1),
	(2,'腾讯推广','el-icon-coin','/projects','Layout',0,1),
	(3,'商务数据','el-icon-data-line','/customerdata','Layout',0,1),
	(4,'项目数据','el-icon-s-data','/projectData','Layout',0,1),
	(5,'财务数据','el-icon-s-finance','/financeData','Layout',0,1),
	(6,'档案中心','el-icon-document-copy','/archives','Layout',0,1),
	(7,'南衡智库','el-icon-magic-stick','/thinktank','Layout',0,1),
	(8,'个人中心','el-icon-s-custom','/personal','Layout',0,1),
	(9,'系统设置','el-icon-setting','/settings','Layout',0,1),
	(10,'备用','el-icon-setting',NULL,'Layout',0,0),
	(11,'客户线索',NULL,'custClue','oceanengine/CustClue',1,1),
	(21,'职员管理',NULL,'staff','settings/Staff',9,1),
	(22,'数据字典',NULL,'dataDictionary','settings/DataDictionary',9,1),
	(23,'权限设置',NULL,'permission','settings/Auth',9,1),
	(24,'登录日志',NULL,'loginlog','settings/LoginLog',9,1),
	(25,'系统日志',NULL,'oplog','settings/Oplog',9,1);

/*!40000 ALTER TABLE `bc_auth_menu` ENABLE KEYS */;
UNLOCK TABLES;


# 转储表 bc_auth_role
# ------------------------------------------------------------

DROP TABLE IF EXISTS `bc_auth_role`;

CREATE TABLE `bc_auth_role` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '',
  `rules_id` varchar(350) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '角色所拥有的规则id,多个规则","隔开',
  `view_scope` char(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'self' COMMENT '查看数据范围权限(全部,部门,自己)',
  `status` tinyint unsigned NOT NULL DEFAULT '1' COMMENT '-1禁用1启用',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='角色-权限表';

LOCK TABLES `bc_auth_role` WRITE;
/*!40000 ALTER TABLE `bc_auth_role` DISABLE KEYS */;

INSERT INTO `bc_auth_role` (`id`, `name`, `title`, `rules_id`, `view_scope`, `status`)
VALUES
	(1,'系统管理员','administrator','14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,64,65,66,67,71,72,73,74,75,76,77,78,79,80,82,83,88,94,95,96,97,98,99,100,101,102,106,107,108,109,110,111,112,118,119,120,121,122,123,124,125,126,127,128,129,130,131','all',1);

/*!40000 ALTER TABLE `bc_auth_role` ENABLE KEYS */;
UNLOCK TABLES;


# 转储表 bc_auth_role_menu
# ------------------------------------------------------------

DROP TABLE IF EXISTS `bc_auth_role_menu`;

CREATE TABLE `bc_auth_role_menu` (
  `role_id` int unsigned NOT NULL,
  `menu_id` int unsigned NOT NULL,
  UNIQUE KEY `role_id` (`role_id`,`menu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='角色和菜单关联表';

LOCK TABLES `bc_auth_role_menu` WRITE;
/*!40000 ALTER TABLE `bc_auth_role_menu` DISABLE KEYS */;

INSERT INTO `bc_auth_role_menu` (`role_id`, `menu_id`)
VALUES
	(1,1),
	(1,2),
	(1,3),
	(1,4),
	(1,5),
	(1,6),
	(1,7),
	(1,8),
	(1,9),
	(1,11),
	(1,12),
	(1,13),
	(1,14),
	(1,15),
	(1,21),
	(1,22),
	(1,23),
	(1,24),
	(1,25);

/*!40000 ALTER TABLE `bc_auth_role_menu` ENABLE KEYS */;
UNLOCK TABLES;


# 转储表 bc_auth_rule
# ------------------------------------------------------------

DROP TABLE IF EXISTS `bc_auth_rule`;

CREATE TABLE `bc_auth_rule` (
  `id` mediumint unsigned NOT NULL AUTO_INCREMENT,
  `name` char(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT 'API接口地址',
  `title` char(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '接口名称',
  `pid` int unsigned NOT NULL DEFAULT '0' COMMENT '父级ID',
  `type` tinyint unsigned NOT NULL DEFAULT '1' COMMENT '1查询2增加3修改4删除5导出',
  `status` tinyint unsigned NOT NULL DEFAULT '1' COMMENT '状态：为1正常，为0禁用',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='权限规则表';

LOCK TABLES `bc_auth_rule` WRITE;
/*!40000 ALTER TABLE `bc_auth_rule` DISABLE KEYS */;

INSERT INTO `bc_auth_rule` (`id`, `name`, `title`, `pid`, `type`, `status`)
VALUES
	(1,'营销中心','商务中心',0,0,1),
	(2,'项目中心','项目中心',0,0,1),
	(3,'商务数据','商务数据',0,0,1),
	(4,'项目数据','项目数据',0,0,1),
	(5,'财务数据','财务数据',0,0,1),
	(6,'档案管理','档案管理',0,0,1),
	(7,'系统设置','系统设置',0,0,1),
	(8,'个人中心','个人中心',0,0,1),
	(9,'其他权限','其他权限',0,0,1),
	(10,'南衡智库','南衡智库',0,0,1),
	(11,'预留2','预留',0,0,0),
	(12,'预留3','预留',0,0,0),
	(13,'预留4','预留',0,0,0),
	(14,'marketing.newcustomer','新增客户',1,0,1),
	(15,'marketing.customers','查看客户',1,0,1),
	(16,'marketing.updatecustomer','更新客户资料',1,3,1),
	(94,'system.datadictionary','添加修改数据字典',7,3,1),
	(95,'system.authsetting','添加修改角色API权限',7,3,1),
	(96,'system.stafflist','查看职员列表',7,0,1),
	(97,'system.newstaff','添加职员',7,2,1),
	(98,'system.updatestaff','修改职员资料',7,3,1),
	(99,'system.resetpassword','修改登陆密码',7,3,1),
	(100,'system.updatepointrule','修改积分规则',7,3,1),
	(101,'system.oplog','查询系统日志',7,0,1),
	(102,'system.loginlog','查询登录日志',7,0,1);

/*!40000 ALTER TABLE `bc_auth_rule` ENABLE KEYS */;
UNLOCK TABLES;


# 转储表 bc_data_tree
# ------------------------------------------------------------

DROP TABLE IF EXISTS `bc_data_tree`;

CREATE TABLE `bc_data_tree` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `code` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `api` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `pid` int unsigned NOT NULL DEFAULT '0',
  `status` tinyint unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='数据字典配置项';

LOCK TABLES `bc_data_tree` WRITE;
/*!40000 ALTER TABLE `bc_data_tree` DISABLE KEYS */;

INSERT INTO `bc_data_tree` (`id`, `name`, `code`, `api`, `pid`, `status`)
VALUES
	(1,'客户类别','customer_type','marketing/customertype',0,1),
	(2,'案件来源','project_cases_source','common/casessource',0,1),
	(3,'付款方式','project_payment_method','common/paymentmethods',0,1);

/*!40000 ALTER TABLE `bc_data_tree` ENABLE KEYS */;
UNLOCK TABLES;


# 转储表 bc_department
# ------------------------------------------------------------

DROP TABLE IF EXISTS `bc_department`;

CREATE TABLE `bc_department` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `department_name` char(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '部门名称',
  `pid` tinyint unsigned NOT NULL DEFAULT '0',
  `status` tinyint unsigned NOT NULL DEFAULT '1',
  `sort` tinyint NOT NULL DEFAULT '99',
  `create_time` int unsigned DEFAULT NULL,
  `update_time` int unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `department_name` (`department_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='部门表';

LOCK TABLES `bc_department` WRITE;
/*!40000 ALTER TABLE `bc_department` DISABLE KEYS */;

INSERT INTO `bc_department` (`id`, `department_name`, `pid`, `status`, `sort`, `create_time`, `update_time`)
VALUES
	(1,'管理部',0,1,99,NULL,NULL),
	(2,'销售部',0,1,99,NULL,NULL);

/*!40000 ALTER TABLE `bc_department` ENABLE KEYS */;
UNLOCK TABLES;


# 转储表 bc_sys_users
# ------------------------------------------------------------

DROP TABLE IF EXISTS `bc_sys_users`;

CREATE TABLE `bc_sys_users` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '用户名',
  `password` char(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '密码',
  `realname` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '真实姓名',
  `phone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '手机号',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '邮箱',
  `sex` tinyint unsigned DEFAULT NULL COMMENT '性别',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '头像',
  `dept_id` tinyint unsigned NOT NULL DEFAULT '0' COMMENT '所属部门ID',
  `login_ip` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0' COMMENT '最后登录IP',
  `login_time` int unsigned NOT NULL DEFAULT '0' COMMENT '最后登录时间',
  `status` tinyint unsigned NOT NULL DEFAULT '1',
  `show` tinyint(1) NOT NULL DEFAULT '1' COMMENT '显示状态',
  `create_time` int unsigned DEFAULT NULL,
  `update_time` int unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='系统用户';

LOCK TABLES `bc_sys_users` WRITE;
/*!40000 ALTER TABLE `bc_sys_users` DISABLE KEYS */;

INSERT INTO `bc_sys_users` (`id`, `username`, `password`, `realname`, `phone`, `email`, `sex`, `avatar`, `dept_id`, `login_ip`, `login_time`, `status`, `show`, `create_time`, `update_time`)
VALUES
	(1,'admin','$2y$10$nVG14s78sAjR7eUbdKv3ReyuRXEucetTAXUZ3N1ulxJfu6ZPkkf0O','administrator','',NULL,1,'avatar/avatar_1.jpeg',1,'',0,1,1,NULL,NULL),
	(2,'user1','14e1b600b1fd579f47433b88e8d85291','测试',NULL,NULL,2,NULL,1,'0',0,1,1,1692958553,1692958553);

/*!40000 ALTER TABLE `bc_sys_users` ENABLE KEYS */;
UNLOCK TABLES;


# 转储表 bc_syslog_login
# ------------------------------------------------------------

DROP TABLE IF EXISTS `bc_syslog_login`;

CREATE TABLE `bc_syslog_login` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` smallint unsigned NOT NULL,
  `login_ip` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '登录IP',
  `url` varchar(800) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT 'URL',
  `login_env` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '登录环境',
  `user_agent` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT 'UA',
  `login_time` int unsigned NOT NULL COMMENT '登录时间',
  `create_time` int unsigned NOT NULL,
  `status` tinyint unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `bc_syslog_login` WRITE;
/*!40000 ALTER TABLE `bc_syslog_login` DISABLE KEYS */;

INSERT INTO `bc_syslog_login` (`id`, `user_id`, `login_ip`, `url`, `login_env`, `user_agent`, `login_time`, `create_time`, `status`)
VALUES
	(1,1,'172.18.0.1','http://bcbusiness.com//api/gettoken/user','PC','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/116.0.0.0 Safari/537.36',1692959325,1692959325,1);

/*!40000 ALTER TABLE `bc_syslog_login` ENABLE KEYS */;
UNLOCK TABLES;


# 转储表 bc_syslog_oplog
# ------------------------------------------------------------

DROP TABLE IF EXISTS `bc_syslog_oplog`;

CREATE TABLE `bc_syslog_oplog` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `api_id` tinyint unsigned NOT NULL COMMENT '操作接口地址',
  `method` varchar(6) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `param` varchar(6000) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '参数',
  `code` char(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0' COMMENT '响应状态码',
  `user_id` smallint unsigned NOT NULL,
  `ip` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `status` tinyint unsigned NOT NULL DEFAULT '1',
  `create_time` int unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `bc_syslog_oplog` WRITE;
/*!40000 ALTER TABLE `bc_syslog_oplog` DISABLE KEYS */;

INSERT INTO `bc_syslog_oplog` (`id`, `api_id`, `method`, `param`, `code`, `user_id`, `ip`, `status`, `create_time`)
VALUES
	(1,97,'POST','{\"staff_dept\":[1],\"roles\":[1],\"username\":\"user1\",\"password\":\"123456\",\"realname\":\"测试\",\"sex\":\"2\"}','201',1,'172.18.0.1',1,1692958553),
	(2,97,'POST','{\"staff_dept\":[1],\"roles\":[1],\"username\":\"dsa\",\"password\":\"3432434\",\"realname\":\"455t\"}','201',1,'172.18.0.1',1,1692958740);

/*!40000 ALTER TABLE `bc_syslog_oplog` ENABLE KEYS */;
UNLOCK TABLES;



/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
