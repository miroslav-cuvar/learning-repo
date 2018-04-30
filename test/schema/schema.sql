create table dodavatel(
	id bigserial not null
		constraint dodavatel_pkey
			primary key,
	nazov varchar(256),
	adresa varchar(64),
	mesto varchar(64),
	psc varchar(5),
	tel_cislo varchar(32),
	e_mail varchar(64)
);

create table produkt(
	id bigserial not null
		constraint produkt_pkey
			primary key,
	nazov varchar(256),
	pribalova_info text
);

create table sklad(
	id bigserial not null
		constraint sklad_pkey
			primary key,
	adresa varchar(64),
	mesto varchar(64),
	psc varchar(5),
	tel_cislo varchar(32),
	e_mail varchar(64)
);

create table produkt_v_sklade(
	produkt_id bigint not null
		constraint produkt_v_sklade_produkt_id_fkey
			references produkt
				on update cascade on delete restrict,
	sklad_id bigint not null
		constraint produkt_v_sklade_sklad_id_fkey
			references sklad
				on update cascade on delete restrict,
	mnozstvo real,
	datum_dodania date,
	min_trvanlivost_do date,
	price real
);

create table vyrobna_zmluva(
	dodavatel_id bigint not null
		constraint vyrobna_zmluva_dodavatel_id_fkey
			references dodavatel
				on update cascade on delete restrict,
	produkt_id bigint not null
		constraint vyrobna_zmluva_produkt_id_fkey
			references produkt
				on update cascade on delete restrict,
	sklad_id bigint not null
		constraint vyrobna_zmluva_sklad_id_fkey
			references sklad
				on update cascade on delete restrict,
	mnozstvo real,
	datum_od date,
	datum_do date
);

create table zakaznik(
	id bigserial not null
		constraint zakaznik_pkey
			primary key,
	meno varchar(64),
	adresa varchar(64),
	mesto varchar(64),
	psc varchar(5),
	tel_cislo varchar(32),
	e_mail varchar(64)
);

create table objednavka(
	id bigserial not null
		constraint objednavka_pkey
			primary key,
	zakaznik_id bigint not null
		constraint objednavka_zakaznik_id_fkey
			references zakaznik
				on update cascade on delete restrict,
	suma real,
	datum date
);

create table faktura(
	id bigserial not null
		constraint faktura_pkey
			primary key,
	objednavka_id bigint not null
		constraint faktura_objednavka_id_fkey
			references objednavka
				on update cascade on delete restrict,
	suma real,
	datum_splatenia date
);

create table polozka_v_objednavke(
	objednavka_id bigint not null
		constraint polozka_v_objednavke_objednavka_id_fkey
			references objednavka
				on update cascade on delete restrict,
	produkt_id bigint not null
		constraint polozka_v_objednavke_produkt_id_fkey
			references produkt
				on update cascade on delete restrict,
	mnozstvo real,
	price real,
	total real
);

create index sklad_idx
	on produkt_v_sklade (sklad_id);

create index dodavatel_idx
	on vyrobna_zmluva (dodavatel_id);