-- 여기는 user3 화면입니다 

CREATE TABLE tbl_books(

       b_isbn	VARCHAR2(13)		PRIMARY KEY,
       b_title	nVARCHAR2(50)		NOT NULL,
       b_comp	nVARCHAR2(51)		NOT NULL,
       b_writer	nVARCHAR2(52)		NOT NULL,
       b_price	NUMBER(5),
       b_year	VARCHAR2(10),		
       b_genre	VARCHAR2(3)		
);

INSERT INTO tbl_books( b_isbn, b_title, b_comp, b_writer, b_price)
VALUES ('979-001','오라클 프로그래밍','생능출판사','서진수',30000);

INSERT INTO tbl_books( b_isbn, b_title, b_comp, b_writer, b_price)
VALUES ('979-002','DO IT 자바','이지퍼블리싱','박은종',25000);

INSERT INTO tbl_books( b_isbn, b_title, b_comp, b_writer, b_price)
VALUES ('979-003','SQL 활용','교육부','교육부',10000);

INSERT INTO tbl_books( b_isbn, b_title, b_comp, b_writer, b_price)
VALUES ('979-004','무궁화꽃이피었습니다','새움','김진명',15000);

INSERT INTO tbl_books( b_isbn, b_title, b_comp, b_writer, b_price)
VALUES ('979-005','직지','쌤앤파커스','김진명',12600);

-- 추가된 도서 전체 목록 확인
SELECT * FROM tbl_books;

-- ISBN 순서로 목록 확인

SELECT * FROM tbl_books ORDER BY b_isbn;

-- tbl_books Table을 생성하고 데이터를 추가하다가 보니
-- 가격 칼럼의 자릿수가 부족하여 10만원 이상의 데이터를 추가할 수 없다
-- 데이터를 추가하기 전이라면 table 삭제하고 생성하면 되겠지만
-- 이미 데이터가 추가되어 있는 상황에서 table을 삭제하면
-- 데이터가 모두 소실되기 때문에 table을 유지하면서 칼럼의 자릿수를 늘려보자

-- DDL 3대 KEYWORD 
-- 생성 : CREATE
-- 삭제 : DROP
-- 변경 : ALTER
-- 상황이 이미 생성된 TABLE의 한 칼럼의 자릿수를 늘리려고 한다

ALTER TABLE tbl_books
MODIFY(b_price NUMBER(7));

-- 변경 후 TEST

INSERT INTO tbl_books( b_isbn, b_title, b_comp, b_writer, b_price)
VALUES('978-801','effective Java','Addison','Joshua Bloch',159000);

SELECT * FROM tbl_books;

-- 테이블을 처음 생성할 당시 생각지 못한 칼럼이 필요한 경우가 있다
-- 이미 생성된 테이블에 새로운 칼럼을 추가하기 
ALTER TABLE tbl_books
ADD(b_remark nVARCHAR2(125));

DESC tbl_books;

ALTER TABLE tbl_books
DROP COLUMN b_remark;

-- 칼럼의 이름 변경
ALTER TABLE tbl_books
RENAME COLUMN b_remark TO b_rem;

-- ALTER TABLE 명령을 수행할 때 매우 주의할 상항
-- 1,DROP COLUMN 
-- 기존에 사용하던 TABLE에서 칼럼을 삭제하면
-- 저장된 데이터가 변형되어 문제가 발생할 수 있음
-- 오라클은 명령 수행전에 절대 경고하지 않는다

-- 2. MODIFY
-- 칼럼의 타입을 변경하는 것으로 저장된 데이터가 변형될 수 있다
-- 가. 자릿수를 줄이면 : 보통 실행 오류가 발생한다
-- 그렇지 않은 경우도 있는데 이때는 저장된 데이터의 일부가 갈릴 수 있다
-- 나. 타입변경
-- 기존 데이터 형식이 변경되면서 데이터가 손실, 소실될 수 있다
-- 특히 CHAR 형과 VARCHAR2 사이에서 타입을 변경하면
-- 기존의 SQL(SELECT) 명령 결과가 전혀 엉뚱하게 나타나가나

-- 3. RENAME COLUMN
-- 칼럼의 이름을 변경하는 것은 데이터 변형이 잘되지는 않지만
-- 다른 SQL 명령문이나, 내장 프로시져, JAVA 프로그래밍에서 TABLE에 접근하여
-- 데이터를 CRUD를 실행할때 문제가 발생할 수 있다

-- 보통 테이블을 생성하거나 칼럼을 추가한 후로는 필요 없더라도 다른 문제가 없으면 
-- DROP, MODIFY 등을 수행하지 말자

-- 사용자의 비밀번호를 변경하기
-- 사용자 비밀번호는 보통 자신의 비밀번호를 변경하고
-- (SYS)DBA 역할에서는 다른 USER의 비밀번호를 변경하기도 한다

ALTER USER user3 IDENTIFIED BY 1234;

CREATE TABLE tbl_genre(
        g_code	VARCHAR2(3)		PRIMARY KEY,
        g_name	nVARCHAR2(15)	 NOT NULL,	
        g_remark	nVARCHAR2(125)		
        
);

INSERT INTO tbl_genre(g_code,g_name)
VALUES('001','프로그래밍');

INSERT INTO tbl_genre(g_code,g_name)
VALUES('002','데이터베이스');

INSERT INTO tbl_genre(g_code,g_name)
VALUES('003','장편소설');

