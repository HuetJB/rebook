-- phpMyAdmin SQL Dump
-- version 4.9.5deb2
-- https://www.phpmyadmin.net/
--
-- Hôte : localhost:3306
-- Généré le : ven. 11 juin 2021 à 14:25
-- Version du serveur :  10.3.29-MariaDB-0ubuntu0.20.04.1
-- Version de PHP : 7.4.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `ecoboard`
--

-- --------------------------------------------------------

--
-- Structure de la table `compteur`
--

CREATE TABLE `compteur` (
  `compteur_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `compteur_name` varchar(200) NOT NULL,
  `compteur_link` varchar(255) NOT NULL,
  `compteur_number` bigint(20) NOT NULL,
  `compteur_level` int(11) NOT NULL COMMENT 'NULL=pas_contrat / 1=contrat_attente_validation / 2=contrat_OK',
  `date_signature_compteur` bigint(20) NOT NULL,
  `compteur_heures_creuses` text DEFAULT NULL,
  `compteur_puissance_max` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Doublure de structure pour la vue `compteur_details`
-- (Voir ci-dessous la vue réelle)
--
CREATE TABLE `compteur_details` (
`compteur_id` int(11)
,`user_id` int(11)
,`compteur_name` varchar(200)
,`compteur_link` varchar(255)
,`compteur_number` bigint(20)
,`compteur_level` int(11)
,`date_signature_compteur` bigint(20)
,`compteur_heures_creuses` text
,`compteur_puissance_max` int(11)
,`user_email` varchar(100)
,`user_phone` varchar(20)
,`user_name` varchar(100)
,`user_firstname` varchar(100)
,`user_level_access` int(11)
,`user_compteur_level` int(11)
,`email_verified` int(1)
);

-- --------------------------------------------------------

--
-- Doublure de structure pour la vue `contrat_details`
-- (Voir ci-dessous la vue réelle)
--
CREATE TABLE `contrat_details` (
`contrat_type_id` int(11)
,`fournisseur_id` int(11)
,`contrat_type_name` varchar(200)
,`fournisseur_name` varchar(200)
);

-- --------------------------------------------------------

--
-- Structure de la table `contrat_tarif`
--

CREATE TABLE `contrat_tarif` (
  `contrat_tarif_id` int(11) NOT NULL,
  `contrat_type_id` int(11) DEFAULT NULL,
  `contrat_tarif_puissance_souscrite` int(11) NOT NULL COMMENT 'en kVA',
  `contrat_tarif_tarif` float DEFAULT NULL COMMENT 'en €/kWh',
  `contrat_tarif_abonement_mensuel` float DEFAULT NULL COMMENT 'en €/mois',
  `contrat_tarif_has_heures_creuses_pleines` int(11) NOT NULL DEFAULT 0,
  `contrat_tarif_tarif_heures_pleines` float DEFAULT NULL COMMENT 'en €/kWh',
  `contrat_tarif_tarif_heures_creuses` float DEFAULT NULL COMMENT 'en €/kWh'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Doublure de structure pour la vue `contrat_tarif_details`
-- (Voir ci-dessous la vue réelle)
--
CREATE TABLE `contrat_tarif_details` (
`contrat_tarif_id` int(11)
,`form_id` int(11)
,`compteur_id` int(11)
,`user_id` int(11)
,`contrat_type_id` int(11)
,`fournisseur_id` int(11)
,`contrat_tarif_puissance_souscrite` int(11)
,`contrat_tarif_tarif` float
,`contrat_tarif_abonement_mensuel` float
,`contrat_tarif_has_heures_creuses_pleines` int(11)
,`contrat_tarif_tarif_heures_pleines` float
,`contrat_tarif_tarif_heures_creuses` float
,`form_fournisseur` varchar(100)
,`form_has_chauffage` int(1)
,`form_has_voiture` int(1)
,`form_has_piscine` int(1)
,`form_has_ballon_eau_chaude` int(1)
,`compteur_name` varchar(200)
,`compteur_link` varchar(255)
,`compteur_number` bigint(20)
,`compteur_level` int(11)
,`date_signature_compteur` bigint(20)
,`compteur_heures_creuses` text
,`compteur_puissance_max` int(11)
,`user_email` varchar(100)
,`user_phone` varchar(20)
,`user_name` varchar(100)
,`user_firstname` varchar(100)
,`user_level_access` int(11)
,`user_compteur_level` int(11)
,`email_verified` int(1)
,`contrat_type_name` varchar(200)
,`fournisseur_name` varchar(200)
);

-- --------------------------------------------------------

--
-- Structure de la table `contrat_type`
--

CREATE TABLE `contrat_type` (
  `contrat_type_id` int(11) NOT NULL,
  `fournisseur_id` int(11) NOT NULL,
  `contrat_type_name` varchar(200) COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Structure de la table `donnee`
--

CREATE TABLE `donnee` (
  `donnee_id` int(11) NOT NULL,
  `compteur_id` int(11) NOT NULL,
  `donnee_name` varchar(100) NOT NULL,
  `donnee_unit` varchar(100) NOT NULL,
  `donnee_type` int(10) NOT NULL COMMENT '0=pas_type / 1=enedis_value_auto',
  `last_update_ts` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Doublure de structure pour la vue `donnee_details`
-- (Voir ci-dessous la vue réelle)
--
CREATE TABLE `donnee_details` (
`donnee_id` int(11)
,`compteur_id` int(11)
,`user_id` int(11)
,`donnee_name` varchar(100)
,`donnee_unit` varchar(100)
,`donnee_type` int(10)
,`last_update_ts` bigint(20)
,`compteur_name` varchar(200)
,`compteur_link` varchar(255)
,`compteur_number` bigint(20)
,`compteur_level` int(11)
,`date_signature_compteur` bigint(20)
,`compteur_heures_creuses` text
,`compteur_puissance_max` int(11)
,`user_email` varchar(100)
,`user_phone` varchar(20)
,`user_name` varchar(100)
,`user_firstname` varchar(100)
,`user_level_access` int(11)
,`user_compteur_level` int(11)
,`email_verified` int(1)
);

-- --------------------------------------------------------

--
-- Structure de la table `formulaire`
--

CREATE TABLE `formulaire` (
  `form_id` int(11) NOT NULL,
  `compteur_id` int(10) NOT NULL,
  `contrat_type_id` int(11) DEFAULT NULL,
  `form_fournisseur` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `form_has_chauffage` int(1) NOT NULL DEFAULT 0,
  `form_has_voiture` int(1) NOT NULL DEFAULT 0,
  `form_has_piscine` int(1) NOT NULL DEFAULT 0,
  `form_has_ballon_eau_chaude` int(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Doublure de structure pour la vue `formulaire_details`
-- (Voir ci-dessous la vue réelle)
--
CREATE TABLE `formulaire_details` (
`form_id` int(11)
,`compteur_id` int(11)
,`user_id` int(11)
,`contrat_type_id` int(11)
,`form_fournisseur` varchar(100)
,`form_has_chauffage` int(1)
,`form_has_voiture` int(1)
,`form_has_piscine` int(1)
,`form_has_ballon_eau_chaude` int(1)
,`compteur_name` varchar(200)
,`compteur_link` varchar(255)
,`compteur_number` bigint(20)
,`compteur_level` int(11)
,`date_signature_compteur` bigint(20)
,`compteur_heures_creuses` text
,`compteur_puissance_max` int(11)
,`user_email` varchar(100)
,`user_phone` varchar(20)
,`user_name` varchar(100)
,`user_firstname` varchar(100)
,`user_level_access` int(11)
,`user_compteur_level` int(11)
,`email_verified` int(1)
);

-- --------------------------------------------------------

--
-- Structure de la table `fournisseur`
--

CREATE TABLE `fournisseur` (
  `fournisseur_id` int(11) NOT NULL,
  `fournisseur_name` varchar(200) COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Structure de la table `user`
--

CREATE TABLE `user` (
  `user_id` int(11) NOT NULL,
  `user_email` varchar(100) NOT NULL,
  `user_phone` varchar(20) NOT NULL,
  `user_name` varchar(100) NOT NULL,
  `user_firstname` varchar(100) NOT NULL,
  `user_password` varchar(100) NOT NULL,
  `user_level_access` int(11) NOT NULL COMMENT '0=desactivé / 1=user / 10=admin ',
  `entreprise_name` varchar(200) DEFAULT NULL,
  `email_verified` int(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Doublure de structure pour la vue `user_details`
-- (Voir ci-dessous la vue réelle)
--
CREATE TABLE `user_details` (
`user_id` int(11)
,`user_email` varchar(100)
,`user_phone` varchar(20)
,`user_name` varchar(100)
,`user_firstname` varchar(100)
,`user_level_access` int(11)
,`email_verified` int(1)
,`compteur_level` int(11)
,`compteur_id` int(11)
);

-- --------------------------------------------------------

--
-- Structure de la vue `compteur_details`
--
DROP TABLE IF EXISTS `compteur_details`;

CREATE ALGORITHM=UNDEFINED DEFINER=`jean-baptiste`@`%` SQL SECURITY DEFINER VIEW `compteur_details`  AS  select `compteur`.`compteur_id` AS `compteur_id`,`compteur`.`user_id` AS `user_id`,`compteur`.`compteur_name` AS `compteur_name`,`compteur`.`compteur_link` AS `compteur_link`,`compteur`.`compteur_number` AS `compteur_number`,`compteur`.`compteur_level` AS `compteur_level`,`compteur`.`date_signature_compteur` AS `date_signature_compteur`,`compteur`.`compteur_heures_creuses` AS `compteur_heures_creuses`,`compteur`.`compteur_puissance_max` AS `compteur_puissance_max`,`user_details`.`user_email` AS `user_email`,`user_details`.`user_phone` AS `user_phone`,`user_details`.`user_name` AS `user_name`,`user_details`.`user_firstname` AS `user_firstname`,`user_details`.`user_level_access` AS `user_level_access`,`user_details`.`compteur_level` AS `user_compteur_level`,`user_details`.`email_verified` AS `email_verified` from (`compteur` join `user_details` on(`user_details`.`user_id` = `compteur`.`user_id`)) ;

-- --------------------------------------------------------

--
-- Structure de la vue `contrat_details`
--
DROP TABLE IF EXISTS `contrat_details`;

CREATE ALGORITHM=UNDEFINED DEFINER=`jean-baptiste`@`%` SQL SECURITY DEFINER VIEW `contrat_details`  AS  select `contrat_type`.`contrat_type_id` AS `contrat_type_id`,`fournisseur`.`fournisseur_id` AS `fournisseur_id`,`contrat_type`.`contrat_type_name` AS `contrat_type_name`,`fournisseur`.`fournisseur_name` AS `fournisseur_name` from (`contrat_type` join `fournisseur` on(`fournisseur`.`fournisseur_id` = `contrat_type`.`fournisseur_id`)) ;

-- --------------------------------------------------------

--
-- Structure de la vue `contrat_tarif_details`
--
DROP TABLE IF EXISTS `contrat_tarif_details`;

CREATE ALGORITHM=UNDEFINED DEFINER=`jean-baptiste`@`%` SQL SECURITY DEFINER VIEW `contrat_tarif_details`  AS  select `contrat_tarif`.`contrat_tarif_id` AS `contrat_tarif_id`,`formulaire_details`.`form_id` AS `form_id`,`formulaire_details`.`compteur_id` AS `compteur_id`,`formulaire_details`.`user_id` AS `user_id`,`formulaire_details`.`contrat_type_id` AS `contrat_type_id`,`contrat_details`.`fournisseur_id` AS `fournisseur_id`,`contrat_tarif`.`contrat_tarif_puissance_souscrite` AS `contrat_tarif_puissance_souscrite`,`contrat_tarif`.`contrat_tarif_tarif` AS `contrat_tarif_tarif`,`contrat_tarif`.`contrat_tarif_abonement_mensuel` AS `contrat_tarif_abonement_mensuel`,`contrat_tarif`.`contrat_tarif_has_heures_creuses_pleines` AS `contrat_tarif_has_heures_creuses_pleines`,`contrat_tarif`.`contrat_tarif_tarif_heures_pleines` AS `contrat_tarif_tarif_heures_pleines`,`contrat_tarif`.`contrat_tarif_tarif_heures_creuses` AS `contrat_tarif_tarif_heures_creuses`,`formulaire_details`.`form_fournisseur` AS `form_fournisseur`,`formulaire_details`.`form_has_chauffage` AS `form_has_chauffage`,`formulaire_details`.`form_has_voiture` AS `form_has_voiture`,`formulaire_details`.`form_has_piscine` AS `form_has_piscine`,`formulaire_details`.`form_has_ballon_eau_chaude` AS `form_has_ballon_eau_chaude`,`formulaire_details`.`compteur_name` AS `compteur_name`,`formulaire_details`.`compteur_link` AS `compteur_link`,`formulaire_details`.`compteur_number` AS `compteur_number`,`formulaire_details`.`compteur_level` AS `compteur_level`,`formulaire_details`.`date_signature_compteur` AS `date_signature_compteur`,`formulaire_details`.`compteur_heures_creuses` AS `compteur_heures_creuses`,`formulaire_details`.`compteur_puissance_max` AS `compteur_puissance_max`,`formulaire_details`.`user_email` AS `user_email`,`formulaire_details`.`user_phone` AS `user_phone`,`formulaire_details`.`user_name` AS `user_name`,`formulaire_details`.`user_firstname` AS `user_firstname`,`formulaire_details`.`user_level_access` AS `user_level_access`,`formulaire_details`.`user_compteur_level` AS `user_compteur_level`,`formulaire_details`.`email_verified` AS `email_verified`,`contrat_details`.`contrat_type_name` AS `contrat_type_name`,`contrat_details`.`fournisseur_name` AS `fournisseur_name` from ((`contrat_tarif` join `formulaire_details` on(`formulaire_details`.`contrat_type_id` = `contrat_tarif`.`contrat_type_id`)) join `contrat_details` on(`contrat_details`.`contrat_type_id` = `contrat_tarif`.`contrat_type_id`)) where `formulaire_details`.`compteur_puissance_max` = `contrat_tarif`.`contrat_tarif_puissance_souscrite` ;

-- --------------------------------------------------------

--
-- Structure de la vue `donnee_details`
--
DROP TABLE IF EXISTS `donnee_details`;

CREATE ALGORITHM=UNDEFINED DEFINER=`jean-baptiste`@`%` SQL SECURITY DEFINER VIEW `donnee_details`  AS  select `donnee`.`donnee_id` AS `donnee_id`,`compteur_details`.`compteur_id` AS `compteur_id`,`compteur_details`.`user_id` AS `user_id`,`donnee`.`donnee_name` AS `donnee_name`,`donnee`.`donnee_unit` AS `donnee_unit`,`donnee`.`donnee_type` AS `donnee_type`,`donnee`.`last_update_ts` AS `last_update_ts`,`compteur_details`.`compteur_name` AS `compteur_name`,`compteur_details`.`compteur_link` AS `compteur_link`,`compteur_details`.`compteur_number` AS `compteur_number`,`compteur_details`.`compteur_level` AS `compteur_level`,`compteur_details`.`date_signature_compteur` AS `date_signature_compteur`,`compteur_details`.`compteur_heures_creuses` AS `compteur_heures_creuses`,`compteur_details`.`compteur_puissance_max` AS `compteur_puissance_max`,`compteur_details`.`user_email` AS `user_email`,`compteur_details`.`user_phone` AS `user_phone`,`compteur_details`.`user_name` AS `user_name`,`compteur_details`.`user_firstname` AS `user_firstname`,`compteur_details`.`user_level_access` AS `user_level_access`,`compteur_details`.`user_compteur_level` AS `user_compteur_level`,`compteur_details`.`email_verified` AS `email_verified` from (`donnee` join `compteur_details` on(`compteur_details`.`compteur_id` = `donnee`.`compteur_id`)) ;

-- --------------------------------------------------------

--
-- Structure de la vue `formulaire_details`
--
DROP TABLE IF EXISTS `formulaire_details`;

CREATE ALGORITHM=UNDEFINED DEFINER=`jean-baptiste`@`%` SQL SECURITY DEFINER VIEW `formulaire_details`  AS  select `formulaire`.`form_id` AS `form_id`,`compteur_details`.`compteur_id` AS `compteur_id`,`compteur_details`.`user_id` AS `user_id`,`formulaire`.`contrat_type_id` AS `contrat_type_id`,`formulaire`.`form_fournisseur` AS `form_fournisseur`,`formulaire`.`form_has_chauffage` AS `form_has_chauffage`,`formulaire`.`form_has_voiture` AS `form_has_voiture`,`formulaire`.`form_has_piscine` AS `form_has_piscine`,`formulaire`.`form_has_ballon_eau_chaude` AS `form_has_ballon_eau_chaude`,`compteur_details`.`compteur_name` AS `compteur_name`,`compteur_details`.`compteur_link` AS `compteur_link`,`compteur_details`.`compteur_number` AS `compteur_number`,`compteur_details`.`compteur_level` AS `compteur_level`,`compteur_details`.`date_signature_compteur` AS `date_signature_compteur`,`compteur_details`.`compteur_heures_creuses` AS `compteur_heures_creuses`,`compteur_details`.`compteur_puissance_max` AS `compteur_puissance_max`,`compteur_details`.`user_email` AS `user_email`,`compteur_details`.`user_phone` AS `user_phone`,`compteur_details`.`user_name` AS `user_name`,`compteur_details`.`user_firstname` AS `user_firstname`,`compteur_details`.`user_level_access` AS `user_level_access`,`compteur_details`.`user_compteur_level` AS `user_compteur_level`,`compteur_details`.`email_verified` AS `email_verified` from (`formulaire` join `compteur_details` on(`compteur_details`.`compteur_id` = `formulaire`.`compteur_id`)) ;

-- --------------------------------------------------------

--
-- Structure de la vue `user_details`
--
DROP TABLE IF EXISTS `user_details`;

CREATE ALGORITHM=UNDEFINED DEFINER=`jean-baptiste`@`%` SQL SECURITY DEFINER VIEW `user_details`  AS  select `user`.`user_id` AS `user_id`,`user`.`user_email` AS `user_email`,`user`.`user_phone` AS `user_phone`,`user`.`user_name` AS `user_name`,`user`.`user_firstname` AS `user_firstname`,`user`.`user_level_access` AS `user_level_access`,`user`.`email_verified` AS `email_verified`,max(`compteur`.`compteur_level`) AS `compteur_level`,min(`compteur`.`compteur_id`) AS `compteur_id` from (`user` left join `compteur` on(`user`.`user_id` = `compteur`.`user_id`)) group by `user`.`user_id` ;

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `compteur`
--
ALTER TABLE `compteur`
  ADD PRIMARY KEY (`compteur_id`);

--
-- Index pour la table `contrat_tarif`
--
ALTER TABLE `contrat_tarif`
  ADD PRIMARY KEY (`contrat_tarif_id`);

--
-- Index pour la table `contrat_type`
--
ALTER TABLE `contrat_type`
  ADD PRIMARY KEY (`contrat_type_id`);

--
-- Index pour la table `donnee`
--
ALTER TABLE `donnee`
  ADD PRIMARY KEY (`donnee_id`);

--
-- Index pour la table `formulaire`
--
ALTER TABLE `formulaire`
  ADD PRIMARY KEY (`form_id`);

--
-- Index pour la table `fournisseur`
--
ALTER TABLE `fournisseur`
  ADD PRIMARY KEY (`fournisseur_id`);

--
-- Index pour la table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `user_username` (`user_email`),
  ADD KEY `user_phone` (`user_phone`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `compteur`
--
ALTER TABLE `compteur`
  MODIFY `compteur_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `contrat_tarif`
--
ALTER TABLE `contrat_tarif`
  MODIFY `contrat_tarif_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `contrat_type`
--
ALTER TABLE `contrat_type`
  MODIFY `contrat_type_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `donnee`
--
ALTER TABLE `donnee`
  MODIFY `donnee_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `formulaire`
--
ALTER TABLE `formulaire`
  MODIFY `form_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `fournisseur`
--
ALTER TABLE `fournisseur`
  MODIFY `fournisseur_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `user`
--
ALTER TABLE `user`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
