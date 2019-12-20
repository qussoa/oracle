-- 여기는 user3화면

CREATE TABLE tbl_student(
        st_num	VARCHAR2(3)		PRIMARY KEY,
        st_name	Nvarchar2(50)	NOT NULL	,
        st_tel	vaRCHAR2(20)	,	
        st_addr	nvarchar2(125)	,	
        st_grade	NUMBER(1)		,
        st_dept	VARCHAR2(3)		
);

SELECT COUNT( *) FROM tbl_student;
SELECT * FROM tbl_student;

SELECT * FROM tbl_score2;
SELECT * FROM tbl_score;

SELECT
    *
FROM tbl_score, tbl_student
WHERE tbl_score.s_num = tbl_student.st_num;

SELECT * FROM tbl_score SC, tbl_student ST
WHERE sc.s_num = st.st_num;

-- 보고자 하는ㄴ 칼럼만 나열해서 필요한 정보만 확인하기
-- SELECT * 는 데-이터가 많은 경우 조회하는데 다소 시간을 요구하기에
-- SELECT 수행할 때 보고자하는 칼럼만 나열하는 것이 효율성이 좋다

SELECT sc.s_num, st.st_name,sc.s_kor,sc.s_eng,sc.s_math 
FROM tbl_score SC, tbl_student ST
WHERE sc.s_num = st.st_num;

-- 성적데이터에 임의의 데이터를 추가
INSERT INTO tbl_score(s_num,s_kor,s_eng,s_math)
VALUES('101',99,88,77);

-- 학생테이블의 정보에 새로운 학생 정보를 추가하지 않은 상태에서 
-- 성적정보만 추가를 하는 경우
-- EQ JOIN을 실행하면 새로운 학생정보의 성적은 출력이 되지 않는다

SELECT sc.s_num, st.st_name,sc.s_kor,sc.s_eng,sc.s_math 
FROM tbl_score SC, tbl_student ST
WHERE sc.s_num = st.st_num;

-- SCORE TABLE STUDENT TABLE간의 참조무결성이 유지 되지 않고 있는 상황
-- 참조무결성이 완전하지 않은 경우 EQ JOIN으로 데이터를 조회하면 안된다
-- 실제 저장되어 있는 데이터들이 누락되어 출력되기 때문이다
-- LEFT JOIN을 활용하여 조회하기

SELECT  sc.s_num, st.st_name,sc.s_kor,sc.s_eng,sc.s_math 
FROM tbl_score SC
LEFT JOIN tbl_student ST
ON sc.s_num = st.st_num;


SELECT  sc.s_num, st.st_name,sc.s_kor,sc.s_eng,sc.s_math,
            sc.s_kor+sc.s_eng+sc.s_math AS 총점,
            ROUND((sc.s_kor+sc.s_eng+sc.s_math)/3,0) AS 평균
FROM tbl_score SC
LEFT JOIN tbl_student ST
ON sc.s_num = st.st_num;

--SCORE2 데이터 추가하기

DESC tbl_score2;

SELECT sc.s_num, st.st_name,sc.s_kor,sc.s_eng,sc.s_math,
            sc.s_kor+sc.s_eng+sc.s_math AS 총점,
            ROUND((sc.s_kor+sc.s_eng+sc.s_math)/3,0) AS 평균
 
FROM tbl_score2 SC
    LEFT JOIN tbl_student ST
            ON sc.s_num = st.st_num;
            
INSERT INTO tbl_dept(d_num, d_name,d_pro)
VALUES ('001','컴퓨터공학','홍길동');
INSERT INTO tbl_dept(d_num, d_name,d_pro)
VALUES ('002','영어','성춘향');
INSERT INTO tbl_dept(d_num, d_name,d_pro)
VALUES ('003','경영학','임꺽정');
INSERT INTO tbl_dept(d_num, d_name,d_pro)
VALUES ('004','정치경제','장보고');
INSERT INTO tbl_dept(d_num, d_name,d_pro)
VALUES ('005','군사학','이순신');

ALTER TABLE tbl_dept  MODIFY (d_pro NVARCHAR2(3));

SELECT sc.s_num,dp.d_name,dp.d_pro,sc.s_kor
FROM tbl_score2 SC
LEFT JOIN tbl_dept DP
ON sc.s_dept = dp.d_num;

SELECT  sc.s_num, ST.st_name,
    SC.s_dept,DP.d_name,DP.d_pro,
    sc.s_kor,sc.s_eng,sc.s_math,
    sc.s_kor+sc.s_eng+sc.s_math AS 총점,
    ROUND((sc.s_kor+sc.s_eng+sc.s_math)/3,0) AS 평균
