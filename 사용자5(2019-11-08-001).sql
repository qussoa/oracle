-- user5 환경 
-- 데이터를 저장하기 위해 새로운 테이블 생성
-- 간단한 메모를 저장하기 위한 테이블 생성
/*
메모를 작성한 입자
작성시각
작성자
제목 
내용
중요도
약속장소
*/
/*
PK 설정
PK는 테이블의 데이터가 완벽하도록 보장하기 위한 중요한 개념
객체 무결성 보장 
*/
CREATE TABLE tbl_memo(
    m_seq NUMBER PRIMARY KEY,
    m_date VARCHAR2(10) NOT NULL,
    m_time VARCHAR2(8) NOT NULL,
    m_auth nVARCHAR2(20) NOT NULL,
    m_subject nVARCHAR2(125) NOT NULL,
    m_text nVARCHAR2(1000),
    m_flag VARCHAR2(1),
    m_field nVARCHAR2(20),
    m_ok VARCHAR2(1)
);
DROP TABLE tbl_memo;
-- tbl_memo(projection)
-- projection : 칼럼 나열하는 것
INSERT INTO tbl_memo(m_seq,m_date,m_time,m_auth,m_subject)
VALUES(1,'2019-11-08','09:44:00','홍길동','메모작성');
/*
    INSERT를 수행할 때 칼럼을 나열하지 않고
    (projection을 생략할 수 있다)
    INSERT INTO tbl_memo VALUES(.....)
    1. 전체 칼럼에 모든 데이터를 다입력하고 데이터를 추가할때만 가능
    2. TABLE의 칼럼 순서대로 데이터를 나열해야한다.
    
    만약 업무(project)가 진행되는 과정에서 table의 칼럼순서가 구조가 변경되는 경우
    칼럼을 추가하고자 할 경우 보통 table구조에서 끝부분에 칼럼이 추가되는데
    이때는 데이터가 순서대로 원하는 칼럼에 저장될 것이다라는 보장을 할 수 없다
    
*/
SELECT * FROM tbl_memo;

-- m_seq 칼럼의 값이 1인 데이터가 추가된 상태에서
-- 다시 m_seq칼럼의 값이 1인데이터를 또 추가하려면 
--  pk규칙에 어긋나서 데이터가 추가되지 않는다
-- 이런 상황에서 새로운 데이터를 추가할때마다
-- m_seq 값을 기존값과 중복되지 않은 값을 찾아야하는데
-- 이방법이 업무징행에 매우 번거로운 작업이 된다
INSERT INTO tbl_memo(m_seq,m_date,m_time,m_auth,m_subject)
VALUES(1,'2019-11-08','09:44:00','홍길동','메모작성');

-- 만약 m_seq 칼럼의 값을 항상 새로운 값으로 만들수 잇는 방법이 있다면
-- 매우 편리할 것이다
-- 오라클에는 sequence라는 object를 사용하여
-- 해당 object의 특정한 method 를 호출하면 일련번호를 생성할 수 있다
-- SEQUENCE를 생성
-- SEQ_MEMO라는 시퀀스를 생성하고, 시작값을 1로 설정, 자동으로 1씩 증가하는 값으로
-- 새로운 값을 생성하라
CREATE SEQUENCE SEQ_MEMO
START WITH 1 INCREMENT BY 1;

-- SEQ.NEXTVAL : 메서드와 같은 형식이고
-- SELECT INSERT UPDATE 명령문 내에서 사용이 되면
-- 설정한 옵션에 따라 자동으로 값을 생성해 낸다
SELECT SEQ_MEMO.NEXTVAL FROM DUAL;

INSERT INTO tbl_memo(m_seq,m_date,m_time,m_auth,m_subject)
VALUES(SEQ_MEMO.nextval,'2019-11-08','09:44:00','홍길동','메모작성');

SELECT * FROM tbl_memo;

-- 현재 추가된 데이터에서 m_seq가 10인 데이터만 확인을 하고 싶다

SELECT * FROM tbl_memo
WHERE m_seq = 10;

-- m_seq가 10인 레코드의 작성자 이름이 홍길동 -> 성춘향

UPDATE tbl_memo 
SET m_auth = '성춘향'
WHERE m_seq = 12;

select * from tbl_memo;

-- 데이터를 삭제할때
DELETE FROM tbl_memo
WHERE m_seq = 15;

-- CRUD 
-- INSERT INTO : IIV
-- SELECT FROM : SF
-- UPDATE SET WHERE : USW
-- DELETE FROM WHERE : DFW

