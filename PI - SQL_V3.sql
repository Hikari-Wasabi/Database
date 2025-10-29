
CREATE DATABASE wasabi_db;


USE wasabi_db;

CREATE TABLE `contato_inicial`(
`idContato_inicial` INT PRIMARY KEY,
`email` VARCHAR(100) NOT NULL,
`pais` VARCHAR(50)  NOT NULL,
`mensagem` VARCHAR(500) NOT NULL,
`data_envio` DATETIME DEFAULT current_timestamp
);

CREATE TABLE `empresa`(
`idEmpresa` INT PRIMARY KEY AUTO_INCREMENT,
`token` CHAR(10) NOT NULL UNIQUE,
`dt_cadastro` DATETIME DEFAULT current_timestamp,
`razão_social` VARCHAR(100) NOT NULL,
`cnpj` VARCHAR(40) NOT NULL UNIQUE,
`email` VARCHAR(100) NOT NULL UNIQUE,
`tel_celular` VARCHAR(15) UNIQUE,
`tel_residencial` VARCHAR(10) UNIQUE);


CREATE TABLE `endereco`(
`idEndereco` INT PRIMARY KEY AUTO_INCREMENT,
`pais` VARCHAR(45) DEFAULT 'Brasil' NOT NULL,
`estado` VARCHAR(45) NOT NULL,
`cep` VARCHAR(9) NOT NULL,
`complemento` VARCHAR(45),
`numero_residencia` VARCHAR(45) NOT NULL,
`FK_empresa` INT,
CONSTRAINT `fk_empresa_endereco` FOREIGN KEY (`fk_empresa`) REFERENCES `empresa`(`idEmpresa`)
);

CREATE TABLE `funcionario`(
`idFuncionario` INT AUTO_INCREMENT,
`fk_empresa` INT,
`dt_cadastro` DATETIME DEFAULT current_timestamp,
`nome` VARCHAR(100) NOT NULL,
`email` VARCHAR(100) NOT NULL,
`senha` VARCHAR(255),
`data_nascimento` DATE NOT NULL,
`fk_supervisor` INT,
CONSTRAINT `pk_empresa_funcionario` PRIMARY KEY (`idFuncionario`,`fk_empresa`),
CONSTRAINT `fk_empresa_funcionario` FOREIGN KEY (`fk_empresa`) REFERENCES `empresa`(`idEmpresa`),
CONSTRAINT `fk_funcionario_supervisor` FOREIGN KEY (`fk_supervisor`) REFERENCES `funcionario`(`idFuncionario`));

CREATE TABLE `safra_wasabi`(
`idSafra` INT PRIMARY KEY AUTO_INCREMENT,
`numeracao_colheita` INT NOT NULL UNIQUE,
`area_total` DECIMAL(8,2) NOT NULL,
`densidade_cultivo` DECIMAL(8,2) NOT NULL,
`inicio_safra` DATE NOT NULL,
`termino_estimado` DATE NOT NULL,
`tipo_cultivo` VARCHAR(30) NOT NULL, 
CONSTRAINT `chkCultivo`
CHECK (`tipo_cultivo` IN ('Tradicional', 'Estufa')),
`tipo_wasabi` VARCHAR(45) NOT NULL,
CONSTRAINT `chkTipoWasabi`
CHECK (`tipo_wasabi` IN ('Eutrema Japonicum', 'Sawa Wasabi', 'Oka Wasabi')),
`fk_empresa` INT,
CONSTRAINT `fk_empresa_safra` FOREIGN KEY (`fk_empresa`)
REFERENCES `empresa`(`idEmpresa`),
`fk_funcionario` INT, 
CONSTRAINT `fk_safra_responsavel`
	FOREIGN KEY (`fk_funcionario`)
		REFERENCES `funcionario` (idFuncionario)
)AUTO_INCREMENT=1000;



CREATE TABLE `sensor`(
`idsensor` INT PRIMARY KEY AUTO_INCREMENT,
`modelo` VARCHAR(45) NOT NULL,
`numero_serie` VARCHAR(45) NOT NULL,
`status_ativo` TINYINT  NOT NULL,
CONSTRAINT `status_ativo_chk`
	CHECK (`status_ativo` IN (0, 1)),
`max_temp` DECIMAL(5,2),
`min_temp` DECIMAL(5,2),
`min_umidade` DECIMAL(5,2),
`max_umiddade` DECIMAL(5,2),
`ultima_calibracao` DATE NOT NULL,
`fk_safra` INT , 
CONSTRAINT `fk_sensor_safra` FOREIGN KEY (`fk_safra`)
REFERENCES `safra_wasabi`(`idSafra`)) AUTO_INCREMENT=100;


