-- 매입매출 
SELECT D_CODE,D_NAME,D_CEO,D_TEL,D_ADDR
FROM tbl_dept;

SELECT IO_SEQ,IO_DATE,IO_INOUT,IO_QTY,IO_PRICE,IO_TOTAL,IO_PCODE,IO_DCODE
FROM tbl_iolist;

SELECT P_CODE,P_NAME,P_IPRICE,P_OPRICE,P_VAT
FROM tbl_product;

ALTER TABLE tbl_iolist
ADD CONSTRAINT FK_PRODUCT
FOREIGN KEY (io_pcode)
REFERENCES tbl_product(p_code);

ALTER TABLE tbl_iolist
ADD CONSTRAINT FK_DEPT
FOREIGN KEY (io_dcode)
REFERENCES tbl_dept(d_code);

SELECT LEVEL FROM DUAL CONNECT BY LEVEL <= 10;
SELECT LEVEL FROM DUAL CONNECT BY LEVEL <= &LAST;

SELECT LEVEL*10 FROM DUAL CONNECT BY LEVEL <= 10;
SELECT LEVEL*&시작 FROM DUAL CONNECT BY LEVEL <= &종료;
SELECT (LEVEL-10)* -1 FROM DUAL CONNECT BY LEVEL <= 10;


SELECT IO_SEQ,IO_DATE,IO_INOUT,IO_QTY,IO_PRICE,IO_TOTAL,IO_PCODE,IO_DCODE
FROM tbl_iolist
WHERE io_date BETWEEN '&시작일자' AND '&종료일자';

SELECT TO_DATE('2019-02-01','YYYY-MM-DD') -1 + LEVEL FROM DUAL
CONNECT BY LEVEL <= TO_DATE('2019-09-30','YYYY-MM-DD')
- (TO_DATE('2019-02-01','YYYY-MM-DD')+1);


SELECT TO_CHAR(ADD_MONTHS(TO_DATE('2019-02-01','YYYY-MM-DD'), LEVEL -1),'YYYY-MM')
FROM DUAL CONNECT BY LEVEL  
<= TO_DATE('2019-09-30','YYYY-MM-DD')
- (TO_DATE('2019-02-01','YYYY-MM-DD')+1);

SELECT TO_CHAR( ADD_MONTHS(TO_DATE('2019-01-01','YYYY-MM-DD'),LEVEL-1),'YYYY-MM')
FROM DUAL
CONNECT BY LEVEL <5;

-- 현재날짜
SELECT SYSDATE FROM DUAL;
-- 현재 날짜가 포함된 달의 마지막 날짜
SELECT LAST_DAY(SYSDATE) FROM DUAL;
SELECT TO_CHAR( TRUNC(SYSDATE,'MONTH') + (LEVEL -1),'YYYY-DD')
FROM DUAL CONNECT BY LEVEL <=(LAST_DAY(SYSDATE)-TRUNC(SYSDATE,'month')+1);

-- 2018년 1월 1일부터 12월까지의 달수

SELECT * FROM
tbl_iolist IO,
(
SELECT TO_CHAR( ADD_MONTHS(TO_DATE('2018-01-01','YYYY-MM-DD'),LEVEL-1),'YYYY-MM') AS 월
FROM DUAL
CONNECT BY LEVEL <= 12
);

SELECT TO_CHAR(ADD_MONTHS(TO_DATE(io_date,'YYYY-MM-DD'),0),'YYYY-MM') FROM tbl_iolist;


-- 월 리스트를 서브쿼리로 생성한 다음 월별합계
SELECT 월, SUM(io_total)
FROM tbl_iolist IO,
(
SELECT TO_CHAR( ADD_MONTHS(TO_DATE('2018-01-01','YYYY-MM-DD'),LEVEL-1),'YYYY-MM') AS 월
FROM DUAL
CONNECT BY LEVEL <= 12
)
WHERE 월 = SUBSTR(io_date,0,7)
GROUP BY 월;
--1500000, 12250
SELECT MIN(io_total),MAX(io_total) FROM tbl_iolist;

-- SUBQ 10000부터 1500000까지 10000씩 증가하는 값을 생성
-- 각각의 값 범위 10000부터 20000의 합계와 개수를 연산
SELECT SUB.TOTAL, SUM(io_total), COUNT(io_total)
FROM tbl_iolist,
(SELECT LEVEL*10000 AS TOTAL FROM DUAL CONNECT BY LEVEL <= 150) SUB
WHERE io_total >= SUB.TOTAL AND io_total < SUB.TOTAL +10000 
AND io_inout = '매출'
GROUP BY TOTAL
ORDER BY TOTAL;


