-- 여기는 사용자 user4 화면

/*
테이블 생성
    이름 : tbl_books
    칼럼 
        코드 : b_code, VARCHAR(4)
        이름 : b_name, VARCHAR(50)
        출판사 : b_comp, VARCHAR(50)
        저자 : b_writer, VARCHAR(20)
        가격 : b_price, INT
        
    이리련번호 이기 때문에 일다 칼럼을 NUMBER로 설정해서
    1~ 입력순서대로 번호를 부여
    
    요구사항 2 
    기존에 입력된 번호와 다른 새로운 번호를 사용해서 데이터를 입력
    
    요구사항 3
    데이터를 입력할 때 일련번호를 기억하기 힘들 때 항상 새로운 번호로 일련번호를 생성하여
    데이터를 추가할 수 있도록 하기
    
    요구사항 4
    입력된 데이터 중에서 b_price는 숫자값인데 값이 없이 추가가 되면 (null)형태가 된다
    이럴경우 프로그래밍 언어에서 데이터를 가져다 사용할 때 
    문제를 일으킬 수 있다
    가격 칵ㄹ럼에 값이 없이 데이터가 추가되면 자동으로 0을 채우도록 하기
    
*/

CREATE TABLE tbl_books(

b_code    NUMBER PRIMARY KEY,
b_name   VARCHAR2(50) NOT NULL,
b_comp  VARCHAR2(50),
b_writer  VARCHAR2(20),
b_price   NUMBER DEFAULT 0
);

INSERT INTO tbl_books (b_code, b_name, b_comp, b_writer)
VALUES (1,'자바입문','이지퍼블','박은종');

SELECT * FROM tbl_books;

/*
테이블의 칼럼 순서가 정확하다는 보장이 있고
모든 칼럼에 데이터가 있다라는 보장이 있을때
INSERT 명령문에 projection(칼럼을 리스트)하지 않아도
데이터만 정확히 나열하여 명령을 수행할 수 있다

하지만 가급적 사용 자제
*/
INSERT INTO tbl_books
VALUES(2,'오라클','생능','서진수',35000);

/*
데이터를 추가할 때마다 b_code칼럼의 값을 새로 생성하고 싶을 때 
1. Random()
    -- 숫자가 일련번호가 아닌 뒤죽박죽된 순서로 나타나고
    -- 컴퓨터의 random값은 완전한 random 아니기 때문에
        간혹 중복값이 나타날 수 있다
    -- 일련번호를 값으로 PK로 설정할 경우 
       일반적인 경우 일련번호는 데이터가 추가된 순서가 된다
       하지만 RANDOM을 사용하면 그러한 조건을 만들 수 없다
2. 일련번호를 순서대로 자동으로 생성하도록 칼럼을 설정하기 
    -- 오라클 11 이하에서는 불가능
    -- mysql,msql 등등에서는 AUTO INCREAMENT라는 옵션을 칼럼에 부여하면된다
    -- 오라클 12이상에서는 가능
*/

INSERT INTO tbl_books(b_code, b_name)
VALUES(ROUND(DBMS_RANDOM.VALUE(10000000000,999999999),0),'연습도서');

SELECT * FROM tbl_books;

/*
    SEQUENCE 객체(OBJECT)를 사용하여 만드는 방법
    다른 DBMS의 AUTO INCREAMENT 기능 대체하여 사용하는 방법
*/

-- 1부터 (START, WITH), 1씩 증가(INCREMENT BY 1)라는 형태로
-- 숫자값을 생성하는 시퀀스 객체 생성
CREATE SEQUENCE SEQ_BOOKS
START WITH 1 INCREMENT BY 1;

SELECT SEQ_BOOKS.NEXTVAL FROM DUAL;

INSERT INTO tbl_books(b_code,b_name)
VALUES(SEQ_BOOKS.NEXTVAL,'시퀀스연습');
SELECT * FROM tbl_books;

-- 기존에 생성된 테이블 SEQ 적용

/*
    매입매출에서
    tbl_iolist에 데이터를 추가하면서 엑셀로 데이터를 정리하고
    SEQ 칼럼을 만든 다음 일련번호를 추가해 주었다
    새로 만든 앱에서 데이터를 추가할 때 SEQUNCE를 사용하고자한다
    
    1. 기족 데이터의 SEQ칼럼의 최대값이 얼마인가를 확인 : 589
    2. 새로운 SEQUNCE 생성시 START WIHT : 600로 설정
*/

