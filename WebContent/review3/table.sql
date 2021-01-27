DROP TABLE IF EXISTS tblPollList;

create table testPollList(
 tnum int primary key auto_increment,
 tquestion varchar(200) not null,
 tsdate date,
 tedate date,
 twdate date,
 type smallint default 1,
 active smallint default 1
)COLLATE='euckr_korean_ci';

DROP TABLE IF EXISTS tblPollItem;

create table testPollItem(
 tlistnum int not null,
 titemnum smallint default 0,
 titem varchar(50) not null,
 count int,
 primary key(tlistnum, titemnum)
)COLLATE='euckr_korean_ci';
