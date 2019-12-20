-- 여기는 관리자 화면

/*
    TABLESPACE 생성
    이름 :  grade_db
    파일 : C:/bizwork/oracle/data/grade.dbf
    초기 사이즈 : 10b
    자동증가 옵션 : 10K
*/

CREATE TABLESPACE grade_db
DATAFILE 'C:/bizwork/oracle/data/grade.dbf'
SIZE 10M AUTOEXTEND ON NEXT 10K;


/*
   사용자 생성 : 스키마 생성
   ID : grade
   PW : grade
   권한 : DBA
   DEFAULT TABLESPACE : grade_db
*/

CREATE USER grade IDENTIFIED BY grade
DEFAULT TABLESPACE grade_db;
GRANT DBA TO grade;

SELECT * FROM ALL_USERS WHERE USERNAME = 'GRADE';

-- 사용자의 비밀번호 변경
ALTER USER grade IDENTIFIED BY grade;







