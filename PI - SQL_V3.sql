CREATE DATABASE wasabi_db;

USE wasabi_db;

CREATE TABLE `contato_inicial` (
  `id_contato` INT NOT NULL AUTO_INCREMENT,
  `nome_empresa` VARCHAR(50) NULL,
  `email` VARCHAR(100) NOT NULL,
  `pais` VARCHAR(50) NULL,
  `mensagem` VARCHAR(500) NULL,
  `data_cadastro_inicial` DATE NOT NULL,
  PRIMARY KEY (`id_contato`));


CREATE TABLE `empresa_parceira` (
  `id_cliente` INT NOT NULL AUTO_INCREMENT,
  `dtCadastro` DATETIME DEFAULT CURRENT_TIMESTAMP,
  `nome` VARCHAR(1000) NOT NULL,
  `cnpj_global` VARCHAR(40) NOT NULL,
  `pais` VARCHAR(40),
  `estado` VARCHAR(50),
  `cidade` VARCHAR(100),
  `complemento` VARCHAR(40),
  `cep_global` VARCHAR(25),
  `email` VARCHAR(100) NOT NULL,
  `tel_celular` VARCHAR(45),
  `tel_residencial` VARCHAR(8),
  `senha` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id_cliente`),
  `fk_contato` INT NULL,
  CONSTRAINT `fk_empresa_parceira_empresa_contato` FOREIGN KEY
  (`fk_contato`) REFERENCES `contato_inicial` 
  (`id_contato`)); 
  


/* CREATE TABLE `login` (
  `id_login` INT NOT NULL AUTO_INCREMENT,
  `cnpj_global_fk` VARCHAR(40) NOT NULL,
  `senha` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`id_login`),
  INDEX `fk_login_empresa_parceira1_idx` (`cnpj_global_fk` ASC) VISIBLE,
  CONSTRAINT `fk_login_empresa_parceira1`
    FOREIGN KEY (`cnpj_global_fk`)
    REFERENCES `empresa_parceira` (`cnpj_global`));    */
  

CREATE TABLE `safra_wasabi` (
  `id_safra` INT NOT NULL AUTO_INCREMENT,
  `numeracao_colheita` INT NOT NULL,
  `area_total` DECIMAL(8,2) NOT NULL,
  `wasabi_m_quadrado` INT NOT NULL,                    /* Constraint de FK 1:N (Empresa com diversas safras */
  `inicio_safra` DATE NOT NULL,
  `termino_estimado` DATE NOT NULL,
  `max_temp` DECIMAL(6,2) NULL,
  `min_temp` DECIMAL(6,2) NULL,
  `tipo_cultivo` VARCHAR(30) NULL,
  		CONSTRAINT `chkCultivo`
			CHECK (`tipo_cultivo` IN ('Tradicional', 'Estufa')),
  `tipo_wasabi` VARCHAR(45) NULL,[
  CONSTRAINT `chkTipoWasabi`
			CHECK (`tipo_wasabi` IN ('Eutrema Japonicum', 'Sawa Wasabi', 'Oka Wasabi'))
  `fkempresa_parceira` int,
  constraint `chkempresa` foreign key (`fkempresa_parceira`) 
  references `empresa_parceira` (`id_cliente`),
  PRIMARY KEY (`id_safra`)); 
  


CREATE TABLE `wasabi_daily` (
  `id_safra_fk` INT NOT NULL,
  `id_wasabi` INT NOT NULL,
  `data_hora` DATETIME DEFAULT CURRENT_TIMESTAMP,
  `nivel_umidade` DECIMAL (6,2) NULL,
  CONSTRAINT `pk_wasabi_daily_safra_wasabi` PRIMARY KEY
  (`id_safra_fk`, `id_wasabi`),
  CONSTRAINT `fk_safrawasabi_wasabidaily` FOREIGN KEY
  (`id_safra_fk`) REFERENCES `safra_wasabi` 
  (`id_safra`));
  
