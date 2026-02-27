-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Creato il: Feb 17, 2026 alle 20:25
-- Versione del server: 10.4.32-MariaDB
-- Versione PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `portale_vendita_veicoli`
--

-- --------------------------------------------------------

--
-- Struttura della tabella `acquisto`
--

CREATE TABLE `acquisto` (
  `id_acquisto` int(11) NOT NULL,
  `data_acquisto` date NOT NULL,
  `id_annuncio` int(11) NOT NULL,
  `id_compratore` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `acquisto`
--

INSERT INTO `acquisto` (`id_acquisto`, `data_acquisto`, `id_annuncio`, `id_compratore`) VALUES
(1, '2026-02-15', 1, 3),
(2, '2026-02-16', 2, 4);

-- --------------------------------------------------------

--
-- Struttura della tabella `annuncio`
--

CREATE TABLE `annuncio` (
  `id_annuncio` int(11) NOT NULL,
  `titolo` varchar(100) NOT NULL,
  `descrizione` text DEFAULT NULL,
  `data_pubblicazione` date NOT NULL,
  `stato` enum('attivo','venduto','eliminato') NOT NULL,
  `id_utente` int(11) NOT NULL,
  `id_veicolo` int(11) NOT NULL,
  `prezzo` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `annuncio`
--

INSERT INTO `annuncio` (`id_annuncio`, `titolo`, `descrizione`, `data_pubblicazione`, `stato`, `id_utente`, `id_veicolo`, `prezzo`) VALUES
(1, 'Fiat Panda in ottime condizioni', 'Veicolo usato ma ben mantenuto, unico proprietario.', '2026-02-10', 'attivo', 1, 1, 8500),
(2, 'BMW R1250 GS praticamente nuova', 'Moto pronta per viaggi lunghi, poco usata.', '2026-02-12', 'attivo', 2, 2, 18000);

-- --------------------------------------------------------

--
-- Struttura della tabella `categoria`
--

CREATE TABLE `categoria` (
  `id_categoria` int(11) NOT NULL,
  `tipo_categoria` enum('Automobile','Motocicletta') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `categoria`
--

INSERT INTO `categoria` (`id_categoria`, `tipo_categoria`) VALUES
(1, 'Automobile'),
(2, 'Motocicletta');

-- --------------------------------------------------------

--
-- Struttura della tabella `immagine`
--

CREATE TABLE `immagine` (
  `id_immagine` int(11) NOT NULL,
  `url` varchar(255) NOT NULL,
  `id_annuncio` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `immagine`
--

INSERT INTO `immagine` (`id_immagine`, `url`, `id_annuncio`) VALUES
(1, 'https://example.com/images/panda1.jpg', 1),
(2, 'https://example.com/images/panda2.jpg', 1),
(3, 'https://example.com/images/bmw_r1250_1.jpg', 2);

-- --------------------------------------------------------

--
-- Struttura della tabella `marca`
--

CREATE TABLE `marca` (
  `id_marca` int(11) NOT NULL,
  `nome_marca` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `marca`
--

INSERT INTO `marca` (`id_marca`, `nome_marca`) VALUES
(1, 'Fiat'),
(2, 'BMW'),
(3, 'Honda'),
(4, 'Yamaha');

-- --------------------------------------------------------

--
-- Struttura della tabella `preferiti`
--

CREATE TABLE `preferiti` (
  `id_utente` int(11) NOT NULL,
  `id_annuncio` int(11) NOT NULL,
  `data_aggiunta` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `preferiti`
--

INSERT INTO `preferiti` (`id_utente`, `id_annuncio`, `data_aggiunta`) VALUES
(3, 2, '2026-02-14'),
(4, 1, '2026-02-14');

-- --------------------------------------------------------

--
-- Struttura della tabella `utente`
--

CREATE TABLE `utente` (
  `id_utente` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(100) NOT NULL,
  `nome` varchar(50) DEFAULT NULL,
  `cognome` varchar(50) DEFAULT NULL,
  `data_registrazione` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `utente`
--

INSERT INTO `utente` (`id_utente`, `username`, `password`, `email`, `nome`, `cognome`, `data_registrazione`) VALUES
(1, 'MarioRossi', 'password123', 'mario.rossi@example.com', 'Mario', 'Rossi', '2025-01-15'),
(2, 'LuciaBianchi', 'securePass', 'lucia.bianchi@example.com', 'Lucia', 'Bianchi', '2025-02-02'),
(3, 'GiovanniVerdi', 'giovanniPwd', 'giovanni.verdi@example.com', 'Giovanni', 'Verdi', '2025-03-10'),
(4, 'AlessandraNeri', 'alessandra123', 'alessandra.neri@example.com', 'Alessandra', 'Neri', '2025-03-20');

-- --------------------------------------------------------

--
-- Struttura della tabella `veicolo`
--

CREATE TABLE `veicolo` (
  `id_veicolo` int(11) NOT NULL,
  `modello` varchar(100) NOT NULL,
  `anno` int(11) NOT NULL,
  `prezzo` float DEFAULT NULL,
  `chilometraggio` int(11) DEFAULT NULL,
  `colore` varchar(30) DEFAULT NULL,
  `id_marca` int(11) NOT NULL,
  `id_categoria` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `veicolo`
--

INSERT INTO `veicolo` (`id_veicolo`, `modello`, `anno`, `prezzo`, `chilometraggio`, `colore`, `id_marca`, `id_categoria`) VALUES
(1, 'Panda 1.2 Easy', 2020, 8500, 30000, 'Bianco', 1, 1),
(2, 'R1250 GS', 2022, 18000, 5000, 'Blu', 2, 2);

--
-- Indici per le tabelle scaricate
--

--
-- Indici per le tabelle `acquisto`
--
ALTER TABLE `acquisto`
  ADD PRIMARY KEY (`id_acquisto`),
  ADD UNIQUE KEY `id_annuncio` (`id_annuncio`),
  ADD KEY `id_compratore` (`id_compratore`);

--
-- Indici per le tabelle `annuncio`
--
ALTER TABLE `annuncio`
  ADD PRIMARY KEY (`id_annuncio`),
  ADD UNIQUE KEY `id_veicolo` (`id_veicolo`),
  ADD KEY `id_utente` (`id_utente`);

--
-- Indici per le tabelle `categoria`
--
ALTER TABLE `categoria`
  ADD PRIMARY KEY (`id_categoria`);

--
-- Indici per le tabelle `immagine`
--
ALTER TABLE `immagine`
  ADD PRIMARY KEY (`id_immagine`),
  ADD KEY `id_annuncio` (`id_annuncio`);

--
-- Indici per le tabelle `marca`
--
ALTER TABLE `marca`
  ADD PRIMARY KEY (`id_marca`);

--
-- Indici per le tabelle `preferiti`
--
ALTER TABLE `preferiti`
  ADD PRIMARY KEY (`id_utente`,`id_annuncio`),
  ADD KEY `id_annuncio` (`id_annuncio`);

--
-- Indici per le tabelle `utente`
--
ALTER TABLE `utente`
  ADD PRIMARY KEY (`id_utente`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indici per le tabelle `veicolo`
--
ALTER TABLE `veicolo`
  ADD PRIMARY KEY (`id_veicolo`),
  ADD KEY `id_marca` (`id_marca`),
  ADD KEY `id_categoria` (`id_categoria`);

--
-- AUTO_INCREMENT per le tabelle scaricate
--

--
-- AUTO_INCREMENT per la tabella `acquisto`
--
ALTER TABLE `acquisto`
  MODIFY `id_acquisto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT per la tabella `annuncio`
--
ALTER TABLE `annuncio`
  MODIFY `id_annuncio` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT per la tabella `categoria`
--
ALTER TABLE `categoria`
  MODIFY `id_categoria` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT per la tabella `immagine`
--
ALTER TABLE `immagine`
  MODIFY `id_immagine` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT per la tabella `marca`
--
ALTER TABLE `marca`
  MODIFY `id_marca` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT per la tabella `utente`
--
ALTER TABLE `utente`
  MODIFY `id_utente` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT per la tabella `veicolo`
--
ALTER TABLE `veicolo`
  MODIFY `id_veicolo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Limiti per le tabelle scaricate
--

--
-- Limiti per la tabella `acquisto`
--
ALTER TABLE `acquisto`
  ADD CONSTRAINT `acquisto_ibfk_1` FOREIGN KEY (`id_annuncio`) REFERENCES `annuncio` (`id_annuncio`) ON DELETE CASCADE,
  ADD CONSTRAINT `acquisto_ibfk_2` FOREIGN KEY (`id_compratore`) REFERENCES `utente` (`id_utente`) ON DELETE CASCADE;

--
-- Limiti per la tabella `annuncio`
--
ALTER TABLE `annuncio`
  ADD CONSTRAINT `annuncio_ibfk_1` FOREIGN KEY (`id_utente`) REFERENCES `utente` (`id_utente`) ON DELETE CASCADE,
  ADD CONSTRAINT `annuncio_ibfk_2` FOREIGN KEY (`id_veicolo`) REFERENCES `veicolo` (`id_veicolo`) ON DELETE CASCADE;

--
-- Limiti per la tabella `immagine`
--
ALTER TABLE `immagine`
  ADD CONSTRAINT `immagine_ibfk_1` FOREIGN KEY (`id_annuncio`) REFERENCES `annuncio` (`id_annuncio`) ON DELETE CASCADE;

--
-- Limiti per la tabella `preferiti`
--
ALTER TABLE `preferiti`
  ADD CONSTRAINT `preferiti_ibfk_1` FOREIGN KEY (`id_utente`) REFERENCES `utente` (`id_utente`) ON DELETE CASCADE,
  ADD CONSTRAINT `preferiti_ibfk_2` FOREIGN KEY (`id_annuncio`) REFERENCES `annuncio` (`id_annuncio`) ON DELETE CASCADE;

--
-- Limiti per la tabella `veicolo`
--
ALTER TABLE `veicolo`
  ADD CONSTRAINT `veicolo_ibfk_1` FOREIGN KEY (`id_marca`) REFERENCES `marca` (`id_marca`),
  ADD CONSTRAINT `veicolo_ibfk_2` FOREIGN KEY (`id_categoria`) REFERENCES `categoria` (`id_categoria`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
