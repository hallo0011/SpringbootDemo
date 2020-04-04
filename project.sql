/*
 Navicat Premium Data Transfer

 Source Server         : Local
 Source Server Type    : MySQL
 Source Server Version : 80017
 Source Host           : localhost:3306
 Source Schema         : project

 Target Server Type    : MySQL
 Target Server Version : 80017
 File Encoding         : 65001

 Date: 04/04/2020 10:53:01
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for menu
-- ----------------------------
DROP TABLE IF EXISTS `menu`;
CREATE TABLE `menu`  (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `path` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'Vue路由中path',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'Vue路由中name',
  `name_zh` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '中文名称',
  `icon` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '图标',
  `component` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '组件',
  `parent_id` int(10) DEFAULT NULL COMMENT '父节点id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of menu
-- ----------------------------
INSERT INTO `menu` VALUES (1, '/admin', 'Admin', '首页', 'el-icon-s-home', 'AdminIndex', 0);
INSERT INTO `menu` VALUES (2, '/admin/dashboard', 'DashBoard', '运行情况', NULL, 'dashboard/Index', 1);
INSERT INTO `menu` VALUES (3, '/admin', 'User', '用户管理', 'el-icon-user', 'AdminIndex', 0);
INSERT INTO `menu` VALUES (4, '/admin/user/Profile', 'Profile', '用户信息', NULL, 'user/Profile', 3);
INSERT INTO `menu` VALUES (5, '/admin/user/Role', 'Role', '角色配置', NULL, 'user/Role', 3);
INSERT INTO `menu` VALUES (6, '/admin', 'ArticleManage', '测试菜单', 'el-icon-edit', 'AdminIndex', 0);
INSERT INTO `menu` VALUES (7, '/admin/test/Test1', 'ArticleList', '菜单列表1', NULL, 'test/Test1', 6);
INSERT INTO `menu` VALUES (8, '/admin/test/Test2', 'ArticleEdit', '菜单列表2', NULL, 'test/Test2', 6);

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role`  (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'Vue路由中的name',
  `name_zh` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '中文名称，用于渲染导航栏（菜单）界面',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES (1, 'root', '管理员');
INSERT INTO `role` VALUES (2, 'contentAdmin', '内容管理员');
INSERT INTO `role` VALUES (3, 'user', '普通用户');

-- ----------------------------
-- Table structure for role_menu
-- ----------------------------
DROP TABLE IF EXISTS `role_menu`;
CREATE TABLE `role_menu`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rid` int(11) NOT NULL,
  `mid` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `role_id`(`rid`) USING BTREE,
  INDEX `menu_id`(`mid`) USING BTREE,
  CONSTRAINT `role_menu_ibfk_1` FOREIGN KEY (`mid`) REFERENCES `menu` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `role_menu_ibfk_2` FOREIGN KEY (`rid`) REFERENCES `role` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 59 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of role_menu
-- ----------------------------
INSERT INTO `role_menu` VALUES (1, 1, 1);
INSERT INTO `role_menu` VALUES (2, 1, 2);
INSERT INTO `role_menu` VALUES (3, 1, 3);
INSERT INTO `role_menu` VALUES (4, 1, 4);
INSERT INTO `role_menu` VALUES (5, 1, 5);
INSERT INTO `role_menu` VALUES (6, 1, 6);
INSERT INTO `role_menu` VALUES (8, 1, 8);
INSERT INTO `role_menu` VALUES (9, 2, 1);
INSERT INTO `role_menu` VALUES (10, 2, 2);
INSERT INTO `role_menu` VALUES (11, 2, 6);
INSERT INTO `role_menu` VALUES (12, 2, 7);
INSERT INTO `role_menu` VALUES (13, 2, 8);
INSERT INTO `role_menu` VALUES (14, 3, 1);
INSERT INTO `role_menu` VALUES (15, 3, 2);
INSERT INTO `role_menu` VALUES (57, 1, 7);
INSERT INTO `role_menu` VALUES (58, 3, 6);
INSERT INTO `role_menu` VALUES (59, 3, 7);

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `salt` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (4, 'admin', '85ccac6e29850295612fd41f2947b607', 'fofQ6/AjDmIdy3ncuqaqAw==');
INSERT INTO `user` VALUES (6, 'test1', 'e4aefc78de1822cfd07458f6b659eefd', 'HAWU3kqVYlO5fDaVSST/VQ==');
INSERT INTO `user` VALUES (7, 'test2', '8007c88d35eb40ba3e6491ca81770279', 'o4RoLbP92fBjGJEl1P5V8Q==');

-- ----------------------------
-- Table structure for user_role
-- ----------------------------
DROP TABLE IF EXISTS `user_role`;
CREATE TABLE `user_role`  (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `uid` int(10) NOT NULL,
  `rid` int(10) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `uid`(`uid`) USING BTREE,
  INDEX `rid`(`rid`) USING BTREE,
  CONSTRAINT `user_role_ibfk_1` FOREIGN KEY (`rid`) REFERENCES `role` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `user_role_ibfk_2` FOREIGN KEY (`uid`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_role
-- ----------------------------
INSERT INTO `user_role` VALUES (1, 4, 1);
INSERT INTO `user_role` VALUES (11, 6, 2);
INSERT INTO `user_role` VALUES (12, 7, 3);

SET FOREIGN_KEY_CHECKS = 1;
