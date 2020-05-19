-- phpMyAdmin SQL Dump
-- version 3.5.1
-- http://www.phpmyadmin.net
--
-- Client: localhost
-- Généré le: Mar 19 Mai 2020 à 19:47
-- Version du serveur: 5.5.24-log
-- Version de PHP: 5.4.3

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de données: `gestionm`
--

-- --------------------------------------------------------

--
-- Structure de la table `chambre`
--

CREATE TABLE IF NOT EXISTS `chambre` (
  `id_ch` int(11) NOT NULL AUTO_INCREMENT,
  `categorie` varchar(50) NOT NULL,
  `Type_ch` varchar(50) NOT NULL,
  `id_dep` int(11) NOT NULL,
  PRIMARY KEY (`id_ch`),
  KEY `chambre_Departement_FK` (`id_dep`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Contenu de la table `chambre`
--

INSERT INTO `chambre` (`id_ch`, `categorie`, `Type_ch`, `id_dep`) VALUES
(1, 'C1', 'T1', 1),
(2, 'C2', 'T2', 1),
(4, 'C1', 'T1', 2);

-- --------------------------------------------------------

--
-- Structure de la table `departement`
--

CREATE TABLE IF NOT EXISTS `departement` (
  `id_dep` int(11) NOT NULL AUTO_INCREMENT,
  `Nom_dep` varchar(50) NOT NULL,
  PRIMARY KEY (`id_dep`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=8 ;

--
-- Contenu de la table `departement`
--

INSERT INTO `departement` (`id_dep`, `Nom_dep`) VALUES
(1, 'D1'),
(2, 'D2'),
(3, 'D3'),
(4, 'D1'),
(5, 'D2'),
(6, 'D3'),
(7, 'D1');

-- --------------------------------------------------------

--
-- Structure de la table `feuille`
--

CREATE TABLE IF NOT EXISTS `feuille` (
  `numFeu` int(11) NOT NULL AUTO_INCREMENT,
  `dateF` date NOT NULL,
  `id_pat` int(11) NOT NULL,
  `id_dep` int(11) NOT NULL,
  PRIMARY KEY (`numFeu`),
  KEY `Feuille_Patient_FK` (`id_pat`),
  KEY `Feuille_Departement0_FK` (`id_dep`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Contenu de la table `feuille`
--

INSERT INTO `feuille` (`numFeu`, `dateF`, `id_pat`, `id_dep`) VALUES
(1, '2020-06-09', 1, 1),
(2, '2020-06-18', 2, 1),
(3, '2020-03-19', 3, 1),
(4, '2020-06-03', 4, 2);

-- --------------------------------------------------------

--
-- Structure de la table `interner`
--

CREATE TABLE IF NOT EXISTS `interner` (
  `id_pat` int(11) NOT NULL,
  `id_dep` int(11) NOT NULL,
  PRIMARY KEY (`id_pat`,`id_dep`),
  KEY `interner_Departement0_FK` (`id_dep`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `interner`
--

INSERT INTO `interner` (`id_pat`, `id_dep`) VALUES
(1, 1),
(2, 1),
(4, 1),
(4, 2);

-- --------------------------------------------------------

--
-- Structure de la table `lit`
--

CREATE TABLE IF NOT EXISTS `lit` (
  `id_lit` int(11) NOT NULL AUTO_INCREMENT,
  `id_ch` int(11) NOT NULL,
  PRIMARY KEY (`id_lit`),
  KEY `Lit_chambre_FK` (`id_ch`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Contenu de la table `lit`
--

INSERT INTO `lit` (`id_lit`, `id_ch`) VALUES
(1, 1),
(2, 1),
(4, 1),
(3, 2);

-- --------------------------------------------------------

--
-- Structure de la table `medecin`
--

CREATE TABLE IF NOT EXISTS `medecin` (
  `id_med` int(11) NOT NULL AUTO_INCREMENT,
  `Nom_med` varchar(50) NOT NULL,
  `specialite` varchar(50) NOT NULL,
  `id_dep` int(11) NOT NULL,
  PRIMARY KEY (`id_med`),
  KEY `Medecin_Departement_FK` (`id_dep`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

--
-- Contenu de la table `medecin`
--

INSERT INTO `medecin` (`id_med`, `Nom_med`, `specialite`, `id_dep`) VALUES
(1, 'M1', 'S1', 1),
(2, 'M2', 'S2', 1),
(3, 'M3', 'S3', 2),
(4, 'M4', 'S2', 2),
(5, 'M5', 'S1', 1);

-- --------------------------------------------------------

--
-- Structure de la table `occuper`
--

CREATE TABLE IF NOT EXISTS `occuper` (
  `id_lit` int(11) NOT NULL,
  `id_pat` int(11) NOT NULL,
  `DateOcc` date NOT NULL,
  PRIMARY KEY (`id_lit`,`id_pat`),
  KEY `occuper_Patient0_FK` (`id_pat`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `occuper`
--

INSERT INTO `occuper` (`id_lit`, `id_pat`, `DateOcc`) VALUES
(1, 1, '2020-05-19'),
(1, 2, '2018-03-01'),
(1, 3, '2020-03-03'),
(2, 3, '2019-03-02');

-- --------------------------------------------------------

--
-- Structure de la table `patient`
--

CREATE TABLE IF NOT EXISTS `patient` (
  `id_pat` int(11) NOT NULL AUTO_INCREMENT,
  `Nom_pat` varchar(50) NOT NULL,
  `Adr` varchar(50) NOT NULL,
  `Sexe` varchar(10) NOT NULL,
  `date_naiss` date NOT NULL,
  `Lieu_naiss` text NOT NULL,
  PRIMARY KEY (`id_pat`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Contenu de la table `patient`
--

INSERT INTO `patient` (`id_pat`, `Nom_pat`, `Adr`, `Sexe`, `date_naiss`, `Lieu_naiss`) VALUES
(1, 'Malade11', 'dakar', 'M', '1995-05-03', 'Ndande'),
(2, 'Modou sarr', 'Thies', 'M', '1996-05-06', 'Louga'),
(3, 'Fatou Diop', 'podor', 'F', '2000-05-15', 'podor'),
(4, 'Fatou Fall', 'dakar', 'F', '2012-04-22', 'dakar');

-- --------------------------------------------------------

--
-- Structure de la table `suivre`
--

CREATE TABLE IF NOT EXISTS `suivre` (
  `id_med` int(11) NOT NULL,
  `id_pat` int(11) NOT NULL,
  PRIMARY KEY (`id_med`,`id_pat`),
  KEY `suivre_Patient0_FK` (`id_pat`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `suivre`
--

INSERT INTO `suivre` (`id_med`, `id_pat`) VALUES
(2, 1),
(3, 1),
(3, 2);

--
-- Contraintes pour les tables exportées
--

--
-- Contraintes pour la table `chambre`
--
ALTER TABLE `chambre`
  ADD CONSTRAINT `chambre_Departement_FK` FOREIGN KEY (`id_dep`) REFERENCES `departement` (`id_dep`);

--
-- Contraintes pour la table `feuille`
--
ALTER TABLE `feuille`
  ADD CONSTRAINT `Feuille_Departement0_FK` FOREIGN KEY (`id_dep`) REFERENCES `departement` (`id_dep`),
  ADD CONSTRAINT `Feuille_Patient_FK` FOREIGN KEY (`id_pat`) REFERENCES `patient` (`id_pat`);

--
-- Contraintes pour la table `interner`
--
ALTER TABLE `interner`
  ADD CONSTRAINT `interner_Departement0_FK` FOREIGN KEY (`id_dep`) REFERENCES `departement` (`id_dep`),
  ADD CONSTRAINT `interner_Patient_FK` FOREIGN KEY (`id_pat`) REFERENCES `patient` (`id_pat`);

--
-- Contraintes pour la table `lit`
--
ALTER TABLE `lit`
  ADD CONSTRAINT `Lit_chambre_FK` FOREIGN KEY (`id_ch`) REFERENCES `chambre` (`id_ch`);

--
-- Contraintes pour la table `medecin`
--
ALTER TABLE `medecin`
  ADD CONSTRAINT `Medecin_Departement_FK` FOREIGN KEY (`id_dep`) REFERENCES `departement` (`id_dep`);

--
-- Contraintes pour la table `occuper`
--
ALTER TABLE `occuper`
  ADD CONSTRAINT `occuper_Lit_FK` FOREIGN KEY (`id_lit`) REFERENCES `lit` (`id_lit`),
  ADD CONSTRAINT `occuper_Patient0_FK` FOREIGN KEY (`id_pat`) REFERENCES `patient` (`id_pat`);

--
-- Contraintes pour la table `suivre`
--
ALTER TABLE `suivre`
  ADD CONSTRAINT `suivre_Medecin_FK` FOREIGN KEY (`id_med`) REFERENCES `medecin` (`id_med`),
  ADD CONSTRAINT `suivre_Patient0_FK` FOREIGN KEY (`id_pat`) REFERENCES `patient` (`id_pat`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