CREATE SEQUENCE SEQ_IOLIST
START WITH 1 INCREMENT BY 1;

/*
    만약 실수로 SEQ 시작값을 잘 못 설정했을 경우
    
*/

ALTER SEQUENCE SEQ_IOLIST START WITH 600;

ALTER SEQUENCE SEQ_IOLIST INCREMENT BY 600;
SELECT SEQ_IOLIST.NEXTVAL FROM DUAL;
ALTER SEQUENCE SEQ_IOLIST INCREMENT BY 1;

-- 쉬운 방법

DROP SEQUENCE SEQ_IOLIST;
CREATE SEQUENCE SEQ_IOLIST
START WITH 1000 INCREMENT BY 1;

SELECT SEQ_IOLIST.nextval FROM DUAL;
-- 현재 SEQ_IOLIST 값
-- 간혹 현재 SEQ_IOLSIT의 실제값이 아닌 값을 알려주는 경우가 있다
SELECT SEQ_IOLIST.CURRVAL FROM DUAL;

/*
    TABLE에 특정할 수 있는 PK가 있는 경우는
    해당하는 값을 INSERT를 수행하면서 입려가는것이 좋고
    
    그렇지 못할 경우 SEQUENCE를 사용하여 일련번호 형식으로 지정
*/

/*
    도서 코드를 
    B0001 형식으로 일련번호를 만들고 싶다
    이 방신은 ORACLE이외의 다른 DBMS에서는 상당히 복잡하다
*/

DROP TABLE tbl_books;

CREATE TABLE tbl_books(

b_code    VARCHAR2(5) PRIMARY KEY,
b_name   nVARCHAR2(50) NOT NULL,
b_comp   nVARCHAR2(50),
b_writer  nVARCHAR2(20),
b_price   NUMBER DEFAULT 0
);

SELECT 'B' || TRIM(TO_CHAR(SEQ_BOOKS.NEXTVAL,'0000')) FROM DUAL;
-- b_code : B0001 ~ 생성하기
-- TO_CHAR(값,포멧형)
-- TO_CHAR(숫자, '0000') : 자릿수를 4개로 설정하고, 공백부분을 0으로 채워라
-- TO_CHAR(숫자, '9999') : 자릿수를 4개로 설정하고, 남는 부분은 공백으로 둬라
-- TRIM() 문자열의 앞과 뒤의 공백제거, 중간공백은 제거 불가
-- LTRIM, RTRIM

INSERT INTO tbl_books( b_code, b_name)
VALUES( 'B' || TRIM(TO_CHAR(SEQ_BOOKS.NEXTVAL,'0000')), 'SEQ연습');

-- 오라클의 고정길이 문자열 생성
/*
    원래 값이 숫자형일 경우 
    TO_CHAR(값, 포맷형) 
    
    원래 값이 다양한 형일 경우
    LPAD(값, 총길이, 채움문자)
    RPAD(값, 총길이, 채움문자)
*/
-- LPAD
-- 총길이를 10개로 하고 공백은 *로 표시하여 문자열 생성하기
SELECT LPAD(30,10,'*') FROM DUAL;

--RPAD
SELECT RPAD(30,10,'A') FROM DUAL;
SELECT 'B' || LPAD(SEQ_BOOKS.NEXTVAL,4,'0') FROM DUAL;

SELECT RPAD('우리',20,' ') FROM DUAL
UNION ALL SELECT RPAD('대한민국',20,' ') FROM DUAL
UNION ALL SELECT RPAD('미연방합중국',20,' ') FROM DUAL
UNION ALL SELECT RPAD('중화인민공화국',20,' ') FROM DUAL;


SELECT LPAD('우리',20,' ') FROM DUAL
UNION ALL SELECT LPAD('대한민국',20,' ') FROM DUAL
UNION ALL SELECT LPAD('미연방합중국',20,' ') FROM DUAL
UNION ALL SELECT LPAD('중화인민공화국',20,' ') FROM DUAL;

SELECT * FROM tbl_books;
INSERT INTO tbl_books(b_code, b_name)
VALUES ('B' || TRIM(TO_CHAR(SEQ_BOOKS.NEXTVAL,'0000')),'SEQ연습');

INSERT INTO tbl_books(b_code, b_name)
VALUES ('B'||LPAD(SEQ_BOOKS.NEXTVAL,4,'0'),'SEQ연습2');

SELECT *FROM tbl_books;















