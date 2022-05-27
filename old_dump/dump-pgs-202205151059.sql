-- MySQL dump 10.13  Distrib 8.0.18, for macos10.14 (x86_64)
--
-- Host: pgs-database-1.catbhszbumkd.us-east-1.rds.amazonaws.com    Database: pgs
-- ------------------------------------------------------
-- Server version	5.5.5-10.6.7-MariaDB-log

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
-- Table structure for table `audit`
--

DROP TABLE IF EXISTS `audit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `audit` (
  `id_audit` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Id for this registry',
  `table_name` longtext NOT NULL COMMENT 'Name of the table affected',
  `creation_user` longtext NOT NULL COMMENT 'User that created the registry',
  `update_user` longtext NOT NULL COMMENT 'User that updated the registry',
  `creation_date` timestamp NOT NULL DEFAULT current_timestamp() COMMENT 'Date of creation of the registry',
  `update_date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT 'Date of update of the registry',
  `description` longtext DEFAULT '',
  PRIMARY KEY (`id_audit`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Dates of creation and update\nUsers of creation and update\nFor any record in the tables';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `audit`
--

LOCK TABLES `audit` WRITE;
/*!40000 ALTER TABLE `audit` DISABLE KEYS */;
/*!40000 ALTER TABLE `audit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clients`
--

DROP TABLE IF EXISTS `clients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clients` (
  `id_client` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Id for this registry',
  `client_number` int(11) NOT NULL COMMENT 'Client ID Number',
  `document_type` int(11) NOT NULL COMMENT 'Type of Document Number',
  `client_name` longtext NOT NULL COMMENT 'Name of the Client',
  `last_visited` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT 'Last time when the client came',
  `discount` int(11) NOT NULL COMMENT 'Special disccount fot this client',
  `pending_payment` int(11) NOT NULL COMMENT 'Amount pending for payment',
  `id_user` int(11) NOT NULL COMMENT 'The user registry for this client',
  PRIMARY KEY (`id_client`),
  UNIQUE KEY `client_number_UNIQUE` (`client_number`),
  KEY `fk_clients_users_idx` (`id_user`),
  CONSTRAINT `fk_clients_users` FOREIGN KEY (`id_user`) REFERENCES `users` (`id_user`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COMMENT='Table for Clients of HYP';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clients`
--

LOCK TABLES `clients` WRITE;
/*!40000 ALTER TABLE `clients` DISABLE KEYS */;
INSERT INTO `clients` VALUES (1,1032442214,1,'Camilo Díaz','2022-04-29 02:03:10',0,0,1);
/*!40000 ALTER TABLE `clients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fur_statuses`
--

DROP TABLE IF EXISTS `fur_statuses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fur_statuses` (
  `id_fur_status` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Id for this registry',
  `description` longtext NOT NULL COMMENT 'Description of the fur status',
  `factor` double NOT NULL COMMENT 'Factor to calculate the final amount of the service',
  PRIMARY KEY (`id_fur_status`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3 COMMENT='Fur statuses for the pets';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fur_statuses`
--

LOCK TABLES `fur_statuses` WRITE;
/*!40000 ALTER TABLE `fur_statuses` DISABLE KEYS */;
INSERT INTO `fur_statuses` VALUES (1,'Pelaje corto',1),(2,'Pelaje corto/medio',1.25),(3,'Pelaje medio',1.5),(4,'Pelaje medio/largo',1.75),(5,'Pelaje largo',2);
/*!40000 ALTER TABLE `fur_statuses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pet_breeds`
--

DROP TABLE IF EXISTS `pet_breeds`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pet_breeds` (
  `id_pet_breed` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID for this regisrty',
  `name` longtext NOT NULL COMMENT 'Name of the Pet Breed',
  `id_pet_type` int(11) NOT NULL COMMENT 'Type of Pet for this Pet Breed',
  PRIMARY KEY (`id_pet_breed`),
  KEY `fk_pet_types_id_pet_types` (`id_pet_type`),
  CONSTRAINT `fk_pet_types_id_pet_types` FOREIGN KEY (`id_pet_type`) REFERENCES `pet_types` (`id_pet_type`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3 COMMENT='Breeds of Pets in the system';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pet_breeds`
--

LOCK TABLES `pet_breeds` WRITE;
/*!40000 ALTER TABLE `pet_breeds` DISABLE KEYS */;
INSERT INTO `pet_breeds` VALUES (1,'Pequeño',1),(2,'Mediano',1),(3,'Grande',1),(4,'Pequeño',2),(5,'Mediano',2),(6,'Grande',2);
/*!40000 ALTER TABLE `pet_breeds` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pet_types`
--

DROP TABLE IF EXISTS `pet_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pet_types` (
  `id_pet_type` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID for registry',
  `name` longtext NOT NULL COMMENT 'Name of the Pet Type',
  PRIMARY KEY (`id_pet_type`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3 COMMENT='Types of pets in the system';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pet_types`
--

LOCK TABLES `pet_types` WRITE;
/*!40000 ALTER TABLE `pet_types` DISABLE KEYS */;
INSERT INTO `pet_types` VALUES (1,'Perro'),(2,'Gato');
/*!40000 ALTER TABLE `pet_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pets`
--

DROP TABLE IF EXISTS `pets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pets` (
  `id_pet` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Id for this registry',
  `name` longtext NOT NULL COMMENT 'Name of the pet',
  `birth_date` date NOT NULL COMMENT 'Dat for birth of the pet',
  `gender` int(11) NOT NULL COMMENT 'Gender of the pet',
  `is_sterilized` smallint(6) NOT NULL COMMENT 'Is the peat already sterilized',
  `weight` longtext NOT NULL COMMENT 'Weight in KG of the pet',
  `photo` longtext DEFAULT NULL COMMENT 'Binary of the photo of the pet',
  `additional_observations` longtext DEFAULT NULL COMMENT 'Some important things to know about the pet',
  `last_visited` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT 'Las time when the pet came',
  `id_user` int(11) NOT NULL COMMENT 'Owner of the pet',
  `id_pet_breed` int(11) NOT NULL COMMENT 'Breed of the pet',
  `id_fur_status` int(11) NOT NULL COMMENT 'Current status of the fur of the pet',
  PRIMARY KEY (`id_pet`),
  KEY `fk_users_id_user` (`id_user`),
  KEY `fk_pet_breeds_id_pet_breed` (`id_pet_breed`),
  KEY `fk_fur_statuses_id_fur_status` (`id_fur_status`),
  CONSTRAINT `fk_fur_statuses_id_fur_status` FOREIGN KEY (`id_fur_status`) REFERENCES `fur_statuses` (`id_fur_status`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_pet_breeds_id_pet_breed` FOREIGN KEY (`id_pet_breed`) REFERENCES `pet_breeds` (`id_pet_breed`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_users_id_user` FOREIGN KEY (`id_user`) REFERENCES `users` (`id_user`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3 COMMENT='Pets';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pets`
--

LOCK TABLES `pets` WRITE;
/*!40000 ALTER TABLE `pets` DISABLE KEYS */;
INSERT INTO `pets` VALUES (1,'Gary','2021-12-15',1,1,'4.5 Kg','https://pets-static-img-pgs.s3.amazonaws.com/a1.jpeg','Parece un pancito','2022-05-07 16:57:48',1,6,1),(2,'Perrito bebé','2022-01-01',1,0,'1 Kg','https://pets-static-img-pgs.s3.amazonaws.com/a2.jpeg','Está bien bebé','2022-05-07 16:56:36',1,1,1),(3,'Grace','2020-01-27',2,1,'2.5 Kg','https://pets-static-img-pgs.s3.amazonaws.com/a3.jpeg','Es una gatica muy bonita','2022-05-07 16:56:36',1,5,1),(4,'Minnie','2022-01-01',2,0,'2.5 Kg','https://pets-static-img-pgs.s3.amazonaws.com/a4.jpeg','Es cansona cuando la bañan','2022-05-07 16:56:36',1,2,3);
/*!40000 ALTER TABLE `pets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pets_and_vaccines`
--

DROP TABLE IF EXISTS `pets_and_vaccines`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pets_and_vaccines` (
  `id_pets_vaccines` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Id for this registry',
  `id_pet` int(11) NOT NULL,
  `id_vaccine` int(11) NOT NULL,
  `application` date DEFAULT NULL COMMENT 'The date when the vaccine was applicated',
  PRIMARY KEY (`id_pets_vaccines`),
  KEY `fk_pets_and_vaccines_pets1_idx` (`id_pet`),
  KEY `fk_pets_and_vaccines_vaccines1_idx` (`id_vaccine`),
  CONSTRAINT `fk_pets_and_vaccines_pets1` FOREIGN KEY (`id_pet`) REFERENCES `pets` (`id_pet`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_pets_and_vaccines_vaccines1` FOREIGN KEY (`id_vaccine`) REFERENCES `vaccines` (`id_vaccine`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Where the vaccines and the pets are related';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pets_and_vaccines`
--

LOCK TABLES `pets_and_vaccines` WRITE;
/*!40000 ALTER TABLE `pets_and_vaccines` DISABLE KEYS */;
/*!40000 ALTER TABLE `pets_and_vaccines` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `promotions`
--

DROP TABLE IF EXISTS `promotions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `promotions` (
  `id_promotion` int(11) NOT NULL COMMENT 'Id for this registry',
  `id_visit` int(11) NOT NULL COMMENT 'The visit to make promotion',
  `factor` double NOT NULL COMMENT 'The factor of the promotion in percent',
  PRIMARY KEY (`id_promotion`),
  KEY `fk_visits_id_visit` (`id_visit`),
  CONSTRAINT `fk_visits_id_visit` FOREIGN KEY (`id_visit`) REFERENCES `visits` (`id_visit`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Promotions for the visitors';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `promotions`
--

LOCK TABLES `promotions` WRITE;
/*!40000 ALTER TABLE `promotions` DISABLE KEYS */;
/*!40000 ALTER TABLE `promotions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `id_role` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Id for this registry',
  `name` longtext NOT NULL COMMENT 'Name of the role',
  PRIMARY KEY (`id_role`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3 COMMENT='Roles of the users in the system';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'Admin'),(2,'Esteticista'),(3,'Dueño');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `satisfaction_assessments`
--

DROP TABLE IF EXISTS `satisfaction_assessments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `satisfaction_assessments` (
  `id_satisfaction_assessment` int(11) NOT NULL AUTO_INCREMENT COMMENT 'TRIAL',
  `score` int(11) NOT NULL COMMENT 'TRIAL',
  `id_visit` int(11) NOT NULL COMMENT 'TRIAL',
  PRIMARY KEY (`id_satisfaction_assessment`),
  KEY `fk_visits_id_visit_1` (`id_visit`),
  CONSTRAINT `fk_visits_id_visit_1` FOREIGN KEY (`id_visit`) REFERENCES `visits` (`id_visit`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='TRIAL';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `satisfaction_assessments`
--

LOCK TABLES `satisfaction_assessments` WRITE;
/*!40000 ALTER TABLE `satisfaction_assessments` DISABLE KEYS */;
/*!40000 ALTER TABLE `satisfaction_assessments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `services`
--

DROP TABLE IF EXISTS `services`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `services` (
  `id_service` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Id for this registry',
  `name` longtext NOT NULL COMMENT 'Name of the service',
  `average_time` time NOT NULL COMMENT 'Average time of completion for this service',
  `base_amount` int(11) NOT NULL COMMENT 'base amount to charge the owner of the pet',
  PRIMARY KEY (`id_service`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3 COMMENT='Services offered by the pet grooming store';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `services`
--

LOCK TABLES `services` WRITE;
/*!40000 ALTER TABLE `services` DISABLE KEYS */;
INSERT INTO `services` VALUES (4,'Baño','01:00:00',25000),(5,'Peluqueada','00:30:00',20000),(6,'Corte de uñas','00:04:00',25000);
/*!40000 ALTER TABLE `services` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `statuses`
--

DROP TABLE IF EXISTS `statuses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `statuses` (
  `id_status` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Id for this registry',
  `description` longtext NOT NULL COMMENT 'Description of the status',
  PRIMARY KEY (`id_status`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3 COMMENT='Statuses of the visits of the pets';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `statuses`
--

LOCK TABLES `statuses` WRITE;
/*!40000 ALTER TABLE `statuses` DISABLE KEYS */;
INSERT INTO `statuses` VALUES (1,'Agendada'),(2,'En sala de espera/Ingreso'),(3,'En servicio'),(4,'En sala de espera/egreso'),(5,'Entregado'),(6,'Perdido');
/*!40000 ALTER TABLE `statuses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_roles`
--

DROP TABLE IF EXISTS `user_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_roles` (
  `id_user_role` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Id for this registry',
  `id_user` int(11) NOT NULL,
  `id_role` int(11) NOT NULL,
  PRIMARY KEY (`id_user_role`),
  KEY `fk_user_roles_users1_idx` (`id_user`),
  KEY `fk_user_roles_roles1_idx` (`id_role`),
  CONSTRAINT `fk_user_roles_roles1` FOREIGN KEY (`id_role`) REFERENCES `roles` (`id_role`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_roles_users1` FOREIGN KEY (`id_user`) REFERENCES `users` (`id_user`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3 COMMENT='Roles mapping for users';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_roles`
--

LOCK TABLES `user_roles` WRITE;
/*!40000 ALTER TABLE `user_roles` DISABLE KEYS */;
INSERT INTO `user_roles` VALUES (1,1,1),(2,2,2),(3,3,3);
/*!40000 ALTER TABLE `user_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id_user` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Id for this registry',
  `email` longtext NOT NULL COMMENT 'email of the user',
  `password` longtext NOT NULL COMMENT 'password of the user',
  `login` longtext NOT NULL COMMENT 'login or username to make login to the system',
  `phone` double NOT NULL COMMENT 'Phone number of the user',
  `address` longtext NOT NULL COMMENT 'Address of the user',
  PRIMARY KEY (`id_user`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3 COMMENT='The users of the system. It may include pet owners and steticists and pet grooming shop owners or admins';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'camilodiaz369@gmail.com','Password123.','camilodiaz369',3178241317,'Calle Falsa 123 # 45 - 67'),(2,'dpvillalobosm@gmail.com','Diana312456.','dpvillalobosm',3224640065,'Carrera 89 # 12 - 34'),(3,'pepito.perez@gmail.com','Contra123456.','pepitop',310555555,'Calle 56 # 78 - 90');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vaccines`
--

DROP TABLE IF EXISTS `vaccines`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vaccines` (
  `id_vaccine` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Id for this registry',
  `name` longtext NOT NULL COMMENT 'Name of the vaccine',
  PRIMARY KEY (`id_vaccine`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3 COMMENT='Vaccines for all pets';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vaccines`
--

LOCK TABLES `vaccines` WRITE;
/*!40000 ALTER TABLE `vaccines` DISABLE KEYS */;
INSERT INTO `vaccines` VALUES (1,'Si'),(2,'No');
/*!40000 ALTER TABLE `vaccines` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `visits`
--

DROP TABLE IF EXISTS `visits`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `visits` (
  `id_visit` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID for this registry',
  `visit_date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT 'The date when the pet visited us',
  `initial_description` longtext NOT NULL COMMENT 'Some notes written by the steticist when the pet got in',
  `final_description` longtext NOT NULL COMMENT 'Some notes written by the steticist when the pet got out',
  `real_time_used` time NOT NULL COMMENT 'The amount of time in minutes effectively used for attend the visit',
  `total_amount` int(11) NOT NULL COMMENT 'Total amount in currency charged to the owner for the visit',
  `id_service` int(11) NOT NULL COMMENT 'The service made in this visit',
  `id_status` int(11) NOT NULL COMMENT 'The current status of the service',
  `id_user` int(11) NOT NULL COMMENT 'The steticist that is making the service to the pet',
  `id_pet` int(11) NOT NULL COMMENT 'The pet',
  PRIMARY KEY (`id_visit`),
  KEY `fk_pets_id_pet_1` (`id_pet`),
  KEY `fk_services_id_service` (`id_service`),
  KEY `fk_status_id_status` (`id_status`),
  KEY `fk_steticist_id_user` (`id_user`),
  CONSTRAINT `fk_pets_id_pet_1` FOREIGN KEY (`id_pet`) REFERENCES `pets` (`id_pet`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_services_id_service` FOREIGN KEY (`id_service`) REFERENCES `services` (`id_service`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_status_id_status` FOREIGN KEY (`id_status`) REFERENCES `statuses` (`id_status`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_steticist_id_user` FOREIGN KEY (`id_user`) REFERENCES `users` (`id_user`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3 COMMENT='The visits of the pets and owner in the pet grooming store';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `visits`
--

LOCK TABLES `visits` WRITE;
/*!40000 ALTER TABLE `visits` DISABLE KEYS */;
INSERT INTO `visits` VALUES (1,'2022-05-14 14:42:11','Llegó bien','Aún no ha terminado','00:05:00',45000,4,1,1,1),(2,'2022-05-14 14:46:11','Llegó bien. 2','Aún no ha terminado 2','00:06:00',45000,4,1,1,1),(3,'2022-05-14 14:46:11','Llegó bien. 2','Aún no ha terminado 2','00:06:00',45000,4,1,1,1),(4,'2022-05-14 14:46:11','Llegó bien. 2','Aún no ha terminado 2','00:06:00',45000,4,1,1,1);
/*!40000 ALTER TABLE `visits` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'pgs'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-05-15 11:00:02
