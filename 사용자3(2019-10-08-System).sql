-- 여기는 user3화면입니다

-- 오라클 전용 system 쿼리
-- 현재 사용중인 DBMS 엔진의 전역적 명칭, 정복확인
SELECT * FROM V$database; 

-- 현재 사용자가 접근(CRUD)를 할수 있는 TABLE 목록
SELECT * FROM TAB;

-- DBA급 이상의 사용자가 리스트를 확인할 수 있는 명령
SELECT * FROM ALL_TABLES;

-- tbl_books 의 테이블 구조(CREATE TABLE 생성시 모양)
DESC tbl_books;
DESCRIBE tbl_books;

-- SELECT * FROM TAB 과 유사한 형태
-- 사용자 권한에 따라 FROM TAB과 다른 리스트가 출력되가도 한다
SELECT *FROM user_tables;

