-- MySQL dump 10.13  Distrib 5.7.9, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: siga_transportes
-- ------------------------------------------------------
-- Server version	5.6.31-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `cidades`
--

DROP TABLE IF EXISTS `cidades`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cidades` (
  `codigo` bigint(20) NOT NULL AUTO_INCREMENT,
  `nome` varchar(50) NOT NULL,
  `estado_codigo` bigint(20) NOT NULL,
  `pais_codigo` bigint(20) NOT NULL,
  PRIMARY KEY (`codigo`),
  KEY `FK_f2wwf45wgk3q4x43cscrjgi3r` (`estado_codigo`),
  KEY `FK_qp8p1gkh2y61hs9yhifihjnwj` (`pais_codigo`),
  CONSTRAINT `FK_f2wwf45wgk3q4x43cscrjgi3r` FOREIGN KEY (`estado_codigo`) REFERENCES `estados` (`codigo`),
  CONSTRAINT `FK_qp8p1gkh2y61hs9yhifihjnwj` FOREIGN KEY (`pais_codigo`) REFERENCES `paises` (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cidades`
--

LOCK TABLES `cidades` WRITE;
/*!40000 ALTER TABLE `cidades` DISABLE KEYS */;
/*!40000 ALTER TABLE `cidades` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clientes`
--

DROP TABLE IF EXISTS `clientes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `clientes` (
  `codigo` bigint(20) NOT NULL AUTO_INCREMENT,
  `CNPJ` varchar(60) NOT NULL,
  `dataCadastro` date NOT NULL,
  `email` varchar(100) NOT NULL,
  `endereco` varchar(80) NOT NULL,
  `ie` varchar(60) NOT NULL,
  `nome` varchar(80) NOT NULL,
  `telefone` varchar(60) NOT NULL,
  `cidade_codigo` bigint(20) NOT NULL,
  `estado_codigo` bigint(20) NOT NULL,
  PRIMARY KEY (`codigo`),
  UNIQUE KEY `UK_3nns50py9kwl9a4ecbi6b6er3` (`CNPJ`),
  UNIQUE KEY `UK_5amw89hu7w6ql52erkn8x5j1f` (`ie`),
  KEY `FK_biydr2fg5b15iu8j44vi2t9jb` (`cidade_codigo`),
  KEY `FK_idh0tuy4iho5cebonu5u5t3ek` (`estado_codigo`),
  CONSTRAINT `FK_biydr2fg5b15iu8j44vi2t9jb` FOREIGN KEY (`cidade_codigo`) REFERENCES `cidades` (`codigo`),
  CONSTRAINT `FK_idh0tuy4iho5cebonu5u5t3ek` FOREIGN KEY (`estado_codigo`) REFERENCES `estados` (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clientes`
--

LOCK TABLES `clientes` WRITE;
/*!40000 ALTER TABLE `clientes` DISABLE KEYS */;
/*!40000 ALTER TABLE `clientes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `destinos`
--

DROP TABLE IF EXISTS `destinos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `destinos` (
  `codigo` bigint(20) NOT NULL AUTO_INCREMENT,
  `cidade_codigo` bigint(20) NOT NULL,
  `estado_codigo` bigint(20) NOT NULL,
  `pais_codigo` bigint(20) NOT NULL,
  PRIMARY KEY (`codigo`),
  KEY `FK_4fmvqtmxj8t12ita1hql46oan` (`cidade_codigo`),
  KEY `FK_3i2soocdnh0285u8mbstgmkbf` (`estado_codigo`),
  KEY `FK_abs4vqp13vckwohetwyl9edbg` (`pais_codigo`),
  CONSTRAINT `FK_3i2soocdnh0285u8mbstgmkbf` FOREIGN KEY (`estado_codigo`) REFERENCES `estados` (`codigo`),
  CONSTRAINT `FK_4fmvqtmxj8t12ita1hql46oan` FOREIGN KEY (`cidade_codigo`) REFERENCES `cidades` (`codigo`),
  CONSTRAINT `FK_abs4vqp13vckwohetwyl9edbg` FOREIGN KEY (`pais_codigo`) REFERENCES `paises` (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `destinos`
--

LOCK TABLES `destinos` WRITE;
/*!40000 ALTER TABLE `destinos` DISABLE KEYS */;
/*!40000 ALTER TABLE `destinos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `documentos`
--

DROP TABLE IF EXISTS `documentos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `documentos` (
  `codigo` bigint(20) NOT NULL AUTO_INCREMENT,
  `nome` varchar(80) NOT NULL,
  `numero` int(11) NOT NULL,
  PRIMARY KEY (`codigo`),
  UNIQUE KEY `UK_3c3nc11elc9b794mfrbn3nv9d` (`nome`),
  UNIQUE KEY `UK_486dulg1pqlxxp1h8ifsjqcdw` (`numero`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `documentos`
--

LOCK TABLES `documentos` WRITE;
/*!40000 ALTER TABLE `documentos` DISABLE KEYS */;
/*!40000 ALTER TABLE `documentos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `empresas`
--

DROP TABLE IF EXISTS `empresas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `empresas` (
  `codigo` bigint(20) NOT NULL AUTO_INCREMENT,
  `CNPJ` varchar(80) NOT NULL,
  `dataCadastro` date NOT NULL,
  `email` varchar(80) NOT NULL,
  `endereco` varchar(80) NOT NULL,
  `fone` varchar(30) NOT NULL,
  `ie` varchar(80) NOT NULL,
  `nome` varchar(80) NOT NULL,
  `cidade_codigo` bigint(20) NOT NULL,
  `estado_codigo` bigint(20) NOT NULL,
  `responsavel_codigo` bigint(20) NOT NULL,
  PRIMARY KEY (`codigo`),
  UNIQUE KEY `UK_kh61ytsg6nr4ogpyhs8x6lu42` (`CNPJ`),
  UNIQUE KEY `UK_avmac2r40586w2svbe5spnjsb` (`ie`),
  KEY `FK_ekaqpyw307i3mard73jts16me` (`cidade_codigo`),
  KEY `FK_f5bd3gpe296yl3xsiye83x6uw` (`estado_codigo`),
  KEY `FK_gpv0mu4bw1sdjw4mvajrjltek` (`responsavel_codigo`),
  CONSTRAINT `FK_ekaqpyw307i3mard73jts16me` FOREIGN KEY (`cidade_codigo`) REFERENCES `cidades` (`codigo`),
  CONSTRAINT `FK_f5bd3gpe296yl3xsiye83x6uw` FOREIGN KEY (`estado_codigo`) REFERENCES `estados` (`codigo`),
  CONSTRAINT `FK_gpv0mu4bw1sdjw4mvajrjltek` FOREIGN KEY (`responsavel_codigo`) REFERENCES `funcionarios` (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `empresas`
--

LOCK TABLES `empresas` WRITE;
/*!40000 ALTER TABLE `empresas` DISABLE KEYS */;
/*!40000 ALTER TABLE `empresas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `estados`
--

DROP TABLE IF EXISTS `estados`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `estados` (
  `codigo` bigint(20) NOT NULL AUTO_INCREMENT,
  `nome` varchar(50) NOT NULL,
  `sigla` varchar(2) NOT NULL,
  PRIMARY KEY (`codigo`),
  UNIQUE KEY `UK_lwqadf33rdx51e2otolcbyo1` (`nome`),
  UNIQUE KEY `UK_7vpklxk68egwg03v7yoarpr88` (`sigla`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estados`
--

LOCK TABLES `estados` WRITE;
/*!40000 ALTER TABLE `estados` DISABLE KEYS */;
/*!40000 ALTER TABLE `estados` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fornecedores`
--

DROP TABLE IF EXISTS `fornecedores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fornecedores` (
  `codigo` bigint(20) NOT NULL AUTO_INCREMENT,
  `CNPJ` varchar(80) NOT NULL,
  `dataCadastro` date NOT NULL,
  `email` varchar(80) NOT NULL,
  `endereco` varchar(80) NOT NULL,
  `fone` varchar(30) NOT NULL,
  `ie` varchar(80) NOT NULL,
  `nome` varchar(80) NOT NULL,
  `responsavel` varchar(80) NOT NULL,
  `cidade_codigo` bigint(20) NOT NULL,
  `estado_codigo` bigint(20) NOT NULL,
  PRIMARY KEY (`codigo`),
  UNIQUE KEY `UK_ckvx71oosj4ujr1oaxt69c9kl` (`CNPJ`),
  UNIQUE KEY `UK_ebycufwthn6p3cbfav283uhvr` (`ie`),
  KEY `FK_1m7g8c1a9aq2ohfhapl1bqn4g` (`cidade_codigo`),
  KEY `FK_n3i3svntqp313pr4poou898jr` (`estado_codigo`),
  CONSTRAINT `FK_1m7g8c1a9aq2ohfhapl1bqn4g` FOREIGN KEY (`cidade_codigo`) REFERENCES `cidades` (`codigo`),
  CONSTRAINT `FK_n3i3svntqp313pr4poou898jr` FOREIGN KEY (`estado_codigo`) REFERENCES `estados` (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fornecedores`
--

LOCK TABLES `fornecedores` WRITE;
/*!40000 ALTER TABLE `fornecedores` DISABLE KEYS */;
/*!40000 ALTER TABLE `fornecedores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `frotas`
--

DROP TABLE IF EXISTS `frotas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `frotas` (
  `codigo` bigint(20) NOT NULL AUTO_INCREMENT,
  `dataCadastro` date NOT NULL,
  `nomeFrota` varchar(20) NOT NULL,
  `empresa_codigo` bigint(20) NOT NULL,
  `situacao_codigo` bigint(20) NOT NULL,
  PRIMARY KEY (`codigo`),
  UNIQUE KEY `UK_2rpmd9y3emgpj7itrhe9p8rry` (`nomeFrota`),
  KEY `FK_tm2jg52q67u48d8yhbjaxm79j` (`empresa_codigo`),
  KEY `FK_j6ammkp2968nxbhk0rfyil1t6` (`situacao_codigo`),
  CONSTRAINT `FK_j6ammkp2968nxbhk0rfyil1t6` FOREIGN KEY (`situacao_codigo`) REFERENCES `situacoes` (`codigo`),
  CONSTRAINT `FK_tm2jg52q67u48d8yhbjaxm79j` FOREIGN KEY (`empresa_codigo`) REFERENCES `empresas` (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `frotas`
--

LOCK TABLES `frotas` WRITE;
/*!40000 ALTER TABLE `frotas` DISABLE KEYS */;
/*!40000 ALTER TABLE `frotas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `funcao`
--

DROP TABLE IF EXISTS `funcao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `funcao` (
  `codigo` bigint(20) NOT NULL AUTO_INCREMENT,
  `codigoFuncao` varchar(20) NOT NULL,
  `nome` varchar(40) NOT NULL,
  PRIMARY KEY (`codigo`),
  UNIQUE KEY `UK_ki6670spvcit44t478n4ubkaq` (`codigoFuncao`),
  UNIQUE KEY `UK_5tuseq32wi3mrtgtlns0pvu5v` (`nome`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `funcao`
--

LOCK TABLES `funcao` WRITE;
/*!40000 ALTER TABLE `funcao` DISABLE KEYS */;
/*!40000 ALTER TABLE `funcao` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `funcionarios`
--

DROP TABLE IF EXISTS `funcionarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `funcionarios` (
  `codigo` bigint(20) NOT NULL AUTO_INCREMENT,
  `cpf` varchar(50) NOT NULL,
  `dataAdmissao` date NOT NULL,
  `dataDemissao` date DEFAULT NULL,
  `email` varchar(100) NOT NULL,
  `endereco` varchar(90) NOT NULL,
  `nome` varchar(80) NOT NULL,
  `obs` varchar(150) DEFAULT NULL,
  `pis` varchar(30) NOT NULL,
  `telefone` varchar(60) NOT NULL,
  `cidade_codigo` bigint(20) NOT NULL,
  `estado_codigo` bigint(20) NOT NULL,
  `funcao_codigo` bigint(20) NOT NULL,
  `situacao_codigo` bigint(20) NOT NULL,
  PRIMARY KEY (`codigo`),
  UNIQUE KEY `UK_8c4ljj9790y60nbe6vpue6a15` (`cpf`),
  UNIQUE KEY `UK_65vwfbkuvtdqwb98gyfecbf0q` (`pis`),
  KEY `FK_g7p4bs353x28sq9069xrwphe7` (`cidade_codigo`),
  KEY `FK_i9yje0t6e8i6lwnm184yagsb2` (`estado_codigo`),
  KEY `FK_16wd0iw30kod129xeugs1brjg` (`funcao_codigo`),
  KEY `FK_t0ukey4u7380lj0vs5gvudhap` (`situacao_codigo`),
  CONSTRAINT `FK_16wd0iw30kod129xeugs1brjg` FOREIGN KEY (`funcao_codigo`) REFERENCES `funcao` (`codigo`),
  CONSTRAINT `FK_g7p4bs353x28sq9069xrwphe7` FOREIGN KEY (`cidade_codigo`) REFERENCES `cidades` (`codigo`),
  CONSTRAINT `FK_i9yje0t6e8i6lwnm184yagsb2` FOREIGN KEY (`estado_codigo`) REFERENCES `estados` (`codigo`),
  CONSTRAINT `FK_t0ukey4u7380lj0vs5gvudhap` FOREIGN KEY (`situacao_codigo`) REFERENCES `situacoes` (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `funcionarios`
--

LOCK TABLES `funcionarios` WRITE;
/*!40000 ALTER TABLE `funcionarios` DISABLE KEYS */;
/*!40000 ALTER TABLE `funcionarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lancarmanutencoes`
--

DROP TABLE IF EXISTS `lancarmanutencoes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lancarmanutencoes` (
  `codigo` bigint(20) NOT NULL AUTO_INCREMENT,
  `data` date NOT NULL,
  `historico` varchar(100) NOT NULL,
  `obs` varchar(150) DEFAULT NULL,
  `valor` decimal(12,2) NOT NULL,
  `conta_codigo` bigint(20) NOT NULL,
  `documento_codigo` bigint(20) NOT NULL,
  `empresa_codigo` bigint(20) NOT NULL,
  `fornecedor_codigo` bigint(20) NOT NULL,
  `veiculo_codigo` bigint(20) NOT NULL,
  PRIMARY KEY (`codigo`),
  KEY `FK_2pbj33orii35aec6jvcbiapr7` (`conta_codigo`),
  KEY `FK_csj83j5ntw0v2kl503n0m7xxy` (`documento_codigo`),
  KEY `FK_qxysc8m7eccax4w6njf4jelc4` (`empresa_codigo`),
  KEY `FK_aqlptfo6ddjcfkjkbxdr6nsl2` (`fornecedor_codigo`),
  KEY `FK_opwhn16mxhujwxp7bo3reb78f` (`veiculo_codigo`),
  CONSTRAINT `FK_2pbj33orii35aec6jvcbiapr7` FOREIGN KEY (`conta_codigo`) REFERENCES `planocontas` (`codigo`),
  CONSTRAINT `FK_aqlptfo6ddjcfkjkbxdr6nsl2` FOREIGN KEY (`fornecedor_codigo`) REFERENCES `fornecedores` (`codigo`),
  CONSTRAINT `FK_csj83j5ntw0v2kl503n0m7xxy` FOREIGN KEY (`documento_codigo`) REFERENCES `documentos` (`codigo`),
  CONSTRAINT `FK_opwhn16mxhujwxp7bo3reb78f` FOREIGN KEY (`veiculo_codigo`) REFERENCES `veiculos` (`codigo`),
  CONSTRAINT `FK_qxysc8m7eccax4w6njf4jelc4` FOREIGN KEY (`empresa_codigo`) REFERENCES `empresas` (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lancarmanutencoes`
--

LOCK TABLES `lancarmanutencoes` WRITE;
/*!40000 ALTER TABLE `lancarmanutencoes` DISABLE KEYS */;
/*!40000 ALTER TABLE `lancarmanutencoes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lancarviagens`
--

DROP TABLE IF EXISTS `lancarviagens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lancarviagens` (
  `codigo` bigint(20) NOT NULL AUTO_INCREMENT,
  `crtc` varchar(40) NOT NULL,
  `data` date NOT NULL,
  `kmInicial` int(11) NOT NULL,
  `obs` varchar(150) DEFAULT NULL,
  `qtdeveiculos` int(11) NOT NULL,
  `status` varchar(20) DEFAULT NULL,
  `destino_codigo` bigint(20) NOT NULL,
  `empresa_codigo` bigint(20) NOT NULL,
  `frota_codigo` bigint(20) NOT NULL,
  `motorista_codigo` bigint(20) NOT NULL,
  `origem_codigo` bigint(20) NOT NULL,
  PRIMARY KEY (`codigo`),
  UNIQUE KEY `UK_74eadfcf7eybebl9isnter6xm` (`status`),
  KEY `FK_vmoiw2vk729vpaiy1mbqiddu` (`destino_codigo`),
  KEY `FK_6bmjdy748u31bj7h67t4sguoq` (`empresa_codigo`),
  KEY `FK_nwy4b86krnhbcqdmlpfrwecn4` (`frota_codigo`),
  KEY `FK_i9gvvojss1nphrrfh3keu7a0l` (`motorista_codigo`),
  KEY `FK_drkp8j09nsncparffe322twvv` (`origem_codigo`),
  CONSTRAINT `FK_6bmjdy748u31bj7h67t4sguoq` FOREIGN KEY (`empresa_codigo`) REFERENCES `empresas` (`codigo`),
  CONSTRAINT `FK_drkp8j09nsncparffe322twvv` FOREIGN KEY (`origem_codigo`) REFERENCES `origens` (`codigo`),
  CONSTRAINT `FK_i9gvvojss1nphrrfh3keu7a0l` FOREIGN KEY (`motorista_codigo`) REFERENCES `funcionarios` (`codigo`),
  CONSTRAINT `FK_nwy4b86krnhbcqdmlpfrwecn4` FOREIGN KEY (`frota_codigo`) REFERENCES `frotas` (`codigo`),
  CONSTRAINT `FK_vmoiw2vk729vpaiy1mbqiddu` FOREIGN KEY (`destino_codigo`) REFERENCES `origens` (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lancarviagens`
--

LOCK TABLES `lancarviagens` WRITE;
/*!40000 ALTER TABLE `lancarviagens` DISABLE KEYS */;
/*!40000 ALTER TABLE `lancarviagens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `origens`
--

DROP TABLE IF EXISTS `origens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `origens` (
  `codigo` bigint(20) NOT NULL AUTO_INCREMENT,
  `cidade_codigo` bigint(20) NOT NULL,
  `estado_codigo` bigint(20) NOT NULL,
  `pais_codigo` bigint(20) NOT NULL,
  PRIMARY KEY (`codigo`),
  KEY `FK_mbjrw7hv4b9i0m3ukqdif9gqa` (`cidade_codigo`),
  KEY `FK_geajla658970ywue87oo77aii` (`estado_codigo`),
  KEY `FK_bu0affxdts05bw39ktvb6wxfx` (`pais_codigo`),
  CONSTRAINT `FK_bu0affxdts05bw39ktvb6wxfx` FOREIGN KEY (`pais_codigo`) REFERENCES `paises` (`codigo`),
  CONSTRAINT `FK_geajla658970ywue87oo77aii` FOREIGN KEY (`estado_codigo`) REFERENCES `estados` (`codigo`),
  CONSTRAINT `FK_mbjrw7hv4b9i0m3ukqdif9gqa` FOREIGN KEY (`cidade_codigo`) REFERENCES `cidades` (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `origens`
--

LOCK TABLES `origens` WRITE;
/*!40000 ALTER TABLE `origens` DISABLE KEYS */;
/*!40000 ALTER TABLE `origens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `paises`
--

DROP TABLE IF EXISTS `paises`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `paises` (
  `codigo` bigint(20) NOT NULL AUTO_INCREMENT,
  `nome` varchar(50) NOT NULL,
  `sigla` varchar(2) NOT NULL,
  PRIMARY KEY (`codigo`),
  UNIQUE KEY `UK_kq9o8foal3am2q42i7yys5ycv` (`nome`),
  UNIQUE KEY `UK_5nqss02pq56tim4sts7e5y7gg` (`sigla`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `paises`
--

LOCK TABLES `paises` WRITE;
/*!40000 ALTER TABLE `paises` DISABLE KEYS */;
/*!40000 ALTER TABLE `paises` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `planocontas`
--

DROP TABLE IF EXISTS `planocontas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `planocontas` (
  `codigo` bigint(20) NOT NULL AUTO_INCREMENT,
  `conta` int(11) NOT NULL,
  `descricao` varchar(20) NOT NULL,
  `saldo` decimal(12,2) NOT NULL,
  `sigla` int(11) NOT NULL,
  `subconta` int(11) NOT NULL,
  `tipo` varchar(20) NOT NULL,
  PRIMARY KEY (`codigo`),
  UNIQUE KEY `UK_7yth8a1xm942540p0ge53ura7` (`conta`),
  UNIQUE KEY `UK_qnqr7vvg6rdp6x9me40omyiy3` (`descricao`),
  UNIQUE KEY `UK_3fjwc3mwpuf7ghb2f4hdsgj1j` (`sigla`),
  UNIQUE KEY `UK_nh4bpigmie99s6y5to5w6i17x` (`subconta`),
  UNIQUE KEY `UK_rut763y18da01jiom84btcurn` (`tipo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `planocontas`
--

LOCK TABLES `planocontas` WRITE;
/*!40000 ALTER TABLE `planocontas` DISABLE KEYS */;
/*!40000 ALTER TABLE `planocontas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `situacoes`
--

DROP TABLE IF EXISTS `situacoes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `situacoes` (
  `codigo` bigint(20) NOT NULL AUTO_INCREMENT,
  `tipoNome` varchar(20) NOT NULL,
  PRIMARY KEY (`codigo`),
  UNIQUE KEY `UK_fmgsbqmhq4nla2ua6r5gl1njo` (`tipoNome`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `situacoes`
--

LOCK TABLES `situacoes` WRITE;
/*!40000 ALTER TABLE `situacoes` DISABLE KEYS */;
/*!40000 ALTER TABLE `situacoes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipoveiculo`
--

DROP TABLE IF EXISTS `tipoveiculo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tipoveiculo` (
  `codigo` bigint(20) NOT NULL AUTO_INCREMENT,
  `especie` varchar(80) NOT NULL,
  `nome` varchar(80) NOT NULL,
  `tracao` varchar(80) NOT NULL,
  PRIMARY KEY (`codigo`),
  UNIQUE KEY `UK_fipln6im7baf31f8ehbp4eo85` (`especie`),
  UNIQUE KEY `UK_k31o8wemft4y085cwpd4yf6qf` (`nome`),
  UNIQUE KEY `UK_14waxjie5qa4xyigy173w8o5n` (`tracao`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipoveiculo`
--

LOCK TABLES `tipoveiculo` WRITE;
/*!40000 ALTER TABLE `tipoveiculo` DISABLE KEYS */;
/*!40000 ALTER TABLE `tipoveiculo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usuarios` (
  `codigo` bigint(20) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `veiculos`
--

DROP TABLE IF EXISTS `veiculos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `veiculos` (
  `codigo` bigint(20) NOT NULL AUTO_INCREMENT,
  `ano` date NOT NULL,
  `dataCompra` date NOT NULL,
  `dataFabricacao` date NOT NULL,
  `dataInicio` date NOT NULL,
  `kmInicial` int(11) NOT NULL,
  `marca` varchar(80) NOT NULL,
  `modelo` varchar(80) NOT NULL,
  `obs` varchar(150) DEFAULT NULL,
  `placas` varchar(80) NOT NULL,
  `renavam` int(11) NOT NULL,
  `tipoAquisicao` varchar(80) NOT NULL,
  `valor` decimal(12,2) NOT NULL,
  `empresa_codigo` bigint(20) NOT NULL,
  `frota_codigo` bigint(20) NOT NULL,
  `situacao_codigo` bigint(20) NOT NULL,
  `tipoVeiculo_codigo` bigint(20) NOT NULL,
  PRIMARY KEY (`codigo`),
  UNIQUE KEY `UK_1us6ndrx5385qdm58oba5hmcw` (`placas`),
  UNIQUE KEY `UK_dd27nuxsfww8495ok0hauw2y9` (`renavam`),
  KEY `FK_fd75av4c7t7sw9n9rpm851fpx` (`empresa_codigo`),
  KEY `FK_t6pgqiaiigxvnmedexhb46mc5` (`frota_codigo`),
  KEY `FK_anlml1ixi5s7rcwyukwj8fqe7` (`situacao_codigo`),
  KEY `FK_glluicf7509bmstyexc72g3y9` (`tipoVeiculo_codigo`),
  CONSTRAINT `FK_anlml1ixi5s7rcwyukwj8fqe7` FOREIGN KEY (`situacao_codigo`) REFERENCES `situacoes` (`codigo`),
  CONSTRAINT `FK_fd75av4c7t7sw9n9rpm851fpx` FOREIGN KEY (`empresa_codigo`) REFERENCES `empresas` (`codigo`),
  CONSTRAINT `FK_glluicf7509bmstyexc72g3y9` FOREIGN KEY (`tipoVeiculo_codigo`) REFERENCES `tipoveiculo` (`codigo`),
  CONSTRAINT `FK_t6pgqiaiigxvnmedexhb46mc5` FOREIGN KEY (`frota_codigo`) REFERENCES `frotas` (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `veiculos`
--

LOCK TABLES `veiculos` WRITE;
/*!40000 ALTER TABLE `veiculos` DISABLE KEYS */;
/*!40000 ALTER TABLE `veiculos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'siga_transportes'
--

--
-- Dumping routines for database 'siga_transportes'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-11-13  9:56:08
