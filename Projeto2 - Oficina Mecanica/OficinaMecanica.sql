CREATE DATABASE IF NOT EXISTS oficina;
use oficina;

-- cliente
DROP TABLE IF EXISTS cliente;
CREATE TABLE cliente (
		  idCliente int NOT NULL AUTO_INCREMENT,
		  Nome varchar(45) NOT NULL,
		  CPF varchar(9) NOT NULL,
		  PRIMARY KEY (idCliente),
		  UNIQUE KEY CPF_UNIQUE (CPF)
); 

INSERT INTO cliente VALUES (3,'Maria',123456789),(4,'Leo',987654321);

-- carro
DROP TABLE IF EXISTS carro;
CREATE TABLE carro (
		  idCarro int NOT NULL AUTO_INCREMENT,
		  Placa varchar(45) NOT NULL,
		  Modelo varchar(45) NOT NULL,
		  Marca varchar(45) NOT NULL,
		  IdCliente int NOT NULL,
		  PRIMARY KEY (idCarro),
		  UNIQUE KEY Placa_UNIQUE (Placa),
		  KEY IdCliente_idx (IdCliente),
		  CONSTRAINT IdCliente FOREIGN KEY (IdCliente) REFERENCES cliente (idCliente)
); 

INSERT INTO carro VALUES (1,'QRE-1444','LOGAN','RENAULT',3),(2,'ETW-5281','PALIO','FIAT',4);

-- equipe
DROP TABLE IF EXISTS equipe;
CREATE TABLE equipe (
		  idEquipe int NOT NULL AUTO_INCREMENT,
		  Descricao varchar(45) NOT NULL,
		  PRIMARY KEY (idEquipe)
); 

INSERT INTO equipe VALUES (1,'TROCA PNEUS'),(2,'TROCA OLEO');

-- funcionario
CREATE TABLE funcionario (
		  idFuncionario int NOT NULL AUTO_INCREMENT,
		  Nome varchar(45) NOT NULL,
		  Endereco varchar(45) NOT NULL,
		  Especialidade varchar(45) NOT NULL,
		  IdEquipe int NOT NULL,
		  PRIMARY KEY (idFuncionario),
		  KEY IdEquipe_idx (IdEquipe),
		  CONSTRAINT IdEq FOREIGN KEY (IdEquipe) REFERENCES equipe (idEquipe)
); 

INSERT INTO funcionario VALUES (1,'VICTOR','CAMPO GRANDE - RJ','MECANICO',1),(2,'MARIA','REALENGO - RJ','MECANICO',2),(3,'JOSUÉ','BANGU - RJ','MECANICO',1),(4,'GABRIEL','PACIENCIA - RJ','MECANICO',2);

-- OS
DROP TABLE IF EXISTS ordem_servico;
CREATE TABLE ordem_servico (
		  idOrdem_Servico int NOT NULL AUTO_INCREMENT,
		  DataEmissao datetime NOT NULL,
		  DataConclusao datetime NOT NULL,
		  Satuts enum('Aguardando','Aprovado','Reprovada') NOT NULL DEFAULT 'Aguardando',
		  IdCarro int NOT NULL,
		  IdEquipe int DEFAULT NULL,
		  PRIMARY KEY (idOrdem_Servico),
		  KEY IdCarro_idx (IdCarro),
		  KEY IdEquipe_idx (IdEquipe),
		  CONSTRAINT IdCarro FOREIGN KEY (IdCarro) REFERENCES carro (idCarro),
		  CONSTRAINT IdEquipe FOREIGN KEY (IdEquipe) REFERENCES equipe (idEquipe)
) ;


INSERT INTO ordem_servico 
VALUES (2,'2023-11-11 00:00:00','2023-11-15 00:00:00','Aguardando',1,1),(3,'2023-11-23 00:00:00','2022-11-25 00:00:00','Aguardando',2,2);

-- peças
DROP TABLE IF EXISTS pecas;
CREATE TABLE pecas (
		  idPecas int NOT NULL AUTO_INCREMENT,
		  Descricao varchar(45) NOT NULL,
		  Valor float NOT NULL,
		  PRIMARY KEY (idPecas)
); 

INSERT INTO pecas VALUES (1,'Pneu',80.0),(2,'Oleo',20.0);

-- peças utilizadas
DROP TABLE IF EXISTS pecasutilizadas;
CREATE TABLE pecasutilizadas (
	  idPecasUtilizadas int NOT NULL AUTO_INCREMENT,
	  Qtd INT NOT NULL DEFAULT 1,
	  IdPecas int DEFAULT NULL,
	  IdOS int DEFAULT NULL,
	  PRIMARY KEY (idPecasUtilizadas),
	  KEY IdPecas_idx (IdPecas),
	  KEY IdOS_idx (IdOS),
	  CONSTRAINT IdOS FOREIGN KEY (IdOS) REFERENCES ordem_servico (idOrdem_Servico),
	  CONSTRAINT IdPecas FOREIGN KEY (IdPecas) REFERENCES pecas (idPecas)
); 

INSERT INTO pecasutilizadas VALUES (3,4,1,2),(4,2,2,3);


-- serviços
DROP TABLE IF EXISTS servicos;
CREATE TABLE servicos (
		  idServicos int NOT NULL AUTO_INCREMENT,
		  Descricao varchar(45) NOT NULL,
		  Valor float NOT NULL,
		  PRIMARY KEY (idServicos)
); 

INSERT INTO servicos VALUES (1,'Troca Pneu',100),(2,'Troca Oleo',50);

-- serviço realizado
DROP TABLE IF EXISTS servicorealizado;
CREATE TABLE servicorealizado (
		  idServicoRealizado int NOT NULL AUTO_INCREMENT,
		  IdServico int NOT NULL,
		  IdOS int NOT NULL,
		  PRIMARY KEY (idServicoRealizado),
		  KEY IdServico_idx (IdServico),
		  KEY IdOSs_idx (IdOS),
		  CONSTRAINT IdOSs FOREIGN KEY (IdOS) REFERENCES servicos (idServicos),
		  CONSTRAINT IdServico FOREIGN KEY (IdServico) REFERENCES servicos (idServicos)
); 

INSERT INTO servicorealizado VALUES (1,1,1),(2,2,2);

