CREATE TABLE tblHscode (
	no              int(10)          auto_increment  ,
	year            int(20)           NULL      ,
	country        varchar(300)            NULL      ,
	hs            varchar(300)              NULL      ,
	english		  varchar(300)              NULL      ,
	korean	      varchar(300)              NULL      ,
	weight	      varchar(300)              NULL      ,
	unit	      varchar(300)              NULL      ,
	basic	      varchar(300)              NULL      ,
	wto	      varchar(300)              NULL      ,
	asia	      varchar(300)              NULL      ,
	efta	      varchar(300)              NULL      ,
	
	PRIMARY KEY ( no )
)COLLATE='euckr_korean_ci';