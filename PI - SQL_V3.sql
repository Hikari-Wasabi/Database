CREATE DATABASE wasabi_db;

USE wasabi_db;

CREATE TABLE `contato_inicial`(
`idcontato_inicial` INT PRIMARY KEY,
`email` VARCHAR(100),
`pais` VARCHAR(50),
`mensagem` VARCHAR(500),
`data_envio` DATE);

CREATE TABLE `empresa`(
`idempresa` INT PRIMARY KEY AUTO_INCREMENT,
`token` CHAR(24) NOT NULL,
`dt_cadastro` DATE NOT NULL,
`nome` VARCHAR(100) NOT NULL,
`cnpj_global` VARCHAR(40) NOT NULL,
`email` VARCHAR(100) NOT NULL,
`tel_celular` VARCHAR(15) NOT NULL,
`tel_residencial` VARCHAR(10) ,
`senha` VARCHAR(255) NOT NULL);

CREATE TABLE `endereco`(
`idendereco` INT PRIMARY KEY AUTO_INCREMENT,
`pais` VARCHAR(45),
`estado` VARCHAR(45),
`cep` VARCHAR(9),
`complemento` VARCHAR(45),
`numero_residencia` VARCHAR(45),
`fk_idEmpresa` INT,
CONSTRAINT `fk_empresa_endereco` FOREIGN KEY (`fk_idEmpresa`) REFERENCES `empresa`(`idEmpresa`));

CREATE TABLE `funcionario`(
`idfuncionario` INT,
`fk_empresa` INT,
`nome` VARCHAR(100),
`email` VARCHAR(100),
`senha` VARCHAR(255),
`data_nascimento` DATE,
`fk_supervisor` INT,
CONSTRAINT `pk_empresa_funcionario` PRIMARY KEY (`idfuncionario`,`fk_empresa`),
CONSTRAINT `fk_empresa_funcionario` FOREIGN KEY (`fk_empresa`) REFERENCES `empresa`(`idempresa`),
CONSTRAINT `fk_funcionario_supervisor` FOREIGN KEY (`fk_supervisor`) REFERENCES `funcionario`(`idfuncionario`));

CREATE TABLE `safra_wasabi`(
`id_safra` INT PRIMARY KEY AUTO_INCREMENT,
`numeracao_colheita` INT NOT NULL,
`area_total` DECIMAL(8,2),
`densidade_cultivo` DECIMAL(8,2),
`inicio_safra` DATE,
`termino_estimado` DATE,
`tipo_cultivo` VARCHAR(30), 
CONSTRAINT `chkCultivo`
CHECK (`tipo_cultivo` IN ('Tradicional', 'Estufa')),
`tipo_wasabi` VARCHAR(45),
CONSTRAINT `chkTipoWasabi`
CHECK (`tipo_wasabi` IN ('Eutrema Japonicum', 'Sawa Wasabi', 'Oka Wasabi')),
`fk_empresa` INT,
CONSTRAINT `fk_empresa_safra` FOREIGN KEY (`fk_empresa`)
REFERENCES `empresa`(`idempresa`));

CREATE TABLE `responsavel`(
`fk_safra_wasabi` INT NOT NULL,
`fk_funcionario` INT,
CONSTRAINT `pk_responsavel` PRIMARY KEY (`fk_safra_wasabi`,`fk_funcionario`),
CONSTRAINT `fk_responsavel_safra` FOREIGN KEY (`fk_safra_wasabi`) REFERENCES `safra_wasabi`(`id_safra`),
CONSTRAINT `fk_responsavel_funcionario` FOREIGN KEY (`fk_funcionario`) REFERENCES `funcionario`(`idfuncionario`));

CREATE TABLE `sensor`(
`idsensor` INT PRIMARY KEY AUTO_INCREMENT,
`modelo` VARCHAR(45) NOT NULL,
`numero_serie` VARCHAR(45),
`status_funcionamento` VARCHAR(45) NOT NULL,
`max_temp` DECIMAL(6,2),
`min_temp` DECIMAL(6,2),
`min_umidade` VARCHAR(45),
`max_umiddade` VARCHAR(45),
`ultima_calibracao` DATE ,
`fk_safra` INT , 
CONSTRAINT `fk_sensor_safra` FOREIGN KEY (`fk_safra`)
REFERENCES `safra_wasabi`(`id_safra`));

CREATE TABLE `wasabi_daily`(
`id_wasabi` INT NOT NULL,
`fk_Sensor` INT NOT NULL,
`data_hora` DATETIME NOT NULL,
`nivel_umidade` DECIMAL(6,2) NOT NULL,
`nivel_temperatura` DECIMAL(6,2) NOT NULL,
CONSTRAINT `pk_sensor_wasabi` PRIMARY KEY (`id_wasabi`,`fk_sensor`),
CONSTRAINT `fk_sensor_wasabi` FOREIGN KEY (`fk_sensor`) REFERENCES `sensor`(`idsensor`));

CREATE TABLE `localizacao_sensor`(
`id_localizacao` INT,
`fk_sensor` INT,
`latitude` VARCHAR(45),
`logitude` VARCHAR(45),
`data_instalacao` DATETIME,
`data_retirada` DATE,
`rua` VARCHAR(45),
`secao` VARCHAR(45),
`status_ativo` TINYINT DEFAULT 0, -- TINYINT limita numeros entre 127 até -127, CONSTRAINT para ser apenas 0(falso) e 1(verdadeiro), valor base caso não tenha nada seŕa 0;
CONSTRAINT `pk_sensor_localizacao` PRIMARY KEY (`id_localizacao`, `fk_sensor`),
CONSTRAINT `fk_sensor_localizacao` FOREIGN KEY (`fk_sensor`) REFERENCES `sensor`(`idSensor`));