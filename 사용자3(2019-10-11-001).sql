-- 여기는 user3화면입니다
-- 현재 user3사용자가 사용할 수 있는 Table목록
SELECT * FROM TAB;

--TABLE과 VIEW 차이
/*
--------------------------------------------
TABLE                      VIEW
--------------------------------------------
실제 저장된 데이터          가상의데이터 테이블로부터
                            SELECT실행한 후 보여주는 형태
CRUD 모두 가능             READ조회(SELECT)만 가능
원본데이터                  TABLE로부터 새로 생성된 보기전용
                            데이터
*/

-- 단순한 성적테이블조회
SELECT * FROM tbl_score;
-- JOIN
-- 단순 성적테이블 조회로는 구체적 학생의 이름이라던가 다른 정보를 찾기 어렵다
-- 학번과 연계된 학생테이블로부터 학생 이름을 연결하고
-- 학과와 연계된 학과테이블로 부터 학과 이름을 연결하여 
-- 마치 한개의 데이터 Sheet처럼 보기 위한 SQL

-- 학생테이블
DESC tbl_student;

-- 현재 학생테이블에 학과 코드 칼럼이 있음에도
-- SQL의 편의성을 고려하여
-- 성적테이블에 학과 코드를 추가하여 관리를 했다 : tbl_score2
-- 이런 상황이되면 자칫잘못하여 tbl_score2테이블에 등록된
-- 학과 코드가 실제 학생의 학과 코드가 아닌 값이 등록될 수 있다
-- 이런 경우 데이터를 조회했을때 실제 데이터와 차이가 있는 오류가 생길 수 있다

-- tbl_score 테이블과tbl_student를 JOIN하고
-- 그 결과에서 학과 코드를 기준으로 다시 tbl_dept와 JOIN을 수행하는 SQL

-- tbl_score tbl_student JOIN

SELECT 
    *
FROM tbl_score SC
LEFT JOIN tbl_student ST
ON sc.s_num=st.st_num;

SELECT * FROM tbl_dept;

-- 학생데이터 삭제
DELETE FROM tbl_student;

SELECT  *FROM tbl_student;

-- 학생테이블과 학과테이블을 JOIN
-- 보고자하는 칼럼만 리스트로 나열하고
-- 결과를 학번순으로 정렬하여 복이
SELECT st.st_num,st.st_name,st.st_dept,dp.d_name,dp.d_pro
FROM tbl_student ST
LEFT JOIN tbl_dept DP
ON st.st_dept = dp.d_num
ORDER BY st.st_num;

-- 위의 SQL을 VIEW생성
-- 1. ORDER BY 제거
-- 2. 각 칼럼에 별도의 ALIAS 설정
-- 3. SQL 문 () 감싸기
-- 4. CREATE VIEW AS 키워드 추가

CREATE VIEW view_st_dept
AS
(
SELECT    st.st_num 학번,
            st.st_name 이름,
            st.st_dept 학과코드,
            dp.d_name 학과이름,
            dp.d_pro 담당교수
FROM tbl_student ST
LEFT JOIN tbl_dept DP
ON st.st_dept = dp.d_num
);

SELECT  *FROM view_st_dept;

SELECT  *FROM view_st_dept
WHERE "학과이름" = '컴퓨터공학';

SELECT * FROM view_st_dept
WHERE "학과이름" LIKE '컴퓨터%'
ORDER BY "학번";

-- view_st_dept 를 사용
-- 학과별 학생수(count) 확인

SELECT 학과코드,학과이름, COUNT("학과이름")
FROM view_st_dept
GROUP BY 학과코드,학과이름
ORDER BY 학과이름;

-- 학생수를 기준으로 오름차순 정렬
-- 직계함수(SUM,COUNT,MAX,MIN,AVG)를 사용할때
-- 만약 직계함수로 감싸지 않은 칼럼을 Projection에 표시하려고 하면
-- 그 칼럼들은 반드시 GROUP BY 절에 나열해주어야 한다

SELECT 학과코드, 학과이름, COUNT(학과코드)
FROM view_st_depT
GROUP BY 학과코드, 학과이름
ORDER BY COUNT(학과코드);

-- 1. 전체 데이터에서 학과코드 별로 묶어서, 학과코드가 무엇인지 List
-- 2. List내에 포함된 학생수를 계산
-- -> 학과코드별로 부분 합을 계산

-- SQL에서는 학번은 현재 view에서 절대 중복된 값이 없으므로
-- GROUP BY가아무런 효과를 발휘하지 못한다
SELECT 학번, 이름, COUNT(*)
FROM view_st_dept
GROUP BY 학번, 이름;

-- 학과별로 학생수를 계산하고
-- 학생수가 20명이상인 과만 보기
-- 집계 계산 후 결과에 대한 조건 설정
SELECT 학과코드, 학과이름, COUNT(*)
FROM view_st_dept
GROUP BY 학과코드, 학과이름
HAVING COUNT(*) >= 20;

-- 학과별 학생수 계산
-- 컴퓨터공학과만 보여라
SELECT 학과코드, 학과이름, COUNT(*)
FROM view_st_dept
GROUP BY 학과코드, 학과이름
HAVING 학과이름 = '컴퓨터공학';

-- HAVING 절은 GROUP BY가 이루어지고, 집계함수가 계산된 후
-- 조건을 설정하여 리스트를 추출하는 부분이다
-- 이 경우 원본데이터를 먼저 GROUP 하는 연산이 수행되고
-- 그 결과에 대하여 조건을 설정한다
-- 만약 기존의 칼럼을 기준으로 조건을 설정하려면
-- HAVING 이 아닌 WHERE에서 조건을 설정하여
-- 추출되는 LIST개수를 줄이고
-- 추출된 LIST만 가지고 GROUP, 집계함수 연산을 수행하는 것이
-- SQL 수행 효율면에서 매우 유리하다

