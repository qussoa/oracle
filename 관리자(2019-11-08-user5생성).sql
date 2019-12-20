-- 관리자

CREATE TABLESPACE user5_db
DATAFILE '/bizwork/oracle/data/user5.dbf'
SIZE 10M AUTOEXTEND ON NEXT 1K;

/*
오라클 DBMS에서의 user의 개념
타 DBMS(mysql, msql)등에서는 기본적인 Schema를 DATABASE라는 이름으로 
생성하여 관리
오라클에서는 기본스키마 user와 긴밀한 관계이다
USER = database 기본 스키마의 관점으로 생각해야한다

USER
DBMS Object 들을 관리하는 주체
TABLE VIEW SEQUENCE INDEX

만약 user5로 접속하여 user4가 가지고 있는 어떤 table을 select하고 싶다
select * from user4.tbl_table;
*/

CREATE USER user5 IDENTIFIED BY user5
DEFAULT TABLESPACE user5_db;

GRANT DBA TO user5;