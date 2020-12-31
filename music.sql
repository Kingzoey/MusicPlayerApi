/*
 Navicat Premium Data Transfer

 Source Server         : musicplayer
 Source Server Type    : MySQL
 Source Server Version : 80022
 Source Host           : localhost:3306
 Source Schema         : music

 Target Server Type    : MySQL
 Target Server Version : 80022
 File Encoding         : 65001

 Date: 31/12/2020 17:03:35
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin`  (
  `admin_id` decimal(6, 0) NOT NULL COMMENT '管理员id',
  `email` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '管理员邮箱, 可用于登录, 唯一',
  `tel` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '管理员手机号, 可用于登录, 唯一',
  `nickname` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '管理员用户名, 最长40个字符',
  `password` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '密码, 最长20个字符',
  `gender` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '性别: 男/女/null',
  `avatar` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '头像',
  `create_time` date NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`admin_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for favorite
-- ----------------------------
DROP TABLE IF EXISTS `favorite`;
CREATE TABLE `favorite`  (
  `usid` decimal(8, 0) NOT NULL COMMENT '用户id',
  `sid` decimal(10, 0) NOT NULL COMMENT '歌曲id',
  PRIMARY KEY (`usid`, `sid`) USING BTREE,
  INDEX `sid_fav`(`sid`) USING BTREE,
  CONSTRAINT `sid_fav` FOREIGN KEY (`sid`) REFERENCES `song` (`sid`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `usid_fav` FOREIGN KEY (`usid`) REFERENCES `users` (`usid`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for follow
-- ----------------------------
DROP TABLE IF EXISTS `follow`;
CREATE TABLE `follow`  (
  `usid` decimal(8, 0) NOT NULL COMMENT '用户id',
  `follow_usid` decimal(8, 0) NOT NULL COMMENT '被关注的用户id',
  PRIMARY KEY (`usid`, `follow_usid`) USING BTREE,
  INDEX `follow_usid`(`follow_usid`) USING BTREE,
  CONSTRAINT `usid` FOREIGN KEY (`usid`) REFERENCES `users` (`usid`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `follow_usid` FOREIGN KEY (`follow_usid`) REFERENCES `users` (`usid`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for likesongcomment
-- ----------------------------
DROP TABLE IF EXISTS `likesongcomment`;
CREATE TABLE `likesongcomment`  (
  `usid` decimal(8, 0) NOT NULL COMMENT '用户id',
  `scid` decimal(10, 0) NOT NULL COMMENT '歌曲评论id',
  PRIMARY KEY (`usid`, `scid`) USING BTREE,
  INDEX `scid_like`(`scid`) USING BTREE,
  CONSTRAINT `scid_like` FOREIGN KEY (`scid`) REFERENCES `songcomment` (`scid`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `usid_like` FOREIGN KEY (`usid`) REFERENCES `users` (`usid`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for listenhistory
-- ----------------------------
DROP TABLE IF EXISTS `listenhistory`;
CREATE TABLE `listenhistory`  (
  `usid` decimal(8, 0) NOT NULL COMMENT '用户id',
  `sid` decimal(10, 0) NOT NULL COMMENT '歌曲id',
  `create_time` date NOT NULL COMMENT '播放时间',
  PRIMARY KEY (`usid`, `sid`, `create_time`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for message
-- ----------------------------
DROP TABLE IF EXISTS `message`;
CREATE TABLE `message`  (
  `mid` int NOT NULL COMMENT '私信id',
  `usid` int NULL DEFAULT NULL COMMENT '用户id',
  `to_id` int NULL DEFAULT NULL COMMENT '接收信息的用户id',
  `content` varchar(400) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '私信内容',
  `create_time` date NOT NULL COMMENT '发送时间',
  PRIMARY KEY (`mid`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for musician
-- ----------------------------
DROP TABLE IF EXISTS `musician`;
CREATE TABLE `musician`  (
  `musician_id` decimal(6, 0) NOT NULL COMMENT 'musician的id',
  `usid` decimal(8, 0) NULL DEFAULT NULL COMMENT '音乐人专页-音乐人账号链接',
  `name` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '音乐人专页-音乐人名字',
  `description` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '音乐人专页-描述',
  `banner` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '音乐人专页-图片链接',
  PRIMARY KEY (`musician_id`) USING BTREE,
  INDEX `usid_musician`(`usid`) USING BTREE,
  CONSTRAINT `usid_musician` FOREIGN KEY (`usid`) REFERENCES `users` (`usid`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for searchhistory
-- ----------------------------
DROP TABLE IF EXISTS `searchhistory`;
CREATE TABLE `searchhistory`  (
  `usid` decimal(8, 0) NOT NULL COMMENT '用户id',
  `content` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '搜索内容',
  `create_time` timestamp(6) NOT NULL COMMENT '搜索时间',
  PRIMARY KEY (`usid`, `content`, `create_time`) USING BTREE,
  CONSTRAINT `usid_search` FOREIGN KEY (`usid`) REFERENCES `users` (`usid`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for song
-- ----------------------------
DROP TABLE IF EXISTS `song`;
CREATE TABLE `song`  (
  `sid` decimal(10, 0) NOT NULL COMMENT '歌曲id, 自动分配',
  `path` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '歌曲文件在服务器上的存储路径',
  `title` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '歌曲名',
  `description` varchar(400) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '歌曲简介',
  `cover` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '专辑封面在服务器上的存储路径',
  `create_time` date NOT NULL COMMENT '歌曲上传时间',
  `time` decimal(10, 0) NOT NULL COMMENT '歌曲时长（秒数）',
  `usid` decimal(8, 0) NULL DEFAULT NULL COMMENT '上传用户id',
  `like_num` decimal(8, 0) NOT NULL COMMENT '点赞量',
  `favorite_num` decimal(8, 0) NOT NULL COMMENT '收藏量',
  `watch_num` decimal(10, 0) NOT NULL COMMENT '播放量',
  PRIMARY KEY (`sid`) USING BTREE,
  INDEX `usid_song`(`usid`) USING BTREE,
  CONSTRAINT `usid_song` FOREIGN KEY (`usid`) REFERENCES `users` (`usid`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for songcomment
-- ----------------------------
DROP TABLE IF EXISTS `songcomment`;
CREATE TABLE `songcomment`  (
  `scid` decimal(10, 0) NOT NULL COMMENT '歌曲评论id',
  `usid` decimal(8, 0) NULL DEFAULT NULL COMMENT '用户id',
  `sid` decimal(10, 0) NULL DEFAULT NULL COMMENT '歌曲id',
  `content` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '评论内容',
  `reply_scid` int NULL DEFAULT NULL COMMENT '如果是对评论的评论, 则此处保存被评论的评论的id, 否则是null',
  `create_time` date NOT NULL COMMENT '评论发表时间',
  `like_num` decimal(10, 0) NOT NULL COMMENT '点赞数',
  PRIMARY KEY (`scid`) USING BTREE,
  INDEX `usid_sc`(`usid`) USING BTREE,
  INDEX `sid_sc`(`sid`) USING BTREE,
  CONSTRAINT `sid_sc` FOREIGN KEY (`sid`) REFERENCES `song` (`sid`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `usid_sc` FOREIGN KEY (`usid`) REFERENCES `users` (`usid`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for songtag
-- ----------------------------
DROP TABLE IF EXISTS `songtag`;
CREATE TABLE `songtag`  (
  `sid` decimal(10, 0) NOT NULL COMMENT '歌曲id',
  `tag_id` decimal(6, 0) NOT NULL COMMENT 'tag的id',
  PRIMARY KEY (`sid`, `tag_id`) USING BTREE,
  INDEX `tag_id_songtag`(`tag_id`) USING BTREE,
  CONSTRAINT `sid_songtag` FOREIGN KEY (`sid`) REFERENCES `song` (`sid`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `tag_id_songtag` FOREIGN KEY (`tag_id`) REFERENCES `tag` (`tag_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for tag
-- ----------------------------
DROP TABLE IF EXISTS `tag`;
CREATE TABLE `tag`  (
  `tag_id` decimal(6, 0) NOT NULL COMMENT 'tag的id',
  `name` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'tag名字, 最长10个字符(10个够用)',
  `musician_id` decimal(6, 0) NULL DEFAULT NULL COMMENT '如果是音乐人tag, 则这里是musician的id',
  PRIMARY KEY (`tag_id`) USING BTREE,
  INDEX `musician_id_tag`(`musician_id`) USING BTREE,
  CONSTRAINT `musician_id_tag` FOREIGN KEY (`musician_id`) REFERENCES `musician` (`musician_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `usid` decimal(8, 0) UNSIGNED NOT NULL COMMENT '用户id, 自动分配',
  `email` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户邮箱, 可用于登录, 唯一',
  `tel` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户手机号, 可用于登录, 唯一',
  `nickname` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户名, 最长10个字符',
  `password` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '密码(明文ok), 最长20个字符',
  `gender` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '性别: 男/女/null',
  `avatar` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '头像, 存储路径',
  `create_time` date NOT NULL COMMENT '创建时间, 时间戳格式',
  `birthday` date NULL DEFAULT NULL COMMENT '生日',
  `signature` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '个性签名',
  `follower_num` decimal(8, 0) NOT NULL COMMENT '粉丝数',
  `musician_id` decimal(8, 0) NULL DEFAULT NULL,
  PRIMARY KEY (`usid`) USING BTREE,
  INDEX `musician_id`(`musician_id`) USING BTREE,
  CONSTRAINT `musician_id` FOREIGN KEY (`musician_id`) REFERENCES `musician` (`musician_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;