ALTER TABLE tbl_genre MODIFY(g_name nVARCHAR2(50));

SELECT * FROM tbl_genre;

DESC tbl_books;
ALTER TABLE tbl_books MODIFY (b_genre nVARCHAR2(10));

-- 현재 BOOK 테이블에 추가된 데이터들에 장르칼럼이 비어있는 상태이다
-- 장르칼럼의 데이터를 채워넣기
SELECT * FROM tbl_books;

-- UPDATE를 실행할 때 2개 이상의 레코드에 영향을 미치도록
-- 명령을 수행하는 것은 특별한 경우가 아니면 지양을 하자
-- UPDATE 수행은 먼저 PK를 확인한후 WHERE 절에 PK조건을 설정하여 하자
UPDATE tbl_books
SET b_genre = '데이터베이스'
WHERE b_isbn = '979-001';

UPDATE tbl_books
SET b_genre = '데이터베이스'
WHERE b_isbn = '979-003';

UPDATE tbl_books
SET b_genre = '장편소설'
WHERE b_isbn = '979-004';


UPDATE tbl_books
SET b_genre = '프로그래밍'
WHERE b_isbn = '979-002';

UPDATE tbl_books
SET b_genre = '장편소설'
WHERE b_isbn = '979-005';


UPDATE tbl_books
SET b_genre = '프로그래밍'
WHERE b_isbn = '978-801';

SELECT * FROM tbl_books;

SELECT * FROM tbl_books
WHERE b_genre = '데이터베이스';

SELECT * FROM tbl_books
WHERE b_genre = '장편소설';

SELECT * FROM tbl_books;

-- books 테이블의 데이터 중에 장르가 장편소설인 데이터를 장르소설로 바꾸고 싶다

UPDATE tbl_books
SET b_genre = '장르소설'
WHERE b_genre = '장편소설';

SELECT * FROM tbl_books;

INSERT INTO tbl_books(b_isbn,b_title,b_comp,b_writer,b_price,b_genre)
VALUES ('979-006','황태자비납치사건','새움','김진명',25000,'장르소설');

SELECT * FROM tbl_books;

-- 장로소설만 보고 싶다

SELECT * FROM tbl_books
WHERE b_genre = '장르소설';

-- 도서정보 데이터를 저장하기 위해서 table을 생성후 
-- 많은 도서를 여러 사람이 입력하다 보니
-- 일부 데이터에 빈칸등이 잘못 삽입되어 데이터를 조회할때 
-- 문제가 발생했다
-- 장르별로 데이터를 조회했더니
-- 장르 이름은 같은데 일부 데이터가 조회되지 않는 형상을 발경
-- 이러한 논리적 문제를 해결하기 위해 '장르 테이블'을 하나 별도로 생성하고
-- books 테이블을 '정규화' 과정을 통해서 조회오류가 발생하지 않도록 해보자

SELECT * FROM tbl_genre;

-- 1. book테이블의 장르 칼럼에 저장된 문자열을 tbl_genre테이블에 잇는 코드 값으로 
--    변경하기

-- 가. 데이터베이스 장르 코드로 변경하기
SELECT * FROM tbl_books
WHERE b_genre = '데이터베이스';
UPDATE tbl_books
SET b_genre = '002'
WHERE b_genre = '데이터베이스';

SELECT * FROM tbl_books;

-- 나. 프로그래밍 장르코드로 변경하기
UPDATE tbl_books
SET b_genre = '001'
WHERE b_genre = '프로그래밍';

-- 다, 장르소설을 장편소설 코드로 변경하기
UPDATE tbl_books
SET b_genre = '003'
WHERE b_genre = '장르소설';

SELECT * FROM tbl_books;
SELECT * FROM tbl_genre;

-- 도서정보를 확인하면서 장르칼럼의 코드값 대신 장르 이름으로 보고 싶다
-- table JOIN 수행

-- 테이블 JOIN 수행 
-- 2개 이상의 테이블을 서로 연계해서 하나의 리스트로 보여주는 것
-- RELATION SHIP

SELECT * FROM tbl_books,tbl_genre
WHERE tbl_books.b_genre = tbl_genre.g_code;

SELECT tbl_books.b_isbn, tbl_books.b_title,
        tbl_books.b_comp, tbl_books.b_writer,
        tbl_books.b_genre,
      --  tbl_genre.g_code,
        tbl_genre.g_name
 FROM tbl_books,tbl_genre
WHERE tbl_books.b_genre = tbl_genre.g_code;


SELECT B.b_isbn, B.b_title,
        B.b_comp, B.b_writer,
        B.b_genre,
      --  tbl_genre.g_code,
        G.g_name
 FROM tbl_books B,tbl_genre G -- ANSI tbl_books AS B, tbl_genre AS G
WHERE B.b_genre = G.g_code;

INSERT INTO tbl_books(b_isbn,b_title,b_comp,b_writer,b_genre)
VALUES ('979-007','자바의정석','도을출판','남궁성','004');

SELECT * FROM tbl_books;

SELECT * FROM [table1],[table2]
WHERE table1.col = table2.col;
-- 완전 join, EQ join 이라고 하며
-- 결과를 카티션곱이라고 한다
-- table1과 table2 를 relation 할때
-- 서로 연결하는 칼럼의 값이 두 테이블에 모두 존재할떄
-- 정상적인 결과를 낼 수 있다
