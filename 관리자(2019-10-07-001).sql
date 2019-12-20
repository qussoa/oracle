-- 여기는 관리자 화면입니다
-- 새로운 TABLESPACE 생성
-- 이름 : user3_db
-- datafile : /bizwork/oracle/data/user3.dbf
-- 초기크기 : 10Mbyte
-- 자동확장, 크기는 1Kbyte

CREATE TABLESPACE user3_db
DATAFILE '/bizwork/oracle/data/user3.dbf'
SIZE 10M AUTOEXTEND ON NEXT 1K;

-- 개념 Schema
-- DBMS 차원에서 바라본 Schema
-- 논리적인 개념으로 Table 등과 같은 저장소 Object를 모아놓은 그룹

-- Oracle에서는 USER개 개념 Schema 역할을 수행

-- 새로운 유저 생성
-- ID user3
-- PW 1234
-- default tablespace user3_db

CREATE USER user3 IDENTIFIED BY 1234
DEFAULT TABLESPACE user3_db;

-- 생성된 사용자에게 DB 접근 권한을 부여
-- 학습의 편리성을 위해 DBA 권한을 부여
GRANT DBA TO user3;