FROM tbl_score2 SC
LEFT JOIN tbl_student ST
ON SC.s_num = st.st_num
LEFT JOIN tbl_dept DP
ON sc.s_dept = dp.d_num;

SELECT  sc.s_num, ST.st_name,
    SC.s_dept,DP.d_name,DP.d_pro,
    sc.s_kor,sc.s_eng,sc.s_math,
    sc.s_kor+sc.s_eng+sc.s_math AS 총점,
    ROUND((sc.s_kor+sc.s_eng+sc.s_math)/3,0) AS 평균
FROM tbl_score2 SC
LEFT JOIN tbl_student ST
ON SC.s_num = st.st_num
LEFT JOIN tbl_dept DP
ON sc.s_dept = dp.d_num
WHERE DP.d_name = '컴퓨터공학';

CREATE VIEW view_score
AS
(
SELECT  sc.s_num, ST.st_name,
    SC.s_dept,DP.d_name,DP.d_pro,
    sc.s_kor,sc.s_eng,sc.s_math,
    sc.s_kor+sc.s_eng+sc.s_math AS 총점,
    ROUND((sc.s_kor+sc.s_eng+sc.s_math)/3,0) AS 평균
FROM tbl_score2 SC
LEFT JOIN tbl_student ST
ON SC.s_num = st.st_num
LEFT JOIN tbl_dept DP
ON sc.s_dept = dp.d_num
);

SELECT *FROM view_score;

SELECT  *FROM view_score
WHERE d_name = '컴퓨터공학';


SELECT  *FROM view_score
ORDER BY s_num;

DESC view_score;

-- 한번 view 로 생성해두면 물리적 테이블이 있는 것과 같이 작동을 하며
-- select 문에 의해 다양한 옵션을 사용해 데이터를 조회할 수 있다


SELECT  *FROM view_score
WHERE 평균 > 80;


SELECT  *FROM view_score
WHERE 평균 BETWEEN 70 AND 90;


SELECT  *FROM view_score
WHERE 평균 >= 70 AND 평균 <= 90;


SELECT  *FROM view_score
WHERE s_dept IN('001','003')
ORDER BY d_name;


SELECT  *FROM view_score
WHERE s_dept = '001' OR s_dept = '003'
ORDER BY d_name;


SELECT  *FROM view_score
WHERE s_dept BETWEEN '001' AND '003'
ORDER BY s_dept;

SELECT * FROM view_score
WHERE d_name LIKE '컴퓨터%';


SELECT * FROM view_score
WHERE d_name LIKE '%공학';

SELECT s_num || ' : ' || st_name
FROM view_score;

SELECT * FROM view_score
WHERE d_name LIKE '컴퓨터' || '%';

-- 해당 칼럼의 데이터가 다수 존재할 때
-- 중복되지 않는 데이터만 추출하는 키워드
SELECT DISTINCT s_dept,d_name
FROM view_score
ORDER BY s_dept;

-- 표준 SQL
SELECT s_dept, d_name
FROM view_score
GROUP BY s_dept,d_name
ORDER BY s_dept;

-- GROUP BY
-- 특정 칼름을 기준으로 하여 집계를 할때 사용하는 명령

-- 1. 학과별로 국ㄱ어점수의 총점을 계산하고 싶다
-- 각 학과별로 그룹으로 묶고 국ㄱ어점수의 총점으 ㄹ계산 한후
-- 학과 번호 순으로 보이기 
-- 부분 합 집계

SELECT s_dept, d_name, d_pro, SUM(s_kor)
FROM view_score
GROUP BY s_dept, d_name, d_pro
ORDER BY s_dept;

-- GROUP BY로 묶어 부분합을 보고자 할때 
-- 기준으로 하는 칼럼이외의 SELECT문에 나열된 칼럼들 중
-- 집계함수로 감싸지 않은 칼럼들은 GROUP BY 절 다음에 나열 해주어야 한다


-- 학번, 학과코드로 묶어서 보여주는 데이터는 
-- 의미 없는 명령문이다
-- group으로 묶어서 집계할 때는 어떤 칼럼들을 묶을 것인지 생각해야한다
SELECT s_num,s_dept, d_name, d_pro, SUM(s_kor)
FROM view_score
GROUP BY s_num,s_dept, d_name, d_pro
ORDER BY s_dept;

SELECT s_dept, d_name, d_pro, 
SUM(s_kor) AS 국어총점,
SUM(s_eng) AS 영어총점,
SUM(s_math) AS 수학총점
FROM view_score
WHERE d_name IN ('컴퓨터공학','영어')
GROUP BY s_dept, d_name, d_pro
ORDER BY s_dept;

-- GROUP BY를 실행할 때 조건을 부여하는 방법 
-- WHERE 조건을 부여하는 방법 HAVING 조건을 부여하는 방법

















