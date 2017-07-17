/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50540
Source Host           : localhost:3306
Source Database       : ssm_fin

Target Server Type    : MYSQL
Target Server Version : 50540
File Encoding         : 65001

Date: 2017-07-17 15:35:56
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for user_ur_ref_role
-- ----------------------------
DROP TABLE IF EXISTS `user_ur_ref_role`;
CREATE TABLE `user_ur_ref_role` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `role` bigint(20) NOT NULL,
  `user` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user` (`user`),
  KEY `role` (`role`),
  CONSTRAINT `user_ur_ref_role_ibfk_1` FOREIGN KEY (`user`) REFERENCES `tbl_user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `user_ur_ref_role_ibfk_2` FOREIGN KEY (`role`) REFERENCES `tbl_role` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user_ur_ref_role
-- ----------------------------
INSERT INTO `user_ur_ref_role` VALUES ('14', '1', '1');
INSERT INTO `user_ur_ref_role` VALUES ('27', '3', '3');
INSERT INTO `user_ur_ref_role` VALUES ('28', '3', '3');
INSERT INTO `user_ur_ref_role` VALUES ('32', '2', '2');
INSERT INTO `user_ur_ref_role` VALUES ('33', '2', '2');
INSERT INTO `user_ur_ref_role` VALUES ('37', '5', '5');
INSERT INTO `user_ur_ref_role` VALUES ('38', '5', '4');
