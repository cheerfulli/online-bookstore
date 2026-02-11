-- MySQL dump 10.13  Distrib 8.0.33, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: springboot-vue
-- ------------------------------------------------------
-- Server version	8.0.33

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `address`
--

DROP TABLE IF EXISTS `address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8 */;
CREATE TABLE `address` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `phone` char(11) DEFAULT NULL,
  `address` varchar(128) DEFAULT NULL,
  `add_detail` varchar(128) DEFAULT NULL,
  `add_name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `address_user_id_fk` (`user_id`),
  CONSTRAINT `address_user_id_fk` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `address`
--

LOCK TABLES `address` WRITE;
/*!40000 ALTER TABLE `address` DISABLE KEYS */;
INSERT INTO `address` (`id`, `user_id`, `phone`, `address`, `add_detail`, `add_name`) VALUES (4,17,'18289300101','江 西 省','f三美分，\n','，，');
/*!40000 ALTER TABLE `address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cart`
--

DROP TABLE IF EXISTS `cart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8 */;
CREATE TABLE `cart` (
  `id` int NOT NULL AUTO_INCREMENT,
  `pay_price` decimal(10,2) DEFAULT NULL,
  `product_id` bigint DEFAULT NULL,
  `post_fee` decimal(10,2) DEFAULT NULL,
  `count` int DEFAULT '1',
  `user_id` bigint DEFAULT NULL,
  `username` varchar(50) DEFAULT NULL,
  `address_id` int DEFAULT NULL,
  `cart_name` varchar(255) DEFAULT NULL,
  `cart_picture` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart`
--

LOCK TABLES `cart` WRITE;
/*!40000 ALTER TABLE `cart` DISABLE KEYS */;
/*!40000 ALTER TABLE `cart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item`
--

DROP TABLE IF EXISTS `item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8 */;
CREATE TABLE `item` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '商品id，同时也是商品编号',
  `title` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '商品标题',
  `sell_point` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '商品卖点',
  `price` decimal(10,2) NOT NULL COMMENT '商品价格，单位为：分',
  `stock` int NOT NULL COMMENT '库存数量',
  `barcode` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '商品条形码',
  `image` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '商品图片',
  `cid` bigint NOT NULL COMMENT '所属类目，叶子类目',
  `status` tinyint NOT NULL DEFAULT '1' COMMENT '商品状态，1-正常，2-下架，3-删除',
  `created` datetime DEFAULT NULL COMMENT '创建时间',
  `updated` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `cid` (`cid`) USING BTREE,
  KEY `status` (`status`) USING BTREE,
  KEY `updated` (`updated`) USING BTREE,
  KEY `id` (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC COMMENT='商品表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item`
--

LOCK TABLES `item` WRITE;
/*!40000 ALTER TABLE `item` DISABLE KEYS */;
INSERT INTO `item` (`id`, `title`, `sell_point`, `price`, `stock`, `barcode`, `image`, `cid`, `status`, `created`, `updated`) VALUES (1,'手账本','三莹月周间手帐本日式手账本记事日记笔记本子 日程手账周计划本',19.99,1999,'1','https://gd2.alicdn.com/imgextra/i4/132942065/O1CN015slStJ1R7oUcJMOVB_!!132942065.jpg_400x400.jpg',1,1,'2023-02-15 16:59:15','2023-03-07 16:03:10'),(2,'小米10Pro','【咨询减钱+现货速发】xiaomi/小米10 5G手机全网通官方旗舰小米官网10至尊版正品K40pro新品11小米手机10s',2999.00,1998,NULL,'https://gw.alicdn.com/imgextra/i2/2208143412112/O1CN01Ucp0kn1RTLCyjjKAq_!!2208143412112.jpg_Q75.jpg_.webp',1,1,'2023-03-07 15:53:31','2023-03-10 15:30:15'),(3,'红米K60','【抢先加购 3日0点开抢】Redmi K60手机红米k60手机小米手机小米官方旗舰店官网新品正品redmik60',2699.00,79,NULL,'https://gd2.alicdn.com/imgextra/i3/368976905/O1CN01Bmrztb20sXdfYmxzi_!!368976905.jpg_400x400.jpg',5,1,'2023-03-06 15:56:55','2023-03-06 15:57:38'),(4,'外星人笔记本','ALIENWARE/外星人高端游戏本吃鸡电竞1517英寸独显笔记本电脑学生',3580.00,20,NULL,'https://gd1.alicdn.com/imgextra/i1/2214800833667/O1CN01TKrNN51cxXBZaNxA4_!!2214800833667.jpg',1,1,'2023-03-05 15:57:41','2023-03-08 11:24:02'),(5,'Acer笔记本','Acer/宏碁 Aspire A315 新款i5独显笔记本电脑轻薄便携学生上网课用四核超薄商务办公本15.6英寸宏基手提电脑',2000.00,100,NULL,'https://gd4.alicdn.com/imgextra/i2/2214800833667/O1CN01fZqqu01cxXBS0ghhs_!!2214800833667.jpg_400x400.jpg',1,1,'2023-03-04 15:57:49','2024-03-01 21:06:03'),(6,'汉堡','手工汉堡胚美式面包胚商业家庭早餐面包半成品即食港式奶油猪仔包',36.80,290,NULL,'https://shadow.elemecdn.com/app/element/hamburger.9cf7b091-55e9-11e9-a976-7f4d0b07eef6.png',1,1,'2023-03-03 15:58:01','2023-03-10 15:32:02'),(7,'乐事薯片','乐事薯片大包装休闲食品膨化平价小吃零食大礼包整箱批发官方旗舰',21.00,5000,NULL,'https://gw.alicdn.com/imgextra/i4/1048187520/O1CN01DtbxdB25QDEIFViNh_!!0-item_pic.jpg_Q75.jpg_.webp',1,1,'2023-03-07 15:58:07','2023-03-07 15:58:09'),(8,'倩碧润肤乳液','【38开抢】倩碧匀净卓研润肤乳液焕白肌肤提亮肤色舒缓维稳',430.00,9999,NULL,'https://gw.alicdn.com/imgextra/i3/1653734047/O1CN01IhMjWr1flZh1NXBGZ_!!1653734047.jpg_Q75.jpg_.webp',1,1,'2023-03-07 15:58:09','2023-03-07 15:58:11'),(9,'Adidas阿迪达斯板鞋','Adidas阿迪达斯 DAILY3.0男子夏季低帮透气休闲白帆布板鞋 GY8115',339.00,4997,NULL,'http://localhost:9090/files/3212033a0e3b480d8b6806c685639563_IMG_20230128_212807.jpg',1,1,'2023-03-09 11:43:00','2024-06-22 14:42:57'),(11,'12','111',123.00,1,NULL,'http://localhost:9090/files/5147fa5ba8704b528ecc03f4014e14fe_6e188046f8e0259a.jpg',2,1,'2024-06-22 14:46:06',NULL),(12,'123121','fsfsf',1.00,1,NULL,'http://localhost:9090/files/ec8ae91f764047c1983b90e66169a977_-253fead462411fbe.jpg',1,1,'2024-06-22 14:47:00','2024-06-22 14:47:59'),(13,'fsaf','vcxv',1231.00,1,NULL,'http://localhost:9090/files/4897a3bd4c9b45c2b53f9f4ab5b9582e_14f303c2579fb791.jpg',1,1,'2024-06-22 14:48:36',NULL),(14,'好','vx',123.00,11,NULL,'http://localhost:9090/files/91c404fc22af49fb9c0c1877b685fe70_-253fead462411fbe.jpg',7,1,'2024-06-22 14:49:00','2024-06-22 16:44:09');
/*!40000 ALTER TABLE `item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item_detail`
--

DROP TABLE IF EXISTS `item_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8 */;
CREATE TABLE `item_detail` (
  `item_id` bigint NOT NULL COMMENT '商品ID',
  `item_detail` text CHARACTER SET utf8 COLLATE utf8_unicode_ci COMMENT '商品的详情',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='商品详细信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_detail`
--

LOCK TABLES `item_detail` WRITE;
/*!40000 ALTER TABLE `item_detail` DISABLE KEYS */;
INSERT INTO `item_detail` (`item_id`, `item_detail`, `create_time`, `update_time`) VALUES (1,'<p><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i1/132942065/O1CN01hwmS2L1R7oUkhY4GF_!!132942065.jpg\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i3/132942065/O1CN01dfrCxx1R7oUoE4xOj_!!132942065.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i3/132942065/O1CN01fWfCdH1R7oUcW05cV_!!132942065.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i4/132942065/O1CN01GePNOa1R7oUcVyTrr_!!132942065.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i4/132942065/O1CN01j4ZmU71R7oUn5IAld_!!132942065.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i1/132942065/O1CN018IV8Uw1R7oUlOf2R3_!!132942065.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i2/132942065/O1CN01IpjvaM1R7oUkhXCDN_!!132942065.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i3/132942065/O1CN01yQSJsS1R7oUpg6WHL_!!132942065.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i1/132942065/O1CN01XebETt1R7oUhCEFoL_!!132942065.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i3/132942065/O1CN01puUiVT1R7oUkjlITx_!!132942065.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i2/132942065/O1CN01HPDI931R7oUmUPZVN_!!132942065.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i1/132942065/O1CN01KXkjDw1R7oUkjiDCF_!!132942065.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i1/132942065/O1CN01A53Jv11R7oUoE5QUO_!!132942065.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i2/132942065/O1CN015etSCU1R7oUcVzcXl_!!132942065.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i1/132942065/O1CN01zUAf7V1R7oUkjikU0_!!132942065.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i1/132942065/O1CN01OSGHPP1R7oUpg9Cc4_!!132942065.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i3/132942065/O1CN01lPt9mo1R7oUn5IAmj_!!132942065.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i4/132942065/O1CN01ihij981R7oUnPMJV0_!!132942065.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i4/132942065/O1CN01xQw7hp1R7oUkjldHq_!!132942065.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i3/132942065/O1CN01gdFVef1R7oUlG3iiH_!!132942065.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i1/132942065/O1CN01aReWTj1R7oUhCFf60_!!132942065.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i1/132942065/O1CN01LLLfpa1R7oUmUNlJS_!!132942065.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i1/132942065/O1CN01hlhlYn1R7oUihv887_!!132942065.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i2/132942065/O1CN016pDyYm1R7oUlG5fGh_!!132942065.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i4/132942065/O1CN01eNJg471R7oUq17Ous_!!132942065.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i3/132942065/O1CN01AeEtAP1R7oUoscGmm_!!132942065.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i4/132942065/O1CN015CCkd21R7oUkNSazZ_!!132942065.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i4/132942065/O1CN01vmT0Q71R7oUpg9GmQ_!!132942065.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i1/132942065/O1CN010k61Ul1R7oUoE55jm_!!132942065.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i4/132942065/O1CN01qEQrLL1R7oUiE2xGT_!!132942065.jpg\" class=\"\" style=\"max-width: 750.0px;\"></p>','2023-03-09 10:40:22','2023-03-10 10:40:30'),(2,'<div id=\"description\" class=\"J_DetailSection tshop-psm ke-post\">\n    \n    <div id=\"J_DivItemDesc\" class=\"content\"><p style=\"margin: 1.12em 0.0px;padding: 0.0px;\"><b style=\"font-size: 28px; color: rgb(255, 0, 0);\">适用型号：小米10Pro</b><br/></p><p style=\"margin: 1.12em 0.0px;padding: 0.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i2/1934249039/O1CN01pNG1FU2GduieRyQdc_!!1934249039.jpg\" style=\"max-width: 750.0px;\" data-spm-anchor-id=\"2013.1.0.i0.1ace250cIasuuI\"/><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i2/1934249039/O1CN01uImZ9T2GduijgUktu_!!1934249039.jpg\" style=\"max-width: 750.0px;\"/><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i3/1934249039/O1CN01Q1tyea2GduieRyd5v_!!1934249039.jpg\" style=\"max-width: 750.0px;\"/><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i2/1934249039/O1CN01W4c4392GduimQgouv_!!1934249039.jpg\" style=\"max-width: 750.0px;\"/><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i1/1934249039/O1CN01v7LRUx2GdujZ1YRTV_!!1934249039.jpg\" class=\"\" style=\"max-width: 750.0px;\"/><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i2/1934249039/O1CN01mhrdOV2GdujUkX0Td_!!1934249039.jpg\" class=\"\" style=\"max-width: 750.0px;\"/><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i2/1934249039/O1CN01K1qI8M2GdujYYUszf_!!1934249039.jpg\" class=\"\" style=\"max-width: 750.0px;\"/><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i3/1934249039/O1CN01AMMMH32GdujcO1R2o_!!1934249039.jpg\" class=\"\" style=\"max-width: 750.0px;\"/><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i1/1934249039/O1CN01Si9pZd2GdujUkXTbf_!!1934249039.jpg\" class=\"\" style=\"max-width: 750.0px;\"/><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i1/1934249039/O1CN01u10wDQ2GdujQefwfV_!!1934249039.jpg\" class=\"\" style=\"max-width: 750.0px;\"/><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i2/1934249039/O1CN01GVAlBX2GdujWQpTMW_!!1934249039.jpg\" class=\"\" style=\"max-width: 750.0px;\"/><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i4/1934249039/O1CN013jAWez2GduipdSHuT_!!1934249039.jpg\" class=\"\" style=\"max-width: 750.0px;\"/><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i2/1934249039/O1CN01trdT0N2GduinTeYFB_!!1934249039.jpg\" class=\"\" style=\"max-width: 750.0px;\"/><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i3/1934249039/O1CN01iff1J12GduiiPBcau_!!1934249039.jpg\" class=\"\" style=\"max-width: 750.0px;\"/></p><p style=\"margin: 1.12em 0.0px;padding: 0.0px;\">&nbsp;</p></div>\n</div>','2023-03-10 11:26:59','2023-03-10 11:42:29'),(3,'<div style=\"width: 750.0px;height: 10742.0px;overflow: hidden;\"><br/>&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img style=\"display: block;width: 100.0%;\" src=\"https://img.alicdn.com/imgextra/i4/368976905/O1CN01bWzV0d20sXdh5XIZu_!!368976905.jpg\"/><img style=\"display: block;width: 100.0%;\" src=\"https://img.alicdn.com/imgextra/i1/368976905/O1CN01RNT3Q620sXd6zmJr4_!!368976905.jpg\"/><img style=\"display: block;width: 100.0%;\" src=\"https://img.alicdn.com/imgextra/i4/368976905/O1CN01MAcLRN20sXcT6j1ft_!!368976905.jpg\"/><img style=\"display: block;width: 100.0%;\" src=\"https://img.alicdn.com/imgextra/i2/368976905/O1CN01aRlEB620sXeX0wgPR_!!368976905.jpg\"/><img style=\"display: block;width: 100.0%;\" src=\"https://img.alicdn.com/imgextra/i4/368976905/O1CN01Y4x5oa20sXeRBO1DR_!!368976905.jpg\" class=\"\"/><img style=\"display: block;width: 100.0%;\" src=\"https://img.alicdn.com/imgextra/i4/368976905/O1CN01jQ8hkV20sXeVwIl6e_!!368976905.jpg\" class=\"\"/><img style=\"display: block;width: 100.0%;\" src=\"https://img.alicdn.com/imgextra/i1/368976905/O1CN01f3siBK20sXeRa0SHZ_!!368976905.jpg\" class=\"\"/><img style=\"display: block;width: 100.0%;\" src=\"https://img.alicdn.com/imgextra/i2/368976905/O1CN01W9E2dm20sXeNXaflH_!!368976905.jpg\" class=\"\"/><img style=\"display: block;width: 100.0%;\" src=\"https://img.alicdn.com/imgextra/i1/368976905/O1CN01sHjnC820sXYtJqIn3_!!368976905.jpg\" class=\"\"/><img style=\"display: block;width: 100.0%;\" src=\"https://img.alicdn.com/imgextra/i3/368976905/O1CN01jmTTwG20sXcWZlg52_!!368976905.jpg\" class=\"\"/><img style=\"display: block;width: 100.0%;\" src=\"https://img.alicdn.com/imgextra/i2/368976905/O1CN01ftgTGM20sXVIIDF01_!!368976905.jpg\" class=\"\"/><img style=\"display: block;width: 100.0%;\" src=\"https://img.alicdn.com/imgextra/i4/368976905/O1CN01uJlPnk20sXSsf2Dqj_!!368976905.jpg\" class=\"\"/><img style=\"display: block;width: 100.0%;\" src=\"https://img.alicdn.com/imgextra/i3/368976905/O1CN01UMscaW20sXePhjxIx_!!368976905.jpg\" class=\"\"/><img style=\"display: block;width: 100.0%;\" src=\"https://img.alicdn.com/imgextra/i2/368976905/O1CN014Jg1ii20sXeNXcPqe_!!368976905.jpg\" class=\"\"/><img style=\"display: block;width: 100.0%;\" src=\"https://img.alicdn.com/imgextra/i4/368976905/O1CN01BZjEU720sXd7PXn1W_!!368976905.jpg\" class=\"\"/><img style=\"display: block;width: 100.0%;\" src=\"https://img.alicdn.com/imgextra/i4/368976905/O1CN01vwaXB520sXP1MUfBi_!!368976905.png\" class=\"\"/><img style=\"display: block;width: 100.0%;\" src=\"https://img.alicdn.com/imgextra/i1/368976905/O1CN0120sXJ3H7i3s9Tpc_!!368976905.jpg\" class=\"\"/><img style=\"display: block;width: 100.0%;\" src=\"https://img.alicdn.com/imgextra/i4/368976905/O1CN01DxqLW620sXNO2xHG9_!!368976905.jpg\" class=\"\"/><img style=\"display: block;width: 100.0%;\" src=\"https://img.alicdn.com/imgextra/i2/368976905/TB2lzflGgaTBuNjSszfXXXgfpXa_!!368976905.jpg\" class=\"\"/><img style=\"display: block;width: 100.0%;\" src=\"https://img.alicdn.com/imgextra/i4/368976905/O1CN0120sXHqmlby0K1hs_!!368976905.jpg\" class=\"\"/></div>','2023-03-10 11:34:06','2023-03-10 11:54:03'),(4,'<p><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i4/2212424212173/O1CN01p2lDBT1RvHSUKVTcd_!!2212424212173.jpg\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i4/2212424212173/O1CN01AUKQ8t1RvHSTCBlTo_!!2212424212173.png\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i3/2212424212173/O1CN01PQycuI1RvHSOJOPxe_!!2212424212173.png\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i2/2212424212173/O1CN01KcvafR1RvHSOjE30V_!!2212424212173.png\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i1/2212424212173/O1CN01Bg6SNc1RvHSMh7lQE_!!2212424212173.png\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i3/2212424212173/O1CN01enJaaN1RvHSMh8lut_!!2212424212173.png\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i4/2212424212173/O1CN01j5qpK51RvHSDfaCAl_!!2212424212173.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i2/2212424212173/O1CN011LjOE71RvHSOjFrMr_!!2212424212173.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i3/2212424212173/O1CN01Vg4ux91RvHSNKAdbf_!!2212424212173.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i4/2212424212173/O1CN01k9hhMU1RvHSRQQcF7_!!2212424212173.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i1/2212424212173/O1CN01c7otvH1RvHSJmJ7YQ_!!2212424212173.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i2/2212424212173/O1CN0136KH0Z1RvHSMmt3h2_!!2212424212173.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i4/2212424212173/O1CN01DuD9DI1RvHSIOdqkE_!!2212424212173.png\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i1/2212424212173/O1CN01vmuEqE1RvHSSW0g2V_!!2212424212173.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i1/2212424212173/O1CN01kAD4TI1RvHSRQSE0R_!!2212424212173.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i3/2212424212173/O1CN010yib9o1RvHSTCD6lp_!!2212424212173.jpg\" class=\"\" style=\"max-width: 750.0px;\"><span style=\"font-size: 14.0px;\">电脑质保2年，支持15天换货，7天无理由换货，现在购买送豪华礼品【电脑鼠标一个，鼠标垫一张，电脑包一个】，新到库存资源机98新1000台，电脑配置已全面升级满足各种日常家用办公</span> &ZeroWidthSpace;&ZeroWidthSpace;&ZeroWidthSpace;&ZeroWidthSpace;&ZeroWidthSpace;&ZeroWidthSpace;&ZeroWidthSpace;</p>','2023-03-10 11:34:11',NULL),(5,'<div class=\"sub-wrap\" id=\"J_SubWrap\">\n                                \n<div id=\"attributes\" class=\"attributes\">\n    \n\n    \n\n    \n\n\n    \n\n    \n\n    <!-- attributes div start -->\n    \n            <div><br/></div></div><div id=\"description\" class=\"J_DetailSection tshop-psm ke-post\"><div id=\"J_DivItemDesc\" class=\"content\"><div class=\"descV8-container\"><div class=\"descV8-singleImage\">\n        \n        <img src=\"//img.alicdn.com/imgextra/i4/2215220596796/O1CN01rI4uMr204cT5wKqcA_!!2215220596796.jpg\" data-name=\"singleImage\" class=\"descV8-singleImage-image lazyload\" style=\"width: 750px; height: 1399.5967741935483px;\"/>\n    </div><div class=\"descV8-singleImage\">\n        \n        <img src=\"//img.alicdn.com/imgextra/i4/2215220596796/O1CN01zMzb5Q204cSxtjuxi_!!2215220596796.jpg\" data-name=\"singleImage\" class=\"descV8-singleImage-image lazyload\" style=\"width: 750px; height: 1237.5px;\"/>\n    </div><div class=\"descV8-singleImage\">\n        \n        <img src=\"//img.alicdn.com/imgextra/i4/2215220596796/O1CN01uwWz3K204cT7mwlDw_!!2215220596796.jpg\" data-name=\"singleImage\" class=\"descV8-singleImage-image lazyload\" style=\"width: 750px; height: 1293.1451612903227px;\"/>\n    </div><div class=\"descV8-singleImage\">\n        \n        <img src=\"//img.alicdn.com/imgextra/i4/2215220596796/O1CN01wAUnk0204cT1i55PN_!!2215220596796.jpg\" data-name=\"singleImage\" class=\"descV8-singleImage-image lazyload\" style=\"width: 750px; height: 1573.7903225806451px;\"/>\n    </div><div class=\"descV8-singleImage\">\n        \n        <img src=\"//img.alicdn.com/imgextra/i3/2215220596796/O1CN01P8UKVv204cT5wKB46_!!2215220596796.jpg\" data-name=\"singleImage\" class=\"descV8-singleImage-image lazyload\" style=\"width: 750px; height: 1368.1451612903227px;\"/>\n    </div><div class=\"descV8-singleImage\">\n        \n        <img src=\"//img.alicdn.com/imgextra/i2/2215220596796/O1CN015gelYL204cSr2G7vV_!!2215220596796.jpg\" data-name=\"singleImage\" class=\"descV8-singleImage-image lazyload\" style=\"width: 750px; height: 965.3225806451613px;\"/>\n    </div><div class=\"descV8-singleImage\">\n        \n        <img src=\"//img.alicdn.com/imgextra/i4/2215220596796/O1CN01YQNH0T204cT0j9A4p_!!2215220596796.jpg\" data-name=\"singleImage\" class=\"descV8-singleImage-image lazyload\" style=\"width: 750px; height: 1252.016129032258px;\"/>\n    </div><div class=\"descV8-singleImage\">\n        \n        <img src=\"//img.alicdn.com/imgextra/i2/2215220596796/O1CN01LgpYZv204cT5wKJPC_!!2215220596796.jpg\" data-name=\"singleImage\" class=\"descV8-singleImage-image lazyload\" style=\"width: 750px; height: 984.6774193548387px;\"/>\n    </div><div class=\"descV8-singleImage\">\n        \n        <img src=\"//img.alicdn.com/imgextra/i1/2215220596796/O1CN010H7X4x204cT4qd005_!!2215220596796.jpg\" data-name=\"singleImage\" class=\"descV8-singleImage-image lazyload\" style=\"width: 750px; height: 704.0322580645161px;\"/>\n    </div><div class=\"descV8-singleImage\">\n        \n        <img src=\"//img.alicdn.com/imgextra/i1/2215220596796/O1CN01FQSq6W204cT4qebnN_!!2215220596796.jpg\" data-name=\"singleImage\" class=\"descV8-singleImage-image lazyload\" style=\"width: 750px; height: 1225.4032258064517px;\"/>\n    </div><div class=\"descV8-singleImage\">\n        \n        <img src=\"//img.alicdn.com/imgextra/i1/2215220596796/O1CN019b7DB9204cSvneJsG_!!2215220596796.jpg\" data-name=\"singleImage\" class=\"descV8-singleImage-image lazyload\" style=\"width: 750px; height: 1074.1935483870968px;\"/>\n    </div><div class=\"descV8-singleImage\">\n        \n        <img src=\"//img.alicdn.com/imgextra/i1/2215220596796/O1CN0160h0QB204cT8f1vUU_!!2215220596796.jpg\" data-name=\"singleImage\" class=\"descV8-singleImage-image lazyload\" style=\"width: 750px; height: 989.516129032258px;\"/>\n    </div><div class=\"descV8-singleImage\">\n        \n        <img src=\"//img.alicdn.com/imgextra/i1/2215220596796/O1CN01ipL0ZD204cSvndRoT_!!2215220596796.jpg\" data-name=\"singleImage\" class=\"descV8-singleImage-image lazyload\" style=\"width: 750px; height: 1324.5967741935483px;\"/>\n    </div>\n        </div></div>\n</div><div id=\"reviews\" data-reviewapi=\"//rate.taobao.com/detail_rate.htm?userNumId=2215220596796&amp;auctionNumId=696355599456&amp;showContent=1&amp;currentPage=1&amp;ismore=0&amp;siteID=12\" data-reviewcountapi=\"\" data-listapi=\"//rate.taobao.com/feedRateList.htm?userNumId=2215220596796&amp;auctionNumId=696355599456&amp;siteId=12&amp;spuId=1610837657\" data-commonapi=\"//rate.taobao.com/detailCommon.htm?userNumId=2215220596796&amp;auctionNumId=696355599456&amp;siteID=12&amp;spuId=1610837657\" data-usefulapi=\"//rate.taobao.com/vote_useful.htm?userNumId=2215220596796&amp;auctionNumId=696355599456\">\n</div>\n<div id=\"deal-record\">\n    \n    <div class=\"tb-public-panel\">\n        <div id=\"J_showBuyerList\">\n        </div>\n    </div>\n</div>\n\n                                </div>','2023-03-10 11:34:15','2023-03-10 14:40:51'),(6,'<p><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i1/2206873082203/O1CN01CovB3n1S91DdKMPGW_!!2206873082203.jpg\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i4/2206873082203/O1CN01DeJp9U1S91DbL4xAd_!!2206873082203.jpg\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i4/2206873082203/O1CN0103GGAj1S91Dgxg1Ig_!!2206873082203.jpg\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i4/2206873082203/O1CN01UIu6tJ1S91DjBSXrb_!!2206873082203.jpg\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i1/2206873082203/O1CN01lPfE0F1S91DdKKjLF_!!2206873082203.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i2/2206873082203/O1CN01ySdTRn1S91DjBQb9L_!!2206873082203.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i4/2206873082203/O1CN014cj5Zv1S91DiU8Uke_!!2206873082203.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i1/2206873082203/O1CN01R2QdH31S91KAjd0ft_!!2206873082203.jpg\" class=\"\" style=\"max-width: 750.0px;\"></p>','2023-03-10 11:34:18',NULL),(7,'<p><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i4/1715535627/O1CN01vg1sa01rRDK4U64fg_!!1715535627.jpg\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i1/1715535627/O1CN01CrwGDd1rRDK6sPgO8_!!1715535627.jpg\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i2/1715535627/O1CN01pn4ph91rRDKCCpljT_!!1715535627.jpg\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i1/1715535627/O1CN01755wZI1rRDK4U5jvJ_!!1715535627.jpg\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i3/1715535627/O1CN01j1yplt1rRDKD6gQhk_!!1715535627.jpg\" class=\"\" style=\"max-width: 750.0px;\" width=\"790\" height=\"1480\"></p>','2023-03-10 11:34:21',NULL),(8,'<p><img src=\"https://img.alicdn.com/imgextra/i1/49920024/O1CN019DR57D1C31zC8NR9H_!!49920024.jpg\"></p>','2023-03-10 11:34:25',NULL),(9,'<div id=\"J_DivItemDesc\" class=\"content\"><div><img src=\"https://img.alicdn.com/imgextra/i2/777481810/O1CN01FQSHD11PF1diJmic2_!!777481810.jpg\" style=\"max-width: 750.0px;height: auto;\"></div><div><img src=\"https://img.alicdn.com/imgextra/i3/777481810/O1CN0136g9Zj1PF1dgLMAAy_!!777481810.jpg\" style=\"max-width: 750.0px;height: auto;\"></div><div><img src=\"https://img.alicdn.com/imgextra/i2/777481810/O1CN01w05UoB1PF1dbZo9T7_!!777481810.jpg\" style=\"max-width: 750.0px;height: auto;\"></div><div><img src=\"https://img.alicdn.com/imgextra/i4/777481810/O1CN01ULnkFY1PF1diJmFVb_!!777481810.jpg\" style=\"max-width: 750.0px;height: auto;\"></div><div><img src=\"https://img.alicdn.com/imgextra/i2/777481810/O1CN01nnmDXn1PF1dbZqQrU_!!777481810.jpg\" class=\"\" style=\"max-width: 750.0px;height: auto;\"></div><div><img src=\"https://img.alicdn.com/imgextra/i2/777481810/O1CN01d2rwNx1PF1diJnrJI_!!777481810.jpg\" class=\"\" style=\"max-width: 750.0px;height: auto;\"></div><div><img src=\"https://img.alicdn.com/imgextra/i4/777481810/O1CN01WkcBHP1PF1diJmqw5_!!777481810.jpg\" class=\"\" style=\"max-width: 750.0px;height: auto;\"></div><div><img src=\"https://img.alicdn.com/imgextra/i4/777481810/O1CN01SxAdP71PF1dh7OiPf_!!777481810.jpg\" class=\"\" style=\"max-width: 750.0px;height: auto;\"></div><div><img src=\"https://img.alicdn.com/imgextra/i1/777481810/O1CN01q4nFto1PF1djAJXw0_!!777481810.jpg\" class=\"\" style=\"max-width: 750.0px;height: auto;\"></div><div><img src=\"https://img.alicdn.com/imgextra/i4/777481810/O1CN01T2KxY51PF1djAJPcs_!!777481810.jpg\" class=\"\" style=\"max-width: 750.0px;height: auto;\"></div><div><img src=\"https://img.alicdn.com/imgextra/i1/777481810/O1CN01HVJMrT1PF1dZoFoz7_!!777481810.jpg\" class=\"\" style=\"max-width: 750.0px;height: auto;\"></div><div><img src=\"https://img.alicdn.com/imgextra/i2/777481810/O1CN01sB6aTf1PF1dgLMdJR_!!777481810.jpg\" class=\"\" style=\"max-width: 750.0px;height: auto;\"></div><div><img src=\"//img.alicdn.com/tps/i4/T10B2IXb4cXXcHmcPq-85-85.gif\" class=\"\" data-ks-lazyload=\"https://img.alicdn.com/imgextra/i1/777481810/O1CN01Z9MvNV1PF1diJqXkU_!!777481810.jpg\" style=\"max-width: 750.0px;height: auto;\"></div></div>','2023-03-10 11:34:34',NULL),(51,'<p>adasjdasa ca k&nbsp;</p>','2023-03-10 15:36:34','2024-02-22 18:28:10'),(11,'<p></p>','2024-06-22 14:46:06',NULL),(12,'<p></p>','2024-06-22 14:47:09',NULL),(13,'<p></p>','2024-06-22 14:48:36',NULL),(14,'<p></p>','2024-06-22 14:49:21',NULL);
/*!40000 ALTER TABLE `item_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `refund_order`
--

DROP TABLE IF EXISTS `refund_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8 */;
CREATE TABLE `refund_order` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '订单表主键',
  `order_no` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '订单编号',
  `order_picture` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '商品预览图',
  `refund_type` int DEFAULT NULL COMMENT '退款的类型：1.未发货退款 2.发货了退款',
  `refund_reason` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '退款原因',
  `refund_desc` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '退款的详细信息',
  `refund_amount` decimal(10,2) DEFAULT NULL COMMENT '退款的金额',
  `user_id` bigint DEFAULT NULL COMMENT '退款用户id',
  `username` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '退款用户名',
  `product_id` int DEFAULT NULL,
  `refund_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=67 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='退款的订单表信息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `refund_order`
--

LOCK TABLES `refund_order` WRITE;
/*!40000 ALTER TABLE `refund_order` DISABLE KEYS */;
INSERT INTO `refund_order` (`id`, `order_no`, `order_picture`, `refund_type`, `refund_reason`, `refund_desc`, `refund_amount`, `user_id`, `username`, `product_id`, `refund_date`) VALUES (59,'1763549309065265152','https://gd4.alicdn.com/imgextra/i2/2214800833667/O1CN01fZqqu01cxXBS0ghhs_!!2214800833667.jpg_400x400.jpg',1,'收到商品少件','ddddd',2000.00,17,'admin',NULL,NULL),(64,'1763851006232793088','https://gd2.alicdn.com/imgextra/i4/132942065/O1CN015slStJ1R7oUcJMOVB_!!132942065.jpg_400x400.jpg',1,'与商家协调一致退款','111',19.99,17,'admin',NULL,NULL),(65,'1763851822075252736','https://gw.alicdn.com/imgextra/i2/2208143412112/O1CN01Ucp0kn1RTLCyjjKAq_!!2208143412112.jpg_Q75.jpg_.webp',1,'七天无理由退换','555',2999.00,17,'admin',NULL,NULL),(66,'1763855565034414080','https://gd4.alicdn.com/imgextra/i3/777481810/O1CN01f9yUKG1PF1dXKtyfT_!!777481810.jpg_400x400.jpg',1,'七天无理由退换','5555555555',1017.00,17,'admin',NULL,NULL);
/*!40000 ALTER TABLE `refund_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_order`
--

DROP TABLE IF EXISTS `t_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8 */;
CREATE TABLE `t_order` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '订单id',
  `order_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT '购买的商品名称',
  `order_no` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT '订单流水号',
  `order_picture` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT '订单的预览图',
  `product_id` bigint DEFAULT NULL COMMENT '购买的商品ID',
  `pay_price` decimal(10,2) DEFAULT NULL COMMENT '商品单价。精确到2位小数;单位:元。如:200.07，表示:200元7分',
  `post_fee` decimal(10,2) DEFAULT NULL COMMENT '邮费。精确到2位小数;单位:元。如:200.07，表示:200元7分',
  `count` int NOT NULL DEFAULT '1' COMMENT '购买商品的数量',
  `state` int DEFAULT NULL COMMENT '状态：1.已支付 2.未支付',
  `create_time` datetime DEFAULT NULL COMMENT '订单创建时间',
  `payment_time` datetime DEFAULT NULL COMMENT '付款时间',
  `end_time` datetime DEFAULT NULL COMMENT '交易完成时间',
  `user_id` bigint DEFAULT NULL COMMENT '用户id',
  `username` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT '买家昵称',
  `address_id` int DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `create_time` (`create_time`) USING BTREE,
  KEY `buyer_nick` (`username`) USING BTREE,
  KEY `status` (`state`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=75 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_order`
--

LOCK TABLES `t_order` WRITE;
/*!40000 ALTER TABLE `t_order` DISABLE KEYS */;
INSERT INTO `t_order` (`id`, `order_name`, `order_no`, `order_picture`, `product_id`, `pay_price`, `post_fee`, `count`, `state`, `create_time`, `payment_time`, `end_time`, `user_id`, `username`, `address_id`) VALUES (1,'小米10Pro','1804800006191366144','https://gw.alicdn.com/imgextra/i2/872196368/O1CN017JxrzU1wuaxr3daS4_!!872196368.jpg_Q75.jpg_.webp\n',14,123.00,0.00,1,1,'2023-01-18 07:05:05','2022-02-10 09:00:00',NULL,17,'admin',NULL),(2,'红米','1804797481853698048','https://gd2.alicdn.com/imgextra/i3/368976905/O1CN01Bmrztb20sXdfYmxzi_!!368976905.jpg_400x400.jpg\n',12,1.00,0.00,1,1,'2023-01-03 04:08:00','2023-01-03 04:06:00',NULL,17,'admin',NULL),(7,'手账本','1634111170392649728','https://gd2.alicdn.com/imgextra/i4/132942065/O1CN015slStJ1R7oUcJMOVB_!!132942065.jpg_400x400.jpg\n',NULL,20.00,0.00,1,2,'2023-03-05 01:51:11',NULL,NULL,5,'xia',NULL),(8,'手账本','1632199181990936576','https://gd2.alicdn.com/imgextra/i4/132942065/O1CN015slStJ1R7oUcJMOVB_!!132942065.jpg_400x400.jpg\n',NULL,20.00,0.00,1,1,'2023-03-05 01:59:44','2023-03-05 10:00:43',NULL,5,'xia',NULL),(9,'小米10Pro','1632200081102913536','https://gw.alicdn.com/imgextra/i2/872196368/O1CN017JxrzU1wuaxr3daS4_!!872196368.jpg_Q75.jpg_.webp\n',NULL,10000.00,0.00,1,2,'2023-03-05 02:03:19',NULL,NULL,5,'xia',NULL),(10,'红米K60','1632200678665428992','https://gd2.alicdn.com/imgextra/i3/368976905/O1CN01Bmrztb20sXdfYmxzi_!!368976905.jpg_400x400.jpg\n',NULL,2699.00,0.00,1,1,'2023-03-05 02:05:41','2023-03-05 10:06:02',NULL,5,'xia',NULL),(11,'红米K60','1632201774330884096','https://gd2.alicdn.com/imgextra/i3/368976905/O1CN01Bmrztb20sXdfYmxzi_!!368976905.jpg_400x400.jpg\n',NULL,2699.00,0.00,1,2,'2023-03-05 02:10:11',NULL,NULL,5,'xia',NULL),(12,'小米10Pro','1632203830471024640','https://gw.alicdn.com/imgextra/i2/872196368/O1CN017JxrzU1wuaxr3daS4_!!872196368.jpg_Q75.jpg_.webp\n',NULL,10000.00,0.00,1,1,'2023-03-05 10:18:13','2023-03-05 10:18:41',NULL,5,'xia',NULL),(13,'手账本','1632660231534194688','https://gd2.alicdn.com/imgextra/i4/132942065/O1CN015slStJ1R7oUcJMOVB_!!132942065.jpg_400x400.jpg\n',NULL,20.00,0.00,1,1,'2023-03-06 16:31:47','2023-03-06 16:33:33',NULL,8,'晴',NULL),(15,'乐事薯片','1634111170392649728','https://gw.alicdn.com/imgextra/i4/1048187520/O1CN01DtbxdB25QDEIFViNh_!!0-item_pic.jpg_Q75.jpg_.webp',NULL,21.00,0.00,1,2,'2023-03-07 14:38:49',NULL,NULL,5,'xia',NULL),(17,'倩碧润肤乳液','1633302031521292288','https://gw.alicdn.com/imgextra/i3/1653734047/O1CN01IhMjWr1flZh1NXBGZ_!!1653734047.jpg_Q75.jpg_.webp',NULL,430.00,0.00,1,1,'2023-03-07 15:25:34','2023-03-08 11:02:29',NULL,5,'xia',NULL),(18,'手账本','1633300985197633536','https://gd2.alicdn.com/imgextra/i4/132942065/O1CN015slStJ1R7oUcJMOVB_!!132942065.jpg_400x400.jpg',NULL,19.99,0.00,1,1,'2023-03-07 17:04:53','2023-03-08 10:58:22',NULL,5,'xia',NULL),(20,'乐事薯片','1633300985197633536','https://gw.alicdn.com/imgextra/i4/1048187520/O1CN01DtbxdB25QDEIFViNh_!!0-item_pic.jpg_Q75.jpg_.webp',NULL,21.00,0.00,1,1,'2023-03-07 17:14:33','2023-03-08 10:58:22',NULL,5,'xia',NULL),(21,'笔记本','1634385754610311168','https://gd1.alicdn.com/imgextra/i1/2214800833667/O1CN01TKrNN51cxXBZaNxA4_!!2214800833667.jpg',NULL,50000.00,0.00,1,2,'2023-03-07 21:18:30',NULL,NULL,5,'xia',NULL),(24,'汉堡','1633671671267221504','https://shadow.elemecdn.com/app/element/hamburger.9cf7b091-55e9-11e9-a976-7f4d0b07eef6.png',NULL,36.80,0.00,1,1,'2023-03-09 11:27:30','2023-03-09 11:31:18',NULL,4,'1',NULL),(25,'汉堡','1633671671267221504','https://shadow.elemecdn.com/app/element/hamburger.9cf7b091-55e9-11e9-a976-7f4d0b07eef6.png',NULL,36.80,0.00,1,1,'2023-03-09 11:28:15','2023-03-09 11:31:18',NULL,4,'1',NULL),(26,'汉堡','1633671671267221504','https://shadow.elemecdn.com/app/element/hamburger.9cf7b091-55e9-11e9-a976-7f4d0b07eef6.png',NULL,36.80,0.00,1,1,'2023-03-09 11:28:25','2023-03-09 11:31:18',NULL,4,'1',NULL),(30,'汉堡','1634363325854883840','https://shadow.elemecdn.com/app/element/hamburger.9cf7b091-55e9-11e9-a976-7f4d0b07eef6.png',NULL,36.80,0.00,1,1,'2023-03-11 09:19:17','2023-03-11 09:19:39',NULL,5,'xia',NULL),(31,'乐事薯片','1634385754610311168','https://gw.alicdn.com/imgextra/i4/1048187520/O1CN01DtbxdB25QDEIFViNh_!!0-item_pic.jpg_Q75.jpg_.webp',NULL,21.00,0.00,1,2,'2023-03-11 10:46:00',NULL,NULL,5,'xia',NULL),(32,'外星人笔记本','1634385754610311168','https://gd1.alicdn.com/imgextra/i1/2214800833667/O1CN01TKrNN51cxXBZaNxA4_!!2214800833667.jpg',NULL,3580.00,0.00,1,2,'2023-03-11 10:46:43',NULL,NULL,5,'xia',NULL),(33,'外星人笔记本','1634385754610311168','https://gd1.alicdn.com/imgextra/i1/2214800833667/O1CN01TKrNN51cxXBZaNxA4_!!2214800833667.jpg',NULL,3580.00,0.00,1,2,'2023-03-11 10:47:20',NULL,NULL,5,'xia',NULL),(34,'Acer笔记本','1635492890651680768','https://gd4.alicdn.com/imgextra/i2/2214800833667/O1CN01fZqqu01cxXBS0ghhs_!!2214800833667.jpg_400x400.jpg',NULL,2348.00,0.00,1,2,'2023-03-11 10:51:50',NULL,NULL,5,'xia',NULL),(36,'Acer笔记本','1635274609705648128','https://gd4.alicdn.com/imgextra/i2/2214800833667/O1CN01fZqqu01cxXBS0ghhs_!!2214800833667.jpg_400x400.jpg',NULL,2500.00,0.00,1,1,'2023-03-13 21:40:24','2023-03-14 12:03:51',NULL,5,'xia',NULL),(38,'外星人笔记本','1635492890651680768','https://gd1.alicdn.com/imgextra/i1/2214800833667/O1CN01TKrNN51cxXBZaNxA4_!!2214800833667.jpg',NULL,3580.00,0.00,1,2,'2023-03-14 12:06:54',NULL,NULL,5,'xia',NULL),(39,'倩碧润肤乳液','1640575836509065216','https://gw.alicdn.com/imgextra/i3/1653734047/O1CN01IhMjWr1flZh1NXBGZ_!!1653734047.jpg_Q75.jpg_.webp',NULL,430.00,0.00,1,2,'2023-03-14 12:07:25',NULL,NULL,5,'xia',NULL),(41,'手账本','1640575836509065216','https://gd2.alicdn.com/imgextra/i4/132942065/O1CN015slStJ1R7oUcJMOVB_!!132942065.jpg_400x400.jpg',NULL,19.99,0.00,1,2,'2023-03-28 12:45:28',NULL,NULL,5,'xia',NULL),(43,'外星人笔记本','1760604536419397632','https://gd1.alicdn.com/imgextra/i1/2214800833667/O1CN01TKrNN51cxXBZaNxA4_!!2214800833667.jpg',NULL,3580.00,0.00,1,2,'2024-02-22 17:56:47',NULL,NULL,17,'admin',NULL),(44,'外星人笔记本','1760607270250004480','https://gd1.alicdn.com/imgextra/i1/2214800833667/O1CN01TKrNN51cxXBZaNxA4_!!2214800833667.jpg',NULL,3580.00,0.00,1,1,'2024-02-22 17:58:18','2024-02-22 18:08:03',NULL,17,'admin',NULL),(46,'外星人笔记本','1760610495816585216','https://gd1.alicdn.com/imgextra/i1/2214800833667/O1CN01TKrNN51cxXBZaNxA4_!!2214800833667.jpg',NULL,3580.00,0.00,1,1,'2024-02-22 18:20:27','2024-02-22 18:20:46',NULL,17,'admin',NULL),(47,'汉堡','1760610850298187776','https://shadow.elemecdn.com/app/element/hamburger.9cf7b091-55e9-11e9-a976-7f4d0b07eef6.png',NULL,36.80,0.00,1,1,'2024-02-22 18:21:31','2024-02-22 18:22:05',NULL,17,'admin',NULL),(49,'汉堡','1762429629294501888','https://shadow.elemecdn.com/app/element/hamburger.9cf7b091-55e9-11e9-a976-7f4d0b07eef6.png',NULL,36.80,0.00,2,1,'2024-02-27 16:34:41','2024-02-27 18:49:28',NULL,17,'admin',NULL),(51,'倩碧润肤乳液','1762406715291648000','https://gw.alicdn.com/imgextra/i3/1653734047/O1CN01IhMjWr1flZh1NXBGZ_!!1653734047.jpg_Q75.jpg_.webp',NULL,430.00,0.00,3,1,'2024-02-27 16:47:17','2024-02-27 17:19:00',NULL,17,'admin',NULL),(52,'小米10Pro','1762405757291606016','https://gw.alicdn.com/imgextra/i2/2208143412112/O1CN01Ucp0kn1RTLCyjjKAq_!!2208143412112.jpg_Q75.jpg_.webp',NULL,2999.00,0.00,1,1,'2024-02-27 17:14:11','2024-02-27 17:14:44',NULL,17,'admin',NULL),(53,'汉堡','1762428338178678784','https://shadow.elemecdn.com/app/element/hamburger.9cf7b091-55e9-11e9-a976-7f4d0b07eef6.png',6,36.80,0.00,1,1,'2024-02-27 18:43:55','2024-02-27 18:44:29',NULL,17,'admin',NULL),(54,'汉堡','1762428782938480640','https://shadow.elemecdn.com/app/element/hamburger.9cf7b091-55e9-11e9-a976-7f4d0b07eef6.png',6,36.80,0.00,5,1,'2024-02-27 18:45:41','2024-02-27 18:45:53',NULL,17,'admin',NULL),(57,'小米10Pro','1762431180503310336','https://gw.alicdn.com/imgextra/i2/2208143412112/O1CN01Ucp0kn1RTLCyjjKAq_!!2208143412112.jpg_Q75.jpg_.webp',2,2999.00,0.00,1,1,'2024-02-27 18:55:07','2024-02-27 18:55:26',NULL,17,'admin',NULL),(58,'红米K60','1762432095830466560','https://gd2.alicdn.com/imgextra/i3/368976905/O1CN01Bmrztb20sXdfYmxzi_!!368976905.jpg_400x400.jpg',3,2699.00,0.00,1,1,'2024-02-27 18:58:51','2024-02-27 18:59:10',NULL,17,'admin',NULL),(59,'Acer笔记本','1763549309065265152','https://gd4.alicdn.com/imgextra/i2/2214800833667/O1CN01fZqqu01cxXBS0ghhs_!!2214800833667.jpg_400x400.jpg',5,2000.00,0.00,1,3,'2024-03-01 20:58:15','2024-03-01 20:58:46',NULL,17,'admin',NULL),(60,'Acer笔记本','1763549691980054528','https://gd4.alicdn.com/imgextra/i2/2214800833667/O1CN01fZqqu01cxXBS0ghhs_!!2214800833667.jpg_400x400.jpg',5,2000.00,0.00,4,1,'2024-03-01 20:59:46','2024-03-01 21:00:03',NULL,17,'admin',NULL),(67,'Adidas阿迪达斯板鞋','1804411548700594176','https://gd4.alicdn.com/imgextra/i3/777481810/O1CN01f9yUKG1PF1dXKtyfT_!!777481810.jpg_400x400.jpg',9,339.00,0.00,1,2,'2024-06-20 21:32:00',NULL,NULL,17,'admin',NULL),(69,'倩碧润肤乳液','1804445413225869312','https://gw.alicdn.com/imgextra/i3/1653734047/O1CN01IhMjWr1flZh1NXBGZ_!!1653734047.jpg_Q75.jpg_.webp',8,430.00,0.00,2,2,'2024-06-22 12:42:00',NULL,NULL,17,'admin',NULL),(71,'dsf','1804406955967074304','http://localhost:9090/files/91c404fc22af49fb9c0c1877b685fe70_-253fead462411fbe.jpg',14,123.00,0.00,1,1,'2024-06-22 14:51:00','2024-06-21 00:00:00',NULL,17,'admin',NULL),(72,'好','1804445685725605888','http://localhost:9090/files/91c404fc22af49fb9c0c1877b685fe70_-253fead462411fbe.jpg',14,123.00,0.00,1,2,'2024-06-22 17:25:51',NULL,NULL,17,'admin',NULL),(73,'Adidas阿迪达斯板鞋','1804786510913355776','http://localhost:9090/files/3212033a0e3b480d8b6806c685639563_IMG_20230128_212807.jpg',9,339.00,0.00,3,2,'2024-06-22 17:27:00',NULL,NULL,17,'admin',NULL);
/*!40000 ALTER TABLE `t_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '用户名',
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '用户密码',
  `nick_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '昵称',
  `age` int DEFAULT NULL COMMENT '年龄',
  `avatar` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '用户头像',
  `sex` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '性别',
  `address` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '地址',
  `role` int NOT NULL DEFAULT '2' COMMENT '用户的角色，1是管理员，2是普通用户',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='用户信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` (`id`, `username`, `password`, `nick_name`, `age`, `avatar`, `sex`, `address`, `role`) VALUES (5,'xia','7777xia.','七',19,'http://localhost:9090/files/7164df51623f40b8b535cf985b267176_4.jpg','男','四川省 成都市 双流区 川大路二段 四川大学江安校区',1),(8,'晴','123','小晴',20,'http://localhost:9090/files/b209277b413d48c787cda94ded2e1e85_5.jpg','女','湖南',2),(13,'111','111','test',10,NULL,'男','test',2),(16,'8','5555',NULL,NULL,NULL,NULL,NULL,2),(17,'admin','123','admin',20,'http://localhost:9090/files/1dacd3720e9446dbbf72f8d0c15f84e2_6e188046f8e0259a.jpg','未知','四川省成都市',1),(18,'526','12345678',NULL,NULL,NULL,NULL,NULL,2),(19,'15','123','test',11,NULL,'未知','四川大学',2),(20,'test','123','test',20,NULL,'男','test',2);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_advice`
--

DROP TABLE IF EXISTS `user_advice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8 */;
CREATE TABLE `user_advice` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '建议的唯一ID',
  `user_id` int NOT NULL COMMENT '用户 id',
  `nick_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '昵称',
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT '用户名',
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT '建议标题',
  `content` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT '建议内容',
  `create_time` datetime DEFAULT NULL COMMENT '建议日期',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='用户建议表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_advice`
--

LOCK TABLES `user_advice` WRITE;
/*!40000 ALTER TABLE `user_advice` DISABLE KEYS */;
INSERT INTO `user_advice` (`id`, `user_id`, `nick_name`, `username`, `title`, `content`, `create_time`) VALUES (2,17,NULL,'admin','哈哈哈哈，一定会幸福的','大大大大大AAAI','2023-12-01 16:51:12'),(4,5,'七','xia','5555','55555','2023-11-30 16:51:22'),(5,5,'七','xia','sss','ssss','2023-11-28 16:51:25'),(6,5,'七','xia','hhhhhh','111','2023-11-24 17:46:18'),(7,17,'admin','admin','111111','55555','2023-12-04 17:46:33'),(8,17,'admin','admin','1111','1111111','2024-02-22 18:23:40'),(9,17,'admin','admin','希望多点漫画书','多点','2024-06-22 14:58:22');
/*!40000 ALTER TABLE `user_advice` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-06-24 16:03:05
