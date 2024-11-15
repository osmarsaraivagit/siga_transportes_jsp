-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 14/06/2024 às 12:42
-- Versão do servidor: 10.4.32-MariaDB
-- Versão do PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `siga_transportes`
--

-- --------------------------------------------------------

--
-- Estrutura para tabela `acertos_viagens`
--

CREATE TABLE `acertos_viagens` (
  `id` int(20) NOT NULL,
  `fk_lancar_viagens_id` bigint(20) NOT NULL,
  `creditar` decimal(10,2) NOT NULL,
  `debitar` decimal(10,2) NOT NULL,
  `historico` varchar(100) NOT NULL,
  `fk_plano_contas_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Estrutura para tabela `clientes`
--

CREATE TABLE `clientes` (
  `id` bigint(20) NOT NULL,
  `nome` varchar(80) NOT NULL,
  `CNPJ` varchar(60) NOT NULL,
  `ie` varchar(60) NOT NULL,
  `email` varchar(100) NOT NULL,
  `endereco` varchar(80) NOT NULL,
  `telefone` varchar(60) NOT NULL,
  `data_cadastro` date NOT NULL,
  `fk_cidades_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Despejando dados para a tabela `clientes`
--

INSERT INTO `clientes` (`id`, `nome`, `CNPJ`, `ie`, `email`, `endereco`, `telefone`, `data_cadastro`, `fk_cidades_id`) VALUES
(37, 'SADA TRANSPORTES LTDA', '11.111.111/1111-11', '1111111111111', 'sada@gmail.com', 'FIAT', '(31) 65678-7894', '2023-10-21', 44);

-- --------------------------------------------------------

--
-- Estrutura para tabela `documentos`
--

CREATE TABLE `documentos` (
  `id` bigint(20) NOT NULL,
  `nome_doc` varchar(80) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Despejando dados para a tabela `documentos`
--

INSERT INTO `documentos` (`id`, `nome_doc`) VALUES
(1, 'Cupom Fiscal'),
(4, 'Nota Fiscal'),
(5, 'Recibo'),
(7, 'PIX3'),
(8, 'CRLV'),
(9, 'PERMISSO');

-- --------------------------------------------------------

--
-- Estrutura para tabela `doc_veiculos`
--

CREATE TABLE `doc_veiculos` (
  `id` int(11) NOT NULL,
  `nome_doc` varchar(60) NOT NULL,
  `data_realizado` date NOT NULL,
  `data_vencimento` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Estrutura para tabela `empresas`
--

CREATE TABLE `empresas` (
  `id` bigint(20) NOT NULL,
  `nome` varchar(80) NOT NULL,
  `CNPJ` varchar(80) NOT NULL,
  `ie` varchar(80) NOT NULL,
  `email` varchar(80) NOT NULL,
  `endereco` varchar(100) NOT NULL,
  `fk_cidades_id` bigint(20) NOT NULL,
  `fone` varchar(30) NOT NULL,
  `responsavel` varchar(80) NOT NULL,
  `data_inicio` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Despejando dados para a tabela `empresas`
--

INSERT INTO `empresas` (`id`, `nome`, `CNPJ`, `ie`, `email`, `endereco`, `fk_cidades_id`, `fone`, `responsavel`, `data_inicio`) VALUES
(1, 'fsdfs', '23.131', '312312', 'FSDF@FAFAS', '321312', 43, '321321312312', '312321', '2023-10-25'),
(2, 'Gloria Transportes', '03.252.789/0001-66', '1247917891254', 'gloria.transportes@yahoo.com', 'Rua 1', 43, '31356565', 'Teste1', '1989-08-28');

-- --------------------------------------------------------

--
-- Estrutura para tabela `exames`
--

CREATE TABLE `exames` (
  `id` int(11) NOT NULL,
  `nome_exame` varchar(60) NOT NULL,
  `cid` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Despejando dados para a tabela `exames`
--

INSERT INTO `exames` (`id`, `nome_exame`, `cid`) VALUES
(1, 'Admissional', '0'),
(3, 'Demissional', NULL);

-- --------------------------------------------------------

--
-- Estrutura para tabela `fornecedores`
--

CREATE TABLE `fornecedores` (
  `id` bigint(20) NOT NULL,
  `nome` varchar(80) NOT NULL,
  `CNPJ` varchar(80) NOT NULL,
  `ie` varchar(80) NOT NULL,
  `email` varchar(80) NOT NULL,
  `endereco` varchar(80) NOT NULL,
  `fone` varchar(30) NOT NULL,
  `responsavel` varchar(80) NOT NULL,
  `data_cadastro` date NOT NULL,
  `fk_cidades_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Despejando dados para a tabela `fornecedores`
--

INSERT INTO `fornecedores` (`id`, `nome`, `CNPJ`, `ie`, `email`, `endereco`, `fone`, `responsavel`, `data_cadastro`, `fk_cidades_id`) VALUES
(2, 'GW Pneus editado', '11.111.111/1111-11', '211111111123', 'FSDF@FAFAS', 'dasd2121', '1231232', 'fdsafas', '2023-09-24', 43);

-- --------------------------------------------------------

--
-- Estrutura para tabela `frotas`
--

CREATE TABLE `frotas` (
  `id` bigint(20) NOT NULL,
  `nome_frota` varchar(20) NOT NULL,
  `fk_empresas_id` bigint(20) NOT NULL,
  `fk_situacoes_id` bigint(20) NOT NULL,
  `data_cadastro` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Despejando dados para a tabela `frotas`
--

INSERT INTO `frotas` (`id`, `nome_frota`, `fk_empresas_id`, `fk_situacoes_id`, `data_cadastro`) VALUES
(2, 'F2254', 2, 6, '2024-03-17'),
(3, 'F2212', 1, 6, '2024-03-31');

-- --------------------------------------------------------

--
-- Estrutura para tabela `funcionarios`
--

CREATE TABLE `funcionarios` (
  `id` bigint(20) NOT NULL,
  `nome` varchar(80) NOT NULL,
  `fk_empresa_id` bigint(20) NOT NULL,
  `CPF` varchar(50) NOT NULL,
  `PIS` varchar(30) NOT NULL,
  `data_admissao` date NOT NULL,
  `email` varchar(100) NOT NULL,
  `endereco` varchar(90) NOT NULL,
  `fk_funcao_id` bigint(20) NOT NULL,
  `telefone` varchar(60) NOT NULL,
  `salario` decimal(10,2) NOT NULL,
  `fk_cidades_id` bigint(20) NOT NULL,
  `fk_situacoes_id` bigint(20) NOT NULL,
  `data_cadastro` date NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Despejando dados para a tabela `funcionarios`
--

INSERT INTO `funcionarios` (`id`, `nome`, `fk_empresa_id`, `CPF`, `PIS`, `data_admissao`, `email`, `endereco`, `fk_funcao_id`, `telefone`, `salario`, `fk_cidades_id`, `fk_situacoes_id`, `data_cadastro`) VALUES
(4, 'Teste edt', 2, '132.434.242-34', '423423423', '2024-03-17', '12fsaf@ga.com', 'Rua teste, 45, Guarjo,', 3, '(42) 34234-0000', 3154.58, 44, 6, '2024-03-17'),
(5, 'Fulano', 2, '123.232.32', '2131', '2024-03-17', 'oit@fas.com', 'Rua oese tres carmos, Bairro Centro. CEP:354871-000', 3, '(32) 13423-423', 3568.87, 44, 6, '2024-03-17');

-- --------------------------------------------------------

--
-- Estrutura para tabela `funcoes`
--

CREATE TABLE `funcoes` (
  `id` bigint(20) NOT NULL,
  `nome` varchar(60) NOT NULL,
  `codigo` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Despejando dados para a tabela `funcoes`
--

INSERT INTO `funcoes` (`id`, `nome`, `codigo`) VALUES
(1, 'Cegonheiro', '2342'),
(3, 'Soldador', '48757'),
(5, 'Motorista', 'q12321');

-- --------------------------------------------------------

--
-- Estrutura para tabela `lancar_baixa_veiculos`
--

CREATE TABLE `lancar_baixa_veiculos` (
  `id` bigint(20) NOT NULL,
  `fk_veiculos_id` bigint(20) NOT NULL,
  `data_venda` date NOT NULL,
  `km_final` int(11) NOT NULL,
  `comprador` varchar(60) NOT NULL,
  `fone_comprador` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Estrutura para tabela `lancar_contabilidade`
--

CREATE TABLE `lancar_contabilidade` (
  `id` bigint(20) NOT NULL,
  `data` date NOT NULL,
  `debitar` decimal(10,2) NOT NULL,
  `creditar` decimal(10,2) NOT NULL,
  `historico` varchar(100) NOT NULL,
  `fk_plano_contas_id` bigint(20) NOT NULL,
  `fk_documento_id` bigint(20) NOT NULL,
  `fk_empresa_id` bigint(20) NOT NULL,
  `fk_fornecedor_id` bigint(20) NOT NULL,
  `fk_veiculos_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Estrutura para tabela `lancar_ferias`
--

CREATE TABLE `lancar_ferias` (
  `id` int(20) NOT NULL,
  `fk_funiconarios_id` bigint(20) NOT NULL,
  `data_inicio` date NOT NULL,
  `data_fim` date NOT NULL,
  `ano_referente` date NOT NULL,
  `valor` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Estrutura para tabela `lancar_financeiro_viagens`
--

CREATE TABLE `lancar_financeiro_viagens` (
  `id` bigint(20) NOT NULL,
  `fk_lancar_viagens_id` bigint(20) NOT NULL,
  `creditar` decimal(8,2) NOT NULL,
  `debitar` decimal(8,2) NOT NULL,
  `historico` varchar(100) NOT NULL,
  `fk_plano_contas_id` bigint(20) NOT NULL,
  `fk_documento_id` bigint(20) NOT NULL,
  `fk_fornecedor_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Estrutura para tabela `lancar_viagens`
--

CREATE TABLE `lancar_viagens` (
  `id` bigint(20) NOT NULL,
  `crtc` varchar(30) NOT NULL,
  `data` date NOT NULL,
  `fk_frota_id` bigint(20) NOT NULL,
  `fk_motorista_id` bigint(20) NOT NULL,
  `fk_origem_id` bigint(20) NOT NULL,
  `fk_destino_id` bigint(20) NOT NULL,
  `kmInicial` int(11) NOT NULL,
  `kmFinal` int(11) NOT NULL,
  `kmTotal` bigint(30) NOT NULL,
  `litragem` double NOT NULL,
  `qtdeveiculos` int(11) NOT NULL,
  `fk_empresa_id` bigint(20) NOT NULL,
  `obs` varchar(100) NOT NULL,
  `status` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Estrutura para tabela `localidades`
--

CREATE TABLE `localidades` (
  `id` bigint(20) NOT NULL,
  `cidade` varchar(50) NOT NULL,
  `estado` varchar(2) NOT NULL,
  `pais` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Despejando dados para a tabela `localidades`
--

INSERT INTO `localidades` (`id`, `cidade`, `estado`, `pais`) VALUES
(43, 'Betim', 'MG', 'Brasil'),
(44, 'BELO HORIZONTE', 'MG', 'BRASIL');

-- --------------------------------------------------------

--
-- Estrutura para tabela `plano_contas`
--

CREATE TABLE `plano_contas` (
  `id` bigint(20) NOT NULL,
  `tipo` varchar(20) NOT NULL,
  `conta` int(11) NOT NULL,
  `descricao` varchar(20) NOT NULL,
  `sigla_situacao` char(1) NOT NULL,
  `saldo` decimal(11,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Despejando dados para a tabela `plano_contas`
--

INSERT INTO `plano_contas` (`id`, `tipo`, `conta`, `descricao`, `sigla_situacao`, `saldo`) VALUES
(6, '1-ATIVO', 11, 'CAIXA', 'D', 0.00),
(7, '1-ATIVO', 12, 'CONTAS A RECEBER', 'D', 0.00),
(8, '1-ATIVO', 13, 'ESTOQUE', 'D', 10.15),
(9, '1-ATIVO', 15, 'BANCOS', 'D', 50.00),
(10, '2-PASSIVO', 20, 'CONTAS A PAGAR', 'C', 54.00),
(11, '3-DESPESAS', 30, 'ENERGIA ELÉTRICA', 'D', 6400.00);

-- --------------------------------------------------------

--
-- Estrutura para tabela `situacoes`
--

CREATE TABLE `situacoes` (
  `id` bigint(20) NOT NULL,
  `tipo_nome` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Despejando dados para a tabela `situacoes`
--

INSERT INTO `situacoes` (`id`, `tipo_nome`) VALUES
(5, 'APOSENTADO'),
(6, 'ATIVO'),
(7, 'DEMITIDO'),
(8, 'LICENÇA');

-- --------------------------------------------------------

--
-- Estrutura para tabela `tipos_niveis`
--

CREATE TABLE `tipos_niveis` (
  `id` bigint(20) NOT NULL,
  `nome_nivel` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Despejando dados para a tabela `tipos_niveis`
--

INSERT INTO `tipos_niveis` (`id`, `nome_nivel`) VALUES
(1, 'admin'),
(2, 'manutenção'),
(5, 'multas'),
(6, 'financeiro'),
(7, 'viagens'),
(9, 'pessoal');

-- --------------------------------------------------------

--
-- Estrutura para tabela `tipos_veiculos`
--

CREATE TABLE `tipos_veiculos` (
  `id` bigint(20) NOT NULL,
  `tipo_de_veiculo` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Despejando dados para a tabela `tipos_veiculos`
--

INSERT INTO `tipos_veiculos` (`id`, `tipo_de_veiculo`) VALUES
(2, 'Caminhão'),
(1, 'Pickup');

-- --------------------------------------------------------

--
-- Estrutura para tabela `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `nome` varchar(60) NOT NULL,
  `cpf` varchar(20) NOT NULL,
  `usuario` varchar(50) NOT NULL,
  `senha` varchar(255) NOT NULL,
  `fk_id_nivel` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Despejando dados para a tabela `usuarios`
--

INSERT INTO `usuarios` (`id`, `nome`, `cpf`, `usuario`, `senha`, `fk_id_nivel`) VALUES
(8, 'JR', '000.000.000-00', 'admin@admin.com', '123', 1),
(12, 'Jr Manutenção', '213.1', 'osmar.saraiva@gmail.com', '123', 2),
(13, 'Osmar', '030.834.156-1', 'admin@admin.com', '123', 2);

-- --------------------------------------------------------

--
-- Estrutura para tabela `veiculos`
--

CREATE TABLE `veiculos` (
  `id` bigint(20) NOT NULL,
  `fk_tipo_veiculo_id` bigint(20) NOT NULL,
  `marca` varchar(80) NOT NULL,
  `modelo` varchar(80) NOT NULL,
  `ano_modelo` int(4) NOT NULL,
  `ano_fabricacao` int(4) NOT NULL,
  `renavam` int(20) NOT NULL,
  `placas` varchar(80) NOT NULL,
  `dataCompra` date NOT NULL,
  `fk_empresas_id` bigint(20) NOT NULL,
  `fk_frota_id` bigint(20) NOT NULL,
  `tipo_aquisicao` varchar(50) NOT NULL,
  `km_inicial` int(11) NOT NULL,
  `valor` decimal(10,2) NOT NULL,
  `data_emplacamento` date NOT NULL,
  `fk_situacoes_id` bigint(20) NOT NULL,
  `obs` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Despejando dados para a tabela `veiculos`
--

INSERT INTO `veiculos` (`id`, `fk_tipo_veiculo_id`, `marca`, `modelo`, `ano_modelo`, `ano_fabricacao`, `renavam`, `placas`, `dataCompra`, `fk_empresas_id`, `fk_frota_id`, `tipo_aquisicao`, `km_inicial`, `valor`, `data_emplacamento`, `fk_situacoes_id`, `obs`) VALUES
(22, 2, 'Scania', '21dasdateste', 2001, 124, 32432, 'hfdsa154', '2024-03-17', 2, 2, '2312', 1321, 321312.24, '2024-03-12', 6, '321321'),
(23, 2, 'fdsa', 'fdsfas', 2019, 2020, 1321, '32132132', '2024-03-17', 2, 2, 'fsaf21teste', 32132121, 215400.00, '2024-03-17', 6, '321321');

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `acertos_viagens`
--
ALTER TABLE `acertos_viagens`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_lancar_viagens_id_acerto` (`fk_lancar_viagens_id`),
  ADD KEY `fk_plano_contas_id_acerto` (`fk_plano_contas_id`);

--
-- Índices de tabela `clientes`
--
ALTER TABLE `clientes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_cidades_id` (`fk_cidades_id`);

--
-- Índices de tabela `documentos`
--
ALTER TABLE `documentos`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `doc_veiculos`
--
ALTER TABLE `doc_veiculos`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `empresas`
--
ALTER TABLE `empresas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_cidade` (`fk_cidades_id`);

--
-- Índices de tabela `exames`
--
ALTER TABLE `exames`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `fornecedores`
--
ALTER TABLE `fornecedores`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_cidades` (`fk_cidades_id`);

--
-- Índices de tabela `frotas`
--
ALTER TABLE `frotas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `situcao_fk` (`fk_situacoes_id`),
  ADD KEY `fk_empresas` (`fk_empresas_id`);

--
-- Índices de tabela `funcionarios`
--
ALTER TABLE `funcionarios`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_g7p4bs353x28sq9069xrwphe7` (`fk_cidades_id`),
  ADD KEY `FK_t0ukey4u7380lj0vs5gvudhap` (`fk_situacoes_id`),
  ADD KEY `fk_empresa_id` (`fk_empresa_id`),
  ADD KEY `fk_funcao_id` (`fk_funcao_id`);

--
-- Índices de tabela `funcoes`
--
ALTER TABLE `funcoes`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `lancar_baixa_veiculos`
--
ALTER TABLE `lancar_baixa_veiculos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_veiculos_id` (`fk_veiculos_id`);

--
-- Índices de tabela `lancar_contabilidade`
--
ALTER TABLE `lancar_contabilidade`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_dy6uec0ucvvq1eniwyk4fltiy` (`fk_plano_contas_id`),
  ADD KEY `FK_p3afl2c4etqqj1kbawusk2ypt` (`fk_documento_id`),
  ADD KEY `FK_cskm7ts2fpctppnbkr8paqut9` (`fk_empresa_id`),
  ADD KEY `FK_3bim69q3srfcw7r38ymii6hw7` (`fk_fornecedor_id`),
  ADD KEY `fk_veiculos_id_conta` (`fk_veiculos_id`);

--
-- Índices de tabela `lancar_ferias`
--
ALTER TABLE `lancar_ferias`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `lancar_financeiro_viagens`
--
ALTER TABLE `lancar_financeiro_viagens`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_fornecedor_id` (`fk_fornecedor_id`),
  ADD KEY `fK_documento_id` (`fk_documento_id`),
  ADD KEY `fk_lancar_viagens_id` (`fk_lancar_viagens_id`),
  ADD KEY `fk_plano_contas_id` (`fk_plano_contas_id`);

--
-- Índices de tabela `lancar_viagens`
--
ALTER TABLE `lancar_viagens`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_vmoiw2vk729vpaiy1mbqiddu` (`fk_destino_id`),
  ADD KEY `FK_6bmjdy748u31bj7h67t4sguoq` (`fk_empresa_id`),
  ADD KEY `FK_nwy4b86krnhbcqdmlpfrwecn4` (`fk_frota_id`),
  ADD KEY `FK_i9gvvojss1nphrrfh3keu7a0l` (`fk_motorista_id`),
  ADD KEY `FK_drkp8j09nsncparffe322twvv` (`fk_origem_id`);

--
-- Índices de tabela `localidades`
--
ALTER TABLE `localidades`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `plano_contas`
--
ALTER TABLE `plano_contas`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `situacoes`
--
ALTER TABLE `situacoes`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `tipos_niveis`
--
ALTER TABLE `tipos_niveis`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `tipos_veiculos`
--
ALTER TABLE `tipos_veiculos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_qvxlhmubifx9m0egeyca0j0fh` (`tipo_de_veiculo`);

--
-- Índices de tabela `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_id_nivel` (`fk_id_nivel`);

--
-- Índices de tabela `veiculos`
--
ALTER TABLE `veiculos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_empresas_id` (`fk_empresas_id`),
  ADD KEY `fk_frota_id` (`fk_frota_id`),
  ADD KEY `fk_situaçoes_id` (`fk_situacoes_id`),
  ADD KEY `fk_tipo_veiculo_id` (`fk_tipo_veiculo_id`);

--
-- AUTO_INCREMENT para tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `acertos_viagens`
--
ALTER TABLE `acertos_viagens`
  MODIFY `id` int(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `clientes`
--
ALTER TABLE `clientes`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- AUTO_INCREMENT de tabela `documentos`
--
ALTER TABLE `documentos`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de tabela `doc_veiculos`
--
ALTER TABLE `doc_veiculos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `empresas`
--
ALTER TABLE `empresas`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de tabela `exames`
--
ALTER TABLE `exames`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de tabela `fornecedores`
--
ALTER TABLE `fornecedores`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de tabela `frotas`
--
ALTER TABLE `frotas`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de tabela `funcionarios`
--
ALTER TABLE `funcionarios`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de tabela `funcoes`
--
ALTER TABLE `funcoes`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de tabela `lancar_baixa_veiculos`
--
ALTER TABLE `lancar_baixa_veiculos`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `lancar_contabilidade`
--
ALTER TABLE `lancar_contabilidade`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `lancar_ferias`
--
ALTER TABLE `lancar_ferias`
  MODIFY `id` int(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `lancar_financeiro_viagens`
--
ALTER TABLE `lancar_financeiro_viagens`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `lancar_viagens`
--
ALTER TABLE `lancar_viagens`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `localidades`
--
ALTER TABLE `localidades`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=45;

--
-- AUTO_INCREMENT de tabela `plano_contas`
--
ALTER TABLE `plano_contas`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de tabela `situacoes`
--
ALTER TABLE `situacoes`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de tabela `tipos_niveis`
--
ALTER TABLE `tipos_niveis`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de tabela `tipos_veiculos`
--
ALTER TABLE `tipos_veiculos`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de tabela `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT de tabela `veiculos`
--
ALTER TABLE `veiculos`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- Restrições para tabelas despejadas
--

--
-- Restrições para tabelas `acertos_viagens`
--
ALTER TABLE `acertos_viagens`
  ADD CONSTRAINT `fk_lancar_viagens_id_acerto` FOREIGN KEY (`fk_lancar_viagens_id`) REFERENCES `lancar_viagens` (`id`),
  ADD CONSTRAINT `fk_plano_contas_id_acerto` FOREIGN KEY (`fk_plano_contas_id`) REFERENCES `plano_contas` (`id`);

--
-- Restrições para tabelas `clientes`
--
ALTER TABLE `clientes`
  ADD CONSTRAINT `fk_cidades_id` FOREIGN KEY (`fk_cidades_id`) REFERENCES `localidades` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Restrições para tabelas `empresas`
--
ALTER TABLE `empresas`
  ADD CONSTRAINT `fk_cidade` FOREIGN KEY (`fk_cidades_id`) REFERENCES `localidades` (`id`);

--
-- Restrições para tabelas `fornecedores`
--
ALTER TABLE `fornecedores`
  ADD CONSTRAINT `fk_cidades` FOREIGN KEY (`fk_cidades_id`) REFERENCES `localidades` (`id`);

--
-- Restrições para tabelas `frotas`
--
ALTER TABLE `frotas`
  ADD CONSTRAINT `fk_empresas` FOREIGN KEY (`fk_empresas_id`) REFERENCES `empresas` (`id`),
  ADD CONSTRAINT `situcao_fk` FOREIGN KEY (`fk_situacoes_id`) REFERENCES `situacoes` (`id`);

--
-- Restrições para tabelas `funcionarios`
--
ALTER TABLE `funcionarios`
  ADD CONSTRAINT `FK_g7p4bs353x28sq9069xrwphe7` FOREIGN KEY (`fk_cidades_id`) REFERENCES `localidades` (`id`),
  ADD CONSTRAINT `FK_t0ukey4u7380lj0vs5gvudhap` FOREIGN KEY (`fk_situacoes_id`) REFERENCES `situacoes` (`id`),
  ADD CONSTRAINT `fk_empresa_id` FOREIGN KEY (`fk_empresa_id`) REFERENCES `empresas` (`id`),
  ADD CONSTRAINT `fk_funcao_id` FOREIGN KEY (`fk_funcao_id`) REFERENCES `funcoes` (`id`);

--
-- Restrições para tabelas `lancar_baixa_veiculos`
--
ALTER TABLE `lancar_baixa_veiculos`
  ADD CONSTRAINT `fk_veiculos_id` FOREIGN KEY (`fk_veiculos_id`) REFERENCES `veiculos` (`id`);

--
-- Restrições para tabelas `lancar_contabilidade`
--
ALTER TABLE `lancar_contabilidade`
  ADD CONSTRAINT `FK_3bim69q3srfcw7r38ymii6hw7` FOREIGN KEY (`fk_fornecedor_id`) REFERENCES `fornecedores` (`id`),
  ADD CONSTRAINT `FK_cskm7ts2fpctppnbkr8paqut9` FOREIGN KEY (`fk_empresa_id`) REFERENCES `empresas` (`id`),
  ADD CONSTRAINT `FK_dy6uec0ucvvq1eniwyk4fltiy` FOREIGN KEY (`fk_plano_contas_id`) REFERENCES `plano_contas` (`id`),
  ADD CONSTRAINT `FK_p3afl2c4etqqj1kbawusk2ypt` FOREIGN KEY (`fk_documento_id`) REFERENCES `documentos` (`id`),
  ADD CONSTRAINT `fk_veiculos_id_conta` FOREIGN KEY (`fk_veiculos_id`) REFERENCES `veiculos` (`id`);

--
-- Restrições para tabelas `lancar_financeiro_viagens`
--
ALTER TABLE `lancar_financeiro_viagens`
  ADD CONSTRAINT `fK_documento_id` FOREIGN KEY (`fk_documento_id`) REFERENCES `documentos` (`id`),
  ADD CONSTRAINT `fk_fornecedor_id` FOREIGN KEY (`fk_fornecedor_id`) REFERENCES `fornecedores` (`id`),
  ADD CONSTRAINT `fk_lancar_viagens_id` FOREIGN KEY (`fk_lancar_viagens_id`) REFERENCES `lancar_viagens` (`id`),
  ADD CONSTRAINT `fk_plano_contas_id` FOREIGN KEY (`fk_plano_contas_id`) REFERENCES `plano_contas` (`id`);

--
-- Restrições para tabelas `lancar_viagens`
--
ALTER TABLE `lancar_viagens`
  ADD CONSTRAINT `FK_6bmjdy748u31bj7h67t4sguoq` FOREIGN KEY (`fk_empresa_id`) REFERENCES `empresas` (`id`),
  ADD CONSTRAINT `FK_i9gvvojss1nphrrfh3keu7a0l` FOREIGN KEY (`fk_motorista_id`) REFERENCES `funcionarios` (`id`),
  ADD CONSTRAINT `FK_nwy4b86krnhbcqdmlpfrwecn4` FOREIGN KEY (`fk_frota_id`) REFERENCES `frotas` (`id`);

--
-- Restrições para tabelas `usuarios`
--
ALTER TABLE `usuarios`
  ADD CONSTRAINT `fk_id_nivel` FOREIGN KEY (`fk_id_nivel`) REFERENCES `tipos_niveis` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Restrições para tabelas `veiculos`
--
ALTER TABLE `veiculos`
  ADD CONSTRAINT `fk_empresas_id` FOREIGN KEY (`fk_empresas_id`) REFERENCES `empresas` (`id`),
  ADD CONSTRAINT `fk_frota_id` FOREIGN KEY (`fk_frota_id`) REFERENCES `frotas` (`id`),
  ADD CONSTRAINT `fk_situaçoes_id` FOREIGN KEY (`fk_situacoes_id`) REFERENCES `situacoes` (`id`),
  ADD CONSTRAINT `fk_tipo_veiculo_id` FOREIGN KEY (`fk_tipo_veiculo_id`) REFERENCES `tipos_veiculos` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