SELECT 학과코드, 학과이름, COUNT(*)
FROM view_st_dept --1. 실행
WHERE 학과이름 = '컴퓨터공학' --2. 
GROUP BY 학과코드, 학과이름;  --3
-- -> WHERE 에 의해 제한 LIST만 가지고 GROUP실행

-- 성적테이블과 학생테블 JOIN
SELECT
    *
FROM tbl_score SC
LEFT JOIN tbl_student ST
ON sc.s_num= st.st_num;

CREATE VIEW view_sc_st
AS
(
SELECT sc.s_num AS 학번,
st.st_name AS 이름,
st.st_dept AS 학과코드, 
sc.s_kor AS 국어,
sc.s_eng AS 영어, 
sc.s_math AS 수학
FROM tbl_score SC
LEFT JOIN tbl_student ST
ON sc.s_num= st.st_num
);

SELECT * FROM view_sc_st;

-- 생성된 2개의 VIEW JOIN

SELECT SC.학번,SC.이름, SC.학과코드,DP.학과이름,
        SC.국어,SC.영어,SC.수학
FROM view_sc_st SC -- 주테이블
LEFT JOIN view_st_dept DP
ON sc."학과코드"= dp."학과코드"
ORDER BY sc."학번";

-- 2개의 VIEW JOIN 했더니 결과가 원하는 바가 나오지 않았다
SELECT
    *
FROM tbl_score SC
LEFT JOIN tbl_student ST
ON sc.s_num = st.st_num
LEFT JOIN tbl_dept DP
ON ST.st_dept = dp.d_num;

SELECT sc.s_num,st.st_name,dp.d_name,dp.d_pro,
SC.s_kor, sc.s_eng,sc.s_math
FROM tbl_score SC
LEFT JOIN tbl_student ST
ON sc.s_num = st.st_num
LEFT JOIN tbl_dept DP
ON ST.st_dept = dp.d_num;


DROP VIEW tbl_성적일람표;
DROP VIEW view_성적일람표;

CREATE VIEW view_성적일람표
AS
(
SELECT sc.s_num AS 학번,
st.st_name AS 학생이름,
dp.d_num AS 학과코드,
dp.d_name AS 학과이름,
dp.d_pro AS 담당코드,
SC.s_kor AS 국어,
sc.s_eng AS 영어, 
sc.s_math AS 수학,
sc.s_kor+sc.s_eng+sc.s_math AS 총점,
ROUND((sc.s_kor+sc.s_eng+sc.s_math)/3,0) AS 평균,
RANK() OVER(ORDER BY (sc.s_kor+sc.s_eng+sc.s_math) DESC ) AS 석차
FROM tbl_score SC
LEFT JOIN tbl_student ST
ON sc.s_num = st.st_num
LEFT JOIN tbl_dept DP
ON ST.st_dept = dp.d_num
);

SELECT  *FROM "VIEW_성적일람표"; 

-- 전체 학생의 과목별 총점
SELECT SUM(국어),SUM(영어),SUM(수학)
FROM "VIEW_성적일람표";

--학과별로 과목별 총점
SELECT 학과코드, 학과이름, SUM(국어),SUM(영어),SUM(수학)
FROM "VIEW_성적일람표"
GROUP BY 학과코드, 학과이름;


SELECT 학과코드, 학과이름, 
SUM(국어) AS 국어총점,
SUM(영어) AS 영어총점,
SUM(수학) AS 수학총점,
SUM(총점) AS 전체총점,
ROUND(AVG(평균),1) AS 전체평균
FROM "VIEW_성적일람표"
--WHERE 학과이름 IN ('영어','군사학')
GROUP BY 학과코드, 학과이름;


SELECT 학과코드, 학과이름, 
    SUM(국어) AS 국어총점,
    SUM(영어) AS 영어총점,
    SUM(수학) AS 수학총점,
    SUM(총점) AS 전체총점,
    ROUND(AVG(평균),1) AS 전체평균
FROM "VIEW_성적일람표"
WHERE 학과코드 IN ('002','003')
GROUP BY 학과코드, 학과이름;

DELETE tbl_score;

-- 학과 평균이 

SELECT * FROM tbl_score;


SELECT 학과코드, 학과이름, 
    SUM(국어) AS 국어총점,
    SUM(영어) AS 영어총점,
    SUM(수학) AS 수학총점,
    SUM(총점) AS 전체총점,
    ROUND(AVG(평균),1) AS 전체평균
FROM "VIEW_성적일람표"
GROUP BY 학과코드, 학과이름
HAVING ROUND(AVG(평균),1)>=75;



SELECT 학과코드, 학과이름, 
    SUM(국어) AS 국어총점,
    SUM(영어) AS 영어총점,
    SUM(수학) AS 수학총점,
    SUM(총점) AS 전체총점,
    ROUND(AVG(평균),1) AS 전체평균
FROM "VIEW_성적일람표"
WHERE 학과코드 BETWEEN '002' AND'005'
GROUP BY 학과코드, 학과이름;

SELECT 학과코드, 학과이름,
COUNT(*) 학생수 ,
MAX(총점) AS 최고점,
MIN(총점) AS 최저점,
SUM(총점),
ROUND(AVG(평균),1) 
FROM "VIEW_성적일람표"
GROUP BY 학과코드, 학과이름
ORDER BY 학과코드;














