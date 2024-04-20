/*
Navicat MySQL Data Transfer

Source Server         : coba01
Source Server Version : 50505
Source Host           : localhost:3306
Source Database       : db_medifast

Target Server Type    : MYSQL
Target Server Version : 50505
File Encoding         : 65001

Date: 2024-04-20 16:58:46
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for `artikel`
-- ----------------------------
DROP TABLE IF EXISTS `artikel`;
CREATE TABLE `artikel` (
  `id_artikel` int(11) NOT NULL AUTO_INCREMENT,
  `judul` varchar(255) DEFAULT NULL,
  `foto` varchar(255) DEFAULT NULL,
  `isi` mediumtext DEFAULT '',
  `createdat` date DEFAULT NULL,
  `updatedat` date DEFAULT NULL,
  PRIMARY KEY (`id_artikel`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of artikel
-- ----------------------------
INSERT INTO `artikel` VALUES ('1', '4 Rekomendasi Obat Maag yang Ampuh', 'artikel2.png', '1. Mylanta: Mylanta adalah salah satu obat maag yang bagus dan banyak dikenal masyarakat. Obat ini mengandung kombinasi dari magnesium hidroksida dan aluminium hidroksida yang dapat meredakan sakit maag.\\n 2. Promag: Promag juga merupakan pilihan obat maag yang bagus dan mudah didapatkan di apotek maupun warung. Obat ini juga mengandung magnesium hidroksida dan aluminium hidroksida.\\n 3. Polysilane: Polysilane adalah obat maag yang dapat membantu mengatasi masalah maag dan gangguan pencernaan lain seperti perut kembung dan rasa tidak nyaman di perut.\\n 4. Polycrol Forte: Polycrol Forte adalah obat maag cair yang mengandung aluminium hidroksida, magnesium hidroksida, dan methylpolysiloxane. Obat ini efektif untuk mengobati gangguan pada saluran pencernaan seperti gastritis, perut kembung, maag, hiatus hernia, tukak lambung, dan usus duabelas jari.', '2024-04-11', '2024-04-26');

-- ----------------------------
-- Table structure for `dokter`
-- ----------------------------
DROP TABLE IF EXISTS `dokter`;
CREATE TABLE `dokter` (
  `id_dokter` int(11) NOT NULL AUTO_INCREMENT,
  `nama_dokter` varchar(255) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `spesialis` varchar(255) DEFAULT NULL,
  `rating` varchar(255) DEFAULT NULL,
  `favorited` int(10) DEFAULT NULL,
  `pengalaman` int(10) DEFAULT NULL,
  `tentang` varchar(255) DEFAULT NULL,
  `jadwal` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_dokter`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of dokter
-- ----------------------------
INSERT INTO `dokter` VALUES ('1', 'Dr. Eki Rakhmah Z, Sp.A', 'dokter_1.png', 'Dokter Anak', '4.8', '1', '1', 'apa ini 1', 'senin, 07:00 - 08:00');
INSERT INTO `dokter` VALUES ('2', 'Dr. Yudi Heriyanto', 'dokter_4.png', 'Dokter Umum', '4.2', '0', '2', 'apa ini 2', 'selasa, 07:00 - 08:00');
INSERT INTO `dokter` VALUES ('3', 'Dr. Rina wijaya, Sp.PD', 'dokter_2.png', 'Dokter Dalam', '4.8', '0', '10', 'apa ini 3', 'rabu, 07:00 - 08:00');
INSERT INTO `dokter` VALUES ('4', 'Dr. Budi Santoso, Sp.A', 'dokter_5.png', 'Dokter Anak', '4.3', '1', '11', 'apa ini 4', 'kamis, 07:00 - 08:00');
INSERT INTO `dokter` VALUES ('5', 'Dr. Lilis', 'dokter_3.png', 'Dokter Umum', '4.5', '0', '5', 'apa ini 5', 'jumat, 07:00 - 08:00');

-- ----------------------------
-- Table structure for `user`
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id_user` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(255) DEFAULT NULL,
  `lastname` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `telephone` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_user`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('1', 'wahyu', 'sanhusi', 'wahyu@gmail.com', '0835478853', 'password');
INSERT INTO `user` VALUES ('2', 'agus', 'william', 'agus@gmail.com', '0835478853', 'password');
INSERT INTO `user` VALUES ('3', 'rafi', 'ahmad', 'rafi@gmail.com', '0835478853', 'password');
INSERT INTO `user` VALUES ('4', 'odang', 'saluhi', 'odang@gmail.com', '0835478853', 'password');
INSERT INTO `user` VALUES ('5', 'budi', 'gunawan', 'budi@gmail.com', '0835478853', 'password');