CREATE TABLE `wasabi_daily`(
`id_registro` INT NOT NULL AUTO_INCREMENT,
`fk_Sensor` INT NOT NULL,
`data_hora` DATETIME DEFAULT current_timestamp,
`valor_umidade` DECIMAL(5,2) NOT NULL,
`valor_temperatura` DECIMAL(5,2) NOT NULL,
CONSTRAINT `pk_sensor_wasabi` PRIMARY KEY (`id_registro`,`fk_sensor`),
CONSTRAINT `fk_sensor_wasabi` FOREIGN KEY (`fk_sensor`) REFERENCES `sensor`(`idSensor`));

SELECT * FROM wasabi_daily;

CREATE TABLE `localizacao_sensor`(
`idLocalizacao` INT PRIMARY KEY,
`fk_sensor` INT,
`data_instalacao` DATETIME NOT NULL ,
`rua_plantacao` VARCHAR(45) NOT NULL,
`bloco_plantacao` VARCHAR(45) NOT NULL,
CONSTRAINT `fk_sensor_localizacao` FOREIGN KEY (`fk_sensor`) REFERENCES `sensor`(`idSensor`)
);


INSERT INTO empresa (token, razão_social, cnpj, email, tel_celular, tel_residencial)
VALUES
('ABC123BR01', 'WasabiTech Brasil', '77.777.777/0001-90', 'contato@wasabibr.com', '+5511987654321', '1133445566'),
('DEF456BR02', 'Green Agro Brasil', '99.999.999/0001-10', 'info@greenagro.com.br', '+5511998765432', '1144556677'),
('GHI789BR03', 'NaturaFarm Brasil', '88.888.333/0001-44', 'natura@farm.com.br', '+5511976543210', NULL);


INSERT INTO endereco (pais, estado, cep, complemento, numero_residencia, FK_empresa)
VALUES
('Brasil', 'São Paulo', '04567-000', 'Condomínio Verde', '55A', 1),
('Brasil', 'Minas Gerais', '30123-456', 'Próximo ao rio', '102', 2),
('Brasil', 'Rio de Janeiro', '22030-040', 'Bairro Jardim', '304', 3);

INSERT INTO funcionario (fk_empresa, nome, email, senha, data_nascimento, fk_supervisor)
VALUES
(1, 'João Silva', 'joao@wasabibr.com', 'senhaJoao', '1988-05-12', NULL),
(2, 'Maria Souza', 'maria@greenagro.com.br', 'senhaMaria', '1990-09-22', NULL),
(3, 'Carlos Oliveira', 'carlos@agrotech.com.br', 'senhaCarlos', '1985-02-10', NULL);


INSERT INTO funcionario (fk_empresa, nome, email, senha, data_nascimento, fk_supervisor) VALUE
	(1, 'Mario augusto', 'mario@wasabibr.com', 'senhaJoao', '2000-10-19', 1),
	(2, 'Fernanda Lima', 'fernanda@greenagro.com.br', 'senhaFernanda', '1995-03-08', 2),
	(3, 'Bruno Pereira', 'bruno@agrotech.com.br', 'senhaBruno', '1999-01-25', 3);

INSERT INTO safra_wasabi (numeracao_colheita, area_total, densidade_cultivo, inicio_safra, termino_estimado, tipo_cultivo, tipo_wasabi, fk_empresa)
VALUES
(1000, 250.50, 1.25, '2025-01-15', '2025-10-15', 'Tradicional', 'Eutrema Japonicum', 1),
(1001, 180.30, 0.95, '2025-03-10', '2025-12-10', 'Estufa', 'Sawa Wasabi', 2),
(1002, 300.00, 1.40, '2025-02-05', '2025-11-05', 'Tradicional', 'Oka Wasabi', 3);


INSERT INTO sensor (modelo, numero_serie, status_ativo, max_temp, min_temp, min_umidade, max_umiddade, ultima_calibracao, fk_safra)
VALUES
('DHT11', 'SN100BR01', 1, 35.50, 5.20, '60', '90', '2025-06-01', 1000),
('DHT11', 'SN100BR02', 1, 33.80, 6.00, '55', '85', '2025-07-10', 1001),
('AM2302', 'SN100BR03', 0, 30.00, 8.00, '65', '95', '2025-05-20', 1002);

INSERT INTO localizacao_sensor (idLocalizacao, fk_sensor, data_instalacao, rua_plantacao, bloco_plantacao)
VALUES
(1, 100, '2025-01-10 09:00:00', 'Rua K', 'A1'),
(2, 101, '2025-02-15 10:30:00', 'Rua L', 'B2'),
(3, 102, '2025-03-05 08:45:00', 'Rua M', 'C3');



select * from wasabi_daily JOIN sensor
	ON fk_sensor = idsensor;
    
    
