use mi_bicing;

-- PROGRAMACIÓN SOBRE BICING

-- Ejercicios de Procedures

-- 1- Procedure para registrar un nuevo usuario. (1 punto)
ALTER TABLE usuaris MODIFY data_alta timestamp default current_timestamp;

drop procedure if exists nuevo_usuario;
delimiter //
create procedure nuevo_usuario(in dni char(10), in nom_usuari varchar(100), in cognom_1 varchar(100), in cognom_2 varchar(100), 
in mail_usuari varchar(45), in cc char(20), in tarifa int)
begin
	insert into usuaris values(default, dni, nom_usuari, cognom_1, cognom_2, mail_usuari, default, cc, tarifa);
end //
delimiter ;
call nuevo_usuario("356789129T", "Joan", "Ortega", "Martí", "joan.ortega@mail.com","ES642100007892435046", 1);

select * from usuaris;

-- 2- Procedure para devolver una bicicleta. (1 punto)
ALTER TABLE lloguer modify tarifa_minutatge decimal(4,2) null;
ALTER TABLE lloguer modify inici_lloguer timestamp default current_timestamp;
INSERT INTO lloguer(estacio_origen_id) values(175);

drop procedure if exists retorn_bicicleta;
delimiter //
create procedure retorn_bicicleta(in estacio_final int, in id_lloguer int)
begin
	set @hora_actual = (select current_timestamp());
    UPDATE lloguer set fi_lloguer = @hora_actual, estacio_final_id = estacio_final where id = id_lloguer;
    
end //
delimiter ;
call retorn_bicicleta(181, 66);

select * from lloguer;

-- 3- Procedure para calcular el coste total de alquiler por usuario. (1 punto)
drop procedure if exists cost_lloguer;
delimiter //
create procedure cost_lloguer(in id_lloguer int)
begin
	set @temps_lloguer = (select ((fi_lloguer - inici_lloguer)/60) from lloguer where id = id_lloguer);
    if @temps_lloguer < 30 then
		UPDATE lloguer set tarifa_minutatge = (select lloguer_30_minuts from preu_lloguer where id = 1) where id = id_lloguer;
	elseif @temps_lloguer < 120 then
		UPDATE lloguer set tarifa_minutatge = (select lloguer_30_120_minuts from preu_lloguer where id = 1) where id = id_lloguer;
	else
		UPDATE lloguer set tarifa_minutatge = (select lloguer_120_minuts from preu_lloguer where id = 1) where id = id_lloguer;
	end if;
end //
delimiter ;
call cost_lloguer(66);

select * from lloguer;

-- select (fi_lloguer - inici_lloguer)/60 from lloguer where id = 66;

-- select * from preu_lloguer;

-- 4- Procedure para generar reporte de ingresos mensuales. (1 punto)
drop procedure if exists ingressos_mensuals;
delimiter //
create procedure ingressos_mensuals(in mes int, in any_year int, out ingres_mes decimal(4,2))
begin
	set @ingres = (select sum(cost_total) from facturacio where month(data_factura)= mes and year(data_factura) = any_year);
	select concat ("Els ingressos del període ",any_year, "-", mes, " són " , @ingres, "€") as Ingressos_mensuals;
end //
delimiter ;
call ingressos_mensuals(8, 2023, @ingres);

select * from facturacio;

--

-- Ejercicios de Triggers
-- 1- Trigger para evitar el alquiler de bicicletas no disponibles. (1 punto)

alter table bicicletes add column disponibilitat boolean;
update bicicletes set disponibilitat = 1;
update bicicletes set disponibilitat = 0 where id = 1;
select * from bicicletes;

select disponibilitat from bicicletes where id = 1;

drop trigger if exists bicicletes_no_disponibles;
delimiter //
create trigger bicicletes_no_disponibles
before insert on bicicletes_has_lloguer
for each row
begin
	
    set @disponible = (select disponibilitat from bicicletes where id = new.bicicletes_id);
    
    if @disponible = 0 then
		signal sqlstate '45000' set message_text = "La bicicleta no està disponible en aquests moments.";
	end if;
    
end //
delimiter ;

insert into bicicletes_has_lloguer values(default, 1, 68, 5);

select * from bicicletes_has_lloguer BL  right join lloguer L on L.id = BL.lloguer_id;

-- 2- Trigger para actualizar el estado de la bicicleta al devolverla. (1 punto)
alter table lloguer add column bicicleta_id int;
update lloguer set bicicleta_id = 1 where id = 67;


drop trigger if exists retorn_bicicleta;
delimiter //
create trigger retorn_bicicleta
after update on lloguer
for each row
begin
	set @fi_estacio = (select estacio_final_id from lloguer where id = new.id);
    if @fi_estacio is not null then
		update bicicletes set disponibilitat = 1 where id = new.bicicleta_id;
	end if;
    
end //
delimiter ;

UPDATE lloguer set fi_lloguer = (select current_timestamp()), estacio_final_id = 277, bicicleta_id = 1 where id = 67;

select * from lloguer;
select * from bicicletes;

-- 3- Trigger para actualizar el saldo del usuario después de un alquiler. (1 punto)
alter table usuaris add column saldo decimal(7,2);
update usuaris set saldo = 0;
alter table lloguer add column usuari_id int;
update lloguer set usuari_id = 3 where id = 67;

drop trigger if exists actualitzar_saldo;
delimiter //
create trigger actualitzar_saldo
after update on lloguer
for each row
begin
	
    set @temps_lloguer = (select ((fi_lloguer - inici_lloguer)/60) from lloguer where id = new.id);
    if @temps_lloguer < 30 then
		update usuaris set saldo = saldo + (select lloguer_30_minuts from preu_lloguer where id = 1) where id = new.usuari_id;
	elseif @temps_lloguer < 120 then
		update usuaris set saldo = saldo + (select lloguer_30_120_minuts from preu_lloguer where id = 1) where id = new.usuari_id;
	else
		update usuaris set saldo = saldo + (select lloguer_120_minuts from preu_lloguer where id = 1) where id = new.usuari_id;
        
	end if;
    
    -- update usuaris set saldo = saldo + () where id = new.usuari_id;
    
end //
delimiter ;

select * from usuaris;

-- 

-- Ejercicios de Eventos

-- 1- Evento para enviar notificaciones de alquileres próximos a vencer. (1,5 punto)
-- Crea un evento que se ejecute cada hora y envíe notificaciones a los usuarios cuyas bicicletas alquiladas están próximas a vencer 
-- (por ejemplo, dentro de la próxima hora). Este ejemplo asume la existencia de una tabla notificaciones para registrar las notificaciones.
-- Frecuencia: Cada hora.
-- Acción: Enviar notificaciones a los usuarios.

create table notificacions(
	id int primary key auto_increment,
    usuari_id int,
    bicicleta_id int,
    tipus_notificacio varchar(50)
);


drop event if exists notificacions;
delimiter //
create event notificacions
on schedule every 1 hour
do 
begin
	insert into comptes values(default, "CompteNova", 2024);
    select * from comptes;
end //
delimiter ;



select * from facturacio_has_usuaris;


select * from lloguer;
select * from bicicletes_has_lloguer;
select * from bicicletes_has_lloguer BL  right join lloguer L on L.id = BL.lloguer_id;

