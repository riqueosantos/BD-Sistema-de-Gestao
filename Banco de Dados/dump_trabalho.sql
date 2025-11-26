-- MySQL dump 10.13  Distrib 8.0.44, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: trabalho_bd
-- ------------------------------------------------------
-- Server version	8.0.44

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `alocacoes`
--

DROP TABLE IF EXISTS `alocacoes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alocacoes` (
  `id_alocacao` int NOT NULL AUTO_INCREMENT,
  `id_disciplina` int NOT NULL,
  `id_professor` int NOT NULL,
  `id_sala` int NOT NULL,
  `id_turno` int NOT NULL,
  `dia_semana` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id_alocacao`),
  KEY `FK_Aloc_Disc` (`id_disciplina`),
  KEY `FK_Aloc_Prof` (`id_professor`),
  KEY `FK_Aloc_Sala` (`id_sala`),
  KEY `FK_Aloc_Turno` (`id_turno`),
  CONSTRAINT `FK_Aloc_Disc` FOREIGN KEY (`id_disciplina`) REFERENCES `disciplinas` (`id_disciplina`),
  CONSTRAINT `FK_Aloc_Prof` FOREIGN KEY (`id_professor`) REFERENCES `professores` (`id_professor`),
  CONSTRAINT `FK_Aloc_Sala` FOREIGN KEY (`id_sala`) REFERENCES `salas` (`id_sala`),
  CONSTRAINT `FK_Aloc_Turno` FOREIGN KEY (`id_turno`) REFERENCES `turnos` (`id_turno`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alocacoes`
--

LOCK TABLES `alocacoes` WRITE;
/*!40000 ALTER TABLE `alocacoes` DISABLE KEYS */;
INSERT INTO `alocacoes` VALUES (1,101,1,1,5,'Ter'),(2,102,2,4,5,'Qua'),(3,103,3,7,5,'Qui'),(4,104,4,9,6,'Sex'),(5,105,5,6,6,'Seg'),(6,201,6,2,5,'Ter'),(7,201,6,2,2,'Qua'),(8,202,7,5,5,'Qui'),(9,203,8,8,5,'Sex'),(10,204,9,10,6,'Seg'),(11,301,10,11,5,'Ter'),(12,301,10,11,3,'Qua'),(13,302,11,13,5,'Qui'),(14,303,12,3,5,'Sex'),(15,304,13,5,6,'Seg'),(16,305,14,1,6,'Ter'),(17,401,15,12,5,'Qua'),(18,402,16,14,5,'Qui'),(19,501,17,15,5,'Sex'),(20,502,18,16,5,'Seg');
/*!40000 ALTER TABLE `alocacoes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `alunos`
--

DROP TABLE IF EXISTS `alunos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alunos` (
  `id_aluno` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(60) NOT NULL,
  `matricula` int NOT NULL,
  `email` varchar(60) NOT NULL,
  `telefone` char(13) DEFAULT NULL,
  PRIMARY KEY (`id_aluno`),
  UNIQUE KEY `UQ_Matricula` (`matricula`),
  UNIQUE KEY `UQ_Email` (`email`),
  UNIQUE KEY `UQ_Telefone` (`telefone`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alunos`
--

LOCK TABLES `alunos` WRITE;
/*!40000 ALTER TABLE `alunos` DISABLE KEYS */;
INSERT INTO `alunos` VALUES (1,'Aluno Exemplo',202501,'aluno','11999888777');
/*!40000 ALTER TABLE `alunos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `avisos`
--

DROP TABLE IF EXISTS `avisos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `avisos` (
  `id_aviso` int NOT NULL AUTO_INCREMENT,
  `titulo` varchar(50) NOT NULL,
  `mensagem` varchar(255) NOT NULL,
  `data_publicacao` date NOT NULL,
  `id_coordenador` int DEFAULT NULL,
  `id_professor` int DEFAULT NULL,
  PRIMARY KEY (`id_aviso`),
  KEY `FK_Avisos_Coord` (`id_coordenador`),
  KEY `FK_Avisos_Prof` (`id_professor`),
  CONSTRAINT `FK_Avisos_Coord` FOREIGN KEY (`id_coordenador`) REFERENCES `coordenadores` (`id_coordenador`),
  CONSTRAINT `FK_Avisos_Prof` FOREIGN KEY (`id_professor`) REFERENCES `professores` (`id_professor`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `avisos`
--

LOCK TABLES `avisos` WRITE;
/*!40000 ALTER TABLE `avisos` DISABLE KEYS */;
INSERT INTO `avisos` VALUES (1,'Aviso','aviso teste','2025-11-25',NULL,NULL),(2,'Aviso','teste 2','2025-11-25',NULL,NULL);
/*!40000 ALTER TABLE `avisos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `coordenadores`
--

DROP TABLE IF EXISTS `coordenadores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `coordenadores` (
  `id_coordenador` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `telefone` varchar(20) DEFAULT NULL,
  `id_usuario` int DEFAULT NULL,
  PRIMARY KEY (`id_coordenador`),
  UNIQUE KEY `email` (`email`),
  KEY `fk_coord_usuario` (`id_usuario`),
  CONSTRAINT `fk_coord_usuario` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `coordenadores`
--

LOCK TABLES `coordenadores` WRITE;
/*!40000 ALTER TABLE `coordenadores` DISABLE KEYS */;
INSERT INTO `coordenadores` VALUES (1,'Coordenação Geral','coord@escola.com','1199999999',1);
/*!40000 ALTER TABLE `coordenadores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cursos`
--

DROP TABLE IF EXISTS `cursos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cursos` (
  `id_curso` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `cod` varchar(20) NOT NULL,
  `descricao` text,
  `duracao_periodo` varchar(50) DEFAULT NULL,
  `id_coordenador` int DEFAULT NULL,
  PRIMARY KEY (`id_curso`),
  UNIQUE KEY `cod` (`cod`),
  KEY `fk_curso_coord` (`id_coordenador`),
  CONSTRAINT `fk_curso_coord` FOREIGN KEY (`id_coordenador`) REFERENCES `coordenadores` (`id_coordenador`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cursos`
--

LOCK TABLES `cursos` WRITE;
/*!40000 ALTER TABLE `cursos` DISABLE KEYS */;
INSERT INTO `cursos` VALUES (1,'Análise e Des. Sistemas','ADS',NULL,NULL,1);
/*!40000 ALTER TABLE `cursos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `disciplinas`
--

DROP TABLE IF EXISTS `disciplinas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `disciplinas` (
  `id_disciplina` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `cod` varchar(20) NOT NULL,
  `carga_horaria` int DEFAULT NULL,
  `ementa` text,
  `id_curso` int DEFAULT NULL,
  `id_professor` int DEFAULT NULL,
  `periodo` int DEFAULT '1',
  PRIMARY KEY (`id_disciplina`),
  UNIQUE KEY `cod` (`cod`),
  KEY `fk_disc_curso` (`id_curso`),
  KEY `fk_disc_prof` (`id_professor`),
  CONSTRAINT `fk_disc_curso` FOREIGN KEY (`id_curso`) REFERENCES `cursos` (`id_curso`) ON DELETE CASCADE,
  CONSTRAINT `fk_disc_prof` FOREIGN KEY (`id_professor`) REFERENCES `professores` (`id_professor`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=506 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `disciplinas`
--

LOCK TABLES `disciplinas` WRITE;
/*!40000 ALTER TABLE `disciplinas` DISABLE KEYS */;
INSERT INTO `disciplinas` VALUES (101,'Introdução à ADS','ADS101',80,NULL,1,NULL,1),(102,'Prog. Estruturada','ADS102',80,NULL,1,NULL,1),(103,'Matemática Aplicada','ADS103',40,NULL,1,NULL,1),(104,'Lógica de Programação','ADS104',80,NULL,1,NULL,1),(105,'Comunicação e Expressão','ADS105',40,NULL,1,NULL,1),(201,'Estrutura de Dados','ADS201',80,NULL,1,NULL,2),(202,'Desenvolvimento Web','ADS202',80,NULL,1,NULL,2),(203,'Banco de Dados I','ADS203',80,NULL,1,NULL,2),(204,'Sistemas Operacionais','ADS204',40,NULL,1,NULL,2),(205,'Redes de Computadores','ADS205',80,NULL,1,NULL,2),(301,'Engenharia de Software','ADS301',80,NULL,1,NULL,3),(302,'Prog. Orientada a Objetos','ADS302',80,NULL,1,NULL,3),(303,'Estatística','ADS303',40,NULL,1,NULL,3),(304,'Design de Interação','ADS304',40,NULL,1,NULL,3),(305,'Segurança da Informação','ADS305',40,NULL,1,NULL,3),(401,'Desenvolvimento Móvel','ADS401',80,NULL,1,NULL,4),(402,'Cloud Computing','ADS402',40,NULL,1,NULL,4),(403,'Inteligência Artificial','ADS403',40,NULL,1,NULL,4),(404,'Gestão de Projetos','ADS404',40,NULL,1,NULL,4),(405,'Testes e Qualidade','ADS405',40,NULL,1,NULL,4),(501,'Empreendedorismo','ADS501',40,NULL,1,NULL,5),(502,'TCC I','ADS502',40,NULL,1,NULL,5),(503,'Computação Gráfica','ADS503',40,NULL,1,NULL,5),(504,'DevOps','ADS504',80,NULL,1,NULL,5),(505,'Auditoria de Sistemas','ADS505',40,NULL,1,NULL,5);
/*!40000 ALTER TABLE `disciplinas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `professores`
--

DROP TABLE IF EXISTS `professores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `professores` (
  `id_professor` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `id_usuario` int DEFAULT NULL,
  PRIMARY KEY (`id_professor`),
  UNIQUE KEY `email` (`email`),
  KEY `fk_prof_usuario` (`id_usuario`),
  CONSTRAINT `fk_prof_usuario` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `professores`
--

LOCK TABLES `professores` WRITE;
/*!40000 ALTER TABLE `professores` DISABLE KEYS */;
INSERT INTO `professores` VALUES (1,'Ana Paula','ana@escola.com',2),(2,'Bruno Lopes','bruno@escola.com',3),(3,'Carla Souza','carla@escola.com',4),(4,'Daniel Alves','daniel@escola.com',5),(5,'Eduarda Lima','eduarda@escola.com',6),(6,'Fernanda Guedes','fernanda@escola.com',7),(7,'Gustavo Rocha','gustavo@escola.com',8),(8,'Helena Nunes','helena@escola.com',9),(9,'Igor Silva','igor@escola.com',10),(10,'Karen Lima','karen@escola.com',11),(11,'Lucas Mendes','lucas@escola.com',12),(12,'Mariana Souza','mariana@escola.com',13),(13,'Nelson Costa','nelson@escola.com',14),(14,'Olívia Pires','olivia@escola.com',15),(15,'Paulo Viana','paulo@escola.com',16),(16,'Quintino Reis','quintino@escola.com',17),(17,'Uriel Borges','uriel@escola.com',18),(18,'Viviane Leal','viviane@escola.com',19);
/*!40000 ALTER TABLE `professores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `salas`
--

DROP TABLE IF EXISTS `salas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `salas` (
  `id_sala` int NOT NULL AUTO_INCREMENT,
  `numero` varchar(15) NOT NULL,
  `capacidade` int NOT NULL,
  `tipo` varchar(20) DEFAULT 'sala de aula',
  PRIMARY KEY (`id_sala`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `salas`
--

LOCK TABLES `salas` WRITE;
/*!40000 ALTER TABLE `salas` DISABLE KEYS */;
INSERT INTO `salas` VALUES (1,'301',40,'sala de aula'),(2,'302',40,'sala de aula'),(3,'303',40,'sala de aula'),(4,'305',40,'sala de aula'),(5,'306',40,'sala de aula'),(6,'201',40,'sala de aula'),(7,'202',40,'sala de aula'),(8,'203',40,'sala de aula'),(9,'205',40,'sala de aula'),(10,'206',40,'sala de aula'),(11,'401',40,'sala de aula'),(12,'402',40,'sala de aula'),(13,'405',40,'sala de aula'),(14,'406',40,'sala de aula'),(15,'501',40,'sala de aula'),(16,'505',40,'sala de aula'),(17,'301',40,'sala de aula'),(18,'Lab 1',30,'sala de aula');
/*!40000 ALTER TABLE `salas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `turmas`
--

DROP TABLE IF EXISTS `turmas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `turmas` (
  `id_turma` int NOT NULL,
  `nome` varchar(50) NOT NULL,
  `hora_inicio` time NOT NULL,
  `hora_fim` time NOT NULL,
  PRIMARY KEY (`id_turma`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `turmas`
--

LOCK TABLES `turmas` WRITE;
/*!40000 ALTER TABLE `turmas` DISABLE KEYS */;
/*!40000 ALTER TABLE `turmas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `turnos`
--

DROP TABLE IF EXISTS `turnos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `turnos` (
  `id_turno` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(10) NOT NULL,
  `hora_inicio` time NOT NULL,
  `hora_fim` time NOT NULL,
  PRIMARY KEY (`id_turno`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `turnos`
--

LOCK TABLES `turnos` WRITE;
/*!40000 ALTER TABLE `turnos` DISABLE KEYS */;
INSERT INTO `turnos` VALUES (1,'Manhã 1','08:00:00','09:40:00'),(2,'Manhã 2','09:50:00','11:30:00'),(3,'Tarde 1','14:00:00','15:40:00'),(4,'Tarde 2','15:50:00','17:30:00'),(5,'Noite 1','18:30:00','20:10:00'),(6,'Noite 2','20:20:00','22:00:00'),(7,'Noite 1','18:30:00','20:10:00');
/*!40000 ALTER TABLE `turnos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuarios` (
  `id_usuario` int NOT NULL AUTO_INCREMENT,
  `nome_usuario` varchar(50) NOT NULL,
  `senha` varchar(255) NOT NULL,
  `tipo` enum('professor','coordenador','outro') DEFAULT 'outro',
  PRIMARY KEY (`id_usuario`),
  UNIQUE KEY `nome_usuario` (`nome_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES (1,'coordenador','123','coordenador'),(2,'ana.paula','123','professor'),(3,'bruno.lopes','123','professor'),(4,'carla.souza','123','professor'),(5,'daniel.alves','123','professor'),(6,'eduarda.lima','123','professor'),(7,'fernanda.guedes','123','professor'),(8,'gustavo.rocha','123','professor'),(9,'helena.nunes','123','professor'),(10,'igor.silva','123','professor'),(11,'karen.lima','123','professor'),(12,'lucas.mendes','123','professor'),(13,'mariana.souza','123','professor'),(14,'nelson.costa','123','professor'),(15,'olivia.pires','123','professor'),(16,'paulo.viana','123','professor'),(17,'quintino.reis','123','professor'),(18,'uriel.borges','123','professor'),(19,'viviane.leal','123','professor');
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `vw_curso_disciplinas`
--

DROP TABLE IF EXISTS `vw_curso_disciplinas`;
/*!50001 DROP VIEW IF EXISTS `vw_curso_disciplinas`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_curso_disciplinas` AS SELECT 
 1 AS `curso`,
 1 AS `coordenador`,
 1 AS `disciplina`,
 1 AS `carga_horaria`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_professores_alocados`
--

DROP TABLE IF EXISTS `vw_professores_alocados`;
/*!50001 DROP VIEW IF EXISTS `vw_professores_alocados`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_professores_alocados` AS SELECT 
 1 AS `professor`,
 1 AS `disciplina`,
 1 AS `sala`,
 1 AS `turno`*/;
SET character_set_client = @saved_cs_client;

--
-- Dumping events for database 'trabalho_bd'
--

--
-- Dumping routines for database 'trabalho_bd'
--

--
-- Final view structure for view `vw_curso_disciplinas`
--

/*!50001 DROP VIEW IF EXISTS `vw_curso_disciplinas`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_curso_disciplinas` AS select `c`.`nome` AS `curso`,`co`.`nome` AS `coordenador`,`d`.`nome` AS `disciplina`,`d`.`carga_horaria` AS `carga_horaria` from ((`cursos` `c` left join `coordenadores` `co` on((`c`.`id_coordenador` = `co`.`id_coordenador`))) left join `disciplinas` `d` on((`c`.`id_curso` = `d`.`id_curso`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_professores_alocados`
--

/*!50001 DROP VIEW IF EXISTS `vw_professores_alocados`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_professores_alocados` AS select `p`.`nome` AS `professor`,`d`.`nome` AS `disciplina`,`s`.`numero` AS `sala`,`t`.`nome` AS `turno` from ((((`alocacoes` `a` join `professores` `p` on((`a`.`id_professor` = `p`.`id_professor`))) join `disciplinas` `d` on((`a`.`id_disciplina` = `d`.`id_disciplina`))) join `salas` `s` on((`a`.`id_sala` = `s`.`id_sala`))) join `turnos` `t` on((`a`.`id_turno` = `t`.`id_turno`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-11-25 23:52:57
