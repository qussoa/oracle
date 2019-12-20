-- 사용자 정보 테이블
CREATE TABLE tbl_user(
u_id	VARCHAR2(125)	NOT NULL	PRIMARY KEY,
u_nick	NVARCHAR2(125) ,
u_name	NVARCHAR2(125) NOT NULL,			
u_password	NVARCHAR2(125)	NOT NULL	,
u_tel	NVARCHAR2(20)	,
u_grade	NVARCHAR2(5)		
);
drop table tbl_user;
-- 사용자의 취미정보테이블
CREATE TABLE tbl_uhobby(
uh_seq	NUMBER	NOT NULL	PRIMARY KEY,
uh_id	VARCHAR2(125)	NOT NULL,
uh_code	VARCHAR2(5)	NOT NULL	

);
--취미리스트 테이블
CREATE TABLE tbl_hobby(
h_code	VARCHAR2(5)	NOT NULL	PRIMARY KEY,
h_name	NVARCHAR2(125)	NOT NULL,	
h_rem	NVARCHAR2(125)
);

select * from tbl_hobby;

CREATE SEQUENCE SEQ_UHOBBY
START WITH 1 INCREMENT BY 1;


commit;

SELECT * FROM tbl_user
LEFT JOIN tbl_uhobby
on u_id = uh_id;

delete from tbl_user;
commit;

