--SQL 명령들을 사용해서 DBMS학습 진행
-- 오라클 11g의 명령세트를 학습
-- 현재 최신 오라클은 19c 
-- 현업에서 사용하는 오라클 DBMS SW 들이 아직 하위버전을 사용하고 있어서
-- 11위주의 명령세트를 학습하게 된다 

-- 마이그레이션 
-- 버전업, 업그레이드
-- 하위버전에서 사용하던 데이터베이스를 상위버전 또는 다른회사의 DBMS에서 사용할수 있도록
-- 변환, 변경, 이전 하는 것들

-- 오라클 DBMS SW(오라클DB, 오라클 )를 이용 DB관리 명령어를 연습하기 위해
-- 연습용 데이터 저장공간을 생성할 것이다
-- 오라클에서는 Storage에 생성한 물리적 저장공간을 TABLESPACE라고한다
-- 기타 My SQL MSSQL 등의 DBMS SW들은 물리적 저장공간을 DATABASE라고 한다

-- DDL 명령을 사용해서 TABLE  SPACE를 생성한다
-- DDL 명령을 사용하는 사용자는 DBA

-- DDL 명령에서 생성한다 : CREATE
-- 물리 SCHEMA를 생성한다
CREATE TABLESPACE ; -- TABLESPACE 생성하기
CREATE USER; -- 새로운 접속사용자를 생성하기
CREATE TABLE; -- 구체적인 데이터를 저장할 공간을 생성하기

-- DDL 명령에서 삭제한다 : DROP
-- DDL 명령에서 변경한다 : ALTER

-- C:\bizwork\oracle\data
-- C:/bizwork/oracle/data
CREATE TABLESPACE user1_DB 
DATAFILE 'C:/bizwork/oracle/data/user1.dbf'
SIZE 100M ; 

DROP TABLESPACE user1_DB
INCLUDING CONTENTS AND DATAFILES
CASCADE CONSTRAINTS;

-- user1_DB 라는 이름으로 TABLESPACE를 만들어라
-- 물리적 저장공간은 C:/bizwork/oracle/data/user1.dbf이다
-- 초기에 100M(byte)만큼 공간을 확보 후 추가 공간 100K(byte)
CREATE TABLESPACE user1_DB 
DATAFILE 'C:/bizwork/oracle/data/user1.dbf'
SIZE 100M AUTOEXTEND ON NEXT 100K ;

-- 현재 이 화면에서 명령을 수행하는 사용자는 SYSDBA권한을 가진 자이다
-- SYSDBA 권한은  System DB등을 삭제하거나 변경할 수 있기 때문에
-- 실습환경에는 가급적 꼭 필요한 명령 외에는 사용하지 않는 것이 좋다

-- 실습을 위해서 새로운 사용자를 생성하자
-- 관리자가 user1 새로운 사용자를 등록하고
-- 임시로 비밀번호를 1234로 설정한다
-- 그리고 앞으로 user1으로 접속하여 데이터를 추가하면 
-- 데이터는 user1_DB TABLESPACE에 저장하라

CREATE USER user1 IDENTIFIED BY 1234 
DEFAULT TABLESPACE user1_DB;

-- 현재 설치된 오라클 DB에 생성되어 있는 사용자들을 보여달라
SELECT *FROM ALL_USERS;

-- DML SELECT 명령은 데이터를 생성,수정,삭제 후 
-- 정상적으로 수행되었나를 확인하는 용도로 사용된다

-- 오라클에서는 관리자가 새로운 사용자를 생성하면
-- 아무런 권한도 없는 상태로 인식한다
-- 새로 생성된 사용자는 id, pw를 입력하도 접속자체가 불가하다
-- 관리자는 새로 생성된 사용자에게 DBMS에 접속할 수 있는 권한을 부여
-- 권한과 관련된 명령어 셋을 DCL라고한다
-- 권한과 관련된 keyword

-- 권한을 부여 : GRANT
-- 권한을 상실 : REVOKE    
-- 새로 생성한 user1 권한 부여 연습
GRANT CREATE SESSION TO user1;
GRANT DBA TO user1;
REVOKE DBA FROM user1;
