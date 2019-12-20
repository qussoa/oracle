-- 관리자 화면
CREATE TABLESPACE new_grade_db
DATAFILE '/bizwork/oracle/data/new_grade_dbf'
SIZE 100M AUTOEXTEND ON NEXT 100k;

CREATE USER  newg IDENTIFIED BY grade;

GRANT DBA TO newg;