-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Jan 20, 2022 at 09:06 AM
-- Server version: 10.4.22-MariaDB
-- PHP Version: 8.0.13

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `hms`
--

-- --------------------------------------------------------

--
-- Table structure for table `doctors`
--

CREATE TABLE `doctors` (
  `did` int(11) NOT NULL,
  `email` varchar(50) NOT NULL,
  `doctorname` varchar(100) NOT NULL,
  `dept` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `doctors`
--

INSERT INTO `doctors` (`did`, `email`, `doctorname`, `dept`) VALUES
(3, 'krishnan@gmail.com', 'tomy', 'physician'),
(4, 'ambadi@gmail.com', 'hari', 'anasthesia'),
(5, 'liya@gmail.com', 'liya', 'dermatology');

-- --------------------------------------------------------

--
-- Table structure for table `patients`
--

CREATE TABLE `patients` (
  `pid` int(11) NOT NULL,
  `email` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  `gender` varchar(50) NOT NULL,
  `slot` varchar(50) NOT NULL,
  `disease` varchar(50) NOT NULL,
  `time` time NOT NULL,
  `date` date NOT NULL,
  `dept` varchar(50) NOT NULL,
  `number` varchar(13) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `patients`
--

INSERT INTO `patients` (`pid`, `email`, `name`, `gender`, `slot`, `disease`, `time`, `date`, `dept`, `number`) VALUES
(1, 'krishnan@gmail.com', 'sujithkumar', 'Male', 'Morning1', 'ddd', '12:48:00', '2022-02-17', 'specialist', '344578'),
(6, 'patient@gmail.com', 'sujithkumar', 'Male', 'Morning', 'ddd', '09:41:00', '2022-01-25', 'physician', '9999'),
(7, 'patient@gmail.com', 'sujithkumar', 'Male', 'Morning', 'ddd', '09:41:00', '2022-01-25', 'physician', '9999'),
(8, 'patient@gmail.com', 'sujithkumar', 'Male', 'Morning', 'ddd', '09:41:00', '2022-01-25', 'physician', '9999'),
(9, 'patient@gmail.com', 'sujithkumar', 'Male', 'Morning', 'ddd', '09:41:00', '2022-01-25', 'physician', '9999'),
(10, 'patient@gmail.com', 'sujithkumar', 'Male', 'Morning', 'ddd', '09:41:00', '2022-01-25', 'physician', '9999'),
(11, 'patient@gmail.com', 'sujithkumar', 'Male', 'Morning', 'ddd', '09:41:00', '2022-01-25', 'physician', '9999'),
(12, 'patient@gmail.com', 'sujithkumar', 'Male', 'Morning', 'ddd', '09:41:00', '2022-01-25', 'physician', '9999'),
(13, 'sujith.sunu19@gmail.com', 'sujithkumar', 'Male', 'Morning', 'ddd', '00:01:00', '2022-01-19', 'physician', '25454454');

--
-- Triggers `patients`
--
DELIMITER $$
CREATE TRIGGER `patientdelete` BEFORE DELETE ON `patients` FOR EACH ROW INSERT INTO triggr VALUES(NULL,OLD.pid,OLD.email,OLD.name,'PATIENT DELETED',NOW())
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `patientinsertion` AFTER INSERT ON `patients` FOR EACH ROW INSERT INTO triggr VALUES(NULL,NEW.pid,NEW.email,NEW.name,'PATIENT INSERTED',NOW())
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `patientupdate` AFTER UPDATE ON `patients` FOR EACH ROW INSERT INTO triggr VALUES(NULL,NEW.pid,NEW.email,NEW.name,'PATIENT UPDATED',NOW())
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `test`
--

CREATE TABLE `test` (
  `id` int(11) NOT NULL,
  `name` varchar(20) NOT NULL,
  `email` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `test`
--

INSERT INTO `test` (`id`, `name`, `email`) VALUES
(1, 'sujith', 'sujith@gmail.com'),
(2, 'sunu', 'sunu@gmail.com');

-- --------------------------------------------------------

--
-- Table structure for table `triggr`
--

CREATE TABLE `triggr` (
  `tid` int(11) NOT NULL,
  `pid` int(11) NOT NULL,
  `email` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  `action` varchar(50) NOT NULL,
  `timestamp` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `triggr`
--

INSERT INTO `triggr` (`tid`, `pid`, `email`, `name`, `action`, `timestamp`) VALUES
(1, 14, 'sujith.sunu19@gmail.com', 'dujith', 'PATIENT INSERTED', '2022-01-19 07:46:30'),
(2, 14, 'sujith.sunu19@gmail.com', 'dujith', 'PATIENT UPDATED', '2022-01-19 07:47:33'),
(3, 14, 'sujith.sunu19@gmail.com', 'dujith', 'PATIENT DELETED', '2022-01-19 07:47:51');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `password` varchar(1000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `username`, `email`, `password`) VALUES
(1, 'sujith', 'sujith@gmail.com', 'pbkdf2:sha256:260000$lhfqrHm8tvmKX1Wy$ec59bd73d06feb19489171dbdccec9bdc789fee39601d4f501b0d2e6c0782a21'),
(2, 'hari', 'hari@gmail.com', 'pbkdf2:sha256:260000$jvuGeCpJZM70ZTnL$44b85790b397e4fda66b29361770eeefbea51f11b7377f9620bc12c67aaa3706'),
(3, 'manu', 'manu@gmail.com', 'pbkdf2:sha256:260000$eTGKvij1eD30SVMH$f51c2ec95ba13f7d1f05ba2f752444dab44b8cbf25287b54a340d984ee2ae08e'),
(4, 'krishnan', 'krishnan@gmail.com', 'pbkdf2:sha256:260000$WBDtfw5aoBFz8pev$e7e4d2a976bd54b6b0d3818f8817407b04fe6cc1de884e40214057e9608ca5a3'),
(5, 'ayush', 'adr19cs054@cea.ac.in', 'pbkdf2:sha256:260000$ZhhYBiEMWGj9oeqJ$3ee76d488f7a7cd12de1343d4357f38b8d449e0f4032a7a324d0cb67291ab201'),
(6, 'geethu', 'geethu@gmail.com', 'pbkdf2:sha256:260000$630dYe2AvGrPi1gE$46e22964314297008939dccf394d0b97984093c34d1223e7139e931249a03546'),
(7, 'piyush', 'p@gmail.com', 'pbkdf2:sha256:260000$SfE6APUwFUJboQOx$50e3d01a62b7bf9074ce32aa62ac50d9e8ecc723493ccd5aa3fc4ee91d87e3bf'),
(8, 'sujith', 'harinarayananambadi@gmail.com', 'pbkdf2:sha256:260000$sCfVD0Opph8ySlqM$9ac0e40bfaaa9beade27454d68b7673cdc3e057292bc5b5de61a75055a47697b'),
(9, 'hari', 'ambadi@gmail.com', 'pbkdf2:sha256:260000$WCATPDu4nb87FTbQ$61e23e0d4279515694f49189be5d0831053bcc04231c760e9b92076fab8fd756'),
(10, 'liya', 'liya@gmail.com', 'pbkdf2:sha256:260000$x7i14M6F7sG1jDUO$956442c3842aa73af448c6529936dbc65d8a107cb64bc68047d8a948f8eb898a'),
(11, 'patient', 'sujith.sunu19@gmail.com', 'pbkdf2:sha256:260000$yrPEGcGtyqdBEIDd$73ac7d08be2bf7258232357a93cf9eed5e9534c81d1cde10b42c3306a06539a6');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `doctors`
--
ALTER TABLE `doctors`
  ADD PRIMARY KEY (`did`);

--
-- Indexes for table `patients`
--
ALTER TABLE `patients`
  ADD PRIMARY KEY (`pid`);

--
-- Indexes for table `test`
--
ALTER TABLE `test`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `triggr`
--
ALTER TABLE `triggr`
  ADD PRIMARY KEY (`tid`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `doctors`
--
ALTER TABLE `doctors`
  MODIFY `did` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `patients`
--
ALTER TABLE `patients`
  MODIFY `pid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `test`
--
ALTER TABLE `test`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `triggr`
--
ALTER TABLE `triggr`
  MODIFY `tid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
