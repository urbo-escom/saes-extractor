-- PRAGMA foreign_keys = ON; for SQLite
create table periodo (
	numero integer primary key
);

create table tipo_materia (
	tipo varchar(20) primary key
);

create table materia (
	clave varchar(20) primary key,
	periodo integer references periodo(numero),
	tipo varchar(20) references tipo_materia(tipo),

	nombre varchar(50),
	creditos integer,
	minutos_teoria_semana integer,
	minutos_practica_semana integer
);