-- SUBQ와 EQ JOIN으로
-- 학생수가 있는 점수대만 보여주기
SELECT 점수, COUNT(SC.sc_score)
FROM tbl_score SC,
(
SELECT LEVEL * 10 AS 점수 FROM DUAL CONNECT BY LEVEL <= 10)SUB
 WHERE sc.sc_score >= 점수 AND sc.sc_score <= 점수 + 10
GROUP BY 점수
ORDER BY 점수;

--SUBQ와 LEFT JOIN 을 같이 묶어서
-- 학생수가 없는 점수대도 같이 보여주기
SELECT 점수, COUNT(SC.sc_score)
FROM (
SELECT LEVEL * 10 AS 점수 FROM DUAL CONNECT BY LEVEL <= 10)SUB
    LEFT JOIN tbl_score SC
        ON sc.sc_score >= 점수 AND sc.sc_score <= 점수 + 10
GROUP BY 점수
ORDER BY 점수;

SELECT LEVEL*0.1 FROM DUAL CONNECT BY LEVEL <= &변수;

-- sc_subject 칼럼에 들어있는 과목명의 리스트

SELECT sc_subject from tbl_score
GROUP BY sc_subject
ORDER BY sc_subject;

-- sc_subject 칼럼에 들어있는 과목명의 리스트
-- 제 1정규화가 되어있는 데이터를 보고서형태로 보여주는 SQL
SELECT *
FROM (SELECT sc_name, sc_subject, sc_score FROM tbl_score)
PIVOT(
    SUM(sc_score)
    FOR sc_subject
    IN (
        '과학' AS 과학,
        '국사' AS 국사,
        '국어' AS 국어,
        '미술' AS 미술,
        '수학' AS 수학,
        '영어' AS 영어
    )
);

SELECT sc_name,
    SUM(DECODE(sc_subject,'과학', sc_score)) AS 과학,
    SUM(DECODE(sc_subject,'국사', sc_score)) AS 국사,
    SUM(DECODE(sc_subject,'국어', sc_score)) AS 국어,
    SUM(DECODE(sc_subject,'미술', sc_score)) AS 미술,
    SUM(DECODE(sc_subject,'수학', sc_score)) AS 수학,
    SUM(DECODE(sc_subject,'영어', sc_score)) AS 영어
FROM tbl_score
GROUP BY sc_name;

SELECT sc_name,
    DECODE(sc_subject,'과학', sc_score) AS 과학,
    DECODE(sc_subject,'국사', sc_score) AS 국사,
    DECODE(sc_subject,'국어', sc_score) AS 국어,
    DECODE(sc_subject,'미술', sc_score) AS 미술,
    DECODE(sc_subject,'수학', sc_score) AS 수학,
    DECODE(sc_subject,'영어', sc_score) AS 영어
FROM tbl_score
GROUP BY sc_name,
    DECODE(sc_subject,'과학', sc_score,0),
    DECODE(sc_subject,'국사', sc_score,0),
    DECODE(sc_subject,'국어', sc_score,0),
    DECODE(sc_subject,'미술', sc_score,0),
    DECODE(sc_subject,'수학', sc_score,0),
    DECODE(sc_subject,'영어', sc_score,0) 
ORDER BY sc_name;

-- CASE WHEN 표준 SQL에 포함된 연산자
SELECT sc_name,
SUM(CASE WHEN sc_subject = '과학' THEN sc_score END) AS 과학,
SUM(CASE WHEN sc_subject = '국사' THEN sc_score END) AS 국사,
SUM(CASE WHEN sc_subject = '국어' THEN sc_score END) AS 국어,
SUM(CASE WHEN sc_subject = '미술' THEN sc_score END) AS 미술,
SUM(CASE WHEN sc_subject = '수학' THEN sc_score END) AS 수학,
SUM(CASE WHEN sc_subject = '영어' THEN sc_score END) AS 영어
FROM tbl_score
GROUP BY sc_name;

