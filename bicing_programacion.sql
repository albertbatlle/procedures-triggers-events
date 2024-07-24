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

SET FOREIGN_KEY_CHECKS = 0;

create table notificacions(
	id int primary key auto_increment,
    -- usuari_id int,
    destinatari varchar(100),
    assumpte varchar(50),
    missatge text,
    data_creacio timestamp default current_timestamp,
    bicicleta_id int,
    -- constraint FK_UsuariNotificacions foreign key (usuari_id) references usuari(id),
    constraint FK_BicicletaNotificacions foreign key (bicicleta_id) references bicicletes(id)
);

alter table notificacions add column temps_lloguer decimal(7,2);
alter table notificacions add column mail_usuari varchar(45);

alter table lloguer add constraint FK_lloguerbicicletes foreign key (bicicleta_id) references bicicletes(id);
alter table lloguer add constraint FK_lloguerusuari foreign key (usuari_id) references usuari(id);

SET FOREIGN_KEY_CHECKS = 1;
SET GLOBAL event_scheduler=ON;

truncate notificacions;

drop event if exists notificacions;
delimiter //
create event notificacions
on schedule every 1 hour
do 
begin
	
declare done boolean default false;    
declare num_lloguer_id int;
declare num_usuari_id int;
declare num_bicicleta_id int;
declare num_estacio int;
    
declare cursor_usuari_bicicleta cursor for
	SELECT id, usuari_id, bicicleta_id, estacio_final_id
	from lloguer
	where estacio_final_id is null;
	
declare continue handler for not found set done = true;
    
open cursor_usuari_bicicleta;
    
bucle_lectura: loop
	fetch cursor_usuari_bicicleta into num_lloguer_id, num_usuari_id, num_bicicleta_id, num_estacio;
	if done then
		leave bucle_lectura;
	end if;
        
	set @temps_lloguer = (timestampdiff(minute, (select inici_lloguer from lloguer where id = num_lloguer_id), current_timestamp()));
	set @nom_usuari = (select concat_ws(" ", nom, cognom1, cognom2) from usuaris where id = num_usuari_id);
	set @mail_usuari = (select mail from usuaris where id = num_usuari_id);
    set @user_id = num_usuari_id;
    -- set @nul = (SELECT estacio_final_id from lloguer where estacio_final_id is null);
	-- insert into notificacions (id, destinatari, temps_lloguer, mail_usuari) values (default,@nom_usuari,@temps_lloguer,@mail_usuari);
    
    -- if num_estacio is null then
		
		 -- 
         insert into notificacions(destinatari, assumpte, bicicleta_id, temps_lloguer, mail_usuari) values (@nom_usuari, "Venciment Entrega Bicicleta", num_bicicleta_id, @temps_lloguer, @mail_usuari);
        
		  -- insert into notificacions(usuari_id, destinatari, assumpte, bicicleta_id, temps_lloguer, mail_usuari) values (num_usuari_id, @nom_usuari, "Venciment Entrega Bicicleta", num_bicicleta_id, @temps_lloguer, @mail_usuari);
        
        if @temps_lloguer between 20 and 30 then
			update notificacions set missatge = (concat("Falten ", (30 - @temps_lloguer), " minuts perquè puguis entregar la teva bicicleta de manera gratuïta.")) where id = (select max(id) from notificacions);
		elseif @temps_lloguer < 120 then
			update notificacions set missatge = (concat("Falten ", (120 - @temps_lloguer), " minuts perquè puguis entregar la teva bicicleta sense que et cobrem el sobrecost de 5€.")) where id = (select max(id) from notificacions);
		else
			update notificacions set missatge = (concat("El temps de lloguer de la bicicleta és actualment de ", (@temps_lloguer), " minuts. Recora que per cada hora se't cobrarà 5€.")) where id = (select max(id) from notificacions);
		end if; 
	-- end if;
        -- select * from notificacions where usuari_id = num_usuari_id;       
end loop bucle_lectura;

close cursor_usuari_bicicleta;
    
end //
delimiter ;
insert into notificacions (id) values (default);
select * from notificacions;

SET FOREIGN_KEY_CHECKS = 0;

insert into lloguer (estacio_origen_id, bicicleta_id, usuari_id) values (179, 3, 5);

SET FOREIGN_KEY_CHECKS = 1;


-- 2- Evento para archivar alquileres antiguos. (1,5 punto)
-- Crea un evento que se ejecute una vez al año y mueva los registros de alquileres que tengan más de dos años a una tabla de archivo (alquileres_archivo).
-- Frecuencia: Anual.
-- Acción: Archivar registros antiguos.

drop table if exists lloguers_arxivats;
create table lloguers_arxivats like lloguer;
alter table lloguers_arxivats add column DataSupressio timestamp default current_timestamp;
alter table lloguers_arxivats add column lloguer_id int;

select * from lloguer;
select * from lloguers_arxivats;


drop event if exists event_arxivar_lloguer;
delimiter //
create event event_arxivar_lloguer
on schedule every 1 year
do 
begin
	declare done boolean default false;
    
    declare cursor_lloguerID int;
    declare cursor_inici_lloguer timestamp;
    declare cursor_fi_lloguer timestamp;
    declare cursor_origenID int;
    declare cursor_finalID int;
    declare cursor_tarifa decimal(4,2);
    declare cursor_bicicletaID int;
    declare cursor_usuari_id int;
    
    declare cursor_arxivar_lloguer cursor for
		select * from lloguer where inici_lloguer < date_sub(CURDATE(), INTERVAL 2 YEAR);
        
    declare continue handler for not found set done = true;
    
    open cursor_arxivar_lloguer;
    
    bucle_lectura: loop
		fetch cursor_arxivar_lloguer into cursor_lloguerID, cursor_inici_lloguer, cursor_fi_lloguer, cursor_origenID, cursor_finalID, cursor_tarifa, 
        cursor_bicicletaID, cursor_usuari_id;
        if done then
			leave bucle_lectura;
		end if;
        
        insert into lloguers_arxivats values(default, cursor_inici_lloguer, cursor_fi_lloguer, cursor_origenID, cursor_finalID, cursor_tarifa, cursor_bicicletaID, cursor_usuari_id, default, cursor_lloguerID);
        DELETE FROM lloguer where id = cursor_lloguerID;
        
	end loop;
close cursor_arxivar_lloguer;

end //
delimiter ;

insert into lloguer (inici_lloguer, estacio_origen_id) values ("1999-04-23", 176);


