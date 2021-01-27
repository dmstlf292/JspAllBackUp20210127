DROP TABLE IF EXISTS testBoard;

CREATE TABLE `testBoard` (
	`tnum`               int(11)              NOT NULL  auto_increment  ,
	`tname`              varchar(20)                    ,
	`tsubject`           varchar(50)                    ,
	`tcontent`           text                                ,
	`tpos`                smallint(7) unsigned           ,
	`tref`               smallint(7)                    ,
	`tdepth`             smallint(7) unsigned           ,
	`tregdate`          date                           ,
	`tpass`              varchar(15)                    ,
	`tip`                  varchar(15)                    ,
	`tcount`             smallint(7) unsigned           ,
	`tfilename`         varchar(30)                    ,
	`tfilesize`           int(11)                        ,
	PRIMARY KEY ( `tnum` )
)COLLATE='euckr_korean_ci';

DROP TABLE IF EXISTS testBcomment;

CREATE TABLE `testBcomment` (
	`tcnum` INT(11) NOT NULL AUTO_INCREMENT,
	`tnum` INT(11) NULL DEFAULT NULL,
	`tname` VARCHAR(20) NULL DEFAULT NULL,
	`tcomment` VARCHAR(200) NULL DEFAULT NULL,
	`tregdate` DATE NULL DEFAULT NULL,
	PRIMARY KEY (`tcnum`)
)COLLATE='euckr_korean_ci';



















create table tblJoin(
	id char(20) primary key,
	pwd char(20) not null,
	name char(20) not null,
	email char(30),
	hp char(40),
	grade char(2) default '0'
)COLLATE='euckr_korean_ci';

create table tblGuestBook(
	num int primary key auto_increment,
	id char(20) not null,
	contents text, ip char(15) not null,
	regdate date,
	regtime datetime,
	secret char(2) default '0'
)COLLATE='euckr_korean_ci';

create table tblComment(
 	cnum int primary key auto_increment,
 	num int not null,
 	cid char(20) not null,
 	comment text,
 	cip char(15) not null,
 	cregDate date
)COLLATE='euckr_korean_ci';

