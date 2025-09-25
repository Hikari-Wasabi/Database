CREATE DATABASE wasabi;

USE wasabi;

CREATE TABLE contato_inicial (
	id_contato INT PRIMARY KEY auto_increment,
    nome_empresa VARCHAR(40),
    email VARCHAR(50),
    pais VARCHAR(50),
    mensagem VARCHAR(5000),
    data_cadastro_inicial DATETIME DEFAULT CURRENT_TIMESTAMP
    );
    
CREATE TABLE empresa_parceira (
    idCliente INT PRIMARY KEY AUTO_INCREMENT,
    dtCadastro DATETIME DEFAULT CURRENT_TIMESTAMP,
    nome VARCHAR(1000) NOT NULL,
    cnpj_global VARCHAR(40) NOT NULL,
    pais VARCHAR(40) NOT NULL,
    estado VARCHAR (50) NOT NULL,
    cidade VARCHAR(100) NOT NULL,
    endereco VARCHAR(500) NOT NULL,
    complemento VARCHAR(40),
    cep_global VARCHAR(25) NOT NULL, -- 00000-00
    email VARCHAR(100) NOT NULL,
    tel_celular CHAR(13) NOT NULL, -- 55 11 91234-5678
    tel_residencial CHAR(8),
    senha VARCHAR(100) NOT NULL
);

CREATE TABLE login ( -- APENAS NO LOGIN DO WEBSITE
	id_login INT PRIMARY KEY AUTO_INCREMENT,
    cnpj_global VARCHAR(40) NOT NULL,
    senha VARCHAR(40) NOT NULL
	);

CREATE TABLE safra_wasabi ( -- INFORMAÇÕES GERAIS SOBRE AS SAFRAS
	id_safra INT PRIMARY KEY auto_increment,
	numeracao_colheita INT NOT NULL,
    area_total DECIMAL (8,2) NOT NULL, -- EM METROS QUADRADOS
    wasabi_m_quadrado INT NOT NULL, -- QUANTOS WASABIS TEM EM CADA METRO QUADRADO
	inicio_safra DATE NOT NULL,
    termino_estimado DATE NOT NULL,
	max_luminosidade DECIMAL (6,2) NOT NULL,
    min_luminosidade DECIMAL (6,2) NOT NULL,
	tipo_cultivo VARCHAR(30) NOT NULL,
		CONSTRAINT chkCultivo
			CHECK (tipo_cultivo IN ('Tradicional', 'Estufa')),
    tipo_wasabi VARCHAR (40) NOT NULL,
		CONSTRAINT chkTipoWasabi
			CHECK (tipo_wasabi IN ('Eutrema Japonicum', 'Sawa Wasabi', 'Oka Wasabi'))
	);
    
CREATE TABLE wasabi_daily ( -- DADOS COLETADOS EM CADA SAFRA
	id_safra INT PRIMARY KEY auto_increment,
    data_hora DATETIME DEFAULT current_timestamp,
    nivel_luminosidade DECIMAL (6,2)
    );
    
INSERT INTO contato_inicial VALUES
	(DEFAULT, 'Hikari Wasabi', 'hikari@hikariwasabi.com', 'Japão', 'こんにちは', DEFAULT);

INSERT INTO empresa_parceira VALUES
	(DEFAULT, DEFAULT, 'Hikari Wasabi', '01234567789012', 'Japão', 'Takayama', 'Kyuushu', 'Yamato-Ken District 2', 'House 2', '12345-678', 'hikari@hikariwasabi.com', '81123456789', NULL, 'SENHA1234');

INSERT INTO safra_wasabi VALUES
	(DEFAULT, 1, 10000.00, 6, '2024-04-10', '2026-03-20', 700, 280, 'Tradicional', 'Sawa Wasabi');

INSERT INTO wasabi_daily VALUES
	(DEFAULT, DEFAULT, 450);

SELECT * FROM contato_inicial;
SELECT * FROM empresa_parceira;
SELECT * FROM safra_wasabi;
SELECT * FROM wasabi_daily;
	
    


    
	
    
    
    