-- DDL
-- CREATE : 생성 
-- ALTER : 변경
-- DROP : 삭제

CREATE TABLE tbl_iolist(
Io_seq	NUMBER		        PRIMARY KEY,
io_date	VARCHAR2(10)	        NOT NULL	,
io_pname	NVARCHAR2(25)   	NOT NULL,	
io_dname	NVARCHAR2(25)	    NOT NULL,	
io_dceo	NVARCHAR2(25)   	    NOT NULL	,
io_inout	NVARCHAR2(2)	        NOT NULL	,
io_qty	NUMBER	            NOT NULL	,
io_price	NUMBER,
io_total	NUMBER		
);

CREATE TABLE tbl_product(
p_code	VARCHAR2(5)		PRIMARY KEY,
p_name	NVARCHAR2(50)   	NOT NULL	,
p_iprice	NUMBER,		
p_oprice	NUMBER,		
p_vat	VARCHAR2(5)		
);

CREATE TABLE tbl_dept(
d_code	VARCHAR2(5)		PRIMARY KEY,
d_name	NVARCHAR2(50)	NOT NULL,	
d_ceo	NVARCHAR2(50)	NOT NULL,	
d_tel	VARCHAR2(50),		
d_addr	NVARCHAR2(125)		
);

SELECT COUNT(*) FROM tbl_iolist;
SELECT COUNT(*) FROM tbl_product;
SELECT COUNT(*) FROM tbl_dept;

-- 매입, 매출 구분 레코드 개수 알아보기
SELECT IO_INOUT,COUNT(*) FROM tbl_iolist
GROUP BY io_inout;

-- 매입, 매출 구분 합계
SELECT IO_INOUT, SUM(IO_TOTAL) FROM TBL_IOLIST
GROUP BY io_inout;

-- 매입 매출 PIVOT
SELECT DECODE(IO_INOUT,'매입',IO_TOTAL,0) AS 매입,
         DECODE(IO_INOUT,'매출',IO_TOTAL,0) AS 매출
from tbl_iolist;

-- 매입 매출의 합계 pivot

SELECT SUM(DECODE(IO_INOUT,'매입',IO_TOTAL,0)) AS 매입총계,
         SUM(DECODE(IO_INOUT,'매출',IO_TOTAL,0)) AS 매출총계
from tbl_iolist;

-- 매입매출 합계 월별 부분 합을 구하여 PIVOT방식으로 알아보기

SELECT 
         SUBSTR(IO_DATE,0,7) 월별,
         SUM(DECODE(IO_INOUT,'매입',IO_TOTAL,0)) AS 매입총계,
         SUM(DECODE(IO_INOUT,'매출',IO_TOTAL,0)) AS 매출총계
from tbl_iolist
GROUP BY SUBSTR(IO_DATE,0,7);

-- 매입, 매출 합계를 거래처별로 부분합 구하여 PIVOT방식으로 알아보기
-- IO_DNAME 거래처명이 중복이 없다는 가정하에
SELECT 
         IO_DNAME,
         SUM(DECODE(IO_INOUT,'매입',IO_TOTAL,0)) AS 매입총계,
         SUM(DECODE(IO_INOUT,'매출',IO_TOTAL,0)) AS 매출총계
from tbl_iolist
GROUP BY IO_DNAME;

SELECT 
         IO_DNAME, IO_DCEO,
         SUM(DECODE(IO_INOUT,'매입',IO_TOTAL,0)) AS 매입총계,
         SUM(DECODE(IO_INOUT,'매출',IO_TOTAL,0)) AS 매출총계
from tbl_iolist
GROUP BY IO_DNAME,IO_DCEO;

-- 거래명세와 거래처 TABLE을 JOIN하여 확인하기
-- EQ JOIN (INNER JOIN) JOIN하는 테이블이 서로 참조무결성이 보장되는 경우
-- 참조무결성이 위배되는 경우 테이블을 EQ JOIN을 실행하면 
-- 보여지는 데이터가 누락될 수 있다
SELECT * 
FROM tbl_iolist, tbl_dept
WHERE IO_DNAME = D_NAME AND IO_DCEO = D_CEO;

-- 참조무결성이 설정되지 않은 table간의 JOIN
-- 참조 무결성에 위배되는 데이터는 null로 표현된다
SELECT *
FROM tbl_iolist IO
        LEFT JOIN tbl_dept D
            ON io.io_dname = d.d_name and io.io_dceo= d.d_ceo;
            
SELECT *
FROM tbl_iolist IO
    left join tbl_dept D
        on io.io