/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50540
Source Host           : localhost:3306
Source Database       : ssm_fin

Target Server Type    : MYSQL
Target Server Version : 50540
File Encoding         : 65001

Date: 2017-07-17 15:35:22
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for role_rp_ref_permission
-- ----------------------------
DROP TABLE IF EXISTS `role_rp_ref_permission`;
CREATE TABLE `role_rp_ref_permission` (
  `id` bigint(255) NOT NULL AUTO_INCREMENT,
  `role` bigint(255) NOT NULL,
  `permission` bigint(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `role` (`role`),
  KEY `permission` (`permission`),
  CONSTRAINT `role_rp_ref_permission_ibfk_1` FOREIGN KEY (`role`) REFERENCES `tbl_role` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `role_rp_ref_permission_ibfk_2` FOREIGN KEY (`permission`) REFERENCES `tbl_permission` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of role_rp_ref_permission
-- ----------------------------
INSERT INTO `role_rp_ref_permission` VALUES ('2', '1', '70');
INSERT INTO `role_rp_ref_permission` VALUES ('3', '1', '71');
INSERT INTO `role_rp_ref_permission` VALUES ('4', '1', '72');
INSERT INTO `role_rp_ref_permission` VALUES ('5', '1', '73');
INSERT INTO `role_rp_ref_permission` VALUES ('6', '1', '74');
INSERT INTO `role_rp_ref_permission` VALUES ('7', '1', '75');
INSERT INTO `role_rp_ref_permission` VALUES ('8', '1', '76');
INSERT INTO `role_rp_ref_permission` VALUES ('9', '1', '77');
INSERT INTO `role_rp_ref_permission` VALUES ('10', '1', '78');
INSERT INTO `role_rp_ref_permission` VALUES ('11', '1', '79');
INSERT INTO `role_rp_ref_permission` VALUES ('12', '1', '80');
INSERT INTO `role_rp_ref_permission` VALUES ('13', '1', '81');
INSERT INTO `role_rp_ref_permission` VALUES ('14', '1', '82');
INSERT INTO `role_rp_ref_permission` VALUES ('15', '1', '83');
INSERT INTO `role_rp_ref_permission` VALUES ('16', '1', '84');
INSERT INTO `role_rp_ref_permission` VALUES ('17', '1', '85');
INSERT INTO `role_rp_ref_permission` VALUES ('18', '1', '86');
INSERT INTO `role_rp_ref_permission` VALUES ('19', '1', '87');
INSERT INTO `role_rp_ref_permission` VALUES ('20', '1', '88');
INSERT INTO `role_rp_ref_permission` VALUES ('21', '1', '89');
