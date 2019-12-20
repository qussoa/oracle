-- 관리자 화면

/*
TABLESPACE 생성
이름 : user4_db
DATAFILE : '/bizwork/oracle/data/user4.dbf'
초기용량 : 10Mb
자동확장 : 10Kb
*/

/*

사용자 id : user4
       pw : user4
DEFAULT TABLESPACE user4_db
권한 : DBA
*/


CREATE TABLESPACE user4_db
DATAFILE '/bizwork/oracle/data/user4.dbf'
SIZE 10M AUTOEXTEND ON NEXT 10K;

CREATE USER user4 IDENTIFIED BY user4
DEFAULT TABLESPACE user4_db;

GRANT DBA TO user4;

--  사용자를 생성하면서 DEFAULT TABLESPCE를 지정하지 않으면
--  SYSTEM(관리자, 오라클 DBMS가 사용하는 영역)의 TABLESPACE를 사용한다
--  작은 규모에서는 큰 문제가 없으나 SYSTEM 영역을 사용하는 것은 여러가지(보안,관리)에서
--  좋은 방법이 아니다
--  DEFAULT TABLESPACE 나중에 추가하는 방법
--  사용자와 관련하여 정보, 값들을 수정

--  이미 생성된 사용자 ID의 TABLESPACE를 변경
ALTER USER user4 DEFAULT TABLESPACE user4_db;

--  사용자 생성 TABLE등을 생성 후 DEFAULT TABLESPACE를 변경하면 보통 DBMS에서
--  TABLE 등을 TABLESPACE로 옮기면 DATA가 많거나, 하는 경우 문제를 불러올 경우가 있다
--  사용 중(TABLE 등) 경우에는 가급적 변경하지 않는 것이 좋다

--  기존의 TABLESPACE에 있는 TABLE들을 수동으로 다른 TABLESPACE로 옮기기
--  현재 사용자의 DEFAULT TABLESPACE에 있는 table을 다른 TABLESPACE 옮기기


ALTER TABLE tbl_student MOVE TABLESPACE user4_db;
--  DEFAULT TAQBLESPACE를 생성하지 않고 데이터를 저장했을 경우
--  새로운 TABLEPACE를 생성하고
--  사용중이던 TABLE을 새로운 TABLESPACE로 옮기고 DEFAULT TABLE을 변경하는 것이 좋다
--  

--  사용자의 PW 를 변경하는 방법
ALTER USER user4 IDENTIFIED BY user4;

--  oracle 10 이상에서
--  TABLESPACE를 통째로 backup하고 다른곳에 옮겨서 사용할 수 있도록 하는
--  방법이 있다










