/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50540
Source Host           : localhost:3306
Source Database       : ssm_fin

Target Server Type    : MYSQL
Target Server Version : 50540
File Encoding         : 65001

Date: 2017-07-17 15:35:31
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for tbl_permission
-- ----------------------------
DROP TABLE IF EXISTS `tbl_permission`;
CREATE TABLE `tbl_permission` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `expression` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=90 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_permission
-- ----------------------------
INSERT INTO `tbl_permission` VALUES ('70', 'com.etop.controller.HomePageController.permissionManagement', '权限查询');
INSERT INTO `tbl_permission` VALUES ('71', 'com.etop.controller.HomePageController.userManagement', '用户查询');
INSERT INTO `tbl_permission` VALUES ('72', 'com.etop.controller.HomePageController.roleManagement', '角色查询');
INSERT INTO `tbl_permission` VALUES ('73', 'com.etop.controller.PermissionController.updatePermissionJson', '分配角色权限');
INSERT INTO `tbl_permission` VALUES ('74', 'com.etop.controller.PermissionController.getPermissionJson', '浏览角色所有权限');
INSERT INTO `tbl_permission` VALUES ('75', 'com.etop.controller.PermissionController.roleDelete', '权限删除');
INSERT INTO `tbl_permission` VALUES ('76', 'com.etop.controller.PermissionController.roleEdit', '权限编辑');
INSERT INTO `tbl_permission` VALUES ('77', 'com.etop.controller.PermissionController.roleAdd', '权限添加');
INSERT INTO `tbl_permission` VALUES ('78', 'com.etop.controller.RoleController.roleHandlePermission', '权限分配');
INSERT INTO `tbl_permission` VALUES ('79', 'com.etop.controller.RoleController.roleDelete', '角色删除');
INSERT INTO `tbl_permission` VALUES ('80', 'com.etop.controller.RoleController.roleEdit', '角色编辑');
INSERT INTO `tbl_permission` VALUES ('81', 'com.etop.controller.RoleController.permissionBrowse', '权限浏览');
INSERT INTO `tbl_permission` VALUES ('82', 'com.etop.controller.RoleController.updateRoleJson', '分配用户角色');
INSERT INTO `tbl_permission` VALUES ('83', 'com.etop.controller.RoleController.getRoleJson', '浏览用户所有角色');
INSERT INTO `tbl_permission` VALUES ('84', 'com.etop.controller.RoleController.roleAdd', '角色添加');
INSERT INTO `tbl_permission` VALUES ('85', 'com.etop.controller.simulationController.permissionBrowse', '播放音乐');
INSERT INTO `tbl_permission` VALUES ('86', 'com.etop.controller.UserController.roleDelete', '用户删除');
INSERT INTO `tbl_permission` VALUES ('87', 'com.etop.controller.UserController.roleEdit', '用户编辑');
INSERT INTO `tbl_permission` VALUES ('88', 'com.etop.controller.UserController.roleAdd', '用户添加');
INSERT INTO `tbl_permission` VALUES ('89', 'com.etop.controller.UserController.browse', '角色浏览');
