-- phpMyAdmin SQL Dump
-- version 4.9.7
-- https://www.phpmyadmin.net/
--
-- Host: localhost:8889
-- Generation Time: Jan 03, 2022 at 10:14 PM
-- Server version: 5.7.32
-- PHP Version: 7.4.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `KuluSoftwareCalisanlari`
--

-- --------------------------------------------------------

--
-- Table structure for table `calisanlar`
--

CREATE TABLE `calisanlar` (
  `calisan_id` int(11) NOT NULL,
  `calisan_adi` varchar(50) NOT NULL,
  `calisan_soyadi` varchar(50) NOT NULL,
  `medeni_durum` varchar(50) NOT NULL,
  `cinsiyeti` enum('K','E') NOT NULL,
  `dogum_tarihi` date NOT NULL,
  `ise_alinma_tarihi` date NOT NULL,
  `maas_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `calisanlar`
--

INSERT INTO `calisanlar` (`calisan_id`, `calisan_adi`, `calisan_soyadi`, `medeni_durum`, `cinsiyeti`, `dogum_tarihi`, `ise_alinma_tarihi`, `maas_id`) VALUES
(1, 'Burak', 'Evren', 'Bekar', 'E', '1985-12-26', '2010-05-06', 10),
(2, 'Mirkan', 'Genç', 'Bekar', 'E', '1986-08-12', '2010-06-10', 4),
(3, 'Sezer', 'Şimşek', 'Bekar', 'E', '1987-01-15', '2011-02-09', 7),
(4, 'Berk', 'Keskin', 'Bekar', 'E', '1986-07-09', '2011-05-06', 9),
(5, 'Süleyman', 'Ünsal', 'Evli', 'E', '1980-03-10', '2013-05-06', 8),
(6, 'Hande', 'Bal', 'Bekar', 'K', '1992-04-01', '2014-05-06', 2),
(7, 'İdil', 'Akın', 'Bekar', 'K', '1995-11-02', '2016-05-27', 3),
(8, 'Sena', 'Güzel', 'Bekar', 'K', '1994-12-26', '2017-05-06', 1),
(9, 'İrem', 'Gül', 'Evli', 'K', '1994-06-07', '2017-05-17', 5),
(10, 'Sedat', 'Altın', 'Bekar', 'E', '1991-08-18', '2018-05-06', 6);

--
-- Triggers `calisanlar`
--
DELIMITER $$
CREATE TRIGGER `1-guncel_calisan_sayisi` AFTER INSERT ON `calisanlar` FOR EACH ROW INSERT INTO guncel_calisan_sayisi VALUES((SELECT COUNT(*) FROM calisanlar),now())
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `2-yeni_eklenen_calisanlar` BEFORE INSERT ON `calisanlar` FOR EACH ROW INSERT INTO yeni_eklenen_calisanlar VALUES(new.calisan_adi,now())
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `3-silinen-calisanlar_sonrasi_calisan_sayisi` AFTER DELETE ON `calisanlar` FOR EACH ROW INSERT INTO guncel_calisan_sayisi VALUES((SELECT COUNT(*) from calisanlar),now())
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `4-silinen-calisanlar` AFTER DELETE ON `calisanlar` FOR EACH ROW INSERT INTO silinen_calisanlar VALUES(old.calisan_adi,now())
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `departmanlar`
--

CREATE TABLE `departmanlar` (
  `departman_id` int(11) NOT NULL,
  `departman_adi` varchar(50) NOT NULL,
  `mudur_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `departmanlar`
--

INSERT INTO `departmanlar` (`departman_id`, `departman_adi`, `mudur_id`) VALUES
(1, 'Yazılım Geliştirme', 1),
(2, 'UI Tasarım', 3),
(3, 'Müşteri Hizmetleri', 2),
(4, 'Muhasebe', 4);

-- --------------------------------------------------------

--
-- Table structure for table `dpt_calisan`
--

CREATE TABLE `dpt_calisan` (
  `id` int(11) NOT NULL,
  `calisan_id` int(11) DEFAULT NULL,
  `departman_id` int(11) DEFAULT NULL,
  `ise_baslangic_tarihi` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `dpt_calisan`
--

INSERT INTO `dpt_calisan` (`id`, `calisan_id`, `departman_id`, `ise_baslangic_tarihi`) VALUES
(1, 1, 1, '2010-05-06'),
(2, 2, 1, '2010-06-10'),
(3, 3, 2, '2011-02-09'),
(4, 4, 1, '2011-05-06'),
(5, 5, 3, '2013-05-06'),
(6, 6, 2, '2014-05-06'),
(7, 7, 4, '2016-05-27'),
(8, 8, 3, '2017-05-06'),
(9, 9, 4, '2017-05-17'),
(10, 10, 1, '2018-05-06');

-- --------------------------------------------------------

--
-- Table structure for table `guncel_calisan_sayisi`
--

CREATE TABLE `guncel_calisan_sayisi` (
  `sayi` int(11) DEFAULT NULL,
  `tarih` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `guncel_calisan_sayisi`
--

INSERT INTO `guncel_calisan_sayisi` (`sayi`, `tarih`) VALUES
(11, '2022-01-02 00:00:38'),
(10, '2022-01-02 18:30:15');

-- --------------------------------------------------------

--
-- Table structure for table `maaslar`
--

CREATE TABLE `maaslar` (
  `maas_id` int(11) NOT NULL,
  `maas_miktari` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `maaslar`
--

INSERT INTO `maaslar` (`maas_id`, `maas_miktari`) VALUES
(1, 10000),
(2, 9000),
(3, 8000),
(4, 15000),
(5, 11000),
(6, 10000),
(7, 7500),
(8, 12500),
(9, 14000),
(10, 17000),
(11, 6000);

-- --------------------------------------------------------

--
-- Table structure for table `mudur`
--

CREATE TABLE `mudur` (
  `mudur_id` int(11) NOT NULL,
  `mudur_adi` varchar(50) NOT NULL,
  `ise_baslangic_tarihi` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `mudur`
--

INSERT INTO `mudur` (`mudur_id`, `mudur_adi`, `ise_baslangic_tarihi`) VALUES
(1, 'Kağan', '2010-05-04'),
(2, 'Ceren', '2011-06-05'),
(3, 'Kadir', '2014-07-06'),
(4, 'Burak', '2013-08-07');

-- --------------------------------------------------------

--
-- Table structure for table `silinen_calisanlar`
--

CREATE TABLE `silinen_calisanlar` (
  `calisan_adi` varchar(255) DEFAULT NULL,
  `silinme_tarihi` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `silinen_calisanlar`
--

INSERT INTO `silinen_calisanlar` (`calisan_adi`, `silinme_tarihi`) VALUES
('Buğra', '2022-01-02 18:30:15');

-- --------------------------------------------------------

--
-- Table structure for table `unvanlar`
--

CREATE TABLE `unvanlar` (
  `unvan_id` int(11) NOT NULL,
  `unvan_adi` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `unvanlar`
--

INSERT INTO `unvanlar` (`unvan_id`, `unvan_adi`) VALUES
(1, 'Senior Engineer'),
(2, 'Full Stack Developer'),
(3, 'Muhasebeci'),
(4, 'UI Designer'),
(5, 'Müşteri Temsilcisi');

-- --------------------------------------------------------

--
-- Table structure for table `unv_calisan`
--

CREATE TABLE `unv_calisan` (
  `id` int(11) NOT NULL,
  `unvan_id` int(11) DEFAULT NULL,
  `calisan_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `unv_calisan`
--

INSERT INTO `unv_calisan` (`id`, `unvan_id`, `calisan_id`) VALUES
(1, 1, 1),
(2, 2, 2),
(3, 4, 3),
(4, 2, 4),
(5, 5, 5),
(6, 4, 6),
(7, 3, 7),
(8, 5, 8),
(9, 3, 9),
(10, 1, 10);

-- --------------------------------------------------------

--
-- Table structure for table `yeni_eklenen_calisanlar`
--

CREATE TABLE `yeni_eklenen_calisanlar` (
  `calisan_adi` varchar(255) DEFAULT NULL,
  `eklenen_tarih` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `yeni_eklenen_calisanlar`
--

INSERT INTO `yeni_eklenen_calisanlar` (`calisan_adi`, `eklenen_tarih`) VALUES
('Buğra', '2022-01-02 00:00:38');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `calisanlar`
--
ALTER TABLE `calisanlar`
  ADD PRIMARY KEY (`calisan_id`),
  ADD KEY `maas_id` (`maas_id`);

--
-- Indexes for table `departmanlar`
--
ALTER TABLE `departmanlar`
  ADD PRIMARY KEY (`departman_id`),
  ADD KEY `mudur_id` (`mudur_id`);

--
-- Indexes for table `dpt_calisan`
--
ALTER TABLE `dpt_calisan`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_calisan_id` (`calisan_id`),
  ADD KEY `fk_departman_id` (`departman_id`);

--
-- Indexes for table `maaslar`
--
ALTER TABLE `maaslar`
  ADD PRIMARY KEY (`maas_id`);

--
-- Indexes for table `mudur`
--
ALTER TABLE `mudur`
  ADD PRIMARY KEY (`mudur_id`);

--
-- Indexes for table `unvanlar`
--
ALTER TABLE `unvanlar`
  ADD PRIMARY KEY (`unvan_id`);

--
-- Indexes for table `unv_calisan`
--
ALTER TABLE `unv_calisan`
  ADD PRIMARY KEY (`id`),
  ADD KEY `unvanlar_fk_unvan_id` (`unvan_id`),
  ADD KEY `calisanlar_fk_calisan_id` (`calisan_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `calisanlar`
--
ALTER TABLE `calisanlar`
  MODIFY `calisan_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `departmanlar`
--
ALTER TABLE `departmanlar`
  MODIFY `departman_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `dpt_calisan`
--
ALTER TABLE `dpt_calisan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `maaslar`
--
ALTER TABLE `maaslar`
  MODIFY `maas_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `mudur`
--
ALTER TABLE `mudur`
  MODIFY `mudur_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `unvanlar`
--
ALTER TABLE `unvanlar`
  MODIFY `unvan_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `unv_calisan`
--
ALTER TABLE `unv_calisan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `calisanlar`
--
ALTER TABLE `calisanlar`
  ADD CONSTRAINT `calisanlar_ibfk_1` FOREIGN KEY (`maas_id`) REFERENCES `maaslar` (`maas_id`);

--
-- Constraints for table `departmanlar`
--
ALTER TABLE `departmanlar`
  ADD CONSTRAINT `departmanlar_ibfk_1` FOREIGN KEY (`mudur_id`) REFERENCES `mudur` (`mudur_id`);

--
-- Constraints for table `dpt_calisan`
--
ALTER TABLE `dpt_calisan`
  ADD CONSTRAINT `fk_calisan_id` FOREIGN KEY (`calisan_id`) REFERENCES `calisanlar` (`calisan_id`),
  ADD CONSTRAINT `fk_departman_id` FOREIGN KEY (`departman_id`) REFERENCES `departmanlar` (`departman_id`);

--
-- Constraints for table `unv_calisan`
--
ALTER TABLE `unv_calisan`
  ADD CONSTRAINT `calisanlar_fk_calisan_id` FOREIGN KEY (`calisan_id`) REFERENCES `calisanlar` (`calisan_id`),
  ADD CONSTRAINT `unvanlar_fk_unvan_id` FOREIGN KEY (`unvan_id`) REFERENCES `unvanlar` (`unvan_id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
