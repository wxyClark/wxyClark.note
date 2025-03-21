/*
 Navicat Premium Dump SQL

 Source Server         : Lite72_Dev
 Source Server Type    : MySQL
 Source Server Version : 50744 (5.7.44-log)
 Source Host           : 127.0.0.1:3306
 Source Schema         : yii_adv_go

 Target Server Type    : MySQL
 Target Server Version : 50744 (5.7.44-log)
 File Encoding         : 65001

 Date: 11/03/2025 08:04:45
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for const_dict
-- ----------------------------
DROP TABLE IF EXISTS `common_const_dict`;
CREATE TABLE `const_dict` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `const_code` varchar(64) NOT NULL DEFAULT '',
  `app_code` varchar(32) NOT NULL DEFAULT '',
  `table_name` varchar(32) NOT NULL DEFAULT '',
  `column_name` varchar(32) NOT NULL DEFAULT '',
  `remark` varchar(255) NOT NULL DEFAULT '',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP  COMMENT '创建时间',
  `created_by` varchar(25) NOT NULL DEFAULT '' COMMENT '创建人',
  `updated_at` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `updated_by` varchar(25) NOT NULL DEFAULT '' COMMENT '更新人',
  PRIMARY KEY (`id`),
  UNIQUE KEY `const_code` (`const_code`),
  UNIQUE KEY `table_column` (`table_name`,`column_name`),
  KEY `app_code` (`app_code`(8))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='数据字典';

-- ----------------------------
-- Table structure for const_dict_detail
-- ----------------------------
DROP TABLE IF EXISTS `common_const_dict_detail`;
CREATE TABLE `const_dict_detail` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `const_code` varchar(64) NOT NULL DEFAULT '',
  `const_value` int(11) unsigned NOT NULL DEFAULT '0',
  `const_name` varchar(128) NOT NULL DEFAULT '',
  `description` text NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP  COMMENT '创建时间',
  `created_by` varchar(25) NOT NULL DEFAULT '' COMMENT '创建人',
  `updated_at` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `updated_by` varchar(25) NOT NULL DEFAULT '' COMMENT '更新人',
  PRIMARY KEY (`id`),
  UNIQUE KEY `const_code_value` (`const_code`,`const_value`),
  KEY `const_code` (`const_code`),
  KEY `const_name` (`const_name`(64))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='数据字典details';

DROP TABLE IF EXISTS `common_level`;
CREATE TABLE `common_level` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `type` tinyint(2) unsigned NOT NULL DEFAULT '1' COMMENT '1：线下证书等级，2：野狐等级，3：腾讯围棋等级',
  `level_code` char(3) NOT NULL DEFAULT '',
  `level_name` varchar(20) NOT NULL DEFAULT COMMENT '等级名称',
  `level_basic_score` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '基础分',
  `description` text NOT NULL COMMENT '等级描述',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP  COMMENT '创建时间',
  `created_by` varchar(25) NOT NULL DEFAULT '' COMMENT '创建人',
  `updated_at` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `updated_by` varchar(25) NOT NULL DEFAULT '' COMMENT '更新人',
  PRIMARY KEY (`id`),
  UNIQUE KEY `const_code_value` (`const_code`,`const_value`),
  KEY `const_code` (`const_code`),
  KEY `const_name` (`const_name`(64))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='数据字典details';


--  admin 表 超管员

-- ----------------------------
-- Table structure for organization
-- ----------------------------
DROP TABLE IF EXISTS `organization`;
CREATE TABLE `organization` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `org_code` varchar(64) NOT NULL DEFAULT '' COMMENT '组织编码',
  `org_name` varchar(255) NOT NULL DEFAULT '' COMMENT '组织名称',
  `status` tinyint(3) unsigned NOT NULL DEFAULT 1 COMMENT '状态',
  `contacts` varchar(20) NOT NULL DEFAULT '' COMMENT '联系人',
  `phone` int(11) unsigned NOT NULL DEFAULT 0 COMMENT '电话',
  `province` int(7) unsigned NOT NULL COMMENT '省份编码',
  `city` int(7) unsigned NOT NULL DEFAULT 0 COMMENT '城市编码',
  `area` int(7) unsigned NOT NULL DEFAULT 0 COMMENT '县区编码',
  `addres` varchar(255) NOT NULL DEFAULT '' COMMENT '具体地址',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP  COMMENT '创建时间',
  `created_by` varchar(25) NOT NULL DEFAULT '' COMMENT '创建人',
  `updated_at` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `updated_by` varchar(25) NOT NULL DEFAULT '' COMMENT '更新人',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='组织';

DROP TABLE IF EXISTS `org_config`;
CREATE TABLE `organization` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `org_code` varchar(64) NOT NULL DEFAULT '' COMMENT '组织编码',
  `config_type` varchar(64) NOT NULL DEFAULT '' COMMENT '配置类别',
  `config_key` varchar(64) NOT NULL DEFAULT '' COMMENT '配置项',
  `config_value` json(64) NULL COMMENT '配置内容',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP  COMMENT '创建时间',
  `created_by` varchar(25) NOT NULL DEFAULT '' COMMENT '创建人',
  `updated_at` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `updated_by` varchar(25) NOT NULL DEFAULT '' COMMENT '更新人',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='组织配置';

-- ----------------------------
-- Table structure for race
-- ----------------------------
DROP TABLE IF EXISTS `race`;
CREATE TABLE `race` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `race_code` varchar(25) NOT NULL COMMENT '比赛编码',
  `org_code` varchar(25) NOT NULL COMMENT '组织',
  `number` int(10) unsigned NOT NULL COMMENT '比赛届次',
  `start_at` datetime NOT NULL DEFAULT '1970-01-01 00:00:01' COMMENT '开始时间',
  `end_at` datetime NOT NULL DEFAULT '1970-01-01 00:00:01' COMMENT '结束时间',
  `user_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '参与用户数',
  `complete_rate` decimal(8,5) NOT NULL DEFAULT '0.00000' COMMENT '完成率',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '状态（1未开始 2 进行中 3以结束）',
  `stop_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '停赛人数',
  `back_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '复赛人数',
  `leave_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '退赛人数',
  `new_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '新报赛人数',
  `remark` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '总结(备注)',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP  COMMENT '创建时间',
  `created_by` varchar(25) NOT NULL DEFAULT '' COMMENT '创建人',
  `updated_at` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `updated_by` varchar(25) NOT NULL DEFAULT '' COMMENT '更新人',
  PRIMARY KEY (`id`),
  UNIQUE KEY `group_code` (`org_code`,`number`) USING BTREE,
  KEY `status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='比赛';


DROP TABLE IF EXISTS `race_detail`;
CREATE TABLE `race_detail` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `org_code` varchar(25) NOT NULL COMMENT '组织',
  `race_code`varchar(25) NOT NULL COMMENT '比赛编码',
  `black_player_code` varchar(25) NOT NULL COMMENT '黑方',
  `white_player_code` varchar(25) NOT NULL COMMENT '白方',
  `black_player_score` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '黑方得分(0:负;1:平;2:胜)',
  `black_player_score` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '黑方得分(0:负;1:平;2:胜)',
  `remark` varchar(255) unsigned NOT NULL DEFAULT '0' COMMENT '备注',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP  COMMENT '创建时间',
  `created_by` varchar(25) NOT NULL DEFAULT '' COMMENT '创建人',
  `checked_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '确认时间',
  `checked_by` varchar(25) NOT NULL DEFAULT '' COMMENT '确认人',
  `updated_at` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `updated_by` varchar(25) NOT NULL DEFAULT '' COMMENT '更新人',
  PRIMARY KEY (`id`),
  UNIQUE KEY `group_code` (`org_code`,`number`) USING BTREE,
  KEY `status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='比赛';


DROP TABLE IF EXISTS `race_result`;
CREATE TABLE `race_detail` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `org_code` varchar(25) NOT NULL COMMENT '组织',
  `race_code`varchar(25) NOT NULL COMMENT '比赛编码',
  `player_code` varchar(25) NOT NULL COMMENT '玩家',
  `player_tag` tinyint(2) unsigned NOT NULL COMMENT '参赛者标签(1:学生)',
  `win_score` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '胜场分',
  `opponent_score` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '对手分(区分比赛类型：轮次赛、循环赛)',
  `add_up_win_score` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '累进分',
  `gitf_score` int(10) NOT NULL DEFAULT '0' COMMENT '赋分(可手动调整)',
  `total_score` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '总分(用于排名)',
  `team_change` tinyint(2) NOT NULL DEFAULT '0' COMMENT '组别调整(-2：降2组，-1：降1组；0：保组；1：升1组；2：升2组)',
  -- 研究云蛇 算分规则
  `remark` varchar(255) unsigned NOT NULL DEFAULT '0' COMMENT '备注',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP  COMMENT '创建时间',
  `created_by` varchar(25) NOT NULL DEFAULT '' COMMENT '创建人',
  `updated_at` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `updated_by` varchar(25) NOT NULL DEFAULT '' COMMENT '更新人',
  PRIMARY KEY (`id`),
  UNIQUE KEY `group_code` (`org_code`,`number`) USING BTREE,
  KEY `status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='比赛';

-- ----------------------------
-- Table structure for region
-- ----------------------------
DROP TABLE IF EXISTS `common_region`;
CREATE TABLE `region` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `code` int(7) unsigned NOT NULL COMMENT '区域编码',
  `name` varchar(255) NOT NULL COMMENT '区域名称',
  `parent_code` int(7) unsigned NOT NULL COMMENT '父级编码',
  `depth` tinyint(3) NOT NULL COMMENT '深度',T '创建时间',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP  COMMENT '创建时间',
  `created_by` varchar(25) NOT NULL DEFAULT '' COMMENT '创建人',
  `updated_at` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `updated_by` varchar(25) NOT NULL DEFAULT '' COMMENT '更新人',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='区域';


DROP TABLE IF EXISTS `player`;
CREATE TABLE `region` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `player_code` varchar(25) NOT NULL COMMENT '编码',
  `player_name` varchar(32) NOT NULL COMMENT '名称',
  `password` varchar(255) NOT NULL COMMENT '密码',
  `nick_name` varchar(32) NOT NULL COMMENT '昵称',
  `org_code` varchar(25) NOT NULL COMMENT '组织编码',
  `big_team` varchar(25) NOT NULL COMMENT '大组别',
  `cert_level` tinyint(2) unsigned NOT NULL COMMENT '线下等级',
  `online_level` tinyint(2) unsigned NOT NULL COMMENT '网络等级(fox)',
  `status` tinyint(2) unsigned NOT NULL COMMENT '状态(1:初次报赛；2：在赛；3：停赛；4：退赛；5：恢复参赛)',
  `basic_score` int unsigned NOT NULL COMMENT '基础分',
  `gift_score` int unsigned NOT NULL COMMENT '赋分',
  `total_score` int unsigned NOT NULL COMMENT '总分',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP  COMMENT '创建时间',
  `updated_at` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP  COMMENT '创建时间',
  `created_by` varchar(25) NOT NULL DEFAULT '' COMMENT '创建人',
  `updated_at` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `updated_by` varchar(25) NOT NULL DEFAULT '' COMMENT '更新人',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='参赛者';


DROP TABLE IF EXISTS `pre_grouping`;
CREATE TABLE `region` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `race_code` varchar(25) NOT NULL COMMENT '比赛编码',
  `org_code` varchar(25) NOT NULL COMMENT '组织编码',
  `player_code` varchar(25) NOT NULL COMMENT '参赛者编码',
  `player_score` int(10) unsigned NOT NULL COMMENT '参赛者分值',
  `tag` tinyint(2) unsigned NOT NULL COMMENT '参赛者标签',
  `team_id` tinyint(2) unsigned NOT NULL COMMENT '小组编号',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP  COMMENT '创建时间',
  `created_by` varchar(25) NOT NULL DEFAULT '' COMMENT '创建人',
  `updated_at` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `updated_by` varchar(25) NOT NULL DEFAULT '' COMMENT '更新人',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='预分组';


SET FOREIGN_KEY_CHECKS = 1;
