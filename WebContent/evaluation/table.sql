CREATE TABLE user (
  userID varchar(20) ,
  userPassword VARCHAR(64),
  userEmail varchar(50), 
  userEmailHash varchar(64),
  userEmailChecked boolean,
  PRIMARY KEY (userID)
)COLLATE='euckr_korean_ci';




CREATE TABLE evaluation (
  evaluationID int auto_increment,
  userID varchar(20),
  lectureName varchar(50),
  professorName varchar(20),
  lectureYear int,
  semesterDivide varchar(20),
  lectureDivide varchar(10),
  evaluationTitle varchar(50),
  evaluationContent varchar(2048),
  totalScore varchar(5),
  creditScore varchar(5),
  comfortableScore varchar(5),
  lectureScore varchar(5),
  likeCount int, 
  PRIMARY KEY (evaluationID)
)COLLATE='euckr_korean_ci';



CREATE TABLE likey (
  userID varchar(20) ,
  evaluationID int,
  userIP varchar(50),
  PRIMARY KEY (userID,evaluationID)
)COLLATE='euckr_korean_ci';






