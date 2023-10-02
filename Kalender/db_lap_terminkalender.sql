-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Erstellungszeit: 03. Jul 2023 um 13:58
-- Server-Version: 10.4.11-MariaDB
-- PHP-Version: 7.4.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Datenbank: `db_lap_terminkalender`
--

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `tbl_einladungsstati`
--

CREATE TABLE `tbl_einladungsstati` (
  `IDEinladungsstatus` int(10) UNSIGNED NOT NULL,
  `Bezeichnung` varchar(16) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Daten für Tabelle `tbl_einladungsstati`
--

INSERT INTO `tbl_einladungsstati` (`IDEinladungsstatus`, `Bezeichnung`) VALUES
(1, 'Versendet'),
(2, 'Zusage'),
(3, 'Absage');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `tbl_kategorien`
--

CREATE TABLE `tbl_kategorien` (
  `IDKategorie` int(10) UNSIGNED NOT NULL,
  `Bezeichnung` varchar(32) NOT NULL,
  `FIDUser` int(10) UNSIGNED DEFAULT NULL,
  `Farbcode` varchar(8) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Daten für Tabelle `tbl_kategorien`
--

INSERT INTO `tbl_kategorien` (`IDKategorie`, `Bezeichnung`, `FIDUser`, `Farbcode`) VALUES
(1, 'Privat', NULL, '0000ff'),
(2, 'Arbeit', NULL, 'ff0000'),
(3, 'Urlaub', NULL, '00ff00'),
(4, 'WIFI', 1, 'ff3300'),
(5, 'Uni', 1, 'ff6600'),
(6, 'Training', 2, 'cc00ff');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `tbl_staaten`
--

CREATE TABLE `tbl_staaten` (
  `IDStaat` int(10) UNSIGNED NOT NULL,
  `Bezeichnung` varchar(64) NOT NULL,
  `Kurzzeichen` varchar(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Daten für Tabelle `tbl_staaten`
--

INSERT INTO `tbl_staaten` (`IDStaat`, `Bezeichnung`, `Kurzzeichen`) VALUES
(1, 'Österreich', 'AT'),
(2, 'Deutschland', 'DE'),
(3, 'Spanien', 'ES'),
(4, 'Italien', 'IT'),
(5, 'Grossbritannien', 'GB');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `tbl_termine`
--

CREATE TABLE `tbl_termine` (
  `IDTermin` int(10) UNSIGNED NOT NULL,
  `Bezeichnung` varchar(128) NOT NULL,
  `Adresse` varchar(64) DEFAULT NULL,
  `PLZ` varchar(16) DEFAULT NULL,
  `Ort` varchar(64) DEFAULT NULL,
  `FIDStaat` int(10) UNSIGNED DEFAULT NULL,
  `Beginn` datetime NOT NULL,
  `Ende` datetime NOT NULL,
  `Notiz` text DEFAULT NULL,
  `FIDUser` int(10) UNSIGNED NOT NULL,
  `FIDKategorie` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Daten für Tabelle `tbl_termine`
--

INSERT INTO `tbl_termine` (`IDTermin`, `Bezeichnung`, `Adresse`, `PLZ`, `Ort`, `FIDStaat`, `Beginn`, `Ende`, `Notiz`, `FIDUser`, `FIDKategorie`) VALUES
(1, 'Prüfung LAP', 'Wiener Straße 150', '4020', 'Linz', 1, '2023-07-04 08:30:00', '2023-07-04 15:30:00', 'WIFI OÖ', 1, 4),
(2, 'Lehrgang Coding', 'Wiener Straße 150', '4020', 'Linz', 1, '2023-07-05 08:30:00', '2023-07-05 16:30:00', NULL, 1, 4),
(3, 'Vortrag UCD1+2', 'Doktor-Karl-Dorrek-Straße 30', '3500', 'Krems an der Donau', 1, '2023-07-06 09:15:00', '2023-07-06 17:35:00', 'DUK', 1, 5),
(4, 'Wachau-Tage', NULL, '3620', 'Spitz an der Donau', 1, '2023-07-06 08:00:00', '2023-07-08 19:00:00', NULL, 2, 3),
(5, 'Easy-Cheesy Ausfahrt mit Martin S.', NULL, NULL, NULL, 1, '2023-06-18 14:30:00', '2023-06-18 17:00:00', NULL, 3, 1),
(6, 'Clubtreffen', 'Freistädter Straße 400', '4040', 'Linz', 1, '2023-06-18 17:30:00', '2023-06-18 20:00:00', 'DCL', 3, 1),
(7, 'Workshop Aufbau', NULL, NULL, 'Mondsee', 1, '2023-06-04 10:00:00', '2023-06-04 18:00:00', NULL, 2, 1),
(8, 'Jerez', NULL, NULL, NULL, 3, '2023-05-20 08:00:00', '2023-05-21 19:00:00', 'Anreise einplanen', 1, 1),
(9, 'Oberkörper', NULL, '4020', 'Linz', 1, '2023-05-17 14:00:00', '2023-05-17 16:30:00', NULL, 2, 6),
(10, 'Beine', NULL, '4020', 'Linz', 1, '2023-05-16 14:45:00', '2023-05-16 17:00:00', NULL, 2, 6),
(11, 'Friseur', 'Rechte Donaustr. 1', '4020', 'Linz', 1, '2023-05-12 11:00:00', '2023-05-12 11:30:00', 'Ewinger', 1, 1),
(12, 'Urlaub Toskana', NULL, NULL, NULL, 4, '2023-04-30 08:15:00', '2023-05-04 22:00:00', NULL, 2, 3);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `tbl_termine_einladungen`
--

CREATE TABLE `tbl_termine_einladungen` (
  `IDTerminEinladung` int(10) UNSIGNED NOT NULL,
  `FIDTermin` int(10) UNSIGNED NOT NULL,
  `FIDUser` int(10) UNSIGNED NOT NULL,
  `FIDEinladungsstatus` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Daten für Tabelle `tbl_termine_einladungen`
--

INSERT INTO `tbl_termine_einladungen` (`IDTerminEinladung`, `FIDTermin`, `FIDUser`, `FIDEinladungsstatus`) VALUES
(1, 6, 1, 2),
(2, 6, 2, 3),
(3, 8, 2, 2),
(4, 12, 1, 2),
(5, 4, 1, 1);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `tbl_user`
--

CREATE TABLE `tbl_user` (
  `IDUser` int(10) UNSIGNED NOT NULL,
  `Nickname` varchar(32) NOT NULL,
  `Emailadresse` varchar(64) NOT NULL,
  `Passwort` varchar(255) NOT NULL,
  `Vorname` varchar(32) DEFAULT NULL,
  `Nachname` varchar(32) DEFAULT NULL,
  `Notiz` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Daten für Tabelle `tbl_user`
--

INSERT INTO `tbl_user` (`IDUser`, `Nickname`, `Emailadresse`, `Passwort`, `Vorname`, `Nachname`, `Notiz`) VALUES
(1, 'uwemutz', 'uwe.mutz@syne.at', '$2y$10$Zn66AYjdvXXxFauNzcnvIeQGnqW2dygA6jlC4Si3KJRsTRLhe9n7m', 'Uwe', 'Mutz', 'test123'),
(2, 'silv', 'silvia.mutz@syne.at', '$2y$10$Sc/ldZMNGe0SvAz3SlpSouI2AUXirOkDJNoQO/JWblFdQxwfGyA4K', 'Silvia', NULL, 'test456'),
(3, 'tom', 'tom@syne.at', '$2y$10$Pe7re6cUYBlyDFTDc5fLn.xZU7q9ae70RN/cYHIXPk5cx5iOKH9Xa', NULL, NULL, 'test789');

--
-- Indizes der exportierten Tabellen
--

--
-- Indizes für die Tabelle `tbl_einladungsstati`
--
ALTER TABLE `tbl_einladungsstati`
  ADD PRIMARY KEY (`IDEinladungsstatus`);

--
-- Indizes für die Tabelle `tbl_kategorien`
--
ALTER TABLE `tbl_kategorien`
  ADD PRIMARY KEY (`IDKategorie`),
  ADD KEY `FIDUser` (`FIDUser`);

--
-- Indizes für die Tabelle `tbl_staaten`
--
ALTER TABLE `tbl_staaten`
  ADD PRIMARY KEY (`IDStaat`),
  ADD UNIQUE KEY `Bezeichnung` (`Bezeichnung`),
  ADD UNIQUE KEY `Kurzzeichen` (`Kurzzeichen`);

--
-- Indizes für die Tabelle `tbl_termine`
--
ALTER TABLE `tbl_termine`
  ADD PRIMARY KEY (`IDTermin`),
  ADD KEY `FIDStaat` (`FIDStaat`),
  ADD KEY `FIDKategorie` (`FIDKategorie`),
  ADD KEY `FIDUser` (`FIDUser`);

--
-- Indizes für die Tabelle `tbl_termine_einladungen`
--
ALTER TABLE `tbl_termine_einladungen`
  ADD PRIMARY KEY (`IDTerminEinladung`),
  ADD UNIQUE KEY `FIDTermin` (`FIDTermin`,`FIDUser`),
  ADD KEY `FIDEinladungsstatus` (`FIDEinladungsstatus`),
  ADD KEY `FIDUser` (`FIDUser`);

--
-- Indizes für die Tabelle `tbl_user`
--
ALTER TABLE `tbl_user`
  ADD PRIMARY KEY (`IDUser`),
  ADD UNIQUE KEY `Nickname` (`Nickname`),
  ADD UNIQUE KEY `Emailadresse` (`Emailadresse`);

--
-- AUTO_INCREMENT für exportierte Tabellen
--

--
-- AUTO_INCREMENT für Tabelle `tbl_einladungsstati`
--
ALTER TABLE `tbl_einladungsstati`
  MODIFY `IDEinladungsstatus` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT für Tabelle `tbl_kategorien`
--
ALTER TABLE `tbl_kategorien`
  MODIFY `IDKategorie` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT für Tabelle `tbl_staaten`
--
ALTER TABLE `tbl_staaten`
  MODIFY `IDStaat` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT für Tabelle `tbl_termine`
--
ALTER TABLE `tbl_termine`
  MODIFY `IDTermin` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT für Tabelle `tbl_termine_einladungen`
--
ALTER TABLE `tbl_termine_einladungen`
  MODIFY `IDTerminEinladung` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT für Tabelle `tbl_user`
--
ALTER TABLE `tbl_user`
  MODIFY `IDUser` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints der exportierten Tabellen
--

--
-- Constraints der Tabelle `tbl_kategorien`
--
ALTER TABLE `tbl_kategorien`
  ADD CONSTRAINT `tbl_kategorien_ibfk_1` FOREIGN KEY (`FIDUser`) REFERENCES `tbl_user` (`IDUser`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints der Tabelle `tbl_termine`
--
ALTER TABLE `tbl_termine`
  ADD CONSTRAINT `tbl_termine_ibfk_1` FOREIGN KEY (`FIDUser`) REFERENCES `tbl_user` (`IDUser`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `tbl_termine_ibfk_2` FOREIGN KEY (`FIDKategorie`) REFERENCES `tbl_kategorien` (`IDKategorie`) ON UPDATE CASCADE,
  ADD CONSTRAINT `tbl_termine_ibfk_3` FOREIGN KEY (`FIDStaat`) REFERENCES `tbl_staaten` (`IDStaat`) ON UPDATE CASCADE;

--
-- Constraints der Tabelle `tbl_termine_einladungen`
--
ALTER TABLE `tbl_termine_einladungen`
  ADD CONSTRAINT `tbl_termine_einladungen_ibfk_1` FOREIGN KEY (`FIDTermin`) REFERENCES `tbl_termine` (`IDTermin`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `tbl_termine_einladungen_ibfk_2` FOREIGN KEY (`FIDUser`) REFERENCES `tbl_user` (`IDUser`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `tbl_termine_einladungen_ibfk_3` FOREIGN KEY (`FIDEinladungsstatus`) REFERENCES `tbl_einladungsstati` (`IDEinladungsstatus`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
