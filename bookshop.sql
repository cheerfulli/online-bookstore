-- MySQL dump 10.13  Distrib 8.0.33, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: springboot-vue
-- ------------------------------------------------------
-- Server version	8.0.33

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
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
/*!50503 SET character_set_client = utf8mb4 */;
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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `address`
--

LOCK TABLES `address` WRITE;
/*!40000 ALTER TABLE `address` DISABLE KEYS */;
INSERT INTO `address` (`id`, `user_id`, `phone`, `address`, `add_detail`, `add_name`) VALUES (5,22,'19890145501','北京市 市辖区 西城区','江西省南昌市红谷滩区沙井街道丰和南大道696号南昌航空大学','lf'),(6,25,'78412346666','吉林省 长春市 南关区','lll','li'),(7,17,'19820415501','天津市 市辖区 河东区','江西省南昌市红谷滩区沙井街道丰和南大道696号南昌航空大学','lf');
/*!40000 ALTER TABLE `address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cart`
--

DROP TABLE IF EXISTS `cart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart`
--

LOCK TABLES `cart` WRITE;
/*!40000 ALTER TABLE `cart` DISABLE KEYS */;
INSERT INTO `cart` (`id`, `pay_price`, `product_id`, `post_fee`, `count`, `user_id`, `username`, `address_id`, `cart_name`, `cart_picture`) VALUES (13,9.90,36,0.00,2,24,'111',NULL,'烟霞里','http://localhost:9090/files/0692cc9948d144c3b0034d2ae5444797_29502682-1_w_1693210473.jpg'),(14,149.60,35,0.00,1,24,'111',NULL,'茶人四部曲','http://localhost:9090/files/3c4ab9f8f9ac4f3f9044b82ca23aa8ca_29559027-1_w_7.jpg'),(16,26.60,27,0.00,1,24,'111',NULL,'精神病预后档案：从遗弃中诞生','http://localhost:9090/files/092441c6724a43afb9c0c46bc78e612a_29697413-1_w_1713148339 (1).jpg'),(19,34.00,32,0.00,1,22,'21045312',NULL,'望江南','http://localhost:9090/files/f2380b2ea835488983c3a23e342c62db_29367830-1_w_45.jpg'),(24,29.50,30,0.00,1,22,'21045312',NULL,'破冰游戏','http://localhost:9090/files/420f3fc2bb33439b8c6bd7b965ca8e54_29691721-1_l_1710210792.jpg'),(29,41.70,23,0.00,2,27,'333',NULL,'骤雨','http://localhost:9090/files/7ffc689d23a042d4acf8cab8a003104a_29722794-1_w_1715591026.jpg'),(30,115.00,20,0.00,2,27,'333',NULL,'茅盾文学奖自选精编套装','http://localhost:9090/files/1d2400b4c82646378873a277cbeb78de_29714158-1_w_1714263930.jpg'),(31,29.50,22,0.00,1,27,'333',NULL,'欢迎来到人间','http://localhost:9090/files/c1449639120e495fa30d98691ce03b43_29599310-1_w_1693880977.jpg'),(32,9.90,36,0.00,1,22,'21045312',NULL,'烟霞里','http://localhost:9090/files/0692cc9948d144c3b0034d2ae5444797_29502682-1_w_1693210473.jpg'),(34,149.60,35,0.00,1,17,'admin',NULL,'茶人四部曲','http://localhost:9090/files/3c4ab9f8f9ac4f3f9044b82ca23aa8ca_29559027-1_w_7.jpg');
/*!40000 ALTER TABLE `cart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item`
--

DROP TABLE IF EXISTS `item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC COMMENT='商品表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item`
--

LOCK TABLES `item` WRITE;
/*!40000 ALTER TABLE `item` DISABLE KEYS */;
INSERT INTO `item` (`id`, `title`, `sell_point`, `price`, `stock`, `barcode`, `image`, `cid`, `status`, `created`, `updated`) VALUES (15,'马尔克斯：百年孤独（纪念版）','新版典藏内封。加西亚·马尔克斯代表作，惟一正式中文版，未作任何删节，发行量超800万册！',39.60,999,NULL,'http://localhost:9090/files/cd9bf6a4edee467892a9bc1c1d7da1b0_25138856-1_w_7.jpg',3,1,'2024-06-25 13:01:00','2024-06-25 14:56:05'),(16,'假如给我三天光明','(中小学生课外阅读指导丛书)无障碍阅读 彩插励志版 550000多名读者热评！',6.60,66,NULL,'http://localhost:9090/files/db99cbe74f6f4567960b0c8554b0af42_22800646-1_w_52.jpg',1,1,'2024-06-25 13:43:15',NULL),(17,'张嘉佳十年文集限定礼盒','总销量逾1000万册，超40亿阅读，张嘉佳十年佳作重新集结，附赠“十年之约”纪念信，手绘治愈主题长桌垫、三款手写寄语印制明信片。这人生不过一段悲欢离合，这世界也就一场匆匆路过。你我皆在故事中 预售商品',100.00,88,NULL,'http://localhost:9090/files/3af54897e1c449b181699d3675ecf264_29413233-1_w_1716968956.jpg',3,1,'2024-06-25 13:48:38',NULL),(18,'请记得乐园（专享亲签版）','继豆瓣“热门推理”前十《19年间谋杀小叙》，悬疑作家那多脱胎换骨之作。',46.60,77,NULL,'http://localhost:9090/files/d4796f9b56404185aaf1331f9effb967_29708896-1_w_1712898586.jpg',2,1,'2024-06-25 13:50:00','2024-06-25 14:55:51'),(19,'燕食记','（2023第十一届茅奖文学奖十强；当当专项藏书票版；江南岭南风日好，世道味道总关情）\n岭南百年老字号同钦楼盛传将在年底结业。一帮老伙计力挽狂澜，盘下店面。同钦楼已退休的主厨荣贻生师傅，道出个中缘由……\n',39.90,100,NULL,'http://localhost:9090/files/1981fe0b04f4450e92b9c8beadbeadc9_29438760-1_w_1692767299.jpg',9,1,'2024-06-25 13:52:53',NULL),(20,'茅盾文学奖自选精编套装','茅盾文学奖作家自选精篇版，特别收录最新独家访谈，一套书快速了解四部获奖作品。特别赠送含作者印章的精美藏书票。封面特种艺术纸，内文80克护眼纯质纸',115.00,98,NULL,'http://localhost:9090/files/1d2400b4c82646378873a277cbeb78de_29714158-1_w_1714263930.jpg',3,1,'2024-06-25 13:54:00','2024-06-25 13:55:16'),(21,'装腔启示录','人间装腔观察实录，都市男女互撩手册。豆瓣阅读第二届长篇拉力赛总冠军作品，阅读量超396万次。芒果TV官宣同名电视剧！看都市虐恋，高手过招。',24.00,99,NULL,'http://localhost:9090/files/e47c27fc8d9641eeab432c19e9b5f11a_29345197-1_w_1693214693.jpg',5,1,'2024-06-25 13:57:05',NULL),(22,'欢迎来到人间','茅盾文学奖得主毕飞宇睽违十五年长篇新作',29.50,89,NULL,'http://localhost:9090/files/c1449639120e495fa30d98691ce03b43_29599310-1_w_1693880977.jpg',10,1,'2024-06-25 13:58:51',NULL),(23,'骤雨','命运是一场突如其来的大雨。校园无限流生死逃亡。逆向时空的因果宿命。我们在结局相遇，开端即重逢。随书附赠：人设生日卡*2、歌词卡*2、物理试卷*2',41.70,11,NULL,'http://localhost:9090/files/7ffc689d23a042d4acf8cab8a003104a_29722794-1_w_1715591026.jpg',5,1,'2024-06-25 14:01:14',NULL),(24,'那不勒斯四部曲（套装共4册）','童书妈妈三川玲推荐！当当独家函套版！我的天才女友+新名字的故事+离开的,留下的+失踪的孩子。“我的整个生命，只是一场为了提升社会地位的低俗斗争”—— 埃莱娜 费兰',143.40,66,NULL,'http://localhost:9090/files/349a72b8455e451abfe1eba91e9c6457_29447297-1_w_4.jpg',7,1,'2024-06-25 14:02:42',NULL),(25,'立秋','天道立秋，生生不息。人道立业，奋斗不止！实力派作家杜阳林继《惊蛰》之后全新力作！）\n与改革脉搏同频共振，随乡土精神嬗变更生！ 大变革年代，创业者勇毅突围的奋斗史和心灵史！ 书写身在都市、根系乡土的一代人，他们的思考与抉择、热望与坚守！',32.50,88,NULL,'http://localhost:9090/files/7bf39c27d60e4b6ab7bf4df15b9addf6_29704573-1_w_1717051783.jpg',7,1,'2024-06-25 14:03:54',NULL),(26,'女仆','美国亚马逊悬疑畅销榜冠军，全球畅销超300万册，《纽约时报》霸榜39周，当当首发作者签名印签版，中文简体版首次引进）\n《纽约时报》霸榜39周！girls help girls＋双女主视角＋倒叙式推理+复仇爽文！ 罪恶终有源头，受过伤的人总会以同样的方式去伤害别人……',29.50,100,NULL,'http://localhost:9090/files/d1cf18a3fe1a498f8910e9a08aac193e_29735240-1_w_1718091770.jpg',3,1,'2024-06-25 14:05:22',NULL),(27,'精神病预后档案：从遗弃中诞生','（世界是一个巨大的精神病院，我们每个人都是这里的居民。《疯人说》作者穆戈长篇小说）\n校园霸凌的恶魔，反而患了抑郁症；被偷录隐私的患者，却要包庇罪犯；常年关在小黑屋的女孩，从没发声求救……谁是医生谁是病人，谁是精神病谁是正常人，世界是一个巨大的精神病院，欢迎来到非正常世界。',26.60,98,NULL,'http://localhost:9090/files/092441c6724a43afb9c0c46bc78e612a_29697413-1_w_1713148339 (1).jpg',3,1,'2024-06-25 14:08:15',NULL),(28,'追诉时效倒计时','刑警的直觉有多可怕？只一眼就能看出猫腻！日本刑侦小说泰斗横山秀夫至高杰作！豆瓣8.8分！作者印签版 读客悬疑文库\n运钞车劫杀案、白骨抛尸案、灭门惨案……6个短篇掀起9场绝命追凶！横山秀夫是日本推理作家协会奖、德国犯罪小说奖（国际奖）得主！翻开本书，看直觉敏锐的刑警如何识破真凶！读客熊猫君出品',34.90,99,NULL,'http://localhost:9090/files/31af5413ff63423f92857e3d2fff906a_29699828-1_l_1710487131.jpg',6,1,'2024-06-25 14:22:45',NULL),(29,'无辜者的谎言','（相信我！看到结局你一定会头皮发麻；全美读者推荐的悬疑神作，GOODREADS高分作品）\n风靡全美的悬疑神作，人性议题+双线叙事+极限反杀+多重反转，不到最后一刻，一定猜不到凶手是谁。一场关乎正义与人性的审判，一场横亘在伦理与法律间的博弈',24.90,99,NULL,'http://localhost:9090/files/f4ead79e47d94016941d3b6874043e91_29701699-1_w_1713433205.jpg',3,1,'2024-06-25 14:24:41',NULL),(30,'破冰游戏','（英国前自由式滑雪运动员艾莉?雷诺兹处女作 阿尔卑斯暴风雪山庄 × 心理惊悚 × 滑雪竞技）午夜文库\n深呼吸，全员腾空，720°情节反转—— 命案先别提，破冰时间到！',29.50,194,NULL,'http://localhost:9090/files/420f3fc2bb33439b8c6bd7b965ca8e54_29691721-1_l_1710210792.jpg',5,1,'2024-06-25 14:32:19',NULL),(31,'海风中失落的血色馈赠','阿利斯泰尔·麦克劳德作品集）\n很难想出还有谁能写出具有阿利斯泰尔·麦克劳德般魅力的小说。——2013年诺贝尔文学奖得主爱丽丝·门罗 。',21.80,890,NULL,'http://localhost:9090/files/da39407797a74a6fb30070accdd1daa1_29224060-1_w_1695622082.jpg',6,1,'2024-06-25 14:33:39',NULL),(32,'望江南','2022中国好书获奖作品！茅奖得主王旭烽，沉潜26年，最新长篇小说力作。）\n在一片叶子的乾坤中，品饮世间人情，体悟命运流转。茶人精神、江南文化、家国情怀， 见证个人史、家族史、民族史中的百年中国。',34.00,123,NULL,'http://localhost:9090/files/f2380b2ea835488983c3a23e342c62db_29367830-1_w_45.jpg',1,1,'2024-06-25 14:35:04',NULL),(33,'河边的错误 (最新版)','余华先锋代表作 朱一龙主演戛纳入围电影同名小说\n余华先锋代表作（最新精装版）',29.80,88,NULL,'http://localhost:9090/files/c4ce77450ea7464a86543c602b91812b_29587088-1_w_1714375768.jpg',10,1,'2024-06-25 14:38:18',NULL),(34,'紫颜色','底层女性的觉醒之路，女性群像的至深书写。首位获得普利策小说奖的非裔女作家 ——艾丽斯·沃克代表作。普利策小说奖×美国国家图书奖双料得主。同名改编电影由斯皮尔伯格执导。',35.00,122,NULL,'http://localhost:9090/files/d85ea7b52ceb45dd841352ece578b955_29599659-1_w_1695178440.jpg',7,1,'2024-06-25 14:39:47',NULL),(35,'茶人四部曲','（全新修订，重磅集结。带你领略纸上杭州，诗画江南。附赠人物谱系图）\n茶人精神，江南文化，家国情怀。 见证个人史、家族史、民族史中的百年中国！',149.60,50,NULL,'http://localhost:9090/files/3c4ab9f8f9ac4f3f9044b82ca23aa8ca_29559027-1_w_7.jpg',8,1,'2024-06-25 14:41:00','2024-06-26 17:45:35'),(37,'西游记','精装插图青少版 小升初、中考配套阅读 生僻字注音+注释+注解 9-15岁孩子更容易读懂',10.00,0,NULL,'http://localhost:9090/files/8b50c35a4e5b4815a462204274ae32d1_12100008909-1_w_1697622603.jpg',1,1,'2024-06-28 09:47:00','2024-06-29 16:09:51');
/*!40000 ALTER TABLE `item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item_detail`
--

DROP TABLE IF EXISTS `item_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `item_detail` (
  `item_id` bigint NOT NULL COMMENT '商品ID',
  `item_detail` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci COMMENT '商品的详情',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='商品详细信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_detail`
--

LOCK TABLES `item_detail` WRITE;
/*!40000 ALTER TABLE `item_detail` DISABLE KEYS */;
INSERT INTO `item_detail` (`item_id`, `item_detail`, `create_time`, `update_time`) VALUES (15,'<p><img src=\"http://localhost:9090/files/76aaa7bcd44d432b860d2969cec3710f_99999990182041110.jpg\" style=\"max-width:100%;\" contenteditable=\"false\"/></p>','2024-06-25 13:01:00','2024-06-25 13:40:33'),(16,'<img src=\"http://localhost:9090/files/551b2d0f89794207a3a6863ffeef870c_99999990480713857.jpg\" style=\"max-width:100%;\" contenteditable=\"false\"/><img src=\"http://localhost:9090/files/7d99e032c38f4d36bb3069f7dfdbd1c9_99999990480713863.jpg\" style=\"max-width:100%;\" contenteditable=\"false\"/><img src=\"http://localhost:9090/files/4a9cce78d4684f1abcc67ee46e76330a_99999990480713869.jpg\" style=\"max-width:100%;\" contenteditable=\"false\"/>','2024-06-25 13:43:00','2024-06-25 13:44:57'),(17,'<img src=\"http://localhost:9090/files/00f8f87a6fee4d82882eec0a490802d0_99999990596849194.jpg\" style=\"max-width:100%;\" contenteditable=\"false\"/>','2024-06-25 13:48:00','2024-06-25 13:49:12'),(18,'<img src=\"http://localhost:9090/files/58829695845746d2b6c668527b3b9b56_99999990596748151.jpg\" style=\"max-width:100%;\" contenteditable=\"false\"/>','2024-06-25 13:50:00','2024-06-25 13:51:31'),(19,'<img src=\"http://localhost:9090/files/99e5ffded3d4440f951944a77a1a15ea_99999990596335765.jpg\" style=\"max-width:100%;\" contenteditable=\"false\"/>','2024-06-25 13:52:00','2024-06-25 13:53:15'),(20,'<img src=\"http://localhost:9090/files/91905718e7a44b468f3c2d241a840289_99999990596766557.jpg\" style=\"max-width:100%;\" contenteditable=\"false\"/>','2024-06-25 13:54:00','2024-06-25 13:55:48'),(21,'<img src=\"http://localhost:9090/files/6542df47088f42348901c9f7b910405f_99999990368535870.jpg\" style=\"max-width:100%;\" contenteditable=\"false\"/>','2024-06-25 13:57:00','2024-06-25 13:57:30'),(22,'<img src=\"http://localhost:9090/files/051917071dae476f8d9d16d0f4d893b2_99999990587112715.jpg\" style=\"max-width:100%;\" contenteditable=\"false\"/>','2024-06-25 13:58:00','2024-06-25 13:59:09'),(23,'<img src=\"http://localhost:9090/files/5e60b3aba11d4537987ec418e3e835af_99999990596798991.jpg\" style=\"max-width:100%;\" contenteditable=\"false\"/>','2024-06-25 14:01:00','2024-06-25 14:01:33'),(24,'<img src=\"http://localhost:9090/files/1976ed5ebf82463a972b03378ed03514_99999990436801113.jpg\" style=\"max-width:100%;\" contenteditable=\"false\"/>','2024-06-25 14:02:00','2024-06-25 14:03:06'),(25,'<img src=\"http://localhost:9090/files/308d0508809c419997aabfa6cc12ef2d_99999990596852845.jpg\" style=\"max-width:100%;\" contenteditable=\"false\"/>','2024-06-25 14:03:00','2024-06-25 14:04:22'),(26,'<img src=\"http://localhost:9090/files/7f6be6850f3a448f83b21a76685fad7e_99999990596876174.jpg\" style=\"max-width:100%;\" contenteditable=\"false\"/>','2024-06-25 14:05:00','2024-06-25 14:06:50'),(27,'<img src=\"http://localhost:9090/files/4fc7d18e8d4b433c88f44b3f34d2c115_99999990596727142.jpg\" style=\"max-width:100%;\" contenteditable=\"false\"/>','2024-06-25 14:08:00','2024-06-25 14:12:12'),(28,'<img src=\"http://localhost:9090/files/22768fd7e6a54ac08445d7d04dff256e_99999990596694301.jpg\" style=\"max-width:100%;\" contenteditable=\"false\"/>','2024-06-25 14:22:00','2024-06-25 14:23:54'),(29,'<img src=\"http://localhost:9090/files/b0546fa648204649b78da54bffce83ed_99999990596705737.jpg\" style=\"max-width:100%;\" contenteditable=\"false\"/>','2024-06-25 14:24:00','2024-06-25 14:25:24'),(30,'<img src=\"http://localhost:9090/files/c360ce3fb73e40af97b235f1a1a39f45_99999990596679642.jpg\" style=\"max-width:100%;\" contenteditable=\"false\"/>','2024-06-25 14:32:00','2024-06-25 14:32:46'),(31,'<p>用极度简洁的语言，抵达人类关系复杂、神秘的地带</p><p>花一辈子去做自己厌烦的事，比永远自私地追逐梦想、随心所欲，要勇敢得多。</p>&nbsp;<p>内容简介</p><p>《海风中失落的血色馈赠》所收入的七个故事，都发生在新斯科舍省布雷顿角那些严酷的风景中，有少年渴望摆脱家族在海岛世代挖煤的命运而在成年之际离家远行，有人到中年的大学教师回忆少年时他那心怀壮志但困居海岛打鱼为生的父亲，有散居各地的大家族成员在老祖母96岁生日之际齐聚老祖母寡居的海角，尘封往事也在个人心中泛起……这些故事勾画了家庭内部紧密的纽带和难以逾越的鸿沟，以及人们面对命运时候那种一脉相承的脆弱和温柔。</p><p>&nbsp;</p><p>书中的七篇故事既体现了人和自然世界粗粝而深情的交融，也含蓄而节制地勾勒了布雷顿角那些复杂、神秘而质朴的人心。它们被记忆和传说浸润，被海水和鲜血冲刷，又在人生一些微妙的时刻，抵达了艰难而令人喜悦的彼此谅解。</p><p>作者简介</p><p>阿利斯泰尔•麦克劳德（1936-2014），加拿大著名短篇小说家，因其一系列以新斯科舍省布雷顿角为背景的小说闻名，其作品已经被翻译成17种语言。著有短篇小说集《海风中失落的血色馈赠》《当鸟儿带来太阳》和获得都柏林国际文学奖的长篇小说《没什么大不了的》。其中，《海风中失落的血色馈赠》自1976年出版以来，已经成了加拿大文学的经典作品。</p><p>&nbsp;</p><p>麦克劳德曾在加拿大温莎大学教授创意写作课多年，每年夏天都会回到布雷顿角写作。阿利斯泰尔•麦克劳德的小说既充满地域色彩，又传递审了深沉而普世的情感。</p><p>目　　录</p><p>1 秋</p><p>27 黑暗茫茫</p><p>67 海风中失落的血色馈赠</p><p>99 回乡</p><p>125 灰白的金色馈赠</p><p>151 船</p><p>183 去乱岑角的路</p><p>227 跋／乔伊斯·卡罗尔·欧茨</p><p>媒体评论</p><p>“阿利斯泰尔•麦克劳德的出生地是加拿大，他的情感中心是布雷顿角，他是苏格兰人的后裔，但他的写作属于世界。”</p><p>&nbsp;</p><p>很难想出还有谁能写出具有阿利斯泰尔•麦克劳德般魅力的小说。&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ——爱丽丝•门罗</p><p>&nbsp;</p><p>和福克纳或契诃夫的作品一样，阿利斯泰尔•麦克劳德的短篇小说既是地域的，又是普世的，而且，我也认为它们是不朽的。&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ——迈克尔•翁达杰</p><p>在线试读</p><p>我的朋友亨利·范·戴肯说父亲会这样是因为他是苏格兰人，这个民族在花草和家禽这些事上从来就不在行，他们觉得这些都是女人们干的活，男人动手是丢人的事。亨利的父亲种花弄草、养鸡养鸭都是好手。<br/>我们正在局促的鸡棚里打转，忽然门“砰”地打开，我们眼见大卫几乎是被风雨吹打进来的。“有个男人开着辆卡车，上面有头老牛，”他说，“他刚才进咱们家了。”<br/>我们进厨房的时候麦克雷就站在门口的那张桌子边上，父亲还是在窗子那里，虽然现在已经转过来背对着窗口了。看情势好像他们两个谁都没有开过口。<br/>麦克雷这个牛贩子今年五十多了，矮小敦实，一张通红脸孔，嘴角叼着根雪茄。他的一双眼睛也很小，还布满血丝。他的裤脚塞在雨靴里，宽皮带是西部风格，棕色山羊外套下面穿着一件法兰绒衬衣，领口没扣上，看得见他带些红色的胸毛。他手里有根短柄长鞭，一直在用来敲他雨靴的侧边。他刚刚在大风雨里走了一小段，所以衣服是湿的，因为厨房里的热量，这股刺鼻的湿气再混合了他雪茄的味道，让人觉得颇为难受。这种气味里闻得到不计其数惊恐的牲畜——它们曾被关在他卡车的车厢里，也曾被他推来搡去——还闻得到牛粪、汗臭和害怕。<br/>“听说你这儿有匹快不行了的老马，”他的话绕过他的雪茄传出来，“运气好的话，我还能用它来换点水貂饲料。我开的价是二十加元。”<br/>父亲一言不发，不过那双如同他身后大海一样灰暗的眼睛，让我想到曾经有一回，斯科特拖着的圆木撞上半掩盖着的障碍，疯狂地弹飞出去，猛烈的冲力正好压在父亲的双腿上，拖着他碾了一小段，直到撞在一个树墩上。那树墩几乎被撞得连根拔起，斯科特也被撞得差点一屁股坐下。父亲的双眼那时也灰暗，其中映射出的全是恐惧、痛楚和无声的讶异：惊讶的是自己如此苦厄的困境似乎又是如此的熟悉。<br/>此刻的情形，很像他被我们所有人算计了，包括他的妻子、他的六个孩子和抽着雪茄的麦克雷。大海已经在这扇窗上留下不少伤痕，此刻它又被急风暴雨冲击着，而我们绕着父亲围成一圈，他靠着这扇窗，真的很像是被我们逼得走投无路了。他还是什么话都不说，虽然我知道，此刻他的思维正沿着所有可能供他辩驳的小径飞奔着，但所有的路线又一下被他自己否决，因为他明白在每条路的尽头，都有让他痛心的事实在等着他：“拖延又有什么用？卡车已经开来了，以后不会有更好的机会了；你自己就快走了；它再不会变回年轻了；价格不可能再提了；它可能这个冬天就死了，那我们就什么也拿不到；我们不是在给退休的老马开疗养院；我一个人在这里照顾六个孩子，本身就忙不过来；买饲料的钱该花在你孩子身上；对你来说，难道孩子还没有一匹马重要？你自己走了，把我们留在这儿照料它，不公平。”</p><p><a href=\"javascript:void(0);\">显示全部信息</a></p><p>价格说明</p><ul><li><i></i>当当价：为商品的销售价，具体的成交价可能因会员使用优惠券、银铃铛等发生变化，最终以订单结算页价格为准。</li><li><i></i>定价：是图书封底定价。</li><li><i></i>划线价：划线价为参考价，划线价格可能是图书封底定价或该商品曾经展示过的销售价等，由于地区、时间的差异化和市场行情波动，划线价可能会与您购物时展示的不一致，该价格仅供您参考。</li><li><i></i>折扣：折扣指在图书定价基础上计算出的优惠比例或优惠金额。如有疑问，您可在购买前联系客服咨询。</li><li><i></i>异常问题：如您发现活动商品销售价或促销信息有异常，请立即联系我们补正，以便您能顺利购物。</li></ul>','2024-06-25 14:33:00','2024-06-25 14:34:17'),(32,'<img src=\"http://localhost:9090/files/d6557aeec77d47a88df4523b19e326f4_99999990565205923.jpg\" style=\"max-width:100%;\" contenteditable=\"false\"/>','2024-06-25 14:35:00','2024-06-25 14:37:00'),(33,'<ul><li>开 本：32开</li><li>纸 张：胶版纸</li><li>包 装：精装</li><li>是否套装：否</li><li>国际标准书号ISBN：9787538772166</li><li><label>所属分类：</label><a target=\"_bland\" href=\"http://category.dangdang.com/cp01.00.00.00.00.00.html\">图书</a>&gt;<a target=\"_bland\" href=\"http://category.dangdang.com/cp01.03.00.00.00.00.html\">小说</a>&gt;<a target=\"_bland\" href=\"http://category.dangdang.com/cp01.03.30.00.00.00.html\">中国当代小说</a></li></ul><a></a><p>本商品暂无详情。</p>','2024-06-25 14:38:00','2024-06-25 14:38:44'),(34,'<img src=\"http://localhost:9090/files/f7478c8023d54b529b773de5532d59d8_99999990593952802.jpg\" style=\"max-width:100%;\" contenteditable=\"false\"/>','2024-06-25 14:39:00','2024-06-25 14:40:15'),(35,'<img src=\"http://localhost:9090/files/b2b20e59ffdd4fc68333759a74fa10ad_99999990546651884.jpg\" style=\"max-width:100%;\" contenteditable=\"false\"/>','2024-06-25 14:41:00','2024-06-25 14:42:11'),(36,'<p><img src=\"http://localhost:9090/files/2151e74744c24aa38cacb386c5079baf_-253fead462411fbe.jpg\" style=\"max-width:100%;\" contenteditable=\"false\"/></p>','2024-06-25 14:43:00','2024-06-26 17:44:25'),(37,'<img src=\"http://localhost:9090/files/160a5efd9f534bf88bf23bd4ccd0e997_99999990596844408.jpg\" style=\"max-width:100%;\" contenteditable=\"false\"/>','2024-06-28 09:47:00','2024-06-28 09:48:31'),(38,'<p></p>','2024-06-29 16:10:24',NULL);
/*!40000 ALTER TABLE `item_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `refund_order`
--

DROP TABLE IF EXISTS `refund_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `refund_order` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '订单表主键',
  `order_no` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL COMMENT '订单编号',
  `order_picture` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL COMMENT '商品预览图',
  `refund_type` int DEFAULT NULL COMMENT '退款的类型：1.未发货退款 2.发货了退款',
  `refund_reason` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL COMMENT '退款原因',
  `refund_desc` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL COMMENT '退款的详细信息',
  `refund_amount` decimal(10,2) DEFAULT NULL COMMENT '退款的金额',
  `user_id` bigint DEFAULT NULL COMMENT '退款用户id',
  `username` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL COMMENT '退款用户名',
  `product_id` int DEFAULT NULL,
  `refund_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=106 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='退款的订单表信息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `refund_order`
--

LOCK TABLES `refund_order` WRITE;
/*!40000 ALTER TABLE `refund_order` DISABLE KEYS */;
INSERT INTO `refund_order` (`id`, `order_no`, `order_picture`, `refund_type`, `refund_reason`, `refund_desc`, `refund_amount`, `user_id`, `username`, `product_id`, `refund_date`) VALUES (80,'1805499063591288832','http://localhost:9090/files/c4ce77450ea7464a86543c602b91812b_29587088-1_w_1714375768.jpg',1,'七天无理由退换','buxhih',29.80,17,'admin',33,'2024-06-25 15:13:20'),(86,'1805809547024642048','http://localhost:9090/files/7ffc689d23a042d4acf8cab8a003104a_29722794-1_w_1715591026.jpg',1,'假冒品牌','不好，没有假一赔十',41.70,25,'123',23,'2024-06-26 11:48:33'),(105,'1806502917015339008','http://localhost:9090/files/c4ce77450ea7464a86543c602b91812b_29587088-1_w_1714375768.jpg',1,'与商家协调一致退款','不好',29.80,17,'admin',33,'2024-06-28 09:44:21');
/*!40000 ALTER TABLE `refund_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_order`
--

DROP TABLE IF EXISTS `t_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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
) ENGINE=InnoDB AUTO_INCREMENT=110 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_order`
--

LOCK TABLES `t_order` WRITE;
/*!40000 ALTER TABLE `t_order` DISABLE KEYS */;
INSERT INTO `t_order` (`id`, `order_name`, `order_no`, `order_picture`, `product_id`, `pay_price`, `post_fee`, `count`, `state`, `create_time`, `payment_time`, `end_time`, `user_id`, `username`, `address_id`) VALUES (78,'茶人四部曲','1805498196909703168','http://localhost:9090/files/3c4ab9f8f9ac4f3f9044b82ca23aa8ca_29559027-1_w_7.jpg',35,149.60,0.00,3,2,'2024-06-25 15:08:09',NULL,NULL,17,'admin',NULL),(80,'河边的错误 (最新版)','1805499063591288832','http://localhost:9090/files/c4ce77450ea7464a86543c602b91812b_29587088-1_w_1714375768.jpg',33,29.80,0.00,1,3,'2024-06-25 15:11:36','2024-06-25 15:12:29',NULL,17,'admin',NULL),(81,'海风中失落的血色馈赠','1805525742246174720','http://localhost:9090/files/da39407797a74a6fb30070accdd1daa1_29224060-1_w_1695622082.jpg',31,21.80,0.00,3,2,'2024-06-25 16:57:37',NULL,NULL,24,'111',NULL),(82,'精神病预后档案：从遗弃中诞生','1805566729593090048','http://localhost:9090/files/092441c6724a43afb9c0c46bc78e612a_29697413-1_w_1713148339 (1).jpg',27,26.60,0.00,1,5,'2024-06-25 19:40:29','2024-06-25 19:40:49','2024-06-25 19:48:01',22,'21045312',NULL),(83,'破冰游戏','1805567705003651072','http://localhost:9090/files/420f3fc2bb33439b8c6bd7b965ca8e54_29691721-1_l_1710210792.jpg',30,29.50,0.00,4,1,'2024-06-25 19:44:21','2024-06-25 19:44:39',NULL,17,'admin',NULL),(84,'茶人四部曲','1805809125518061568','http://localhost:9090/files/3c4ab9f8f9ac4f3f9044b82ca23aa8ca_29559027-1_w_7.jpg',35,149.60,0.00,2,1,'2024-06-26 11:43:40','2024-06-26 11:44:16',NULL,25,'123',NULL),(85,'精神病预后档案：从遗弃中诞生','1805809547024642048','http://localhost:9090/files/092441c6724a43afb9c0c46bc78e612a_29697413-1_w_1713148339 (1).jpg',27,26.60,0.00,1,5,'2024-06-26 11:45:21','2024-06-26 11:45:40','2024-06-26 11:47:33',25,'123',NULL),(86,'骤雨','1805809547024642048','http://localhost:9090/files/7ffc689d23a042d4acf8cab8a003104a_29722794-1_w_1715591026.jpg',23,41.70,0.00,1,3,'2024-06-26 11:45:21','2024-06-26 11:45:40',NULL,25,'123',NULL),(87,'马尔克斯：百年孤独（纪念版）','1805809547024642048','http://localhost:9090/files/cd9bf6a4edee467892a9bc1c1d7da1b0_25138856-1_w_7.jpg',15,39.60,0.00,1,1,'2024-06-26 11:45:21','2024-06-26 11:45:40',NULL,25,'123',NULL),(88,'破冰游戏','1805811133138448384','http://localhost:9090/files/420f3fc2bb33439b8c6bd7b965ca8e54_29691721-1_l_1710210792.jpg',30,29.50,0.00,1,2,'2024-06-26 11:51:39',NULL,NULL,25,'123',NULL),(89,'女仆','1805812860650577920','http://localhost:9090/files/d1cf18a3fe1a498f8910e9a08aac193e_29735240-1_w_1718091770.jpg',26,29.50,0.00,3,1,'2024-06-26 11:58:00','2024-06-26 12:02:00',NULL,26,'222',NULL),(90,'望江南','1805813902301814784','http://localhost:9090/files/f2380b2ea835488983c3a23e342c62db_29367830-1_w_45.jpg',32,34.00,0.00,1,1,'2024-06-26 12:02:00','2024-06-26 12:03:00',NULL,26,'222',NULL),(92,'立秋','1805814329957244928','http://localhost:9090/files/7bf39c27d60e4b6ab7bf4df15b9addf6_29704573-1_w_1717051783.jpg',25,32.50,0.00,2,2,'2024-06-26 12:04:21',NULL,NULL,26,'222',NULL),(93,'那不勒斯四部曲（套装共4册）','1805814406096445440','http://localhost:9090/files/349a72b8455e451abfe1eba91e9c6457_29447297-1_w_4.jpg',24,143.40,0.00,1,1,'2024-06-26 12:04:39','2024-06-26 12:05:11',NULL,26,'222',NULL),(94,'追诉时效倒计时','1805817098504069120','http://localhost:9090/files/31af5413ff63423f92857e3d2fff906a_29699828-1_l_1710487131.jpg',28,34.90,0.00,1,4,'2024-06-26 12:15:21','2024-06-26 12:15:46',NULL,27,'333',NULL),(95,'烟霞里','1805898621530001408','http://localhost:9090/files/0692cc9948d144c3b0034d2ae5444797_29502682-1_w_1693210473.jpg',36,9.90,0.00,1,2,'2024-06-26 17:39:18',NULL,NULL,22,'21045312',NULL),(96,'烟霞里','1805898929861677056','http://localhost:9090/files/0692cc9948d144c3b0034d2ae5444797_29502682-1_w_1693210473.jpg',36,9.90,0.00,2,2,'2024-06-26 17:40:32',NULL,NULL,22,'21045312',NULL),(98,'茶人四部曲','1805900553338343424','http://localhost:9090/files/3c4ab9f8f9ac4f3f9044b82ca23aa8ca_29559027-1_w_7.jpg',35,149.60,0.00,1,2,'2024-06-26 17:46:59',NULL,NULL,17,'admin',NULL),(99,'茶人四部曲','1805901852511354880','http://localhost:9090/files/3c4ab9f8f9ac4f3f9044b82ca23aa8ca_29559027-1_w_7.jpg',35,149.60,0.00,1,2,'2024-06-26 17:52:08',NULL,NULL,17,'admin',NULL),(100,'紫颜色','1805903888518815744','http://localhost:9090/files/d85ea7b52ceb45dd841352ece578b955_29599659-1_w_1695178440.jpg',34,35.00,0.00,1,1,'2024-06-26 18:00:14','2024-06-26 18:00:32',NULL,17,'admin',NULL),(101,'茶人四部曲','1806158481219743744','http://localhost:9090/files/3c4ab9f8f9ac4f3f9044b82ca23aa8ca_29559027-1_w_7.jpg',35,149.60,0.00,4,1,'2024-06-27 10:51:53','2024-06-27 10:52:23',NULL,25,'123',NULL),(103,'紫颜色','1806158796354580480','http://localhost:9090/files/d85ea7b52ceb45dd841352ece578b955_29599659-1_w_1695178440.jpg',34,35.00,0.00,1,4,'2024-06-27 10:53:09','2024-06-27 10:53:24',NULL,25,'123',NULL),(104,'茶人四部曲','1806502207297159168','http://localhost:9090/files/3c4ab9f8f9ac4f3f9044b82ca23aa8ca_29559027-1_w_7.jpg',35,149.60,0.00,1,4,'2024-06-28 09:37:44','2024-06-28 09:38:19',NULL,17,'admin',NULL),(105,'河边的错误 (最新版)','1806502917015339008','http://localhost:9090/files/c4ce77450ea7464a86543c602b91812b_29587088-1_w_1714375768.jpg',33,29.80,0.00,1,3,'2024-06-28 09:40:33','2024-06-28 09:41:08',NULL,17,'admin',NULL),(106,'马尔克斯：百年孤独（纪念版）','1806503545787645952','http://localhost:9090/files/cd9bf6a4edee467892a9bc1c1d7da1b0_25138856-1_w_7.jpg',15,39.60,0.00,3,2,'2024-06-28 09:43:03',NULL,NULL,17,'admin',NULL),(107,'烟霞里','1806503545787645952','http://localhost:9090/files/0692cc9948d144c3b0034d2ae5444797_29502682-1_w_1693210473.jpg',36,9.90,0.00,1,2,'2024-06-28 09:43:03',NULL,NULL,17,'admin',NULL),(108,'西游记','1806949296447725568','http://localhost:9090/files/8b50c35a4e5b4815a462204274ae32d1_12100008909-1_w_1697622603.jpg',37,10.00,0.00,1,2,'2024-06-29 15:14:18',NULL,NULL,17,'admin',NULL),(109,'西游记','1806949353108578304','http://localhost:9090/files/8b50c35a4e5b4815a462204274ae32d1_12100008909-1_w_1697622603.jpg',37,10.00,0.00,1,2,'2024-06-29 15:14:32',NULL,NULL,17,'admin',NULL);
/*!40000 ALTER TABLE `t_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `username` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL COMMENT '用户名',
  `password` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL COMMENT '用户密码',
  `nick_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL COMMENT '昵称',
  `age` int DEFAULT NULL COMMENT '年龄',
  `avatar` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL COMMENT '用户头像',
  `sex` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL COMMENT '性别',
  `address` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL COMMENT '地址',
  `role` int NOT NULL DEFAULT '2' COMMENT '用户的角色，1是管理员，2是普通用户',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='用户信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` (`id`, `username`, `password`, `nick_name`, `age`, `avatar`, `sex`, `address`, `role`) VALUES (17,'admin','202cb962ac59075b964b07152d234b70','admin',20,'http://localhost:9090/files/2f656b6e8508430c87036196580c3db4_-253fead462411fbe.jpg','未知','南昌航空大学八栋菜鸟驿站',1),(22,'21045312','9a025c66a91da1ca28c395025fae5623','lifeng',20,NULL,'女','江西省南昌市',1),(24,'111','698d51a19d8a121ce581499d7b701668',NULL,NULL,NULL,NULL,NULL,2),(25,'123','202cb962ac59075b964b07152d234b70','早八睡不醒',19,'http://localhost:9090/files/c3ca5ee539b84590b816bc419387fc3d_6e188046f8e0259a.jpg','女','江西省新余市',2),(26,'222','be8fe4c12c4e43217c06098a2595a950','午觉睡不够',18,'http://localhost:9090/files/2886c45d44a148ceb9cb3f26efbefc48_img-17019553771856683e37d9c4bf0f7cddcd72150988bb1.jpg','女','北京市海淀区',2),(27,'333','2b272cbcd91c2d762fcb8261307d295e','零点睡不着',20,'http://localhost:9090/files/ea0ca0906d454d37b48df4d167b062f2_Image_1719047990454.jpg','女','湖南省长沙市',2),(28,'444','550a141f12de6341fba65b0ad0433500','hh',23,NULL,'女','lll',2);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_advice`
--

DROP TABLE IF EXISTS `user_advice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_advice` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '建议的唯一ID',
  `user_id` int NOT NULL COMMENT '用户 id',
  `nick_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL COMMENT '昵称',
  `username` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL COMMENT '用户名',
  `title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL COMMENT '建议标题',
  `content` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL COMMENT '建议内容',
  `create_time` datetime DEFAULT NULL COMMENT '建议日期',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='用户建议表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_advice`
--

LOCK TABLES `user_advice` WRITE;
/*!40000 ALTER TABLE `user_advice` DISABLE KEYS */;
INSERT INTO `user_advice` (`id`, `user_id`, `nick_name`, `username`, `title`, `content`, `create_time`) VALUES (10,26,'午觉睡不够','222','希望改进查询功能','可以根据作者、出版社、日期之类的来查询','2024-06-26 12:07:28'),(11,26,'午觉睡不够','222','关于图书种类的建议','能不能上架漫画书，二次元很需要','2024-06-26 12:08:25'),(12,25,'早八睡不醒','123','关于功能的建议','希望功能再多一点','2024-06-26 12:10:46'),(13,27,'零点睡不着','333','关于价格的建议','能不能便宜点','2024-06-26 12:14:56'),(14,22,'lifeng','21045312','123','ffff','2024-06-26 17:42:34'),(15,25,'早八睡不醒','123','kkll','llass','2024-06-27 10:54:03'),(16,17,'admin','admin','理论','f身份','2024-06-28 09:43:40');
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

-- Dump completed on 2024-07-03 22:18:45
