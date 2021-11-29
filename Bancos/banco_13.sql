create database IF NOT EXISTS banco_13;
use banco_13;
show databases;

create table if not exists entrada(
    id integer primary key auto_increment,
    data_entrada datetime,
    valor numeric(10,2)
);

create table if not exists entrada_log(
    id_log integer primary key auto_increment,
    user varchar(100) not null,
    data_log datetime,
    descricao longtext
);

create table if not exists informacoes(
    id_info integer primary key auto_increment,
    data_inicio datetime not null,
    data_fim datetime not null,
    media numeric(10,2) not null,
    mediana numeric(10,2) not null,
    moda numeric(10,2) not null,
    desvio numeric(10,2) not null,
    maximo numeric(10,2) not null,
    minimo numeric(10,2) not null    
);

-- Procedure tabela entrada

DELIMITER //
	CREATE PROCEDURE log_entrada_insert (Ndata_entrada datetime, Nvalor numeric(10,2))
		BEGIN 
				INSERT INTO entrada_log (user, data_log, descricao) 
                values (current_user, now(),concat('Ação executada por ', current_user, ' adicionou as informçãoes ', Ndata_entrada, ' e ', Nvalor ));
		END ;
//

DELIMITER //
	CREATE PROCEDURE log_entrada_update (Odata_entrada datetime, Ovalor numeric(10,2), Ndata_entrada datetime, Nvalor numeric(10,2))
		begin
				INSERT INTO entrada_log (user, data_log, descricao) 
                values (current_user, now(),concat('Ação executada por ', current_user, ' alterou os dados ', Odata_entrada, ' e ', Ovalor, ' para ', Ndata_entrada, ' e ', Nvalor ));
		END ;
//

DELIMITER //
	CREATE PROCEDURE log_entrada_delete (Odata_entrada datetime, Ovalor numeric(10,1))
		begin
				INSERT INTO entrada_log (user, data_log, descricao) 
                values (current_user, now(),concat('Ação executada por ', current_user, ' fez a exclusão dos dados ', Odata_entrada, ' e ', Ovalor ));
		END ;
//



DELIMITER //

	CREATE TRIGGER TGR_ENTRADA_AI AFTER INSERT ON entrada
    FOR EACH ROW
		BEGIN
			CALL log_entrada_insert (NEW.data_entrada, NEW.valor);
		END;
		//
DELIMITER ;

DELIMITER //

	CREATE TRIGGER TGR_ENTRADA_AU AFTER UPDATE ON entrada
    FOR EACH ROW
		BEGIN
			CALL log_entrada_update (OLD.data_entrada, OLD.valor, NEW.data_entrada, NEW.valor);
		END;
		//
DELIMITER ;

DELIMITER //

	CREATE TRIGGER TGR_ENTRADA_AD AFTER DELETE ON entrada
    FOR EACH ROW
		BEGIN
			CALL log_entrada_delete (OLD.data_entrada, OLD.valor);
		END;
		//
DELIMITER ;

select * from entrada;
show triggers;


-- Procedure tabela informacoes

DELIMITER //
	CREATE PROCEDURE log_informacoes_insert (data_inicio datetime, data_fim datetime, media decimal(10,2), mediana decimal(10,2), moda decimal(10,2), desvio decimal(10,2), maximo decimal(10,2), minimo decimal(10,2))
		BEGIN 
				INSERT INTO entrada_log (user, data_log, descricao) 
                values (current_user, now(),concat('Ação executada por ', current_user, ' adicionou as informçãoes ', data_inicio, ',', data_fim, ',', media, ',', mediana, ',', moda, ',', desvio, ',', maximo, ',', minimo));
		END ;
//

DELIMITER //
	CREATE PROCEDURE log_informacoes_update (Odata_inicio datetime, Odata_fim datetime, Omedia decimal(10,2), Omediana decimal(10,2), Omoda decimal(10,2), Odesvio decimal(10,2), Omaximo decimal(10,2), Ominimo decimal(10,2), Ndata_inicio datetime, Ndata_fim datetime, Nmedia decimal(10,2), Nmediana decimal(10,2), Nmoda decimal(10,2), Ndesvio decimal(10,2), Nmaximo decimal(10,2), Nminimo decimal(10,2))
		begin
				INSERT INTO entrada_log (user, data_log, descricao) 
                values (current_user, now(),concat('Ação executada por ', current_user, ' alterou os dados ', Odata_inicio, ',', Odata_fim, ',', Omedia, ',', Omediana, ',', Omoda, ',', Odesvio, ',', Omaximo, ',', Ominimo, ', ', 'para ',  Ndata_inicio, ',', Ndata_fim, ',', Nmedia, ',', Nmediana, ',', Nmoda, ',', Ndesvio, ',', Nmaximo, ',', Nminimo ));
		END ;
//

DELIMITER //
	CREATE PROCEDURE log_informacoes_delete (Odata_inicio datetime, Odata_fim datetime, Omedia decimal(10,2), Omediana decimal(10,2), Omoda decimal(10,2), Odesvio decimal(10,2), Omaximo decimal(10,2), Ominimo decimal(10,2))
		begin
				INSERT INTO entrada_log (user, data_log, descricao) 
                values (current_user, now(),concat('Ação executada por ', current_user, ' fez a exclusão dos dados ', Odata_inicio, ',', Odata_fim, ',', Omedia, ',', Omediana, ',', Omoda, ',', Odesvio, ',', Omaximo, ',', Ominimo));
		END ;
//



DELIMITER //

	CREATE TRIGGER TGR_INFORMACOES_AI AFTER INSERT ON informacoes
    FOR EACH ROW
		BEGIN
			CALL log_informacoes_insert (NEW.data_inicio, NEW.data_fim, NEW.media, NEW.mediana, NEW.moda, NEW.desvio, NEW.maximo, NEW.minimo);
		END
		//
DELIMITER ;

DELIMITER // 

	CREATE TRIGGER TGR_INFORMACOES_AU AFTER UPDATE ON informacoes
    FOR EACH ROW
		BEGIN
			CALL log_informacoes_update (OLD.data_inicio, OLD.data_fim, OLD.media, OLD.mediana, OLD.moda, OLD.desvio, OLD.maximo, OLD.minimo, NEW.data_inicio, NEW.data_fim, NEW.media, NEW.mediana, NEW.moda, NEW.desvio, NEW.maximo, NEW.minimo);
		END;
		//
DELIMITER ;

DELIMITER //

	CREATE TRIGGER TGR_INFORMACOES_AD AFTER DELETE ON informacoes
    FOR EACH ROW
		BEGIN
			CALL log_informacoes_delete (OLD.data_inicio, OLD.data_fim, OLD.media, OLD.mediana, OLD.moda, OLD.desvio, OLD.maximo, OLD.minimo);
		END;
		//
DELIMITER ;



select * from entrada;
select * from entrada_log;
select * from informacoes;