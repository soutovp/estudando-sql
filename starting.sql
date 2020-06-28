create database estudo;
/*
- Desenvolver uma loja dentro de um jogo, no qual a moeda principal do personagem é chamada de "ZEN"
- Table usuarios
	id
    login
	senha
    zen
- Table loja
	id
    item
    preco
    qtd
- Table compras
	id
    id_usuario
    item
    qtd
*/
/*USANDO A TABELA CRIADA*/
use estudo;
/*TABELA USUARIOS*/
create table usuarios(
	id int unsigned unique not null auto_increment,
    primary key(id),
    login varchar(15) not null,
    senha varchar(20) not null,
    zen double unsigned not null default 0
);

insert into usuarios(login,senha) values ('soutovp','3866870a');

/*TABELA DA LOJA*/
create table loja(
	id int unsigned unique not null auto_increment,
    primary key(id),
    item varchar(100) not null,
    preco double unsigned not null,
    qtd int not null default 0
);

insert into loja(item,preco) values ('lapis',1.50);
insert into loja(item,preco) values ('borracha',0.50);
insert into loja(item,preco) values ('caneta',2.50);
insert into loja(item,preco) values ('caderno',9.99);

/*ADICIONANDO ESTOQUE*/
select * from loja;
update loja set qtd = 5 where id = 1; /*lapis*/
update loja set qtd = 20 where id = 2; /*borracha*/
update loja set qtd = 10 where id = 3; /*caneta*/
update loja set qtd = 50 where id = 4; /*caderno*/

/*TABELA DE COMPRAS*/
create table compras(
	id int unsigned unique not null auto_increment,
    primary key(id),
    id_usuario int unsigned not null,
    item int unsigned not null,
    constraint fk_compras_loja foreign key (item) references loja(id),
    qtd int unsigned not null default 1
);

insert into compras(id_usuario,item,qtd) values(1,2,3);

/*VERIFICAÇÕES DE CADA TABELA*/
select * from usuarios;
select * from loja;
select * from compras;

/*CANCELANDO UMA COMPRA*/
delete from compras where id = 2;

/*EFETUANDO UMA TRANSAÇÃO ALTERANDO VALORES DE ESTOQUE*/
insert into compras(id_usuario,item,qtd) values(1,4,3);
update loja set qtd = qtd-3 where id = 4;
/*MOSTRANDO AS TRANSAÇÕES*/
SELECT c.id, u.login as usuario, l.item, c.qtd, ROUND(l.preco * c.qtd,2) as Valor FROM compras c inner join loja l on c.item = l.id inner join usuarios u on c.id_usuario = u.id;