SELECT sc_name,
SUM(CASE WHEN sc_subject = '과학' THEN sc_score ELSE 0 END) AS 과학,
SUM(CASE WHEN sc_subject = '국사' THEN sc_score ELSE 0 END) AS 국사,
SUM(CASE WHEN sc_subject = '국어' THEN sc_score ELSE 0 END) AS 국어,
SUM(CASE WHEN sc_subject = '미술' THEN sc_score ELSE 0 END) AS 미술,
SUM(CASE WHEN sc_subject = '수학' THEN sc_score ELSE 0 END) AS 수학,
SUM(CASE WHEN sc_subject = '영어' THEN sc_score ELSE 0 END) AS 영어
FROM tbl_score
GROUP BY sc_name;

SELECT io_inout,
    SUM(DECODE(io_inout, '매입', io_total,0)) AS 매입,
    SUM(DECODE(io_inout, '매출', io_total,0)) AS 매출
FROM tbl_iolist
GROUP BY io_inout;


SELECT 
    SUM(DECODE(io_inout, '매입', io_total,0)) AS 매입,
    SUM(DECODE(io_inout, '매출', io_total,0)) AS 매출
FROM tbl_iolist;


SELECT 
 SUM(DECODE(io_inout, '매입', io_total,0)) AS 매입,
    SUM(DECODE(io_inout, '매출', io_total,0)) AS 매출,
    
    SUM(DECODE(io_inout, '매출', io_total,0)) -
    SUM(DECODE(io_inout, '매입', io_total,0)) AS 마진
FROM tbl_iolist;


SELECT 
    TO_CHAR(SUM(DECODE(io_inout, '매입', io_total,0)),'999,999,999,999,999') AS 매입,
    TO_CHAR(SUM(DECODE(io_inout, '매출', io_total,0)),'999,999,999,999,999') AS 매출,
    
    TO_CHAR(SUM(DECODE(io_inout, '매출', io_total,0)) -
    SUM(DECODE(io_inout, '매입', io_total,0)),'999,999,999,999,999') AS 마진
FROM tbl_iolist;

-- 월별 집계
SELECT 
    SUBSTR(io_date,0,7),
    SUM(DECODE(io_inout, '매입', io_total,0)) AS 매입,
    SUM(DECODE(io_inout, '매출', io_total,0)) AS 매출
FROM tbl_iolist
GROUP BY SUBSTR(io_date,0,7)
ORDER BY SUBSTR(io_date,0,7);

-- 거래처별로 매입매출 집계
-- 거래처테이블과 join
SELECT 
    io_dcode, d_name,d_ceo, d_tel,
    SUM(DECODE(io_inout, '매입', io_total,0)) AS 매입,
    SUM(DECODE(io_inout, '매출', io_total,0)) AS 매출
FROM tbl_iolist IO
    LEFT JOIN tbl_dept D
        ON IO.io_dcode = d.d_code
GROUP BY io_dcode, d_name,d_ceo, d_tel
ORDER by io_dcode;

-- select의 projection 부분에서
-- 계산식을 사용할 경우
-- group by 에는 계산식을 모두 기술해 주어야한다
-- alais 부분은 group by 에서 인식하지 않는다
-- having도 계산식을 모두 기술해주어야한다
SELECT 
    io_dcode, d_name || d_ceo || d_tel AS 거래처,
    SUM(DECODE(io_inout, '매입', io_total,0)) AS 매입,
    SUM(DECODE(io_inout, '매출', io_total,0)) AS 매출
FROM tbl_iolist IO
    LEFT JOIN tbl_dept D
        ON IO.io_dcode = d.d_code
GROUP BY io_dcode, d_name || d_ceo || d_tel
HAVING SUM(DECODE(io_inout, '매입', io_total,0)) > 100000
ORDER by io_dcode;

SELECT io_date, io_pcode, p_name,
    DECODE(io_inout,'매입', io_price) AS 매입단가,
    DECODE(io_inout,'매입', io_total) AS 매입합계,
    DECODE(io_inout,'매출', io_price) AS 매출단가,
    DECODE(io_inout,'매출', io_total) AS 매출합계
FROM tbl_iolist, tbl_product
WHERE io_pcode = p_code
ORDER BY io_date;

SELECT io_date, io_dcode, d_name, io_pcode, p_name,
    DECODE(io_inout,'매입', io_price) AS 매입단가,
    DECODE(io_inout,'매입', io_total) AS 매입합계,
    DECODE(io_inout,'매출', io_price) AS 매출단가,
    DECODE(io_inout,'매출', io_total) AS 매출합계
FROM tbl_iolist
    LEFT JOIN tbl_product
        ON io_pcode = p_code
    LEFT JOIN tbl_dept
        ON io_dcode = d_code
ORDER BY io_date;













