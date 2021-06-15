-- phpMyAdmin SQL Dump
-- version 4.7.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 15, 2021 at 08:35 PM
-- Server version: 10.1.24-MariaDB
-- PHP Version: 7.1.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `vjezba_mwa`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetActiveUsers` ()  BEGIN
	SELECT z.ID, z.ime, z.prezime, z.datumRodenja, z.adresa, g.naziv AS grad, zu.naziv AS zupanija, z.OIB, z.email, z.brojMobitela, ss.naziv AS StrucnaSprema
	FROM zaposlenik z
	LEFT JOIN grad g ON g.ID=z.grad_ID
	LEFT JOIN strucnasprema ss ON ss.ID=z.strucnaSprema_ID
	LEFT JOIN zupanija zu ON zu.ID=g.zupanija_ID
	WHERE z.aktivan = 1;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `grad`
--

CREATE TABLE `grad` (
  `ID` int(11) NOT NULL,
  `naziv` varchar(100) DEFAULT NULL,
  `zupanija_ID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `grad`
--

INSERT INTO `grad` (`ID`, `naziv`, `zupanija_ID`) VALUES
(1, 'Čakovec', 1),
(2, 'Prelog', 1),
(3, 'Mursko Središće', 1),
(4, 'Varaždin', 2),
(5, 'Lepoglava', 2),
(6, 'Lepoglava', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `log`
--

CREATE TABLE `log` (
  `ID` int(11) NOT NULL,
  `ime` varchar(45) DEFAULT NULL,
  `prezime` varchar(45) DEFAULT NULL,
  `datum` varchar(45) DEFAULT NULL,
  `akcija` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `log`
--

INSERT INTO `log` (`ID`, `ime`, `prezime`, `datum`, `akcija`) VALUES
(1, 'Test trigger', 'Test trigger', '2021-06-01 20:10:06', 'dodan');

-- --------------------------------------------------------

--
-- Table structure for table `proizvod`
--

CREATE TABLE `proizvod` (
  `id` int(11) NOT NULL,
  `naziv` varchar(200) DEFAULT NULL,
  `cijena` float(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `proizvod`
--

INSERT INTO `proizvod` (`id`, `naziv`, `cijena`) VALUES
(1, 'Šećer', 4.58),
(2, 'Brašno', 3.99),
(3, 'Ulje', 11.99);

-- --------------------------------------------------------

--
-- Table structure for table `racun`
--

CREATE TABLE `racun` (
  `ID` int(11) NOT NULL,
  `zaposlenik_ID` int(11) DEFAULT NULL,
  `datum` datetime DEFAULT NULL,
  `ZKI` varchar(45) DEFAULT NULL,
  `JIR` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `racun`
--

INSERT INTO `racun` (`ID`, `zaposlenik_ID`, `datum`, `ZKI`, `JIR`) VALUES
(1, 1, '2020-12-15 19:48:36', '423442342342', '423423423423');

-- --------------------------------------------------------

--
-- Table structure for table `stavke`
--

CREATE TABLE `stavke` (
  `racun_ID` int(11) NOT NULL,
  `proizvod_ID` int(11) NOT NULL,
  `kolicina` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `stavke`
--

INSERT INTO `stavke` (`racun_ID`, `proizvod_ID`, `kolicina`) VALUES
(1, 1, 2),
(1, 2, 3),
(1, 3, 1);

-- --------------------------------------------------------

--
-- Table structure for table `strucnasprema`
--

CREATE TABLE `strucnasprema` (
  `ID` int(11) NOT NULL,
  `naziv` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `strucnasprema`
--

INSERT INTO `strucnasprema` (`ID`, `naziv`) VALUES
(1, 'NSS'),
(2, 'SSS'),
(3, 'VŠS'),
(4, 'VSS');

-- --------------------------------------------------------

--
-- Table structure for table `tipkorisnika`
--

CREATE TABLE `tipkorisnika` (
  `ID` int(11) NOT NULL,
  `naziv` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tipkorisnika`
--

INSERT INTO `tipkorisnika` (`ID`, `naziv`) VALUES
(1, 'Administrator'),
(2, 'Korisnik');

-- --------------------------------------------------------

--
-- Table structure for table `zaposlenik`
--

CREATE TABLE `zaposlenik` (
  `ID` int(11) NOT NULL,
  `ime` varchar(100) DEFAULT NULL,
  `prezime` varchar(150) DEFAULT NULL,
  `datumRodenja` date DEFAULT NULL,
  `adresa` varchar(250) DEFAULT NULL,
  `grad_ID` int(11) DEFAULT NULL,
  `OIB` varchar(11) DEFAULT NULL,
  `email` varchar(150) DEFAULT NULL,
  `brojMobitela` varchar(45) DEFAULT NULL,
  `strucnaSprema_ID` int(11) DEFAULT NULL,
  `aktivan` int(11) DEFAULT '1',
  `lozinka` varchar(150) DEFAULT NULL,
  `tipKorisnika` int(11) DEFAULT '2'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `zaposlenik`
--

INSERT INTO `zaposlenik` (`ID`, `ime`, `prezime`, `datumRodenja`, `adresa`, `grad_ID`, `OIB`, `email`, `brojMobitela`, `strucnaSprema_ID`, `aktivan`, `lozinka`, `tipKorisnika`) VALUES
(1, 'Pero', 'Perić', '1984-11-12', 'Trg Eugena Kvaternika 2', 5, '12345698778', 'pero.peric@gmail.com', '098/754-6851', 4, 1, 'd231c23d3a41bf25d6a725080785a996', 1),
(2, 'Petra', 'Petrić', '1988-12-02', 'Kvaternikov trg 5', 4, '85496874589', 'petra.petric@gmail.com', '095/854-9987', 4, 0, 'd55a637ab6a30ce122d1b9bcc4c7e3cc', 2),
(4, 'Marko', 'Marković', '1989-01-05', 'Putijane 38', 1, '12345678998', 'marko.markovic@gmail.com', '098/887-8585', 3, 1, '2ee55f1330a6298dbed904f9474cead3', 2),
(5, 'Test 33', 'Test prezime 33', '1993-06-24', 'Test adresa 55', 5, '12345678901', 'test@test55.hr', '098/487-9855', 4, 1, '7bebcfefd6cf65f202df3844456bdb6e', 2),
(6, 'Test trigger', 'Test trigger', '1984-01-04', 'Putijane 38', 1, '12345678998', 'testTrigger@gmail.com', '098/887-8585', 3, 1, '2d8741e53fcb91a418cb7ec500fa79db', 2);

--
-- Triggers `zaposlenik`
--
DELIMITER $$
CREATE TRIGGER `after_insert_zaposlenik` AFTER INSERT ON `zaposlenik` FOR EACH ROW INSERT INTO log
 SET akcija = 'dodan',
     ime = NEW.ime,
     prezime = NEW.prezime,
     datum = NOW()
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `zupanija`
--

CREATE TABLE `zupanija` (
  `ID` int(11) NOT NULL,
  `naziv` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `zupanija`
--

INSERT INTO `zupanija` (`ID`, `naziv`) VALUES
(1, 'Međimurska županija'),
(2, 'Varaždinska županija'),
(4, 'Krapinsko zagorska županija');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `grad`
--
ALTER TABLE `grad`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `grad_zupanija` (`zupanija_ID`);

--
-- Indexes for table `log`
--
ALTER TABLE `log`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `proizvod`
--
ALTER TABLE `proizvod`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `racun`
--
ALTER TABLE `racun`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `zaposlenik_racun` (`zaposlenik_ID`);

--
-- Indexes for table `stavke`
--
ALTER TABLE `stavke`
  ADD PRIMARY KEY (`racun_ID`,`proizvod_ID`),
  ADD KEY `proizvod_stavke` (`proizvod_ID`);

--
-- Indexes for table `strucnasprema`
--
ALTER TABLE `strucnasprema`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `tipkorisnika`
--
ALTER TABLE `tipkorisnika`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `zaposlenik`
--
ALTER TABLE `zaposlenik`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `zaposlenik_grad` (`grad_ID`),
  ADD KEY `zaposlenik_ss` (`strucnaSprema_ID`),
  ADD KEY `zaposlenik_tipKorisnika` (`tipKorisnika`);

--
-- Indexes for table `zupanija`
--
ALTER TABLE `zupanija`
  ADD PRIMARY KEY (`ID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `grad`
--
ALTER TABLE `grad`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT for table `log`
--
ALTER TABLE `log`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `proizvod`
--
ALTER TABLE `proizvod`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `racun`
--
ALTER TABLE `racun`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `strucnasprema`
--
ALTER TABLE `strucnasprema`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `tipkorisnika`
--
ALTER TABLE `tipkorisnika`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `zaposlenik`
--
ALTER TABLE `zaposlenik`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT for table `zupanija`
--
ALTER TABLE `zupanija`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `grad`
--
ALTER TABLE `grad`
  ADD CONSTRAINT `grad_zupanija` FOREIGN KEY (`zupanija_ID`) REFERENCES `zupanija` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `racun`
--
ALTER TABLE `racun`
  ADD CONSTRAINT `zaposlenik_racun` FOREIGN KEY (`zaposlenik_ID`) REFERENCES `zaposlenik` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `stavke`
--
ALTER TABLE `stavke`
  ADD CONSTRAINT `proizvod_stavke` FOREIGN KEY (`proizvod_ID`) REFERENCES `proizvod` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `racun_stavke` FOREIGN KEY (`racun_ID`) REFERENCES `racun` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `zaposlenik`
--
ALTER TABLE `zaposlenik`
  ADD CONSTRAINT `zaposlenik_grad` FOREIGN KEY (`grad_ID`) REFERENCES `grad` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `zaposlenik_ss` FOREIGN KEY (`strucnaSprema_ID`) REFERENCES `strucnasprema` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `zaposlenik_tipKorisnika` FOREIGN KEY (`tipKorisnika`) REFERENCES `tipkorisnika` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
