create database IF NOT EXISTS banco_13;
use banco_13;

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
		END
		//
DELIMITER ;

DELIMITER // #TODO

	CREATE TRIGGER TGR_ENTRADA_AU AFTER UPDATE ON entrada
    FOR EACH ROW
		BEGIN
			CALL log_entrada_update (OLD.data_entrada, OLD.valor, NEW.data_entrada, NEW.valor);
		END
		//
DELIMITER ;

DELIMITER //

	CREATE TRIGGER TGR_ENTRADA_AD AFTER DELETE ON entrada
    FOR EACH ROW
		BEGIN
			CALL log_entrada_delete (OLD.data_entrada, OLD.valor);
		END
		//
DELIMITER ;

select * from entrada;


DELIMITER //
	CREATE PROCEDURE log_informacoes_insert (Ndata_entrada datetime, Nvalor numeric(10,2))
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



